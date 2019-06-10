// ---- String Literals ---- //
// predefined String values
let someString = "Some string literal value"

// multi-line
let quotation = """
The White Rabbit put on his spectacles. "Where shall I begin,
please your Majesty?" he asked.

"Begin as the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""

// leading whitespace ignored up to the whitespace before the closing """
let linesWithIndentation = """
    This line doesn't begin with whitespace.
        This line begins with an indent.
    This line doesn't begin with whitespace.
    """

// escaped characters: \0 (null character), \\, \t, \n, \r, \",
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"

// unicode
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1f496}"

// extending string delimiters
let singleLineString = #"Line 1\nLine 2"#
let doubleLineString = #"Line 1\#nLine 2"#
let useTrippleQuotes = #"""
Here are three more double quotes: """
"""#


// ---- Initializing and Empty String ---- //
var emptyString = ""
var anotherEmptyString = String()

// find out if a String is empty
if emptyString.isEmpty {
    print("Nothing to see here...")
}


// ---- String Mutability ---- //
var variableString = "Horse"
variableString += " and carriage"

let constantString = "Highlander"
//constantString += "and another Highlander" // ERROR


// ---- Working with Characters ---- //
// accessing individual characters by iterating in for-loop
for character in "Dog!🐶" {
    print(character)
}

// array of Characters to String
let catCharacters: [Character] = ["C", "a", "t", "!", "🐈"]
let catString = String(catCharacters)


// ---- Concatenating Strings and Characters ---- //
// concatenate with `+`
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

//append
let exclamationMark: Character = "!"
welcome.append(exclamationMark)

// multilines need to end with a empty line
let badStart = """
one
two
"""
let end = """
three
"""
badStart + end

let goodStart = """
one
two

"""
goodStart + end


// ---- String Interpolation ---- //
// for inserting other values into a string
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"


// ---- Unicode ---- //

// extended grapheme clusters
let eAcute: Character = "\u{E9}"
let combinedEAcute: Character = "\u{65}\u{301}"
let enclosedEAcute: Character = "\u{E9}\u{20DD}"

// regional indiciator values
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"


// ---- Counting Characters ---- //
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐫"
print("unusualMenagerie has \(unusualMenagerie.count) characters.")

// with graphemes
var word = "cafe"
print("the number of characters in \(word) is \(word.count)")

word += "\u{301}"  // add an accent to the ending 'e'
print("the number of characters in \(word) is \(word.count)")


// ---- Accessing and Modifying a String ---- //
// use String-specific subscript syntax
let greeting = "Guten Tag!"
greeting[greeting.startIndex]  // get the first char
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]

// `.indices` property to get all indices
for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}

// inserting
var welcomeWord = "hello"
welcomeWord.insert("!", at: welcomeWord.endIndex)
welcomeWord.insert(contentsOf: " there", at: welcomeWord.index(before: welcomeWord.endIndex))

// removing
welcomeWord.remove(at: welcome.index(before: welcome.endIndex))
let range = welcomeWord.index(welcomeWord.endIndex, offsetBy: -6)..<welcomeWord.endIndex
welcomeWord.removeSubrange(range)


// ---- Substrings ---- //

