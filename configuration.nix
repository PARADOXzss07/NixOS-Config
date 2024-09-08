# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-0056d679-2d11-464b-91a8-8d3a03f67c19".device = "/dev/disk/by-uuid/0056d679-2d11-464b-91a8-8d3a03f67c19";
  networking.hostName = "NixOS"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
    services.xserver.enable = true;

  # Enable DWM + Ricing
   services.xserver.windowManager.dwm = {
   enable = true;
   package = pkgs.dwm.overrideAttrs {
     src = ./dwm;
   };
 };

  # Enable Qtile (WORK IN PROGRESS)
    services.xserver.windowManager.qtile = {
	enable = true;
  };

  
  # Stylix Ricing
  #stylix.enable = true
	
  #stylix.base16Scheme = {
  #  base00 = "1e1e2e";
  #  base01 = "181825";
  #  base02 = "313244";
  #  base03 = "45475a";
  #  base04 = "585b70";
  #  base05 = "cdd6f4";
  #  base06 = "f5e0dc";
  #  base07 = "b4befe";
  #  base08 = "f38ba8";
  #  base09 = "fab387";
  #  base0A = "f9e2af";
  #  base0B = "a6e3a1";
  #  base0C = "94e2d5";
  #  base0D = "89b4fa";
  #  base0E = "cba6f7";
  #  base0F = "f2cdcd";
  #};

  #stylix.image = ./home/paradoxzss/Documents/NixWallpaper.png;  
  # Enable the Hyprland WM (BROKEN)
  # programs.hyprland = {
  # enable = true; 
  # xwayland.enable = true;
  #};

  # Hint Electon apps to use wayland
  # environment.sessionVariables = {
  #  NIXOS_OZONE_WL = "1";
  #  WLR_NO_HARDWARE_CURSORS = "1";
  #};
  
  # Screen sharing
   services.dbus.enable = true;
   xdg.portal = {
   enable = true;
   wlr.enable = true;
   extraPortals = [
   pkgs.xdg-desktop-portal-gtk
  ];
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

# -----------------------------------------------------------------------
# Define a user account. Don't forget to set a password with ‘passwd’.
# -----------------------------------------------------------------------
  users.users.paradoxzss = {
    isNormalUser = true;
    description = "PARADOXzss";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "dialout" ];
    packages = with pkgs; [
    ];
  };

# Flatpak for Cura Slicer

 #services.flatpak.enable = true;


# -----------------------------------------------------------
#                           Install steam
# -----------------------------------------------------------
		programs.steam.enable = true;

# -----------------------------------------------------------
#			    Install firefox.
# -----------------------------------------------------------
		  programs.firefox.enable = true;

# -----------------------------------------------------------
#                        Allow unfree packages
# -----------------------------------------------------------
  		nixpkgs.config.allowUnfree = true;

# -----------------------------------------------------------
#                           To search, run:
#                          $ nix search wget
# -----------------------------------------------------------
  
  environment.systemPackages = with pkgs; [
    	vim
    	wget
    	fastfetch
  	btop
    	git
    	jetbrains.clion
    	gcc
    	spotify
    	neovim
 	fish
    	prismlauncher
    	krita
    	openjdk8
    	openjdk17
	gparted
	btrfs-progs
	gnome-icon-theme
	catppuccin
	lutris
	wine
	cool-retro-term
	hyprpaper
	kitty
	wofi
	waybar
	hyfetch
	nerdfonts
	jetbrains-mono
	st
	dmenu
	gruvbox-dark-gtk
	thonny
	dolphin
	pavucontrol
	libreoffice
	font-awesome
	nitrogen
	emacs
	picom
	brightnessctl
 	 ];
 
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
