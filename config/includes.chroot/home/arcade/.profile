# ~/.profile: executed by Bourne-compatible login shells.
# Cheesecake OS v2 — install prompt on the live USB + kiosk supervisor.

export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER_ALLOW_SOFTWARE=1
export XDG_CURRENT_DESKTOP=cage
export XDG_SESSION_TYPE=wayland

if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    /usr/bin/plymouth quit 2>/dev/null || true

    # Only offer the installer when running from the live USB.
    if [ -d /run/live ]; then
        clear
        echo
        echo "   ==============================================="
        echo "            Welcome to Cheesecake OS"
        echo "   ==============================================="
        echo
        echo "   Press  I  to install Cheesecake OS to this PC's drive."
        echo "   Starting the arcade in 8 seconds..."
        echo
        key=""
        read -t 8 -n 1 key 2>/dev/null || true
        if [ "$key" = "i" ] || [ "$key" = "I" ]; then
            sudo /usr/local/bin/cheesecake-installer
            echo
            echo "Installer finished. Type: sudo reboot"
            exec /bin/bash
        fi
    fi

    while true; do
        echo "=== Launching Cheesecakes Arcade: $(date) ===" >> /home/arcade/cage.log
        /usr/bin/cage -d -s -- /bin/sh /usr/local/bin/cheesecake-session >> /home/arcade/cage.log 2>&1
        status=$?
        echo "Session exited with status $status. Pausing 3s before restart..." >> /home/arcade/cage.log
        echo "Arcade screen stopped (code $status). Last log lines:"
        tail -n 8 /home/arcade/cage.log
        sleep 3
    done
fi
