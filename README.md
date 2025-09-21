# Dotfiles Management

Easily manage and sync your personal configuration files across machines using this dotfiles repository.

---

## Included Dotfiles

This repository currently includes:

- `.zshrc` — Zsh shell configuration (with Oh My Zsh, plugins, aliases, and more)
- `.npmrc` — npm configuration

You can add more files as needed (e.g., `.vimrc`, `.gitconfig`).

## Example Directory Structure

```
dotfiles/
├── .zshrc
├── .npmrc
└── README.md
```

## Quick Setup

Clone this repo and symlink the configs:

```sh
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.npmrc ~/.npmrc
```

> **Tip:** Use `-sf` to force and overwrite existing symlinks.

## OS Notes

- These dotfiles are tailored for macOS, but most settings are portable to Linux.
- Some paths (e.g., Homebrew, nvm, VS Code integration) are macOS-specific. Adjust as needed for Linux.

## Troubleshooting

- **Existing config files:** If you already have a `.zshrc` or `.npmrc`, back them up before symlinking.
- **Symlink issues:** Use `ls -l ~/.zshrc` to verify the symlink points to the right file.
- **Permissions:** Ensure you have the correct permissions for your home directory and dotfiles.

## Customization & Contributions

- Fork or clone and add your own dotfiles.
- Edit `.zshrc` to add aliases, plugins, or environment variables.
- PRs and suggestions are welcome!

## Automate Setup (Optional)

For advanced users, automate installation and updates with tools like:

- [chezmoi](https://www.chezmoi.io/)
- [yadm](https://yadm.io/)
- [dotbot](https://github.com/anishathalye/dotbot)