import XMonad
import Graphics.X11.ExtraTypes.XF86

import XMonad.Hooks.RefocusLast
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.Place
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.WindowSwallowing

import XMonad.Actions.DwmPromote
import XMonad.Actions.FloatSnap
import XMonad.Actions.CycleWS
import XMonad.Actions.Submap

import XMonad.Util.WorkspaceCompare
import XMonad.Util.Run
import XMonad.Util.NamedScratchpad

import XMonad.Layout.Spacing

import System.Environment
import System.Exit

import Data.Monoid
import qualified Data.Map as M

import qualified XMonad.StackSet as W

import Colors

myWorkspaces    = ["૧", "૨", "૩", "૪", "૫", "૬", "૭", "૮", "૯"]

myTerminal = "alacritty"

scratchpads = [ NS "pulsemixer" (myTerminal ++ " --title=pulsemixer -e pulsemixer") (title =? "pulsemixer") doCenterFloat ]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm, xK_d), spawn "rofi -show run")
    , ((modm, xK_p), spawn "passmenu -p 'Select Password'")
    , ((modm .|. shiftMask, xK_x), spawn "sys-options")
    , ((modm, xK_equal), incScreenWindowSpacing 1)
    , ((modm, xK_minus), decScreenWindowSpacing 1)
    , ((modm, xK_BackSpace), setScreenWindowSpacing 0)
    , ((modm, xK_v), namedScratchpadAction scratchpads "pulsemixer")
    , ((modm .|. shiftMask, xK_c), kill)
    , ((modm, xK_space), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modm, xK_n), refresh)
    , ((modm, xK_j), windows W.focusDown)
    , ((modm, xK_k), windows W.focusUp  )
    , ((modm, xK_m), windows W.focusMaster  )
    , ((modm .|. shiftMask, xK_Return), dwmpromote)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j), windows W.swapDown  )
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k), windows W.swapUp    )
    , ((modm, xK_h), sendMessage Shrink)
    , ((modm, xK_l), sendMessage Expand)
    -- Push window back into tiling
    , ((modm, xK_t), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modm , xK_o), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modm .|. shiftMask, xK_o), sendMessage (IncMasterN (-1)))
    -- browser with different profiles
    , ((modm, xK_b), submap . M.fromList $
       [ ((modm, xK_b),  spawn "$BROWSER --profile-directory=clean")
       , ((modm, xK_g),  spawn "$BROWSER --profile-directory=google-main")
       , ((modm, xK_a),  spawn "$BROWSER --profile-directory=google-alt")
       , ((modm, xK_m),  spawn "$BROWSER --profile-directory=microsoft")
       , ((modm, xK_n),  spawn "$BROWSER --incognito")
       ])
    -- office suite
    , ((modm, xK_w), submap . M.fromList $
       [ ((modm, xK_w),  spawn "lowriter --nologo")
       , ((modm, xK_e),  spawn "localc --nologo")
       , ((modm, xK_p),  spawn "loimpress --nologo")
       ])
    -- notification handling
    , ((modm, xK_n), submap . M.fromList $
       [ ((modm, xK_n),  spawn "dunst close-all")
       , ((modm, xK_t),  spawn "dunst close")
       , ((modm, xK_p),  spawn "dunst history-pop")
       ])
    -- brightness control
    , ((modm , xK_c), spawn "busctl --expect-reply=false --user call org.clight.clight /org/clight/clight org.clight.clight Capture 'bb' false false")
    , ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl set +1%")
    , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl set 1%-")

    , ((modm , xK_Tab), toggleWS)
    -- Restart xmonad
    , ((modm , xK_q), spawn "xmonad --recompile; xmonad --restart")
    ]

    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , let shiftAndView i = W.view i . W.shift i
        , (f, m) <- [(W.greedyView, 0), (shiftAndView, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]


myLayout = spacing 0 $ avoidStruts $ tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     nmaster = 1
     ratio   = 1/2
     delta   = 3/100

myManageHook = composeAll
    [ isFloat --> doCenterFloat ] <+> namedScratchpadManageHook scratchpads

myStartupHook = return ()

myHandleEventHook = swallowEventHook (className =? "Alacritty") (className =? "Pcmanfm" <||> className =? "Nsxiv" <||> className =? "mpv")

main = do 
  xmonad $ ewmh $ docks def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = False,
        clickJustFocuses   = False,
        borderWidth        = 2,
        modMask            = mod4Mask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        startupHook        = myStartupHook,
        handleEventHook    = myHandleEventHook
    }
