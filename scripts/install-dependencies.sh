#!/usr/bin/env bash
set -euo pipefail

# Purple-Hypr-Rise dependency installer for Arch Linux.

if ! command -v pacman >/dev/null 2>&1; then
    echo "Error: this installer is intended for Arch Linux and Arch-based distributions."
    exit 1
fi

PACMAN_PACKAGES=(
    # Desktop and Wayland
    hyprland
    waybar
    hyprlauncher
    hyprlock
    hyprpicker
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk

    # Applications
    kitty
    dolphin
    rofi
    fastfetch
    cava
    qt6ct

    # Notifications and OSD
    swaync
    swayosd
    libnotify

    # Screenshots and clipboard
    grim
    slurp
    swappy
    wl-clipboard
    cliphist

    # Audio and media
    pipewire
    pipewire-pulse
    wireplumber
    pavucontrol
    easyeffects
    playerctl
    mpv

    # Utilities used by keybindings / config
    brightnessctl

    # Fonts used as fallbacks and for glyphs
    noto-fonts
    ttf-jetbrains-mono-nerd
)

AUR_PACKAGES=(
    mpvpaper
)

echo "==> Installing packages from official Arch repositories..."
sudo pacman -Syu --needed "${PACMAN_PACKAGES[@]}"

AUR_HELPER=""
if command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
elif command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
fi

if [[ -n "$AUR_HELPER" ]]; then
    echo "==> Installing AUR packages with $AUR_HELPER..."
    "$AUR_HELPER" -S --needed "${AUR_PACKAGES[@]}"
else
    echo
    echo "==> No AUR helper (yay/paru) found."
    echo "    Install an AUR helper, then run:"
    printf '    yay -S --needed'
    printf ' %s' "${AUR_PACKAGES[@]}"
    printf '\n'
fi

echo
echo "==> Dependency installation finished."
echo "Fonts such as SF Pro Display and Unbounded Nerd Font are not included;"
echo "install them separately if you want the exact typography shown in the screenshots."
echo "The optional hyprwave executable referenced by the personal Hyprland config"
echo "is also not included in this package list."
