import Toybox.Lang;
import Toybox.Application;

class ChessTrainerService extends Application.ServiceDelegate {

    function initialize() {
        ServiceDelegate.initialize();
    }

    function onStop() as Void {
        // Service stopped - no pending data to save
        // Storage saves are done on each operation
    }
}
