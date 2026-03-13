import Toybox.Lang;
import Toybox.Application;
import Toybox.WatchUi;

class ChessTrainerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) as Void {
        // App started
    }

    function onStop(state) as Void {
        // App stopped
    }

    function getInitialView() {
        var menuView = new MenuView();
        return [ menuView, new MenuDelegate(menuView) ] as [WatchUi.View, WatchUi.InputDelegate];
    }
}
