using Toybox.WatchUi;
using Toybox.System;

class HistoryView extends WatchUi.View {
    var currentPage = 0;
    var itemsPerPage = 6;

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 5, Graphics.FONT_SMALL, "History", Graphics.TEXT_JUSTIFY_CENTER);
        
        var solved = Storage.solvedPuzzles;
        var incorrect = Storage.incorrectPuzzles;
        
        var total = solved.size() + incorrect.size();
        var startIdx = currentPage * itemsPerPage;
        
        if (total == 0) {
            dc.setColor(Graphics.COLOR_GRAY, Graphics.COLOR_BLACK);
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
        dc.setColor(Graphics.COLOR_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() - 20, Graphics.FONT_TINY, "[BACK] return", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onKey(key) {
        if (key.key == WatchUi.KEY_BACK) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        } else if (key.key == WatchUi.KEY_UP) {
            if (currentPage > 0) {
                currentPage--;
                WatchUi.requestUpdate();
            }
            return true;
        } else if (key.key == WatchUi.KEY_DOWN) {
            currentPage++;
            WatchUi.requestUpdate();
            return true;
        }
        return false;
    }
}

class HistoryDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    function onKey(key) {
        return false;
    }
}
