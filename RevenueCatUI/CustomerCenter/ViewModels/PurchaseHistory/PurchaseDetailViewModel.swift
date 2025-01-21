//
//  Copyright RevenueCat Inc. All Rights Reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      https://opensource.org/licenses/MIT
//
//  PurchaseHistoryViewModel.swift
//
//
//  Created by Facundo Menzella on 14/1/25.
//

import Foundation
import SwiftUI

import RevenueCat

#if os(iOS)

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
final class PurchaseDetailViewModel: ObservableObject {

    @Environment(\.localization)
    private var localization: CustomerCenterConfigData.Localization

    @Published var items: [PurchaseDetailItem] = []

    var localizedOwnership: String? {
        switch purchaseInfo {
        case .subscription(let subscriptionInfo):
            subscriptionInfo.ownershipType == .familyShared
            ? localization.commonLocalizedString(for: .sharedThroughFamilyMember)
            : nil
        case .nonSubscription:
            nil
        }
    }

    init(purchaseInfo: PurchaseInfo) {
        self.purchaseInfo = purchaseInfo
    }

    func didAppear() async {
        await fetchProduct()
    }

    // MARK: - Private

    private let purchaseInfo: PurchaseInfo
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
private extension PurchaseDetailViewModel {

    func fetchProduct() async {
        guard
            let product = await Purchases.shared.products([purchaseInfo.productIdentifier]).first
        else {
            return
        }

        await MainActor.run {
            var items: [PurchaseDetailItem] = [
            .productName(product.localizedTitle)
        ]

        items.append(contentsOf: purchaseInfo.purchaseDetailItems)

            self.items = items
        }
    }
}

#endif
