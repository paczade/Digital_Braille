import UIKit

// Braille mapping for letters a-z and numbers 0-9
let brailleMap: [Character: String] = [
    "a": "100000",
    "b": "101000",
    "c": "110000",
    "d": "110100",
    "e": "100100",
    "f": "111000",
    "g": "111100",
    "h": "101100",
    "i": "011000",
    "j": "011100",
    "k": "100010",
    "l": "101010",
    "m": "110010",
    "n": "110110",
    "o": "100110",
    "p": "111010",
    "q": "111110",
    "r": "101110",
    "s": "011010",
    "t": "011110",
    "u": "100011",
    "v": "101011",
    "w": "011101",
    "x": "110011",
    "y": "110111",
    "z": "100111",
    "0": "011100",
    "1": "100000",
    "2": "101000",
    "3": "110000",
    "4": "110100",
    "5": "100100",
    "6": "111000",
    "7": "111100",
    "8": "101100",
    "9": "011000"
]

// Vibration functions for iOS
func vibrateShortPositive() {
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
}

func vibrateShortError() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}

func vibrateNextLetter() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

// Function to convert text to Braille vibrations
func vibrateBraille(text: String) {
    for char in text.lowercased() {
        let code = brailleMap[char] ?? "000000" // Default to empty cell

        for dot in code {
            if dot == "1" {
                vibrateShortPositive() // Active dot
            } else {
                vibrateShortError() // Inactive dot / error
            }
            // Small pause between dots
            Thread.sleep(forTimeInterval: 0.15)
        }

        // Vibration for next letter
        vibrateNextLetter()
        Thread.sleep(forTimeInterval: 0.3) // Pause after letter
    }
}

// Example usage:
// vibrateBraille(text: "hello 123")
