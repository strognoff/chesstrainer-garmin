import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class MenuView extends WatchUi.View {
    
    const COLOR_GREEN = 0x00CC00;
    const COLOR_BLUE = 0x0088FF;
    
    var currentSelection = 0; // 0=Start, 1=Stats, 2=History
    
    function initialize() {
        WatchUi.View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, 20, Graphics.FONT_MEDIUM, "ChessTrainer", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw menu items
        for (var i = 0; i < 3; i++) {
            var y = 60 + (i * 30);
            if (i == currentSelection) {
                dc.setColor(COLOR_GREEN, Graphics.COLOR_BLACK);
                dc.drawText(dc.getWidth() / 2, y, Graphics.FONT_SMALL, ">", Graphics.TEXT_JUSTIFY_LEFT);
            } else {
                dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
                dc.drawText(dc.getWidth() / 2, y, Graphics.FONT_SMALL, " ", Graphics.TEXT_JUSTIFY_LEFT);
            }
            
            if (i == 0) {
                dc.setColor(i == currentSelection ? COLOR_GREEN : Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
                dc.drawText(dc.getWidth() / 2 + 15, y, Graphics.FONT_SMALL, "START", Graphics.TEXT_JUSTIFY_LEFT);
            } else if (i == 1) {
                dc.setColor(i == currentSelection ? COLOR_GREEN : Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
                dc.drawText(dc.getWidth() / 2 + 15, y, Graphics.FONT_SMALL, "STATS", Graphics.TEXT_JUSTIFY_LEFT);
            } else if (i == 2) {
                dc.setColor(i == currentSelection ? COLOR_GREEN : Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
                dc.drawText(dc.getWidth() / 2 + 15, y, Graphics.FONT_SMALL, "HISTORY", Graphics.TEXT_JUSTIFY_LEFT);
            }
        }
        
        // Footer hint
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() - 20, Graphics.FONT_TINY, "UP/DOWN: Navigate", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() - 8, Graphics.FONT_TINY, "ENTER: Select", Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function handleUp() as Void {
        if (currentSelection > 0) {
            currentSelection--;
            WatchUi.requestUpdate();
        }
    }
    
    function handleDown() as Void {
        if (currentSelection < 2) {
            currentSelection++;
            WatchUi.requestUpdate();
        }
    }
    
    function handleEnter() as Void {
        if (currentSelection == 0) {
            var puzzleListView = new PuzzleListView();
            WatchUi.pushView(puzzleListView, new PuzzleListDelegate(puzzleListView), WatchUi.SLIDE_LEFT);
        } else if (currentSelection == 1) {
            WatchUi.pushView(new StatsView(), new StatsDelegate(), WatchUi.SLIDE_LEFT);
        } else if (currentSelection == 2) {
            var historyView = new HistoryView();
            WatchUi.pushView(historyView, new HistoryDelegate(historyView), WatchUi.SLIDE_LEFT);
        }
    }
}

class MenuDelegate extends WatchUi.InputDelegate {
    var view as MenuView;

    function initialize(mView as MenuView) {
        WatchUi.InputDelegate.initialize();
        view = mView;
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
        }
        return false;
    }
}
