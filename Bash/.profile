# default executables
export EDITOR="vim"
export VISUAL="vim"
export TERMINAL="st"
export BROWSER="brave"
export READER="zathura"

# fix window-frames in vieb browser
export VIEB_WINDOW_FRAME=true

# fix white screen of death in java awt programs
export _JAVA_AWT_WM_NONREPARENTING=1

# my scripts
export MY_SCRIPTS="$HOME/.local/bin/my_scripts"
export MY_SCRIPT_ASSETS="$HOME/.local/share/my_script_assets"

# en_IN doesn't work as expected
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ANDROID_SDK_ROOT="/opt/android-sdk"
export ANDROID_HOME="/opt/android-sdk"
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk/

# PATH variable
export PATH="${HOME}/.bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/.local/share/bin:${PATH}"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"

# this is always used by fzf
export FZF_DEFAULT_OPTS="--color=16 --padding=0,1 --cycle --prompt='>=> ' --pointer='>' --info=inline --layout=reverse"

if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi
