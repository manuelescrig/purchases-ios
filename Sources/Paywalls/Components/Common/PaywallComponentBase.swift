//
//  File.swift
//  
//
//  Created by Josh Holtz on 6/11/24.
//
// swiftlint:disable missing_docs
import Foundation

#if PAYWALL_COMPONENTS

public protocol PaywallComponentBase: Codable, Sendable, Hashable, Equatable { }

public enum PaywallComponent: PaywallComponentBase {

    case text(TextComponent)
    case image(ImageComponent)
    case icon(IconComponent)
    case stack(StackComponent)
    case button(ButtonComponent)
    case package(PackageComponent)
    case purchaseButton(PurchaseButtonComponent)
    case stickyFooter(StickyFooterComponent)

    case tabs(TabsComponent)
    case tabControl(TabControlComponent)
    case tabControlButton(TabControlButtonComponent)
    case tabControlToggle(TabControlToggleComponent)

    public enum ComponentType: String, Codable, Sendable {

        case text
        case image
        case icon
        case stack
        case button
        case package
        case purchaseButton = "purchase_button"
        case stickyFooter = "sticky_footer"

        case tabs
        case tabControl = "tab_control"
        case tabControlButton = "tab_control_button"
        case tabControlToggle = "tab_control_toggle"

    }

}

public extension PaywallComponent {
    typealias LocaleID = String
    typealias LocalizationDictionary = [String: PaywallComponentsData.LocalizationData]
    typealias LocalizationKey = String
    typealias ColorHex = String
}

extension PaywallComponent: Codable {

    enum CodingKeys: String, CodingKey {

        case type
        case fallback

    }

    // swiftlint:disable:next cyclomatic_complexity
    public func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)

        var container = encoder.unkeyedContainer()

        switch self {
        case .text(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .image(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .icon(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .stack(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .button(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .package(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .purchaseButton(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .stickyFooter(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .tabs(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .tabControl(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .tabControlButton(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        case .tabControlToggle(let component):
            var container = encoder.unkeyedContainer()
            container.encode(component)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode the raw string for the `type` field
        let typeString = try container.decode(String.self, forKey: .type)

        // Attempt to convert raw string into our `ComponentType` enum
        if let type = ComponentType(rawValue: typeString) {
            self = try Self.decodeType(from: decoder, type: type)
        } else {
            if !container.contains(.fallback) {
                let context = DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription:
                      """
                      Failed to decode unknown type "\(typeString)" without a fallback.
                      """
                )
                throw DecodingError.dataCorrupted(context)
            }

            do {
                // If `typeString` is unknown, try to decode the fallback
                self = try container.decode(PaywallComponent.self, forKey: .fallback)
            } catch DecodingError.valueNotFound {
                let context = DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription:
                      """
                      Failed to decode unknown type "\(typeString)" without a fallback.
                      """
                )
                throw DecodingError.dataCorrupted(context)
            } catch {
                let context = DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription:
                      """
                      Failed to decode fallback for unknown type "\(typeString)".
                      """,
                    underlyingError: error
                )
                throw DecodingError.dataCorrupted(context)
            }
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    private static func decodeType(from decoder: Decoder, type: ComponentType) throws -> PaywallComponent {
        switch type {
        case .text:
            return .text(try TextComponent(from: decoder))
        case .image:
            return .image(try ImageComponent(from: decoder))
        case .icon:
            return .icon(try IconComponent(from: decoder))
        case .stack:
            return .stack(try StackComponent(from: decoder))
        case .button:
            return .button(try ButtonComponent(from: decoder))
        case .package:
            return .package(try PackageComponent(from: decoder))
        case .purchaseButton:
            return .purchaseButton(try PurchaseButtonComponent(from: decoder))
        case .stickyFooter:
            return .stickyFooter(try StickyFooterComponent(from: decoder))
        case .tabs:
            return .tabs(try TabsComponent(from: decoder))
        case .tabControl:
            return .tabControl(try TabControlComponent(from: decoder))
        case .tabControlButton:
            return .tabControlButton(try TabControlButtonComponent(from: decoder))
        case .tabControlToggle:
            return .tabControlToggle(try TabControlToggleComponent(from: decoder))
        }
    }

}

#endif
