import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class MenuView extends WatchUi.View {
    
    const COLOR_GREEN = 0x00CC00;
    const COLOR_BLUE = 0x0088FF;
    const COLOR_ACCENT = 0x00FFAA;
    
    var currentSelection = 0;
    
    function initialize() {
        WatchUi.View.initialize();
    }

    function onUpdate(dc as Dc) as Void {
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Title - reduced font and moved up
        dc.setColor(COLOR_ACCENT, Graphics.COLOR_BLACK);
        dc.drawText(width / 2, 25, Graphics.FONT_SMALL, "CHESS TRAINER", Graphics.TEXT_JUSTIFY_CENTER);
        
        var centerX = width / 2;
        var itemHeight = 35; // Increased spacing between items
        var startY = 70; // Moved up to accommodate more items
        
        // Draw menu items with more spacing
        drawMenuItem(dc, centerX, startY, 0, "PLAY", "> Start Puzzle");
        drawMenuItem(dc, centerX, startY + itemHeight, 1, "STATS", "> View Progress");
        drawMenuItem(dc, centerX, startY + itemHeight * 2, 2, "HISTORY", "> Past Games");
        drawMenuItem(dc, centerX, startY + itemHeight * 3, 3, "SETTINGS", "> Configure");
        
        // Navigation hint - moved to bottom with smaller font
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(width / 2, 245, Graphics.FONT_SYSTEM_XTINY, "Have FUN!", Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function drawMenuItem(dc as Dc, x as Number, y as Number, index as Number, title as String, subtitle as String) as Void {
        var isSelected = (index == currentSelection);
        
        if (isSelected) {
            dc.setColor(COLOR_BLUE, Graphics.COLOR_BLACK);
        } else {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        }
        
            // Reduced font sizes
            dc.drawText(x, y, Graphics.FONT_XTINY, title, Graphics.TEXT_JUSTIFY_CENTER);
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
            dc.drawText(x, y + 18, Graphics.FONT_XTINY, subtitle, Graphics.TEXT_JUSTIFY_CENTER);    }
    
    function moveSelection(delta as Number) as Void {
        currentSelection = (currentSelection + delta + 4) % 4;
        WatchUi.requestUpdate();
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
            view.moveSelection(-1);
            return true;
        } else if (keyCode == WatchUi.KEY_DOWN) {
            view.moveSelection(1);
            return true;
        } else if (keyCode == WatchUi.KEY_ENTER) {
            if (view.currentSelection == 0) {
                // Navigate to puzzle list
                var puzzleView = new PuzzleListView();
                WatchUi.pushView(puzzleView, new PuzzleListDelegate(puzzleView), WatchUi.SLIDE_LEFT);
            } else if (view.currentSelection == 1) {
                // Navigate to stats
                var statsView = new StatsView();
                WatchUi.pushView(statsView, new StatsDelegate(), WatchUi.SLIDE_LEFT);
            } else if (view.currentSelection == 2) {
                // Navigate to history
                var historyView = new HistoryView();
                WatchUi.pushView(historyView, new HistoryDelegate(historyView), WatchUi.SLIDE_LEFT);
            } else if (view.currentSelection == 3) {
                // Navigate to settings
                var settingsView = new SettingsView();
                WatchUi.pushView(settingsView, new SettingsDelegate(settingsView), WatchUi.SLIDE_LEFT);
            }
            return true;
        }
        
        return false;
    }
}
