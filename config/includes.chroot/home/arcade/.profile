# ~/.profile: executed by Bourne-compatible login shells.

export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER_ALLOW_SOFTWARE=1
export XDG_CURRENT_DESKTOP=cage
export XDG_SESSION_TYPE=wayland

# Booted with the "Install Cheesecake OS" menu entry? Run the installer instead.
if grep -q "cheesecake-install" /proc/cmdline && [ "$(tty)" = "/dev/tty1" ]; then
    /usr/bin/plymouth quit 2>/dev/null || true
    sudo /usr/local/bin/cheesecake-installer
    # After the installer exits, drop to a shell so the user can reboot manually.
    exec /bin/bash
fi

# Auto-start Cheesecakes Arcade Kiosk on TTY1
if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    /usr/bin/plymouth quit 2>/dev/null || true

    while true; do
        echo "=== Launching Cheesecakes Arcade: $(date) ===" >> /home/arcade/cage.log
        /usr/bin/cage -d -s -- /bin/sh /usr/local/bin/cheesecake-session >> /home/arcade/cage.log 2>&1
        echo "Session exited with status $?. Pausing 3s before restart..." >> /home/arcade/cage.log
        sleep 3
    done
fi

