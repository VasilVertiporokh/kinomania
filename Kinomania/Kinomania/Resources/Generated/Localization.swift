// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localization {
  internal enum General {
    /// Cancel
    internal static let cancel = Localization.tr("Localizable", "general.cancel", fallback: "Cancel")
    /// Error
    internal static let error = Localization.tr("Localizable", "general.error", fallback: "Error")
    /// You are offline. Please, enable your Wi-Fi or connect using cellular data.
    internal static let networkError = Localization.tr("Localizable", "general.networkError", fallback: "You are offline. Please, enable your Wi-Fi or connect using cellular data.")
    /// Localizable.strings
    ///   Kinomania
    /// 
    ///   Created by Vasia Vertiporoh on 27/06/2024.
    internal static let ok = Localization.tr("Localizable", "general.ok", fallback: "OK")
  }
  internal enum Movies {
    /// Search
    internal static let searchBarPlaceholder = Localization.tr("Localizable", "movies.searchBarPlaceholder", fallback: "Search")
    internal enum Sort {
      /// Popular
      internal static let popular = Localization.tr("Localizable", "movies.sort.popular", fallback: "Popular")
      /// User votes
      internal static let votes = Localization.tr("Localizable", "movies.sort.votes", fallback: "User votes")
    }
  }
  internal enum MoviesDetails {
    /// Rating
    internal static let ratingLabel = Localization.tr("Localizable", "moviesDetails.ratingLabel", fallback: "Rating")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
