# nvim
My neovim settings

## Requires

- **Neovim nightly build**
- Pipenv
- Git
- GCC
- Ninja
- Go
- Node.js and NPM
- Yarn
- `jq`
- Java >= 11 and Lombok (/usr/local/share/lombok/lombok.jar)

## Features

- Plugin Manager
- Automatic plugin manager setup
- Beautiful color schemes
- Treesitter-based code highlighting
- Super useful bufferline
- Super functional statusline
- Supercharged file explorer
- Fuzzy search with floating window
- Nerd fonts support
- **L**anguage **S**erver **P**rotocol support
	- Code folding
	- Renaming
	- Completion
	- Database support
	- Diagnostics
		- Diagnostics report will shown on statusline, bufferline, editor and explorer
	- Show lightbulb when code action is available
- Rainbow brackets
- Toggle comments
- Show git status on editor
- Wakatime support
- Document generation
- Indent line
- Automatic pair insert
- Git integrations
- Leader key menu
- **D**ebug **A**dapter **P**rotocol support
- Automatic root setting
- Increase number on editor
- Show current context on bracket ending
- Online collaboration
- Zen mode
- Colorbuddy support
- Show TODO List
- Global settings
- Errors List
- Markdown preview
- Template generation *[NEW]*
- Redmine integration *[NEW]*

## WIP Features

- Right mouse drag gestures
- Change background color by git changes
- Template support
- Automatic fetch and detect changes with remote branch
- Spell check
- Read maven dependencies
- Automatic license file generation

## Trouble Shooting

### Can't install java test runner with node-sass error

It may be because your Node.js version is too high.  
May succeed by running these commands and temporarily lowering your Node.js version.

```bash
$ sudo npm i -g n
$ cd ~/.local/share/nvim/dapinstall/java/java-test
$ PATH="/usr/local/bin/node:$PATH" bash
$ npm i --cache $(mktemp -d)
$ npm run build-plugin
```

