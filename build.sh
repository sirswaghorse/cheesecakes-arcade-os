#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
SPLASH=config/includes.chroot/usr/share/plymouth/themes/cheesecake/cheesecake.png
curl -fsSL -o "$SPLASH" "https://cheesecakesarcade.lovable.app/__l5e/assets-v1/585942b3-a24b-45ba-a718-05e76c7c7c8d/spinning-cheesecake.png" || echo "warning: splash art download failed"
lb clean --purge || true
lb config \
  --mode debian \
  --mirror-bootstrap http://deb.debian.org/debian/ \
  --mirror-chroot http://deb.debian.org/debian/ \
  --mirror-binary http://deb.debian.org/debian/ \
  --mirror-chroot-security http://security.debian.org/debian-security/ \
  --mirror-binary-security http://security.debian.org/debian-security/ \
  --distribution bookworm \
  ...the rest stays the same...
  --distribution bookworm \
  --architectures amd64 \
  --archive-areas "main contrib non-free non-free-firmware" \
  --binary-images iso-hybrid \
  --debian-installer none \
  --iso-volume "CHEESECAKE_OS" \
  --iso-application "Cheesecake OS" \
  --bootappend-live "boot=live components quiet splash loglevel=0 rd.systemd.show_status=false vt.global_cursor_default=0 persistence"
lb build
mkdir -p out
mv live-image-amd64.hybrid.iso "out/cheesecake-os-$(date +%Y%m%d)-amd64.iso"
