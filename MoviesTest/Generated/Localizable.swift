// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Error
  internal static let error = L10n.tr("Localizable", "error", fallback: "Error")
  /// Invalid URL
  internal static let invalidURLError = L10n.tr("Localizable", "invalidURLError", fallback: "Invalid URL")
  /// Server returned no data
  internal static let noDataError = L10n.tr("Localizable", "noDataError", fallback: "Server returned no data")
  /// Unknown error
  internal static let nullError = L10n.tr("Localizable", "nullError", fallback: "Unknown error")
  /// OK
  internal static let ok = L10n.tr("Localizable", "OK", fallback: "OK")
  /// Localizable.strings
  ///   MoviesTest
  /// 
  ///   Created by Aleksandr Poliakov on 02.10.2022.
  internal static let screen1Title = L10n.tr("Localizable", "Screen1Title", fallback: "Movies")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
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
