//
//  PackageDetailAPICaseInterface.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 15.09.2023.
//

import Foundation
import NLab

protocol PackageDetailAPICaseInterface: AnyObject {
  func detail(packageId: Int) async -> [PackageSourceItemResponse]?
}

final class PackageDetailAPICase: PackageDetailAPICaseInterface {
  let packageAPI: PackageAPIInterface
  
  init(packageAPI: PackageAPIInterface = PackageAPI()) {
    self.packageAPI = packageAPI
  }
  
  func detail(packageId: Int) async -> [PackageSourceItemResponse]? {
    await packageAPI.detail(packageId: packageId).startAsync()
  }
}

