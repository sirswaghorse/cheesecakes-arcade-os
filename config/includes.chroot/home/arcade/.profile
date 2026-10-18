# ~/.profile: executed by Bourne-compatible login shells.

export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER_ALLOW_SOFTWARE=1
export XDG_CURRENT_DESKTOP=cage

# Auto-start Cheesecakes Arcade Kiosk on TTY1
if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    # Cleanly release Plymouth boot splash
    /usr/bin/plymouth quit 2>/dev/null || true
    exec /usr/bin/cage -d -s -- /usr/local/bin/cheesecake-session
fi
