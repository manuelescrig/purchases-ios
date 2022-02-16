//
//  PromotionalOfferAPI.swift
//  SwiftAPITester
//
//  Created by Nacho Soto on 1/5/22.
//

import RevenueCat

var discount: StoreProductDiscount!

func checkStoreProductDiscountAPI() {
    let offerIdentifier: String? = discount.offerIdentifier
    let currentyCode: String? = discount.currencyCode
    let price: Decimal = discount.price
    let paymentMode: StoreProductDiscount.PaymentMode = discount.paymentMode
    let subscriptionPeriod: SubscriptionPeriod = discount.subscriptionPeriod

    print(
        offerIdentifier!,
        currentyCode!,
        price,
        paymentMode,
        subscriptionPeriod
    )
}

var mode: StoreProductDiscount.PaymentMode!

func checkPaymentModeEnum() {
    switch mode! {
    case
            .payAsYouGo,
            .payUpFront,
            .freeTrial:
        break

    @unknown default: fatalError()
    }
}

var type: StoreProductDiscount.DiscountType!

func checkTypeEnum() {
    switch type! {
    case
            .introductory,
            .promotional:
        break

    @unknown default: fatalError()
    }
}
