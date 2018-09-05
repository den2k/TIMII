//  Copyright © 2017 Schibsted. All rights reserved.

import UIKit

// Flatten an array of dictionaries
func merge(_ dictionaries: [[String: Any]]) -> [String: Any] {
    var result = [String: Any]()
    for dict in dictionaries {
        for (key, value) in dict {
            result[key] = value
        }
    }
    return result
}

private let classPrefix = (Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "")
    .replacingOccurrences(of: "[^a-zA-Z0-9_]", with: "_", options: .regularExpression)

// Get a class by name, adding project prefix if needed
func classFromString(_ name: String) -> AnyClass? {
    return NSClassFromString(name) ?? NSClassFromString("\(classPrefix).\(name)")
}

// Get the name of a class, without project prefix
func nameOfClass(_ name: AnyClass) -> String {
    let name = NSStringFromClass(name)
    let prefix = "\(classPrefix)."
    if name.hasPrefix(prefix) {
        return String(name[prefix.endIndex...])
    }
    return name
}

// Get a protocol by name
func protocolFromString(_ name: String) -> Protocol? {
    return NSProtocolFromString(name) ?? NSProtocolFromString("\(classPrefix).\(name)")
}

// Internal API for converting a path to a full URL
func urlFromString(_ path: String, relativeTo baseURL: URL? = nil) -> URL {
    if path.hasPrefix("~") {
        let path = path.removingPercentEncoding ?? path
        return URL(fileURLWithPath: (path as NSString).expandingTildeInPath)
    } else if let url = URL(string: path, relativeTo: baseURL), url.scheme != nil {
        return url
    }

    // Check if url has a scheme
    if baseURL != nil || path.contains(":") {
        let path = path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? path
        if let url = URL(string: path, relativeTo: baseURL) {
            return url
        }
    }

    // Assume local path
    if (path as NSString).isAbsolutePath {
        return URL(fileURLWithPath: path.removingPercentEncoding ?? path)
    } else {
        return Bundle.main.resourceURL!.appendingPathComponent(path)
    }
}

// MARK: Approximate equality

private let precision: CGFloat = 0.001

extension CGPoint {
    func isNearlyEqual(to other: CGPoint) -> Bool {
        return abs(x - other.x) <= precision && abs(y - other.y) <= precision
    }
}

extension CGSize {
    func isNearlyEqual(to other: CGSize) -> Bool {
        return abs(width - other.width) <= precision && abs(height - other.height) <= precision
    }
}

extension CGRect {
    func isNearlyEqual(to other: CGRect) -> Bool {
        return size.isNearlyEqual(to: other.size) && origin.isNearlyEqual(to: other.origin)
    }
}

extension UIEdgeInsets {
    func isNearlyEqual(to other: UIEdgeInsets) -> Bool {
        return
            abs(left - other.left) <= precision &&
            abs(right - other.right) <= precision &&
            abs(top - other.top) <= precision &&
            abs(bottom - other.bottom) <= precision
    }
}

// MARK: Backwards compatibility

struct IntOptionSet: OptionSet {
    let rawValue: Int
    init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

struct UIntOptionSet: OptionSet {
    let rawValue: UInt
    init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}

#if !swift(>=3.4)

    extension UIFont {
        typealias Weight = UIFontWeight
    }

#endif

#if !swift(>=4)

    extension NSAttributedString {
        struct DocumentType {
            static let html = NSHTMLTextDocumentType
        }

        struct DocumentReadingOptionKey {
            static let documentType = NSDocumentTypeDocumentAttribute
            static let characterEncoding = NSCharacterEncodingDocumentAttribute
        }
    }

    extension NSAttributedStringKey {
        static let foregroundColor = NSForegroundColorAttributeName
        static let font = NSFontAttributeName
        static let paragraphStyle = NSParagraphStyleAttributeName
    }

    extension UIFont.Weight {
        static let ultraLight = UIFontWeightUltraLight
        static let thin = UIFontWeightThin
        static let light = UIFontWeightLight
        static let regular = UIFontWeightRegular
        static let medium = UIFontWeightMedium
        static let semibold = UIFontWeightSemibold
        static let bold = UIFontWeightBold
        static let heavy = UIFontWeightHeavy
        static let black = UIFontWeightBlack
    }

    extension UIFontDescriptor {
        struct AttributeName {
            static let traits = UIFontDescriptorTraitsAttribute
        }

        typealias TraitKey = NSString
    }

    extension UIFontDescriptor.TraitKey {
        static let weight = UIFontWeightTrait as NSString
    }

    extension UILayoutPriority {
        var rawValue: Float { return self }
        init(rawValue: Float) { self = rawValue }

        static let required = UILayoutPriorityRequired
        static let defaultHigh = UILayoutPriorityDefaultHigh
        static let defaultLow = UILayoutPriorityDefaultLow
        static let fittingSizeLevel = UILayoutPriorityFittingSizeLevel
    }

#endif

#if !swift(>=4.2)

    extension UIContentSizeCategory {
        static let didChangeNotification = UIContentSizeCategory.didChangeNotification
    }

    extension NSAttributedString {
        typealias Key = NSAttributedString.Key
    }

    extension NSLayoutConstraint {
        typealias Axis = NSLayoutConstraint.Axis
    }

    extension UIFont {
        typealias TextStyle = UIFont.TextStyle
    }

    extension UIFontDescriptor {
        typealias SymbolicTraits = UIFontDescriptor.SymbolicTraits
    }

    extension UIAccessibilityTraits {
        static var tabBar: UIAccessibilityTraits {
            if #available(iOS 10, *) {
                return UIAccessibilityTraits.tabBar
            }
            preconditionFailure("UIAccessibilityTraitTabBar is not available")
        }

        static let none = UIAccessibilityTraits.none
        static let button = UIAccessibilityTraits.button
        static let link = UIAccessibilityTraits.link
        static let header = UIAccessibilityTraits.header
        static let searchField = UIAccessibilityTraits.searchField
        static let image = UIAccessibilityTraits.image
        static let selected = UIAccessibilityTraits.selected
        static let playsSound = UIAccessibilityTraits.playsSound
        static let keyboardKey = UIAccessibilityTraits.keyboardKey
        static let staticText = UIAccessibilityTraits.staticText
        static let summaryElement = UIAccessibilityTraits.summaryElement
        static let notEnabled = UIAccessibilityTraits.notEnabled
        static let updatesFrequently = UIAccessibilityTraits.updatesFrequently
        static let startsMediaSession = UIAccessibilityTraits.startsMediaSession
        static let adjustable = UIAccessibilityTraits.adjustable
        static let allowsDirectInteraction = UIAccessibilityTraits.allowsDirectInteraction
        static let causesPageTurn = UIAccessibilityTraits.causesPageTurn
    }

    extension UIActivity {
        typealias ActivityType = UIActivity.ActivityType
    }

    extension UIView {
        typealias ContentMode = UIView.ContentMode
        typealias AutoresizingMask = UIView.AutoresizingMask
        typealias TintAdjustmentMode = UIView.TintAdjustmentMode

        static let noIntrinsicMetric = UIView.noIntrinsicMetric

        @nonobjc func bringSubviewToFront(_ subview: UIView) {
            bringSubviewToFront(subview)
        }
    }

    extension UIViewController {
        @nonobjc func addChild(_ child: UIViewController) {
            addChild(child)
        }

        @nonobjc func removeFromParent() {
            removeFromParent()
        }
    }

    extension UIControl {
        typealias State = UIControl.State
        typealias Event = UIControl.Event
        typealias ContentVerticalAlignment = UIControl.ContentVerticalAlignment
        typealias ContentHorizontalAlignment = UIControl.ContentHorizontalAlignment
    }

    extension UIBarButtonItem {
        typealias SystemItem = UIBarButtonItem.SystemItem
        typealias Style = UIBarButtonItem.Style
    }

    extension UIButton {
        typealias ButtonType = UIButton.ButtonType
    }

    extension UIActivityIndicatorView {
        typealias Style = UIActivityIndicatorView.Style
    }

    extension UIProgressView {
        typealias Style = UIProgressView.Style
    }

    extension UIInputView {
        typealias Style = UIInputView.Style
    }

    extension UIDatePicker {
        typealias Mode = UIDatePicker.Mode
    }

    extension UITextField {
        typealias BorderStyle = UITextField.BorderStyle
        typealias ViewMode = UITextField.ViewMode
    }

    extension UITabBar {
        typealias ItemPositioning = UITabBar.ItemPositioning
    }

    extension UITabBarItem {
        typealias SystemItem = UITabBarItem.SystemItem
    }

    extension UITableView {
        typealias Style = UITableView.Style

        static let automaticDimension = UITableView.automaticDimension
    }

    extension UITableViewCell {
        typealias CellStyle = UITableViewCell.CellStyle
        typealias AccessoryType = UITableViewCell.AccessoryType
        typealias FocusStyle = UITableViewCell.FocusStyle
        typealias SelectionStyle = UITableViewCell.SelectionStyle
        typealias SeparatorStyle = UITableViewCell.SeparatorStyle
    }

    extension UISearchBar {
        typealias Style = UISearchBar.Style
    }

    extension UISegmentedControl {
        typealias Segment = UISegmentedControl.Segment
    }

    extension UIScrollView {
        typealias IndicatorStyle = UIScrollView.IndicatorStyle
        typealias IndexDisplayMode = UIScrollView.IndexDisplayMode
        typealias KeyboardDismissMode = UIScrollView.KeyboardDismissMode
    }

    extension UICollectionView {
        typealias ScrollDirection = UICollectionView.ScrollDirection
    }

    extension UIStackView {
        typealias Alignment = UIStackView.Alignment
        typealias Distribution = UIStackView.Distribution
    }

    extension UIWebView {
        typealias PaginationMode = UIWebView.PaginationMode
        typealias PaginationBreakingMode = UIWebView.PaginationBreakingMode
    }

    extension UIAlertController {
        typealias Style = UIAlertController.Style
    }

    extension UIImagePickerController {
        typealias CameraCaptureMode = UIImagePickerController.CameraCaptureMode
        typealias CameraDevice = UIImagePickerController.CameraDevice
        typealias CameraFlashMode = UIImagePickerController.CameraFlashMode
        typealias SourceType = UIImagePickerController.SourceType
        typealias QualityType = UIImagePickerController.QualityType
    }

    extension UISplitViewController {
        typealias DisplayMode = UISplitViewController.DisplayMode
    }

    extension UIBlurEffect {
        typealias Style = UIBlurEffect.Style
    }

#endif
