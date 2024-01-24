{ pkgs, ... }:

{
  services.screen-locker = {
    enable = true;
    inactiveInterval = 30;
    lockCmd = "${pkgs.xscreensaver}/bin/xscreensaver -lock";
    xautolock.extraOptions = [
      "Xautolock.killer: systemctl suspend"
    ];
  };
}
