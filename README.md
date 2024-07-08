# Vim Configuration

Kevin's Vim and Neovim Configuration

This Vim configuration is purely subjective. The goal of it is to get comfortable while programming.

### Tmux Workflow

#### Start a tmux :
```sh
  tmux
```

#### Split the tmux window :
- Horizontal Split
  ```sh
    tmux split-window -h
  ```
- Vertical Split
  ```sh
    tmux split-window -v
  ```

#### Navigate tmux window :
- Ctrl-h: Move to the left pane
- Ctrl-j: Move to the pane below
- Ctrl-k: Move to the pane above
- Ctrl-l: Move to the right pane
- Ctrl-\: Move to the previous pane

### Nvim Customization

#### Create a React Native Component :
```sh
  :CreateComponent file.js / file.jsx / file.ts / file.tsx
```
or inside folder
```sh
  :CreateComponent folder/file.extension
``` 
