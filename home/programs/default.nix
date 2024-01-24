let
  more = { pkgs, ... }: {
    programs = {
      bat.enable = true;

      gpg.enable = true;

      jq.enable = true;

      ssh.enable = true;

    };
  };
in
[
  ./dconf
  ./git
  ./neofetch
  ./rofi
  ./signal
  ./xmonad
  more
]
