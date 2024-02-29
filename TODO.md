# TODO

## Bootstrap

- Install python
  - pip install black, isort, pynvim, i3ipc(sway)
  - pipx?
  - pipx install jrnl
- npm install neovim
- Install neovim (appimage?)
  - sheldon needs openssl, pkg-config
- Install Kitty terminal
  - curl -L <https://sw.kovidgoyal.net/kitty/installer.sh> | sh /dev/stdin
- Install lazygit
- lua? luarocks?
- Install ranger (via pipx install ranger-fm)
- Install alacritty?
  - debian dep install: apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
  - arch dep install: pacman -S cmake freetype2 fontconfig pkg-config make libxcb libxkbcommon python
  - after rustup/cargo are installed, do

    ```sh
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
    cargo build --release
    # If all goes well, this should place a binary at target/release/alacritty.
    ```

- Install neovide
  - deb deps:

      ```sh
    sudo apt install -y curl \
        gnupg ca-certificates git \
        gcc-multilib g++-multilib cmake libssl-dev pkg-config \
        libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
        libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev \
        libxcursor-dev
    ```

  - arch deps:

    ```sh
    sudo pacman -S base-devel fontconfig freetype2 libglvnd sndio cmake \
    git gtk3 python sdl2 vulkan-intel libxkbcommon-x11
    ```

- node cleanup
