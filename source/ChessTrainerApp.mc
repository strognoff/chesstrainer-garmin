import Toybox.Lang;
import Toybox.Application;
import Toybox.WatchUi;

class ChessTrainerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary) as Void {
        // App started - storage is accessed directly via Storage module
    }

    function onStop(state as Dictionary) as Void {
        // App stopped - no explicit save needed as we save on each operation
    }

    function getInitialView() {
        var menuView = new MenuView();
        return [ menuView, new MenuDelegate(menuView) ] as [WatchUi.View, WatchUi.InputDelegate];
    }

    function getServiceDelegate() {
        return [ new ChessTrainerService() ];
    }
}
