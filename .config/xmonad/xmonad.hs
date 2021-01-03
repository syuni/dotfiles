import XMonad

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog

import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.ToggleLayouts

import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)


colorBg = "#282C34"
colorFg = "#ABB2BF"
colorRed = "#E06C75"
colorGreen = "#98C379"
colorYellow = "#E5C07B"
colorBlue = "#61AFEF"
colorPurple = "#C678DD"
colorCyan = "#56B6C2"

myTerminal = "alacritty"

myBorderWidth = 3

myWorkspaces = ["1", "2", "3", "4", "5"]


main :: IO()
main = do
    config <- statusBar myBar myPP toggleStrutsKey myConfig
    xmonad $ ewmh config

myConfig = defaultConfig
    {
      modMask = mod4Mask
    , terminal = myTerminal
    , borderWidth = myBorderWidth
    , workspaces = myWorkspaces
    , layoutHook = myLayout
    , startupHook = myStartupHook
    , normalBorderColor = colorBg
    , focusedBorderColor = colorBlue
    }
    
    `removeKeysP`
    [
      "M-S-<Return>"
    , "M-p"
    , "M-S-p"
    ]

    `additionalKeysP`
    [
      ("M-<Return>", spawn "alacritty") 
    , ("M-f", sendMessage ToggleLayout)
    , ("M-S-h", sendMessage MirrorShrink)
    , ("M-S-l", sendMessage MirrorExpand)
    , ("M-d", spawn "rofi -show combi")
    , ("M-C-l", spawn "i3lock-fancy")
    , ("<XF86MonBrightnessUp>", spawn "brightnessctl -d 'acpi_video0' set +10")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl -d 'acpi_video0' set 10-")
    , ("<XF86KbdBrightnessUp>", spawn "brightnessctl -d 'smc::kbd_backlight' set +15")
    , ("<XF86KbdBrightnessDown>", spawn "brightnessctl -d 'smc::kbd_backlight' set 15-")
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("<XF86AudioPlay>", spawn "playerctl play")
    , ("<XF86AudioPause>", spawn "playerctl pause")
    , ("<XF86AudioNext>", spawn "playerctl next")
    , ("<XF86AudioPrev>", spawn "playerctl previous")
    ]

myLayout = avoidStruts $ gaps [(D,sp), (R,sp), (L,sp)] $ spacing sp $ toggleLayouts (noBorders Full) $ tall ||| Mirror tall
    where
        tall = ResizableTall 1 (3/100) (1/2) []
        sp = 12

myStartupHook = do
    spawnOnce "bash $HOME/.fehbg"
    spawnOnce "xautolock -time 5 -locker 'i3lock-fancy' -notify 10 -notifier 'notify-send -t 5000 -i gtk-dialog-info \"Locking in 10 seconds\"' &"

myBar = "xmobar"
myPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                , ppCurrent         = xmobarColor colorRed  colorBg . \s -> "●"
                , ppUrgent          = xmobarColor colorFg   colorBg . \s -> "●"
                , ppVisible         = xmobarColor colorRed  colorBg . \s -> "⦿"
                , ppHidden          = xmobarColor colorFg   colorBg . \s -> "●"
                , ppHiddenNoWindows = xmobarColor colorFg   colorBg . \s -> "○"
                , ppTitle           = xmobarColor colorRed  colorBg
                , ppOutput          = putStrLn
                , ppWsSep           = " "
                , ppSep             = "  "
                }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
