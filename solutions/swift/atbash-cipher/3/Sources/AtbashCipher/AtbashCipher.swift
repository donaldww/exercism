import Foundation

private enum Group {
  static let size = 5
}

extension String {
  func plainString() -> String {
    return lowercased().map { c -> String in
      switch c {
      case let letter where letter.isLetter:
        // Equivalent of 'z' - letter + 'a' in Go
        let newChar = Character(UnicodeScalar(122 - Int(letter.asciiValue!) + 97)!)
        return String(newChar)
      case _ where c.isNumber:
        return String(c)
      default:
        return ""
      }
    }.joined()
  }
}

enum AtbashCipher {
  static func encode(_ input: String) -> String {
    var spacedString = ""
    for (index, character) in input.plainString().enumerated() {
      if index != 0 && index % Group.size == 0 {
        spacedString.append(" ")
      }
      spacedString.append(character)
    }
    return spacedString
  }

  static func decode(_ input: String) -> String {
    return input.plainString()
  }
}
