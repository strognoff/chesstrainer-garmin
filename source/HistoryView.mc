import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class HistoryView extends WatchUi.View {
    const COLOR_GREEN = 0x00CC00;
    const COLOR_ACCENT = 0x00FFAA;
    
    var currentPage = 0;
    var itemsPerPage = 5;
    var scrollOffset = 0;

    function initialize() {
        WatchUi.View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Header
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(width / 2, 10, Graphics.FONT_MEDIUM, "History", Graphics.TEXT_JUSTIFY_CENTER);
        
        var solved = Storage.getSolvedPuzzles();
        var incorrect = Storage.getIncorrectPuzzles();
        
        var total = solved.size() + incorrect.size();
        
        // Calculate visible range
        var startIdx = scrollOffset;
        var endIdx = startIdx + itemsPerPage;
        if (endIdx > total) {
            endIdx = total;
        }
        
        if (total == 0) {
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
            dc.drawText(width / 2, height / 2, Graphics.FONT_SMALL, "No history yet", Graphics.TEXT_JUSTIFY_CENTER);
        } else {
            var y = 50;
            var itemHeight = 35;
            
            for (var i = startIdx; i < endIdx; i++) {
                var puzzleNum;
                var status;
                var statusColor;
                
                if (i < solved.size()) {
                    puzzleNum = solved[i];
                    status = "Solved";
                    statusColor = COLOR_GREEN;
                } else {
                    puzzleNum = incorrect[i - solved.size()];
                    status = "Failed";
                    statusColor = Graphics.COLOR_RED;
                }
                
                // Get puzzle name
                var puzzleName = PuzzleData.getPuzzleName(puzzleNum);
                
                // Draw background for item
                dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_DK_GRAY);
                dc.fillRectangle(10, y, width - 20, itemHeight - 2);
                
                // Draw puzzle number on top line
                dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
                dc.drawText(20, y + 3, Graphics.FONT_XTINY, (puzzleNum + 1).toString(), Graphics.TEXT_JUSTIFY_LEFT);
                
                // Draw puzzle name on bottom line
                dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
                dc.drawText(20, y + 15, Graphics.FONT_XTINY, puzzleName, Graphics.TEXT_JUSTIFY_LEFT);
                
                // Draw status
                dc.setColor(statusColor, Graphics.COLOR_TRANSPARENT);
                dc.drawText(width - 20, y + 9, Graphics.FONT_TINY, status, Graphics.TEXT_JUSTIFY_RIGHT);
                
                y += itemHeight;
            }
            
            // Draw scroll indicator if needed
            if (total > itemsPerPage) {
                var scrollBarHeight = height - 100;
                var scrollBarY = 50;
                var thumbHeight = (itemsPerPage * scrollBarHeight) / total;
                var thumbY = scrollBarY + (scrollOffset * scrollBarHeight) / total;
                
                // Scroll bar background
                dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_DK_GRAY);
                dc.fillRectangle(width - 8, scrollBarY, 4, scrollBarHeight);
                
                // Scroll thumb
                dc.setColor(COLOR_ACCENT, COLOR_ACCENT);
                dc.fillRectangle(width - 8, thumbY, 4, thumbHeight);
            }
        }
        
        // Footer
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(width / 2, 235, Graphics.FONT_XTINY, "UP/DN: scroll", Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function handleUp() as Void {
        if (scrollOffset > 0) {
            scrollOffset--;
            WatchUi.requestUpdate();
        }
    }
    
    function handleDown() as Void {
        var solved = Storage.getSolvedPuzzles();
        var incorrect = Storage.getIncorrectPuzzles();
        var total = solved.size() + incorrect.size();
        
        if (scrollOffset + itemsPerPage < total) {
            scrollOffset++;
            WatchUi.requestUpdate();
        }
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
