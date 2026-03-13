import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class PuzzleListView extends WatchUi.View {
    var currentPage = 0;
    var itemsPerPage = 5;

    function initialize() {
        WatchUi.View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 5, Graphics.FONT_SMALL, "Select Puzzle", Graphics.TEXT_JUSTIFY_CENTER);
        
        var total = PuzzleData.getPuzzleCount();
        var startIdx = currentPage * itemsPerPage;
        
        for (var i = 0; i < itemsPerPage; i++) {
            var idx = startIdx + i;
            if (idx >= total) { break; }
            
            var y = 35 + (i * 30);
            var status = "";
            
            if (Storage.isSolved(idx)) {
                dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
                status = "OK";
            } else if (Storage.isIncorrect(idx)) {
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                status = "X";
            } else {
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
                status = " ";
            }
            
            dc.drawText(10, y, Graphics.FONT_SMALL, (idx + 1) + ". " + status, Graphics.TEXT_JUSTIFY_LEFT);
        }
        
        // Page indicator
        var pages = (total + itemsPerPage - 1) / itemsPerPage;
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() - 20, Graphics.FONT_TINY, "Page " + (currentPage + 1) + "/" + pages, Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function handleUp() as Void {
        if (currentPage > 0) {
            currentPage--;
            WatchUi.requestUpdate();
        }
    }
    
    function handleDown() as Void {
        var total = PuzzleData.getPuzzleCount();
        var pages = (total + itemsPerPage - 1) / itemsPerPage;
        if (currentPage < pages - 1) {
            currentPage++;
            WatchUi.requestUpdate();
        }
    }
    
    function handleEnter() as Void {
        var idx = currentPage * itemsPerPage;
        if (idx < PuzzleData.getPuzzleCount()) {
            WatchUi.pushView(new BoardView(idx), new BoardDelegate(idx), WatchUi.SLIDE_LEFT);
        }
    }
}

class PuzzleListDelegate extends WatchUi.InputDelegate {
    var view as PuzzleListView;

    function initialize(pListView as PuzzleListView) {
        WatchUi.InputDelegate.initialize();
        view = pListView;
    }

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        var keyCode = key.getKey();
        
        if (keyCode == WatchUi.KEY_UP) {
            view.handleUp();
            return true;
        } else if (keyCode == WatchUi.KEY_DOWN) {
            view.handleDown();
            return true;
        } else if (keyCode == WatchUi.KEY_ENTER) {
            view.handleEnter();
            return true;
        } else if (keyCode == WatchUi.KEY_ESC) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        }
        return false;
    }
}
