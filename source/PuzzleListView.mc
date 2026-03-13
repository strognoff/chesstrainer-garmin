using Toybox.WatchUi;
using Toybox.System;

class PuzzleListView extends WatchUi.View {
    var currentPage = 0;
    var itemsPerPage = 5;

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc) {
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
                status = "✓";
            } else if (Storage.isIncorrect(idx)) {
                dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
                status = "✗";
            } else {
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
                status = " ";
            }
            
            dc.drawText(10, y, Graphics.FONT_SMALL, (idx + 1) + ". " + status, Graphics.TEXT_JUSTIFY_LEFT);
        }
        
        // Navigation hint
        dc.setColor(Graphics.COLOR_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() - 20, Graphics.FONT_TINY, "< UP/DOWN > SEL", Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onKey(key) {
        var total = PuzzleData.getPuzzleCount();
        var pages = (total + itemsPerPage - 1) / itemsPerPage;
        
        if (key.key == WatchUi.KEY_UP) {
            if (currentPage > 0) {
                currentPage--;
                WatchUi.requestUpdate();
            }
            return true;
        } else if (key.key == WatchUi.KEY_DOWN) {
            if (currentPage < pages - 1) {
                currentPage++;
                WatchUi.requestUpdate();
            }
            return true;
        } else if (key.key == WatchUi.KEY_ENTER) {
            var idx = currentPage * itemsPerPage;
            WatchUi.pushView(new BoardView(idx), new BoardDelegate(idx), WatchUi.SLIDE_LEFT);
            return true;
        }
        return false;
    }
}

class PuzzleListDelegate extends WatchUi.InputDelegate {
    var view;

    function initialize() {
        InputDelegate.initialize();
    }

    function onKey(key) {
        return view.onKey(key);
    }
}
