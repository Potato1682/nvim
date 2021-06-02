# nvim
My neovim settings

![image](https://user-images.githubusercontent.com/48394190/120484401-ff21c200-c3ed-11eb-9036-cf03a0aa1335.png)

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
- Docker Engine

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
- Template support
- Automatic license file generation
- Template generation
- Redmine integration *[NEW]*
- Custom color highlighting *[NEW]*
- Spell check

## WIP Features

- Right mouse drag gestures

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

### Some servers stopped working by exit code 125

If you're using `podman`, you may not be using unqualified search registries.  
Comment-out / Add the property to `/etc/containers/registries.conf` like this:
```tst
unqualified-search-registries = ["docker.io"]
```

