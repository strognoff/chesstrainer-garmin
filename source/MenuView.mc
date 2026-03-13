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
        var centerX = width / 2;
        
        // Dark background
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Title with accent
        dc.setColor(COLOR_ACCENT, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, 20, Graphics.FONT_MEDIUM, "ChessTrainer", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Subtitle at Y=57
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, 57, Graphics.FONT_XTINY, "Tactical Training", Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw menu items starting at Y=85
        var itemHeight = 40;
        var startY = 85;
        
        // START
        drawMenuItem(dc, centerX, startY, 0, "START", "> Play Puzzles");
        
        // STATS
        drawMenuItem(dc, centerX, startY + itemHeight, 1, "STATS", "> View Progress");
        
        // HISTORY
        drawMenuItem(dc, centerX, startY + (itemHeight * 2), 2, "HISTORY", "> Past Games");
        
        // Footer starting at Y=240
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, 240, Graphics.FONT_XTINY, "UP/DOWN: Navigate", Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function drawMenuItem(dc as Dc, centerX as Number, y as Number, index as Number, title as String, subtitle as String) as Void {
        var isSelected = (index == currentSelection);
        
        if (isSelected) {
            // Selected item - bright and bold
            dc.setColor(COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX - 70, y, Graphics.FONT_SMALL, ">", Graphics.TEXT_JUSTIFY_LEFT);
            
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX - 50, y, Graphics.FONT_MEDIUM, title, Graphics.TEXT_JUSTIFY_LEFT);
            
            dc.setColor(COLOR_ACCENT, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX - 50, y + 20, Graphics.FONT_XTINY, subtitle, Graphics.TEXT_JUSTIFY_LEFT);
        } else {
            // Unselected item - dimmed
            dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX - 50, y, Graphics.FONT_SMALL, title, Graphics.TEXT_JUSTIFY_LEFT);
            
            dc.setColor(0x333333, Graphics.COLOR_TRANSPARENT);
            dc.drawText(centerX - 50, y + 17, Graphics.FONT_XTINY, subtitle, Graphics.TEXT_JUSTIFY_LEFT);
        }
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
