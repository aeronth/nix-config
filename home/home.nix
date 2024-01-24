{ pkgs, lib, ... }:

let
  username = "aeronth";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  defaultPkgs = with pkgs; [
    arandr               # simple GUI for xrandr
    asciinema            # record the terminal
    dconf2nix            # dconf (gnome) files to nix converter
    dig                  # dns command-line tool
    docker-compose       # docker manager
    dive                 # explore docker layers
    duf                  # disk usage/free utility
    eza                  # a better `ls`
    fd                   # "find" for files
    jitsi-meet-electron  # open source video calls and chat
    killall              # kill processes by name
    libnotify            # notify-send command
    lnav                 # log file navigator on the terminal
    ncdu                 # disk space info (a better du)
    nix-index            # locate packages containing certain nixpkgs
    nix-output-monitor   # nom: monitor nix commands
    nyancat              # the famous rainbow cat!
    pavucontrol          # pulseaudio volume control
    paprefs              # pulseaudio preferences
    pasystray            # pulseaudio systray
    prettyping           # a nicer ping
    pulsemixer           # pulseaudio mixer
    screenkey            # shows keypresses on screen
    simplescreenrecorder # screen recorder gui
    tdesktop             # telegram messaging client
    tldr                 # summary of a man page
    tree                 # display files in a tree view
    vlc                  # media player
    xsel                 # clipboard support (also for neovim)
    zoom-us              # message client

    # haskell packages
    haskellPackages.nix-tree # visualize nix dependencies
  ];

  gnomePkgs = with pkgs.gnome; [
    eog      # image viewer
    evince   # pdf reader
    gnome-disk-utility
    #nautilus # file manager

    # file manager overlay
    pkgs.nautilus
  ];
in
{
  programs.home-manager.enable = true;

  imports = lib.concatMap import [
    ./programs
    ./scripts
    ./services
    ./themes
  ];

  xdg = {
    inherit configHome;
    enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "21.03";

    packages = defaultPkgs ++ gnomePkgs;

    sessionVariables = {
      BROWSER = "${lib.getExe pkgs.firefox-beta-bin}";
      DISPLAY = ":0";
      EDITOR = "vim";
    };
  };

  # restart services on change
  systemd.user.startServices = "sd-switch";

  # notifications about home-manager news
  # news.display = "silent";
}
