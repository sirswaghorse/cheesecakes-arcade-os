# Cheesecake OS (build pipeline, phase 1)

Builds a bootable x86-64 USB image that turns a PC into a Cheesecakes Arcade console.
Power on -> Cheesecake boot splash -> fullscreen Console Mode (/tv). No desktop, no terminal, no exit.

## What phase 1 does
- Debian 12 minimal base built with `live-build`
- Plymouth splash with the spinning Cheesecake (no boot text, zero-second boot menu)
- `cage` Wayland kiosk running Chromium fullscreen on the arcade's /tv page
- Auto-restart if the arcade ever closes; tty switching and console login disabled
- Controller support (Xbox, PlayStation, Switch Pro), Wi-Fi/Bluetooth/audio stacks installed

## Not yet (later phases)
- Install-to-disk wizard (phase 1 runs live from USB)
- Saving games across reboots: add a USB persistence partition (see below) until the installer exists
- Wiring Console Mode's Wi-Fi/Bluetooth/audio/power menu to the OS (bridge)
- Native emulators for heavy consoles

## Build on GitHub
1. Create a repo named `cheesecakes-arcade-os` and upload everything here (including the hidden `.github` folder).
2. Open Actions -> "Build Cheesecake OS" -> Run workflow (~20-30 min).
3. Download the `cheesecake-os-iso` artifact. Push a tag like `v0.1.0` to publish a Release instead.

## Try it
Flash the .iso to a USB drive with BalenaEtcher or Rufus (DD mode), boot the PC from it.
Persistence (optional): create a second ext4 partition labelled `persistence` containing a file
`persistence.conf` with the line `/ union`.

## Change the arcade address
Edit `ARCADE_URL` in `config/includes.chroot/usr/local/bin/cheesecake-session`.
