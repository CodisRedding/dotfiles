# Dotfiles Management

Easily manage and sync your personal configuration files across machines using this dotfiles repository.

---

## Included Dotfiles

This repository currently includes:

- `.zshrc` — Zsh shell configuration (with Oh My Zsh, plugins, aliases, and more)
- `.zprofile` — Zsh profile script, runs at login (for environment variables, etc.)
- `.bash_profile` — Bash shell profile script (for Bash users or compatibility)
- `.npmrc` — npm configuration
- `.yarnrc` — Yarn package manager configuration
- `.gitconfig` — Git configuration (user info, aliases, etc.)
- `.gitignore` — Global Git ignore patterns
- `.aliases` — Centralized shell aliases (sourced by `.zshrc`)
- `Brewfile` — Homebrew/cask/tap/extensions list for easy setup (generated with `brew bundle dump`)

> **Note:** Some files may not be symlinked by default. Review and link only those relevant to your setup.

You can add more files as needed (e.g., `.vimrc`).

## Example Directory Structure

```text
dotfiles/
├── .zshrc
├── .zprofile
├── .bash_profile
├── .npmrc
├── .yarnrc
├── .gitconfig
├── .gitignore
├── .aliases
├── Brewfile
```

## Quick Setup

Clone this repo and symlink the configs:

```sh
git clone https://gitlab.com/<yourusername>/dotfiles.git ~/dotfiles
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.npmrc ~/.npmrc
```

> **Tip:** Use `-sf` to force and overwrite existing symlinks.

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
