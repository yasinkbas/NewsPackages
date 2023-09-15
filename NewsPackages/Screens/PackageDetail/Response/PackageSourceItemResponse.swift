//
//  PackageSourceItemResponse.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 15.09.2023.
//

import Foundation

struct PackageSourceItemResponse: Decodable, Identifiable {
  let id: Int
  var isAdded: Bool
  let name: String
  let index: Int
  let channelCategoryID: Int
  let categoryLocalizationKey: String
  let countryID: Int
  let isVideoChannel: Bool
  
  enum CodingKeys: String, CodingKey {
    case id, isAdded, name, index, categoryLocalizationKey, isVideoChannel
    case channelCategoryID = "channelCategoryId"
    case countryID = "countryId"
  }
}
