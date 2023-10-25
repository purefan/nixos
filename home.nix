{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "purefan";
  home.homeDirectory = "/home/purefan";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    initExtra = ''
      export PATH="$HOME/bin:$PATH"
      export AWS_PAGER=""
    '';
  };


  # https://mynixos.com/home-manager/options/xdg.configFile.%3Cname%3E
  home = {
    file = {
      "bin/.migge-test" = {
        executable = true;
        text = ''
          #!/usr/bin/env bash
          echo "testing"
        '';
      };
    };
  };


  home.packages = [
    pkgs.htop
    pkgs.vscode
    pkgs.brave
    pkgs.tigervnc # enable emulate middle figer in input
    pkgs.ferdium
    pkgs.git
    pkgs.terminator
    pkgs.nextcloud-client
    pkgs.keepassxc
    pkgs.obsidian
    pkgs.scid-vs-pc
    pkgs.gparted
    pkgs.obs-studio # 12/06/2023
    # NDI needs a newer sha256, I submitted a pull request on github
    #pkgs.obs-studio-plugins.obs-ndi # to use the phone as webcam https://obs.camera/docs/getting-started/
    pkgs.spotify # 13/06/2023
    pkgs.gtop # requested by https://cinnamon-spices.linuxmint.com/applets/view/79
    pkgs.nix-index # needed for nix-locate
    pkgs.nodejs_20
    pkgs.wireshark # 30/jun/2023
    pkgs.steam # works nice
    pkgs.gnumake
    pkgs.gcc
    pkgs.unzip
    pkgs.wget
    pkgs.ncdu
    pkgs.heroic # needed for red dead redemption 2 apparently
    pkgs.lsof
    pkgs.openshot-qt
    pkgs.godot_4 # game engine
    pkgs.gimp-with-plugins
    pkgs.gdb # trying to debug vscode crashing (did it twice-in-once)
    pkgs.peek
    pkgs.joplin-desktop
    pkgs.mysql-workbench
    pkgs.ruby_3_2 # Needed for jekyll
    pkgs.dbeaver
    pkgs.cmake
    pkgs.postgresql
    pkgs.awscli2
    pkgs.docker
    pkgs.zip
    pkgs.jq
    pkgs.vlc
    pkgs.flameshot
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
        dbaeumer.vscode-eslint
        ms-vscode-remote.remote-ssh
        ms-vsliveshare.vsliveshare
    ];
    # Good idea but replaces everything, so not suitable for
    # when you have already installed and conf-ed stuff
    # userSettings = {
    #   "workbench.panel.defaultLocation" = "right";
    # };
  };

  # 21/06/2023:
  dconf.settings = {
    "org/cinnamon/desktop/session" = {
        idle-delay = lib.hm.gvariant.mkUint32 0;
    };
    "org/cinnamon/desktop/screensaver" = {
        lock-delay = lib.hm.gvariant.mkUint32 3600;
        lock-enabled = false;
    };
  };


  # generation 6 is safe
  # generation 9 is safe
  # rollback to generation 9:
  # /nix/store/ak5bfzw8jws9rsg4p6fq4h8s197y73wj-home-manager-generation/activate

  # opening ports for discord is done in /etc/nixos/configuration.nix
}
