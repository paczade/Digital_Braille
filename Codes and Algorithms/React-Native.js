// Import Vibration API from React Native
import { Vibration } from 'react-native';

// Braille mapping for letters a-z and numbers 0-9
// Each character maps to a 6-dot Braille cell (string of 1s and 0s)
const brailleMap = {
  a: "100000", b: "101000", c: "110000", d: "110100", e: "100100",
  f: "111000", g: "111100", h: "101100", i: "011000", j: "011100",
  k: "100010", l: "101010", m: "110010", n: "110110", o: "100110",
  p: "111010", q: "111110", r: "101110", s: "011010", t: "011110",
  u: "100011", v: "101011", w: "011101", x: "110011", y: "110111",
  z: "100111",
  "0": "011100", "1": "100000", "2": "101000", "3": "110000",
  "4": "110100", "5": "100100", "6": "111000", "7": "111100",
  "8": "101100", "9": "011000"
};

// Vibration durations (in milliseconds)
const SHORT_VIBRATE = 100;      // Vibration for active Braille dot
const ERROR_VIBRATE = 50;       // Vibration for inactive dot (error)
const NEXT_LETTER_VIBRATE = 300; // Vibration to indicate next letter

// Function to convert text to Braille vibrations
export function vibrateBraille(text) {
  text.toLowerCase().split('').forEach(ch => {
    const code = brailleMap[ch] || "000000"; // Default empty cell

    // Vibrate for each dot in the Braille cell
    code.split('').forEach(dot => {
      const duration = dot === '1' ? SHORT_VIBRATE : ERROR_VIBRATE;
      Vibration.vibrate(duration);
      // Small pause between dots
      const pause = 50;
      const waitTill = Date.now() + duration + pause;
      while (Date.now() < waitTill) {} // simple blocking pause
    });

    // Vibration for next letter
    Vibration.vibrate(NEXT_LETTER_VIBRATE);
    const waitTillLetter = Date.now() + NEXT_LETTER_VIBRATE + 50;
    while (Date.now() < waitTillLetter) {} // pause after letter
  });
}

// Example usage:
// vibrateBraille("hello 123");
