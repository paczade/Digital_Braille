import android.content.Context
import android.os.VibrationEffect
import android.os.Vibrator

// Braille mapping for English letters a-z and numbers 0-9
// Each character maps to a 6-dot Braille cell (string of 1s and 0s)
val brailleMap = mapOf(
    'a' to "100000",
    'b' to "101000",
    'c' to "110000",
    'd' to "110100",
    'e' to "100100",
    'f' to "111000",
    'g' to "111100",
    'h' to "101100",
    'i' to "011000",
    'j' to "011100",
    'k' to "100010",
    'l' to "101010",
    'm' to "110010",
    'n' to "110110",
    'o' to "100110",
    'p' to "111010",
    'q' to "111110",
    'r' to "101110",
    's' to "011010",
    't' to "011110",
    'u' to "100011",
    'v' to "101011",
    'w' to "011101",
    'x' to "110011",
    'y' to "110111",
    'z' to "100111",
    '0' to "011100",
    '1' to "100000",
    '2' to "101000",
    '3' to "110000",
    '4' to "110100",
    '5' to "100100",
    '6' to "111000",
    '7' to "111100",
    '8' to "101100",
    '9' to "011000"
)

// Vibration durations (in milliseconds)
val SHORT_VIBRATE = 100L       // Short vibration for active Braille dot
val ERROR_VIBRATE = 50L        // Short vibration for inactive dot (error feedback)
val NEXT_LETTER_VIBRATE = 300L // Vibration indicating change to next letter

// Function to convert text to Braille vibrations
fun vibrateBraille(context: Context, text: String) {
    // Get Vibrator service from Android system
    val vibrator = context.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator

    // Process each character in the input text
    text.lowercase().forEach { ch ->
        // Get Braille code for character, default to all zeros if not mapped
        val code = brailleMap[ch] ?: "000000"

        // Vibrate for each dot in the Braille cell
        code.forEach { dot ->
            // Determine vibration duration based on dot state
            val duration = if (dot == '1') SHORT_VIBRATE else ERROR_VIBRATE
            // Trigger vibration
            vibrator.vibrate(VibrationEffect.createOneShot(duration, VibrationEffect.DEFAULT_AMPLITUDE))
            // Short pause between dots
            Thread.sleep(duration + 50)
        }

        // Vibration for moving to the next letter
        vibrator.vibrate(VibrationEffect.createOneShot(NEXT_LETTER_VIBRATE, VibrationEffect.DEFAULT_AMPLITUDE))
        // Pause after letter change
        Thread.sleep(NEXT_LETTER_VIBRATE + 50)
    }
}

// Example usage:
// vibrateBraille(this, "hello 123")
// This will convert the text into Braille vibrations:
// - Active dot: short vibration
// - Inactive dot: short error vibration
// - End of letter: longer vibration to indicate moving to next character
