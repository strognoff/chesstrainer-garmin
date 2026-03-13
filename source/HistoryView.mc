import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class HistoryView extends WatchUi.View {
    var currentPage = 0;
    var itemsPerPage = 6;

    function initialize() {
        WatchUi.View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 5, Graphics.FONT_SMALL, "History", Graphics.TEXT_JUSTIFY_CENTER);
        
        var solved = Storage.getSolvedPuzzles();
        var incorrect = Storage.getIncorrectPuzzles();
        
        var total = solved.size() + incorrect.size();
        var startIdx = currentPage * itemsPerPage;
        
        if (total == 0) {
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
            dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_SMALL, "No history yet", Graphics.TEXT_JUSTIFY_CENTER);
        } else {
            for (var i = 0; i < itemsPerPage; i++) {
                var idx = startIdx + i;
                if (idx >= total) { break; }
                
                var y = 35 + (i * 25);
                var puzzleNum;
                var status;
                
                if (idx < solved.size()) {
                    puzzleNum = solved[idx];
                    status = "Solved";
                    dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
                } else {
                    puzzleNum = incorrect[idx - solved.size()];
                    status = "Failed";
                    dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                }
                
                dc.drawText(20, y, Graphics.FONT_SMALL, "Puzzle " + (puzzleNum + 1), Graphics.TEXT_JUSTIFY_LEFT);
                dc.drawText(dc.getWidth() - 20, y, Graphics.FONT_SMALL, status, Graphics.TEXT_JUSTIFY_RIGHT);
            }
        }
        
        // Navigation hint
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() - 20, Graphics.FONT_TINY, "ESC: return", Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function handleUp() as Void {
        if (currentPage > 0) {
            currentPage--;
            WatchUi.requestUpdate();
        }
    }
    
    function handleDown() as Void {
        currentPage++;
        WatchUi.requestUpdate();
    }
}

class HistoryDelegate extends WatchUi.InputDelegate {
    var view as HistoryView;

    function initialize(hView as HistoryView) {
        WatchUi.InputDelegate.initialize();
        view = hView;
    }

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        var keyCode = key.getKey();
        
        if (keyCode == WatchUi.KEY_ESC) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        } else if (keyCode == WatchUi.KEY_UP) {
            view.handleUp();
            return true;
        } else if (keyCode == WatchUi.KEY_DOWN) {
            view.handleDown();
            return true;
        }
        return false;
    }
}
