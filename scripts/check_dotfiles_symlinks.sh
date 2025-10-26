#!/usr/bin/env bash

set -euo pipefail

# Color variables for readability
RED="\033[91m"
GREEN="\033[92m"
RESET="\033[0m"

# This script checks git-tracked files in the repo and determines whether
# corresponding files in $HOME are symlinked to the repo files.
#
# It understands a `home/` directory in the repo: files under `home/...`
# are treated as being mapped directly into $HOME. For other tracked files
# it preserves the previous heuristics (dot-prefixed names or .config).
#
# Modes:
#  --dry-run (default)  : report what is linked/missing and show actions
#  --apply              : create/update symlinks for missing/not-symlink files
#
# When applying, existing files are moved to a timestamped backup dir under
# $HOME (default: $HOME/.dotfiles_backup_<TS>), then replaced with symlinks.

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root" || exit 1

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Not a git repository: $repo_root" >&2
  exit 2
fi

DRY_RUN=true
APPLY=false
while [ $# -gt 0 ]; do
  case "$1" in
    --apply|-a)
      DRY_RUN=false
      APPLY=true
      shift
      ;;
    --dry-run|-n)
      DRY_RUN=true
      APPLY=false
      shift
      ;;
    --help|-h)
      echo "Usage: $0 [--dry-run|--apply]"
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 2
      ;;
  esac
done


# List tracked files
files=$(git ls-files home)

ignore_regex=''

ok=()
not_symlink=()
missing=()
actions=() # for dry-run/apply messages

# helper to resolve abs path (works with macOS without realpath)
resolve_abs() {
  local p="$1"
  if command -v realpath >/dev/null 2>&1; then
    realpath "$p" 2>/dev/null || perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' "$p"
  else
    perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' "$p"
  fi
}

timestamp() { date -u +%Y%m%dT%H%M%SZ; }

backup_root="$HOME/.dotfiles_backup_$(timestamp)"

for f in $files; do
  # explicitly skip .gitignore (we don't want it linked into $HOME)
  if [ "$f" = ".gitignore" ]; then
    continue
  fi

  if [[ $f =~ $ignore_regex ]]; then
    continue
  fi

  repo_file="$repo_root/$f"

  # If the repo has a top-level "home/" directory, treat files under it as
  # mapped directly into $HOME (strip the leading "home/")
  relpath="$f"
  candidates=()
  if [[ "$f" == home/*/* ]]; then
    # Map files in any home/<dir>/* to ~/<dir>/*
    relpath="${f#home/}"
    dir="$(dirname "$relpath")"
    base="$(basename "$relpath")"
    candidates+=("$HOME/$dir/$base")
  else
    if [[ "$f" == home/* ]]; then
      relpath="${f#home/}"
    fi
    base="$(basename "$relpath")"
    dir="$(dirname "$relpath")"
    if [[ "$base" == .* ]]; then
      candidates+=("$HOME/$relpath")
    else
      if [[ "$dir" == "." || "$dir" == "" ]]; then
        candidates+=("$HOME/.$base")
        candidates+=("$HOME/.config/$base")
      else
        candidates+=("$HOME/.$dir/$base")
        candidates+=("$HOME/.config/$dir/$base")
      fi
    fi
  fi

  linked=false
  found_any=false

  repo_real=$(resolve_abs "$repo_file")

  for c in "${candidates[@]}"; do
    if [ -e "$c" ] || [ -L "$c" ]; then
      found_any=true
    fi

    if [ -L "$c" ]; then
      # readlink may return relative paths
      target=$(readlink "$c")
      if [[ "$target" != /* ]]; then
        # expand relative link to absolute
        target="$(cd "$(dirname "$c")" && cd "$(dirname "$target")" 2>/dev/null && pwd)/$(basename "$target")" || true
      fi
      # normalize
      if target_real=$(resolve_abs "$target"); then
        if [ "$target_real" = "$repo_real" ]; then
          linked=true
          break
        fi
      fi
    fi
  done

  if $linked; then
    ok+=("$f")
    continue
  fi

  if $found_any; then
    not_symlink+=("$f")
  else
    missing+=("$f")
  fi

  # For apply/dry-run: plan an action for this file. Choose the primary target
  # (first candidate) as the location to place the symlink.
  primary="${candidates[0]}"
  if [ -z "$primary" ]; then
    # shouldn't happen, but skip defensively
    continue
  fi

  if [ -L "$primary" ]; then
    # link exists but points elsewhere
    actions+=("replace symlink ${GREEN}$repo_file${RESET} -> ${RED}$primary${RESET}")
  elif [ -e "$primary" ]; then
    actions+=("backup and symlink ${GREEN}$repo_file${RESET} -> ${RED}$primary${RESET}")
  else
    # Show repo_file in green and primary in red
    actions+=("create symlink ${GREEN}$repo_file${RESET} -> ${RED}$primary${RESET}")
  fi

  if $APPLY; then
    # ensure parent directory exists
    parent_dir="$(dirname "$primary")"
    if [ ! -d "$parent_dir" ]; then
      if $DRY_RUN; then
        actions+=("mkdir -p $parent_dir")
      else
        mkdir -p "$parent_dir"
      fi
    fi

    if [ -L "$primary" ]; then
      # existing symlink -> replace it
      if $DRY_RUN; then
        :
      else
        # create backup dir if needed
        mkdir -p "$backup_root"
        mv "$primary" "$backup_root/" || true
      fi
    elif [ -e "$primary" ]; then
      # file/dir exists -> move to backup
      if $DRY_RUN; then
        :
      else
        mkdir -p "$backup_root"
        mv "$primary" "$backup_root/"
      fi
    fi

    if $DRY_RUN; then
      :
    else
      # create the symlink
      ln -s "$repo_file" "$primary"

      # After creating the symlink
      # --- Permissions Section: Ensure ~/.ssh/config is always 600 for SSH ---
      if [ "$primary" = "$HOME/.ssh/config" ]; then
        chmod 600 "$repo_file"
      fi
    fi
  fi

done

echo "Checked $(echo "$files" | wc -w) tracked files."
echo

# Print linked files
if [ ${#ok[@]} -ne 0 ]; then
  echo "Linked files:"
  for x in "${ok[@]}"; do
    # Determine the actual symlink target for each linked file
    relpath="$x"
    if [[ "$x" == home/*/* ]]; then
      relpath="${x#home/}"
      dir="$(dirname "$relpath")"
      base="$(basename "$relpath")"
      link_path="$HOME/$dir/$base"
    else
      if [[ "$x" == home/* ]]; then
        relpath="${x#home/}"
      fi
      base="$(basename "$relpath")"
      dir="$(dirname "$relpath")"
      if [[ "$base" == .* ]]; then
        link_path="$HOME/$relpath"
      else
        if [[ "$dir" == "." || "$dir" == "" ]]; then
          link_path="$HOME/.$base"
        else
          link_path="$HOME/.$dir/$base"
        fi
      fi
    fi
    # Show the link and its target
    target_path=$(readlink "$link_path")
    # Replace $HOME with ~ for display
    short_link_path="${link_path/#$HOME/~}"
    short_target_path="${target_path/#$HOME/~}"
    # Show <repo file> -> <home file> (source -> target)
    short_repo_path="${repo_root}/${x}"
    short_repo_path="${short_repo_path/#$HOME/~}" # unlikely, but for consistency
    if [ -n "$target_path" ]; then
      echo -e "  ${GREEN}$short_repo_path${RESET} -> ${GREEN}$short_link_path${RESET}"
    else
      echo -e "  ${GREEN}$short_repo_path${RESET}"
    fi
  done
  echo
fi

# Print not symlinked files
if [ ${#not_symlink[@]} -ne 0 ]; then
  echo "Files present in $HOME but not symlinked to the repo (candidates exist but not symlink to repo):"
  for x in "${not_symlink[@]}"; do
    echo "  $x"
  done
  echo
fi

# Print missing files in light red
if [ ${#missing[@]} -ne 0 ]; then
  echo "Files with no candidate in $HOME (likely not linked or installed):"
  # Print missing files in light red
  for x in "${missing[@]}"; do echo -e "  ${RED}$x${RESET}"; done
  echo
fi

# Show planned actions
if [ ${#actions[@]} -ne 0 ]; then
  echo "Planned actions (primary candidate shown):"
 for a in "${actions[@]}"; do echo -e "  $a"; done
  echo
fi

# Show untracked files in home/ again for visibility
untracked=$(git ls-files --others --exclude-standard home)
if [ -n "$untracked" ]; then
  echo "Untracked files in home/ (not included in symlink checks):"
  while IFS= read -r f; do
    echo -e "  ${RED}$f${RESET} (untracked - run 'git add $f' to include)"
  done <<< "$untracked"
  echo
fi

# Print backup directory message
if $APPLY && [ -d "$backup_root" ]; then
  echo "Backups (if any) placed under: $backup_root"
fi

# Final status
if [ ${#not_symlink[@]} -eq 0 ] && [ ${#missing[@]} -eq 0 ]; then
  echo "All checked tracked files have symlinks in $HOME pointing to the repo."
  exit 0
else
  if $APPLY; then
    echo "Apply completed (or dry-run); check above for details."
    # If dry-run requested apply=false then we still return non-zero so CI/consumers know status
  else
    echo "Some files are not symlinked." >&2
  fi
  # exit non-zero when there are problems
  exit 1
fi
