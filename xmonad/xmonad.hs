import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Layout.NoBorders
import Control.Monad (liftM2)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import System.IO
import XMonad.Layout
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.LayoutCombinators hiding ( (|||) )
import XMonad.Layout.WindowNavigation
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8


xmobarEscape = concatMap doubleLts
  where doubleLts '<' = "<<"
        doubleLts x = [x]

-- Define the names of all workspaces
ws = ["1:main","2:web","3:dev","4:dev","5:doc","6:chat"] ++ map show [7..9]

-- clickable workspaces impact doShift/viewShift function...
myWorkspaces = clickable . (map xmobarEscape) $ ws
                where  clickable l = [ "<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                                       (i,ws) <- zip [1..9] l,                                        
                                      let n = i ]

myManageHook = composeAll 
        [ className =? "sky" --> doShift "2:chat"
        , className =? "chromium" --> viewShift "2:web"
        , className =? "navigator"  --> viewShift "2:web"
        , className =? "jetbrains-idea-ce" --> doShift "3:dev"
        , className =? "Emacs" --> doShift "3:dev"
        , className =? "Gimp" --> viewShift "1:main"
        , className =? "lximage-qt" --> doFloat 
        , className =? "transmission" --> doShift "7"
        , className =? "smplayer" --> viewShift "1:main"
        , className =? "Vlc" --> viewShift "1:main"
        , className =? "htop" --> doCenterFloat
        , className =? "sublime-text" --> viewShift "3:dev"
        , resource  =? "libreoffice" --> doShift "5:doc"
        , transience'
        , isFullscreen --> doFullFloat
        , isDialog --> doCenterFloat
        ]
        where viewShift = doF . liftM2 (.) W.greedyView W.shift


keysToAdd x = [((mod4Mask, xK_F4), kill)
              ,((mod4Mask, xK_p) , spawn "rofi -show drun")
              ,((mod4Mask, xK_Return) , spawn "urxvt -e fish")
	      ,((mod4Mask .|. shiftMask, xK_Return) , spawn "alacritty") 
              ,((mod4Mask, xK_q) , spawn "alacritty --class hunter -e hunter")
              ,((mod4Mask, xK_a) , spawn "dolphin")
              ,((mod4Mask, xK_v) , spawn "xcalib -i -a")
              ,((mod4Mask, xK_r) , spawn "xmonad --restart")
              ,((mod1Mask .|. controlMask, xK_Delete), spawn "urxvt -name htop -e htop") 
              ,((mod4Mask, xK_f), sendMessage $ Toggle NBFULL)
              ,((mod4Mask,                 xK_Right), sendMessage $ Go R)
              ,((mod4Mask,                 xK_Left ), sendMessage $ Go L)
              ,((mod4Mask,                 xK_Up   ), sendMessage $ Go U)
              ,((mod4Mask,                 xK_Down ), sendMessage $ Go D)
              ,((mod4Mask .|. shiftMask, xK_Right), sendMessage $ Swap R)
              ,((mod4Mask .|. shiftMask, xK_Left ), sendMessage $ Swap L)
              ,((mod4Mask .|. shiftMask, xK_Up   ), sendMessage $ Swap U)
              ,((mod4Mask .|. shiftMask, xK_Down ), sendMessage $ Swap D)
              ,((mod4Mask .|. controlMask, xK_Up),  spawn "amixer -q sset Master 5%+")
              ,((mod4Mask .|. controlMask, xK_Down),  spawn "amixer -q sset Master 5%-")
              ,((mod4Mask .|. controlMask, xK_Left),  spawn "xbacklight -dec 2")
              ,((mod4Mask .|. controlMask, xK_Right),  spawn "xbacklight -inc 3")
              ] 

keysToDel x = [] --[((mod4Mask .|. shiftMask), xK_c)] 

-- keysToAdd can override default key-bindings
newKeys x = M.union (M.fromList (keysToAdd x))  (keys def x) 
myKeys x = foldr M.delete (newKeys x) (keysToDel x) 

-- Command to launch the bar.
myBar =  "xmobar ~/.xmonad/xmobarrc"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#bababa" "#029900" . wrap "[" "]" 
                 ,ppWsSep = " | "    
                 ,ppUrgent = xmobarColor "yellow" "red" . xmobarStrip        
                }

myLayoutHook = (windowNavigation . mkToggle (single NBFULL) ) $ Grid ||| Mirror tiled ||| tiled
               where
                  tiled   = Tall nmaster delta ratio
                  nmaster = 1
                  ratio   = 1/2
                  delta   = 3/100



-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = desktopConfig
     { layoutHook =  smartBorders $  myLayoutHook
     , terminal    = "urxvt"
     , modMask     = mod4Mask
     , borderWidth = 1
     , normalBorderColor = "#000000"
     , focusedBorderColor = "#1d71ef"
     , workspaces  = myWorkspaces
     , manageHook = myManageHook <+> manageHook desktopConfig
     , keys = myKeys
     , startupHook = do 
            setWMName "LG3D"  --workaround for java app
            spawn "feh --bg-scale ~/.xmonad/wallpaper.jpg"
            spawn "xsetroot -cursor_name left_ptr"
     }  



-- main = do
--     dbus <- D.connectSession
--     -- Request access to the DBus name
--     D.requestName dbus (D.busName_ "org.xmonad.Log")
--         [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
    
--     xmonad $ def { logHook = dynamicLogWithPP (myLogHook dbus) }





main =  xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig -- { logHook = dynamicLogWithPP (myLogHook dbus) }


-- myLogHook :: D.Client -> PP
-- myLogHook dbus = def { ppOutput = dbusOutput dbus }
    
-- -- Emit a DBus signal on log updates
-- dbusOutput :: D.Client -> String -> IO ()
-- dbusOutput dbus str = do
--     let signal = (D.signal objectPath interfaceName memberName) {
--             D.signalBody = [D.toVariant $ UTF8.decodeString str]
--         }
--     D.emit dbus signal
--   where
--     objectPath = D.objectPath_ "/org/xmonad/Log"
--     interfaceName = D.interfaceName_ "org.xmonad.Log"
--     memberName = D.memberName_ "Update"
