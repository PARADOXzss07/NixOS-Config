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

  boot.initrd.luks.devices."luks-6e4f7381-b66c-487d-a950-c34b1e053615".device = "/dev/disk/by-uuid/6e4f7381-b66c-487d-a950-c34b1e053615";
  networking.hostName = "NixOS"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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
  
  # Enable the Hyprland WM (BROKEN)
  # programs.hyprland = {
  # enable = true; 
  # xwayland.enable = true;
  #};

  # Hint Electon apps to use wayland
  # environment.sessionVariables = {
  #  NIXOS_OZONE_WL = "1";
  #};
  
  # Screen sharing
  # services.dbus.enable = true;
  # xdg.portal = {
  # enable = true;
  # wlr.enable = true;
  # extraPortals = [
  # pkgs.xdg-desktop-portal-gtk
  #];
 #};

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
    #jack.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

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
    	kitty
    	neovim
    	pavucontrol
    	pipewire
    	steam
    	fish
    	prismlauncher
    	krita
    	openjdk8
    	openjdk17
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
