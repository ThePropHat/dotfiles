----------------
--  MONITORS  --
----------------
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-2",     mode = "preferred", position = "1920x0", scale = 1 })

------------------
--  MY PROGRAMS --
------------------
local terminal    = "kitty"
local fileManager = "kitty -e yazi"
local menu        = "rofi -show drun"
local music       = "rmpc"

---------------------
-- WORKSPACE RULES --
---------------------
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", on_created_empty = "steam"})
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-2" })

--------------------
--  WINDOW RULES  --
--------------------
hl.window_rule({
    name = "vesktop-special",
    match = { class = "^(vesktop)$" },
    workspace = "special:magic"
})

hl.window_rule({
    name = "rmpc-special",
    match = { class = "^(rmpc)$" },
    workspace = "special:magic"
})

hl.window_rule({
    name = "lavat-special",
    match = { class = "^(lavat)$" },
    workspace = "special:magic"
})

hl.window_rule({
    name = "easyeffects-silent",
    match = { class = "^(easyeffects)$" },
    workspace = "3"
})

-----------------
--  AUTOSTART  --
-----------------
hl.on("hyprland.start", function () 
    -- Environment services
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("wal -R")
    hl.exec_cmd("easyeffects")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("pw-metadata -n settings 0 clock.force-quantum 1024")
    hl.exec_cmd("hyprctl setcursor Breeze_Light 24")
    
    -- Persistent applications
    hl.exec_cmd("qutebrowser")
    hl.exec_cmd("mpdscribble")
    hl.exec_cmd("mpd-mpris")
    hl.exec_cmd("vesktop")
    
    -- Background shell processes with distinct classes
    hl.exec_cmd("kitty --class rmpc rmpc")
    hl.exec_cmd("kitty --class lavat lavat")
end)

---------------------------
-- ENVIRONMENT VARIABLES --
---------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

---------------------
--  LOOK AND FEEL  --
---------------------
hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 20,
        border_size = 0,
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle"
    },
    decoration = {
        rounding = 7,
        rounding_power = 10,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = false,
            range = 10,
            render_power = 3,
            color = "rgba(1a1a1aee)"
        },
        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696
        }
    },
    dwindle = {
        preserve_split = true
    },
    master = {
        new_status = "master"
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false
    },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        accel_profile = "flat",
        force_no_accel = true,
        touchpad = {
            natural_scroll = false
        }
    }
})

------------------
--  ANIMATIONS  --
------------------
hl.curve("overshot", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1} } })
hl.curve("cubic",    { type = "bezier", points = { {0.22, 1},   {0.36, 1} } })
hl.curve("revert",   { type = "bezier", points = { {0.6, -0.28}, {0.735, 0.045} } })

hl.animation({ leaf = "windows",           enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "windowsIn",         enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "windowsOut",        enabled = true, speed = 4, bezier = "cubic",    style = "slide" })
hl.animation({ leaf = "windowsMove",       enabled = true, speed = 3, bezier = "overshot" })
hl.animation({ leaf = "workspaces",        enabled = true, speed = 4, bezier = "cubic",    style = "slide" })
hl.animation({ leaf = "specialWorkspace",  enabled = true, speed = 4, bezier = "overshot", style = "slidevert" })

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5
})

-------------------
--  KEYBINDINGS  --
-------------------
local mainMod = "SUPER"

-- Core System Actions
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + PERIOD", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + COMMA", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Opacity Toggles
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("hyprctl keyword decoration:active_opacity 1 && hyprctl keyword decoration:inactive_opacity 0.15"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("hyprctl keyword decoration:active_opacity 1.0 && hyprctl keyword decoration:inactive_opacity 1.0"))

-- Navigation / Focus Control
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "down" }))

-- Audio & Application Controls
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty -e rmpc"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("qutebrowser"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("mpc toggle"))
hl.bind(mainMod .. " + Left", hl.dsp.exec_cmd("mpc prev"))
hl.bind(mainMod .. " + Right", hl.dsp.exec_cmd("mpc next"))
hl.bind(mainMod .. " + Up", hl.dsp.exec_cmd("mpc stop"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("pkill rofi || " .. menu))

-- Screenshots (Executed inside a clear shell wrap to safely evaluate pipelines)
hl.bind("Print", hl.dsp.exec_cmd([[sh -c 'grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png && dunstify "Screenshot of the region taken" -t 1000']]))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd([[sh -c 'grim - | wl-copy && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F_%T).png && dunstify "Screenshot of whole screen taken" -t 1000']]))

-- Mouse Interactions
hl.bind(mainMod .. " + mouse_down", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind(mainMod .. " + mouse_up", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspaces Map (1-10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special Workspaces
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Hardware Control Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause",       hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-----------------------------
--  SYSTEM LAYER DEFAULTS  --
-----------------------------
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize"
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false
    },
    no_focus = true
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true
})
