//
//  APIResponse.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 15.09.2023.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
  let bundleStatusCode: Int?
  let errorMessage: String?
  let data: T
}
