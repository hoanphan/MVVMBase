//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Login`.
    static let login = _R.storyboard.login()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Login", bundle: ...)`
    static func login(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.login)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 5 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `activeBorderInput`.
    static let activeBorderInput = Rswift.ColorResource(bundle: R.hostingBundle, name: "activeBorderInput")
    /// Color `borderInput`.
    static let borderInput = Rswift.ColorResource(bundle: R.hostingBundle, name: "borderInput")
    /// Color `errorBorderInput`.
    static let errorBorderInput = Rswift.ColorResource(bundle: R.hostingBundle, name: "errorBorderInput")
    /// Color `priamryButton`.
    static let priamryButton = Rswift.ColorResource(bundle: R.hostingBundle, name: "priamryButton")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "activeBorderInput", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func activeBorderInput(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.activeBorderInput, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "borderInput", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func borderInput(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.borderInput, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "errorBorderInput", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func errorBorderInput(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.errorBorderInput, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "priamryButton", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func priamryButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.priamryButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "activeBorderInput", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func activeBorderInput(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.activeBorderInput.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "borderInput", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func borderInput(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.borderInput.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "errorBorderInput", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func errorBorderInput(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.errorBorderInput.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "priamryButton", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func priamryButton(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.priamryButton.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `account`.
    static let account = Rswift.ImageResource(bundle: R.hostingBundle, name: "account")
    /// Image `icon_eye`.
    static let icon_eye = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_eye")
    /// Image `icon_invisible_eye`.
    static let icon_invisible_eye = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_invisible_eye")
    /// Image `icon_password`.
    static let icon_password = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_password")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "account", bundle: ..., traitCollection: ...)`
    static func account(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.account, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icon_eye", bundle: ..., traitCollection: ...)`
    static func icon_eye(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_eye, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icon_invisible_eye", bundle: ..., traitCollection: ...)`
    static func icon_invisible_eye(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_invisible_eye, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "icon_password", bundle: ..., traitCollection: ...)`
    static func icon_password(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_password, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Main"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 12 localization keys.
    struct localizable {
      /// en translation: Close
      ///
      /// Locales: en, vi
      static let commonClose = Rswift.StringResource(key: "common.close", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Email
      ///
      /// Locales: en, vi
      static let loginEmail = Rswift.StringResource(key: "login.email", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Email not correct format
      ///
      /// Locales: en, vi
      static let loginEmailNotCorrectFormat = Rswift.StringResource(key: "login.email-not-correct-format", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Email not empty
      ///
      /// Locales: en, vi
      static let loginEmailNotEmpty = Rswift.StringResource(key: "login.email-not-empty", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Không có kết nối mạng.
      ///
      /// Locales: en, vi
      static let networkError = Rswift.StringResource(key: "network-error", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Login
      ///
      /// Locales: en, vi
      static let loginLogin = Rswift.StringResource(key: "login.login", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Lỗi dữ liệu trả về
      ///
      /// Locales: en, vi
      static let parseError = Rswift.StringResource(key: "parse-error", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Password
      ///
      /// Locales: en, vi
      static let loginPassword = Rswift.StringResource(key: "login.password", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Password not empty
      ///
      /// Locales: en, vi
      static let loginPasswordNotEmpty = Rswift.StringResource(key: "login.password-not-empty", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Phiên truy cập của Quý khách đã hết hạn. Vui lòng đăng nhập lại.
      ///
      /// Locales: en, vi
      static let tokenExpire = Rswift.StringResource(key: "token-expire", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Thời gian xử lý quá chậm. Vui lòng thử lại sau.
      ///
      /// Locales: en, vi
      static let requestTimeOut = Rswift.StringResource(key: "request-time-out", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)
      /// en translation: Đã xảy ra sự cố. Vui lòng thử lại sau.
      ///
      /// Locales: en, vi
      static let someThingWrong = Rswift.StringResource(key: "some-thing-wrong", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en", "vi"], comment: nil)

      /// en translation: Close
      ///
      /// Locales: en, vi
      static func commonClose(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("common.close", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "common.close"
        }

        return NSLocalizedString("common.close", bundle: bundle, comment: "")
      }

      /// en translation: Email
      ///
      /// Locales: en, vi
      static func loginEmail(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("login.email", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "login.email"
        }

        return NSLocalizedString("login.email", bundle: bundle, comment: "")
      }

      /// en translation: Email not correct format
      ///
      /// Locales: en, vi
      static func loginEmailNotCorrectFormat(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("login.email-not-correct-format", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "login.email-not-correct-format"
        }

        return NSLocalizedString("login.email-not-correct-format", bundle: bundle, comment: "")
      }

      /// en translation: Email not empty
      ///
      /// Locales: en, vi
      static func loginEmailNotEmpty(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("login.email-not-empty", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "login.email-not-empty"
        }

        return NSLocalizedString("login.email-not-empty", bundle: bundle, comment: "")
      }

      /// en translation: Không có kết nối mạng.
      ///
      /// Locales: en, vi
      static func networkError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("network-error", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "network-error"
        }

        return NSLocalizedString("network-error", bundle: bundle, comment: "")
      }

      /// en translation: Login
      ///
      /// Locales: en, vi
      static func loginLogin(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("login.login", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "login.login"
        }

        return NSLocalizedString("login.login", bundle: bundle, comment: "")
      }

      /// en translation: Lỗi dữ liệu trả về
      ///
      /// Locales: en, vi
      static func parseError(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("parse-error", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "parse-error"
        }

        return NSLocalizedString("parse-error", bundle: bundle, comment: "")
      }

      /// en translation: Password
      ///
      /// Locales: en, vi
      static func loginPassword(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("login.password", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "login.password"
        }

        return NSLocalizedString("login.password", bundle: bundle, comment: "")
      }

      /// en translation: Password not empty
      ///
      /// Locales: en, vi
      static func loginPasswordNotEmpty(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("login.password-not-empty", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "login.password-not-empty"
        }

        return NSLocalizedString("login.password-not-empty", bundle: bundle, comment: "")
      }

      /// en translation: Phiên truy cập của Quý khách đã hết hạn. Vui lòng đăng nhập lại.
      ///
      /// Locales: en, vi
      static func tokenExpire(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("token-expire", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "token-expire"
        }

        return NSLocalizedString("token-expire", bundle: bundle, comment: "")
      }

      /// en translation: Thời gian xử lý quá chậm. Vui lòng thử lại sau.
      ///
      /// Locales: en, vi
      static func requestTimeOut(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("request-time-out", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "request-time-out"
        }

        return NSLocalizedString("request-time-out", bundle: bundle, comment: "")
      }

      /// en translation: Đã xảy ra sự cố. Vui lòng thử lại sau.
      ///
      /// Locales: en, vi
      static func someThingWrong(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("some-thing-wrong", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "some-thing-wrong"
        }

        return NSLocalizedString("some-thing-wrong", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try login.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct login: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = LoginController

      let bundle = R.hostingBundle
      let name = "Login"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ViewController

      let bundle = R.hostingBundle
      let commonAlertView = StoryboardViewControllerResource<CommonAlertView>(identifier: "CommonAlertView")
      let name = "Main"

      func commonAlertView(_: Void = ()) -> CommonAlertView? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: commonAlertView)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.main().commonAlertView() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'commonAlertView' could not be loaded from storyboard 'Main' as 'CommonAlertView'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
