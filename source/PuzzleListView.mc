import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class PuzzleListView extends WatchUi.View {
    const COLOR_GREEN = 0x00CC00;
    const COLOR_BLUE = 0x0088FF;
    const COLOR_ACCENT = 0x00FFAA;
    
    var selectedIndex = 0;
    var scrollOffset = 0;
    var itemsPerPage = 5;

    function initialize() {
        WatchUi.View.initialize();
    }

    function onShow() as Void {
        // Refresh the view when it's shown to update the "D" markers
        WatchUi.requestUpdate();
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Draw header background with accent color
        dc.setColor(COLOR_BLUE, COLOR_BLUE);
        dc.fillRectangle(0, 0, dc.getWidth(), 50);
        
        // Draw header text (starting at y=15)
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, 15, Graphics.FONT_SMALL, "Select Puzzle", Graphics.TEXT_JUSTIFY_CENTER);
        
        var total = PuzzleData.getPuzzleCount();
        
        // Ensure selected index is in view
        if (selectedIndex < scrollOffset) {
            scrollOffset = selectedIndex;
        } else if (selectedIndex >= scrollOffset + itemsPerPage) {
            scrollOffset = selectedIndex - itemsPerPage + 1;
        }
        
        // List starts at y=60
        for (var i = 0; i < itemsPerPage; i++) {
            var idx = scrollOffset + i;
            if (idx >= total) { break; }
            
            var y = 60 + (i * 32);
            
            // Highlight selected item with green
            if (idx == selectedIndex) {
                dc.setColor(COLOR_GREEN, COLOR_GREEN);
                dc.fillRoundedRectangle(3, y - 2, dc.getWidth() - 6, 30, 3);
            }
            
            // Determine status
            var isDone = Storage.isSolved(idx);
            var isIncorrect = Storage.isIncorrect(idx);
            
            // Draw puzzle number at X=30
            var numberColor = Graphics.COLOR_LT_GRAY;
            if (isDone) {
                numberColor = COLOR_ACCENT;
            } else if (isIncorrect) {
                numberColor = Graphics.COLOR_RED;
            }
            
            dc.setColor(numberColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText(30, y + 3, Graphics.FONT_SMALL, (idx + 1).toString(), Graphics.TEXT_JUSTIFY_LEFT);
            
            // Draw puzzle name with "D - " prefix if done, ending at max X=250
            var puzzleName = PuzzleData.getPuzzleName(idx);
            if (isDone) {
                puzzleName = "D - " + puzzleName;
            }
            dc.setColor(idx == selectedIndex ? Graphics.COLOR_WHITE : Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
            dc.drawText(250, y + 3, Graphics.FONT_XTINY, puzzleName, Graphics.TEXT_JUSTIFY_RIGHT);
            
            // Draw separator line (except for last item)
            if (i < itemsPerPage - 1 && idx < total - 1) {
                dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
                dc.drawLine(8, y + 29, dc.getWidth() - 8, y + 29);
            }
        }
        
        // Footer at y=240
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_DK_GRAY);
        dc.fillRectangle(0, 240, dc.getWidth(), dc.getHeight() - 240);
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, 243, Graphics.FONT_XTINY, 
                    (selectedIndex + 1) + " / " + total, Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function handleUp() as Void {
        if (selectedIndex > 0) {
            selectedIndex--;
            WatchUi.requestUpdate();
        }
    }
    
    function handleDown() as Void {
        var total = PuzzleData.getPuzzleCount();
        if (selectedIndex < total - 1) {
            selectedIndex++;
            WatchUi.requestUpdate();
        }
    }
    
    function handleEnter() as Void {
        if (selectedIndex < PuzzleData.getPuzzleCount()) {
            var boardView = new BoardView(selectedIndex);
            WatchUi.pushView(boardView, new BoardDelegate(selectedIndex, boardView), WatchUi.SLIDE_LEFT);
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
