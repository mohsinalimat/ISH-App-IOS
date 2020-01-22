//
//  StructureModel.swift
//  ISH
//
//  Created by Admin on 13/05/19.
//  Copyright © 2019 Indian Smart Hub. All rights reserved.
//

import Foundation

//MARK: - Login Struct
/***************************************************************/

struct LoginData : Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case success = "success"
        case message = "message"
        case customerSucess = "customerSuccess"
        case customerID = "customerId"
        case firstName = "firstname"
        case lastName = "lastname"
        case email = "email"
        
        
    }
    let success : Int?
    let message : String?
    let customerSucess : String?
    let customerID : String?
    let firstName : String?
    let lastName : String?
    let email : String?
}



//MARK: - Home Featured Products Struct
/***************************************************************/

struct HomeFeaturedRoot: Codable {
    let success, message: String
    let featuredProduct: [HomeFeaturedData]
}

struct HomeFeaturedData : Codable {
    let id, sku, name: String
    let price: Int
    let label: String
    let regularPrice: Int
    let shortdescription, rewardpoint: String
    let qty: Int
    let wishlist: String
    let img: String
    let configurable: String
    
    enum CodingKeys: String, CodingKey {
        case id, sku, name, price, label
        case regularPrice = "regular_price"
        case shortdescription, rewardpoint, qty, wishlist, img, configurable
    }
}

//MARK: - Home Slider Struct
/***************************************************************/

struct HomeSliderRoot: Codable {
    let success, message: String
    let slider: [HomeSliderData]
}

struct HomeSliderData: Codable {
    let id: String
    let image: String
    let title: String
}

//MARK: - Our Services Struct
/***************************************************************/

struct OurServicesRoot: Codable {
    let success, message: String
    let category: [OurServicesData]
}

struct OurServicesData: Codable {
    let id, name: String
    let img: String
}

//MARK: - Wishlist Struct
/***************************************************************/

struct WishlistRoot: Codable {
    let success, message: String
    let addtocart: [WishlistData]?
}

struct WishlistData: Codable {
    let id, name: String
    let price: Int
    let wishlist, sku, qty: String
    let image: String
}


//MARK: - Category/Service Product Struct
/***************************************************************/

struct CategoryProductsRoot: Codable {
    let success, message: String
    let categoryProduct: [CategoryProductData]
}

struct CategoryProductData: Codable {
    let ids, sku, name: String
    let price, regularPrice: String
    let rewardpoint: String?
    let wishlist: String
    let qty: Int
    let stockAvail, shortdescription: String
    let img: String
    
    enum CodingKeys: String, CodingKey {
        case ids, sku, name, price
        case regularPrice = "regular_price"
        case rewardpoint, wishlist, qty
        case stockAvail = "stock_avail"
        case shortdescription, img
    }
}


//MARK: -  New Arrivals Struct
/***************************************************************/
struct NewArrivalsRoot: Codable {
    let success, message: String
    let todayDeals: [NewArrivalsData]
}


struct NewArrivalsData: Codable {
    let id, sku, name: String
    let price, qty, regularPrice: Int
    let label, shortdescription, rewardpoint, wishlist: String
    let img: String
    let configurable: String
    
    enum CodingKeys: String, CodingKey {
        case id, sku, name, price, qty
        case regularPrice = "regular_price"
        case label, shortdescription, rewardpoint, wishlist, img, configurable
    }
}


//MARK: -  Banner Struct
/***************************************************************/

// MARK: - BannerRoot
struct BannerRoot: Codable {
    let success, message: String
    let banner: [BannerData]
}

struct BannerData: Codable {
    let id: String?
    let image: String
    let title: String
    let link : String?
}


//MARK: - Product Description Struct
/***************************************************************/

struct ProductDescriptionRoot: Codable {
    let success, message: String
    let product: [ProductDescriptionData]
}


struct ProductDescriptionData: Codable {
    let id, sku, stockAvail, name: String
    let price, regularPrice: Int
    let shortdescription, productDescription, qty: String
    let minqty: Int
    let rewardpoint: String?
    let vendor, wishlist, cart: String
    let avalable: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id, sku
        case stockAvail = "stock_avail"
        case name, price
        case regularPrice = "regular_price"
        case shortdescription
        case productDescription = "description"
        case qty, minqty, vendor, rewardpoint, wishlist, cart, avalable, image
    }
}




// MARK: - Search Struct
/***************************************************************/
struct SearchRoot: Codable {
    let success, message: String
    let search: [SearchData]
    
    enum CodingKeys: String, CodingKey {
        case success, message
        case search = "Search"
    }
}

struct SearchData: Codable {
    let id, name, sku, price: String
    let regularPrice, shortdescription, searchDescription: String
    let image: String
    let wishlist, qty, stockAvail, configurable: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, sku, price
        case regularPrice = "regular_price"
        case shortdescription
        case searchDescription = "description"
        case image, wishlist, qty
        case stockAvail = "stock_avail"
        case configurable
    }
}



// MARK: - Wallet Struct
/***************************************************************/
struct WalletRoot: Codable {
    let success: Int
    let message, balance: String
    let customerHistory: [WalletData]
}


struct WalletData: Codable {
    let id, point, comment, date: String
}


// MARK: - Orders Struct
/***************************************************************/

struct OrdersRoot: Codable {
    let success: Int
    let message: String
    let customerOrder: [OrdersDetails]
}

// MARK: - CustomerOrder
struct OrdersDetails: Codable {
    let orderid, deliveryCharge, rewardused, orderdate: String
    let baseSubtotal, ordertotal, status: String
    let expectedTime : String
    
    enum CodingKeys: String, CodingKey {
        case orderid
        case deliveryCharge = "DeliveryCharge"
        case rewardused, orderdate
        case baseSubtotal = "base_subtotal"
        case ordertotal, status
        case expectedTime = "expectedtime"
    }
}



// MARK: - Order Details Struct
/***************************************************************/

struct OrdersDetailsRoot: Codable {
    let success, message: String
    let order: [OrdersDetailsData]
    let payment: [OrdersDetailsPaymentData]
    let shipment: [OrdersDetailsShipmentData]
    let billing: [OrdersDetailsBillingData?]
    let items: [OrdersDetailsItemData]
    
    enum CodingKeys: String, CodingKey {
        case success, message
        case order = "Order"
        case payment, shipment, billing, items
    }
}


struct OrdersDetailsBillingData: Codable {
    let firstname, lastname, street, city: String
    let region, postcode, countryID, telephone: String
    
    enum CodingKeys: String, CodingKey {
        case firstname, lastname, street, city, region, postcode
        case countryID = "country_id"
        case telephone = "telephone "
    }
}


struct OrdersDetailsItemData: Codable {
    let id, name, sku, price: String
    let qty: Int
}


struct OrdersDetailsData: Codable {
    let taxAmount, deliveryCharge, file, rewardused: String
    let discountAmount, subtotal, date, status: String
    
    enum CodingKeys: String, CodingKey {
        case taxAmount = "tax_amount"
        case deliveryCharge = "DeliveryCharge"
        case file, rewardused
        case discountAmount = "discount_amount"
        case subtotal, date, status
    }
}

struct OrdersDetailsPaymentData: Codable {
    let method: String
}

struct OrdersDetailsShipmentData: Codable {
    let firstname, lastname, company, street: String
    let city, region, postcode, countryID: String
    let telephone, shipmentid: String
    
    enum CodingKeys: String, CodingKey {
        case firstname, lastname, company, street, city, region, postcode
        case countryID = "country_id"
        case telephone, shipmentid
    }
}


// MARK: - Home Products Details Struct
/***************************************************************/

// MARK: - HomeProductsRoot
struct HomeProductsRoot: Codable {
    let success, message, cateid: String
    let categoryProduct: [HomeProductsData]
}

// MARK: - CategoryProduct
struct HomeProductsData: Codable {
    let id, sku, name: String
    let price, regularPrice: String
    let rewardpoint : String?
    let wishlist, cart: String
    let qty: String
    let stockAvail, shortdescription: String
    let img: String
    
    enum CodingKeys: String, CodingKey {
        case id, sku, name, price
        case regularPrice = "regular_price"
        case rewardpoint, wishlist, cart, qty
        case stockAvail = "stock_avail"
        case shortdescription, img
    }
}


// MARK: - Hologram Products Details Struct
/***************************************************************/

struct HologramRoot: Codable {
    let success, message, cateid: String
    let categoryProduct: [HologramData]
}

struct HologramData: Codable {
    let id, sku, name: String
    let price, regularPrice: String
    let rewardpoint : String?
    let wishlist, cart: String
    let qty: Int
    let stockAvail, shortdescription: String
    let img: String
    
    enum CodingKeys: String, CodingKey {
        case id, sku, name, price
        case regularPrice = "regular_price"
        case rewardpoint, wishlist, cart, qty
        case stockAvail = "stock_avail"
        case shortdescription, img
    }
}


// MARK: - Cart Products Details Struct
/***************************************************************/

struct CartProductsRoot: Codable {
    let success, message: String
    let totalAmount, totalQty: Int
    let addtocart: [CartProductsData]?
    
    enum CodingKeys: String, CodingKey {
        case success, message
        case totalAmount = "Total Amount"
        case totalQty = "Total Qty"
        case addtocart
    }
}

struct CartProductsData: Codable {
    let id, itemID, name, cart: String
    let sku: String
    let qty, price: Int
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case itemID = "item_id"
        case name, cart, sku, qty, price, image
    }
}


// MARK: - Sub Services Struct
/***************************************************************/

struct SubServicesRoot: Codable {
    let success, message: String
    let category: [SubServicesData]
}

struct SubServicesData: Codable {
    let id, name: String
    let img: String
    let url: String
}


// MARK: - Address Struct
/***************************************************************/

struct AddressRoot: Codable {
    let success: Int
    let message: String
    let customerAddress: [AddressData]
}


struct AddressData: Codable {
    let id: Int
    let firstname, lastname, street, city: String
    let region, postcode, countryID, telephone: String
    let defaultbilling, defaulshiping: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, firstname, lastname, street, city, region, postcode
        case countryID = "country_id"
        case telephone, defaultbilling, defaulshiping
    }
}

// MARK: - Reward Struct
/***************************************************************/
struct RewardRoot: Codable {
    let success, message: String
    let customerPoint: [RewardData]
}

// MARK: - CustomerPoint
struct RewardData: Codable {
    let customerIsExit, point: String
}


// MARK: - Home Services Struct
/***************************************************************/

struct HomeServicesRoot: Codable {
    let success, message: String
    let category: [HomeServicesData]
}

struct HomeServicesData: Codable {
    let id, name: String
    let img: String?
    let url: String?
    
}



// MARK: - Home Sub Services Struct
/***************************************************************/

struct HomeSubServicesRoot: Codable {
    let success, message: String
    let category: [HomeSubServicesData]
}

struct HomeSubServicesData: Codable {
    let id, name: String
    let img: String
    let categoryid: Int
    let categoryname: String
    let url: String
}

