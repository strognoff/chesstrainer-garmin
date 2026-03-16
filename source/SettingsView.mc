
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class SettingsView extends WatchUi.View {
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
        
        // Title
        dc.setColor(COLOR_ACCENT, Graphics.COLOR_BLACK);
        dc.drawText(width / 2, 10, Graphics.FONT_MEDIUM, "SETTINGS", Graphics.TEXT_JUSTIFY_CENTER);
        
        var centerX = width / 2;
        var startY = height / 2 - 30;  // Position it in the middle of the screen
        
        // Get current setting
        var useAscii = Storage.getUseAsciiPieces();
        var displayMode = useAscii ? "ASCII" : "Bitmap";
        
        // Draw setting item
        drawSettingItem(dc, centerX, startY, 0, "Piece Display", displayMode);
        
        // Instructions
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        dc.drawText(width / 2, 225, Graphics.FONT_XTINY, "ENTER: Toggle", Graphics.TEXT_JUSTIFY_CENTER);
     }

    function drawSettingItem(dc as Dc, x as Number, y as Number, index as Number, title as String, value as String) as Void {
        var isSelected = (index == currentSelection);
        
        // Draw title above the value
        if (isSelected) {
            dc.setColor(COLOR_BLUE, Graphics.COLOR_BLACK);
        } else {
            dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        }
        
        dc.drawText(x, y - 20, Graphics.FONT_SMALL, title, Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw current value below the title
        if (isSelected) {
            dc.setColor(COLOR_GREEN, Graphics.COLOR_BLACK);
        } else {
            dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        }
        dc.drawText(x, y + 5, Graphics.FONT_MEDIUM, value, Graphics.TEXT_JUSTIFY_CENTER);
    }

    function togglePieceSetting() as Void {
        var currentValue = Storage.getUseAsciiPieces();
        Storage.setUseAsciiPieces(!currentValue);
        WatchUi.requestUpdate();
    }
}

class SettingsDelegate extends WatchUi.InputDelegate {
    var view as SettingsView;

    function initialize(settingsView as SettingsView) {
        WatchUi.InputDelegate.initialize();
        view = settingsView;
    }

    function onKeyPressed(key as WatchUi.KeyEvent) as Boolean {
        var keyCode = key.getKey();
        
        if (keyCode == WatchUi.KEY_ENTER) {
            view.togglePieceSetting();
            return true;
        } else if (keyCode == WatchUi.KEY_ESC) {
            WatchUi.popView(WatchUi.SLIDE_RIGHT);
            return true;
        }
        
        return false;
    }
}