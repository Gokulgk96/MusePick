//
//  CommonConstants.swift
//  MusePick
//
//  Created by Gokul Gopalakrishnan on 16/04/25.
//

import Foundation

struct CommonConstants {
    public static let orderNow = "ORDER NOW"
    public static let dismiss = "Dismiss"
    public static let close = "CLOSE"
    public static let mainPageSubHeader = "When placing an order, select the option “Contactless delivery” and the courier will leave your order at the door."
    public static let mainPageHeader = "Non-Contact Deliveries"
    public static let thanksHeader = "Thank you"
    public static let shoppingHeader = "For shopping with us"
    public static let categories = "Categories"
    public static let loading = "Data Loading..."
    public static let error = "Error:"
    public static let search = "Search"
    public static let notAvailable = "Not Available"
    public static let errorCategories = "Error loading categories: "
}

struct CommonImageConstants {
    public static let mainPageImage = "shippingbox.fill"
    public static let glass = "magnifyingglass"
}

struct CommonVariables {
    public static var shoppingCartListCount: Int = 0
    public static var selectedArray: [String: Bool] = [:]
    public static var shoppingCartListItem: [String: String] = [:]
    public static var totalcost: Double = 0.0
    public static var address = ""
    public static var cardNumber = ""
}
