//
//  PackageItemResponse.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 15.09.2023.
//

import Foundation

struct PackageItemResponse: Decodable, Identifiable {
  let id: Int
  let isAdded: Bool
  let name: String
  let description: String
  let index: Int
  let image: String
  let style: PackageItemStyle
  let sourceCount: Int
}

struct PackageItemStyle: Codable {
  let fontColor: String?
}
