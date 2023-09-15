//
//  APIServiceInterface.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 14.09.2023.
//

import NLab

protocol APIServiceInterface {
  var client: NLClient { get }
}

extension APIServiceInterface {
  var client: NLClient {
    .init(baseURL: .init(string: "https://bundle-api-contentstore-production.bundlenews.co/")!)
  }
}
