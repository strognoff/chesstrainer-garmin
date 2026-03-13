using Toybox.Storage;
using Toybox.System;

class Storage {
    static const KEY_PROGRESS = "chess_progress";
    static const KEY_SOLVED = "solved";
    static const KEY_INCORRECT = "incorrect";
    static const KEY_TIMES = "times";

    static var solvedPuzzles = [];
    static var incorrectPuzzles = [];
    static var puzzleTimes = {};

    static function initialize() {
        var data = Storage.getValue(KEY_PROGRESS);
        if (data != null) {
            solvedPuzzles = data.get(KEY_SOLVED, []);
            incorrectPuzzles = data.get(KEY_INCORRECT, []);
            puzzleTimes = data.get(KEY_TIMES, {});
        }
    }

    static function save() {
        var data = {
            KEY_SOLVED => solvedPuzzles,
            KEY_INCORRECT => incorrectPuzzles,
            KEY_TIMES => puzzleTimes
        };
        Storage.setValue(KEY_PROGRESS, data);
    }

    static function markSolved(puzzleIndex, timeSeconds) {
        if (!isSolved(puzzleIndex)) {
            solvedPuzzles.add(puzzleIndex);
        }
        puzzleTimes[puzzleIndex] = timeSeconds;
        save();
    }

    static function markIncorrect(puzzleIndex) {
        if (!incorrectPuzzles.contains(puzzleIndex)) {
            incorrectPuzzles.add(puzzleIndex);
        }
        save();
    }

    static function isSolved(puzzleIndex) {
        return solvedPuzzles.contains(puzzleIndex);
    }

    static function isIncorrect(puzzleIndex) {
        return incorrectPuzzles.contains(puzzleIndex);
    }

    static function getStats() {
        var total = PuzzleData.getPuzzleCount();
        var solved = solvedPuzzles.size();
        var incorrect = incorrectPuzzles.size();
        
        // Calculate average time
        var totalTime = 0;
        var count = 0;
        for (var i = 0; i < puzzleTimes.size(); i++) {
            var key = puzzleTimes.keys()[i];
            if (key != null) {
                totalTime += puzzleTimes[key];
                count++;
            }
        }
        var avgTime = count > 0 ? totalTime / count : 0;
        
        return {
            "total" => total,
            "solved" => solved,
            "incorrect" => incorrect,
            "accuracy" => (solved + incorrect) > 0 ? (solved * 100 / (solved + incorrect)) : 0,
            "avgTime" => avgTime
        };
    }

    static function resetProgress() {
        solvedPuzzles = [];
        incorrectPuzzles = [];
        puzzleTimes = {};
        save();
    }
}
