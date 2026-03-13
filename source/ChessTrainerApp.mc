using Toybox.Application;
using Toybox.WatchUi;
using Toybox.System;

class ChessTrainerApp extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
        // Initialize storage
        Storage.initialize();
    }

    function onStop(state) {
        // Save progress
        Storage.save();
    }

    function getInitialView() {
        return [ new MenuView() ];
    }

    function getServiceDelegate() {
        return [ new ChessTrainerService() ];
    }
}
