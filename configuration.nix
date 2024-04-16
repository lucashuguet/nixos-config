{ config, pkgs, pkgs-unstable, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # boot.loader.systemd-boot.enable = true;

  boot = {
    kernelParams = [ "video=1920x1080@60" ];
    # kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "nvidia" ];
    loader.efi.canTouchEfiVariables = true;
    extraModprobeConfig = ''
      blacklist nouveau
      options snd-hda-intel model=asus-zenbook
      options nvidia-drm modeset=1
    '';

    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      configurationLimit = 5;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.xserver.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [vaapiVdpau];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
	enable = true;
        enableOffloadCmd =  true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.xserver.libinput.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --rate 60
  '';
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "fr";
    variant = "azerty";
  };
  console.keyMap = "fr";

  # services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  services.auto-cpufreq.enable = true;
  services.asusd.enable = true;
  services.pcscd.enable = true;
  # services.mpd.enable = true;

  users.users.astrogoat = {
    isNormalUser = true;
    description = "AstroGoat";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    shell = pkgs.fish;
    packages = with pkgs; [];
  };

  nixpkgs.config.allowUnfree = true;

  environment.variables.XCURSOR_SIZE = "32";
  environment.variables.EDITOR = "nvim";

  environment.systemPackages = 
    (with pkgs; [
      neofetch
      neovim
      librewolf
      mpv
      thunderbird
      eza
      bat
      fish
      starship
      hyprland
      rofi-wayland
      waybar
      python3
      pavucontrol
      git
      pywal
      imv
      sxiv
      mpd
      ncmpcpp
      mpc-cli
      prismlauncher
      zathura
      auto-cpufreq
      jdk17
      jdk8
      pass
      gnupg
      pinentry
      pinentry-gtk2
      emacs
      mangal
      aria
      asusctl
      yt-dlp
      home-manager
      swww
      dunst
      qutebrowser
      libnotify
      wl-clipboard
      light
    ])

    ++

    (with pkgs-unstable; [
      alacritty
    ]);

  fonts.packages = 
    (with pkgs-unstable; [
      (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    ])

    ++

    (with pkgs; [
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk
    ]);

  fonts.fontconfig.defaultFonts = {
    serif = [ "Noto Serif" ];
    sansSerif = [ "Noto Sans" ];
    monospace = [ "FantasqueSansM Nerd Font" ];
  };

  programs.hyprland.enable = true;
  programs.fish.enable = true;
  programs.light.enable = true;

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
    enableSSHSupport = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?
}
