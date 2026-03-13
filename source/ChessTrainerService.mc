using Toybox.System;

class ChessTrainerService extends System.ServiceDelegate {
    function initialize() {
        ServiceDelegate.initialize();
    }

    function onStop() {
        // Save any pending data
        Storage.save();
    }
}
