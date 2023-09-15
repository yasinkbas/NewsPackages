//
//  MockPackageDetailAPICase.swift
//  NewsPackagesTests
//
//  Created by Yasin Akbaş on 15.09.2023.
//

@testable import NewsPackages
import Foundation

final class MockPackageDetailAPICase: PackageDetailAPICaseInterface {

  var invokedDetail = false
  var invokedDetailCount = 0
  var invokedDetailParameters: (packageId: Int, Void)?
  var invokedDetailParametersList = [(packageId: Int, Void)]()
  var stubbedDetailResult: [PackageSourceItemResponse]!

  func detail(packageId: Int) async -> [PackageSourceItemResponse]? {
    invokedDetail = true
    invokedDetailCount += 1
    invokedDetailParameters = (packageId, ())
    invokedDetailParametersList.append((packageId, ()))
    return stubbedDetailResult
  }
}
