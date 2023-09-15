//
//  MockPackageListAPICase.swift
//  NewsPackagesTests
//
//  Created by Yasin Akbaş on 15.09.2023.
//

@testable import NewsPackages
import Foundation

final class MockPackageListAPICase: PackageListAPICaseInterface {

  var invokedList = false
  var invokedListCount = 0
  var stubbedListResult: APIResponse<[PackageItemResponse]>!

  func list() async -> APIResponse<[PackageItemResponse]>? {
    invokedList = true
    invokedListCount += 1
    return stubbedListResult
  }
}
