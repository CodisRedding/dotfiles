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
└── README.md
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

## Automate Setup (Optional)

For advanced users, automate installation and updates with tools like:

- [chezmoi](https://www.chezmoi.io/)
- [yadm](https://yadm.io/)
- [dotbot](https://github.com/anishathalye/dotbot)
