//
//  PackageListAPICase.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 14.09.2023.
//

import NLab

protocol PackageListAPICaseInterface: AnyObject {
  func list() async -> APIResponse<[PackageItemResponse]>?
}

final class PackageListAPICase: PackageListAPICaseInterface {
  let packageAPI: PackageAPIInterface
  
  init(packageAPI: PackageAPIInterface = PackageAPI()) {
    self.packageAPI = packageAPI
  }
  
  func list() async -> APIResponse<[PackageItemResponse]>? {
    await packageAPI.list().startAsync()
  }
}
