# Dotfiles Management

Easily manage and sync your personal configuration files across machines using this dotfiles repository.

---

## Included Dotfiles

This repository currently includes:

Most user-facing configuration files live under the `home/` directory and are
intended to be installed into your real `$HOME` as symlinks. For example the
repo file `home/.zshrc` should be linked to `~/.zshrc` on your machine.

Common files included (examples — check `git ls-files` for the authoritative list):

- `home/.zshrc` — Zsh shell configuration (with plugins, aliases, etc.)
- `home/.zprofile` — Zsh profile script (login-time environment variables)
- `home/.bash_profile` — Bash profile script (for Bash compatibility)
- `home/.npmrc` — npm configuration
- `home/.yarnrc` — Yarn configuration
- `home/.gitconfig` — Git configuration (user info, aliases, etc.)
- `.gitignore` — Repo-level ignore (not installed into $HOME)
- `Brewfile` — Homebrew/cask/tap/extensions list for easy setup (generated with `brew bundle dump`)

Note: some repo-owned helper files (like `README.md`, scripts, and the `Brewfile`)
stay at the repo root and are not intended to be symlinked into your home.

## Example Directory Structure

```text
dotfiles/
├── home/
│   ├── .zshrc
│   ├── .zprofile
│   ├── .bash_profile
│   ├── .npmrc
│   ├── .yarnrc
│   └── .gitconfig
├── scripts/
│   └── check_dotfiles_symlinks.sh
├── Brewfile
└── README.md
```

## Quick Setup

Clone this repo and use the included helper to install the `home/` files into
your `$HOME` safely.

```sh
git clone https://gitlab.com/<yourusername>/dotfiles.git ~/dotfiles

# preview changes (dry-run)
bash ~/dotfiles/scripts/check_dotfiles_symlinks.sh --dry-run

# apply: creates timestamped backups of existing files and replaces them with
# symlinks pointing at files under ~/dotfiles/home
bash ~/dotfiles/scripts/check_dotfiles_symlinks.sh --apply
```

If you prefer to manage a single file manually, point the symlink at the
corresponding path under `home/`, for example:

```sh
ln -sf ~/dotfiles/home/.zshrc ~/.zshrc
```

Tip: run the `--dry-run` first to confirm what will change.

## OS Notes

- These dotfiles are tailored for macOS, but most settings are portable to Linux.
- Some paths (e.g., Homebrew, nvm, VS Code integration) are macOS-specific. Adjust as needed for Linux.

## Troubleshooting

- **Existing config files:** If you already have dot files, back them up before symlinking.
- **Symlink issues:** Use `ls -l ~/.<filename>` to verify the symlink points to the right file.
- **Permissions:** Ensure you have the correct permissions for your home directory and dotfiles.

## Customization & Contributions

- Fork or clone and add your own dotfiles.
- PRs and suggestions are welcome!

## Homebrew, Casks, and VS Code Extensions Management

This repository includes a `Brewfile` that lists all Homebrew packages, casks (macOS apps), and VS Code extensions used in this setup.  
You can use this file to quickly set up a new machine or restore your environment.

### To generate/update the Brewfile with your current setup

```sh
brew bundle dump --file=~/dotfiles/Brewfile --force
```

### To install everything from the Brewfile

```sh
brew bundle --file=~/dotfiles/Brewfile
```

This will:

- Install all Homebrew packages (`brew`)
- Install all casks (`cask`)
- Add all taps (`tap`)
- Install all listed VS Code extensions (`vscode`)

**Note:**

- Make sure you have Homebrew installed: [https://brew.sh](https://brew.sh)
- For VS Code extensions, you need the `code` command available in your PATH.

### Keeping Homebrew Up to Date

To update Homebrew itself (the package manager and its formulae/casks list):

```sh
brew update
```

To upgrade all installed packages and casks to their latest versions:

```sh
brew upgrade
```

You can also upgrade a specific package or cask:

```sh
brew upgrade <formula-or-cask>
```

Run these regularly to keep your system and Brewfile dependencies current.

For more details, see the [Homebrew Bundle documentation](https://github.com/Homebrew/homebrew-bundle).

## Automate Setup (Optional)

For advanced users, automate installation and updates with tools like:

- [chezmoi](https://www.chezmoi.io/)
- [yadm](https://yadm.io/)
- [dotbot](https://github.com/anishathalye/dotbot)
