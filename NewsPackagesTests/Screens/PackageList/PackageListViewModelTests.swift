//
//  PackageListViewModelTests.swift
//  NewsPackagesTests
//
//  Created by Yasin Akbaş on 15.09.2023.
//

@testable import NewsPackages
import XCTest

final class PackageListViewModelTests: XCTestCase {
  var viewModel: PackageListViewModel!
  var apiCase: MockPackageListAPICase!
  
  override func setUp() async throws {
    apiCase = .init()
    viewModel = PackageListViewModel(apiCase: apiCase)
  }

  @MainActor
  func test_fetchPackages_InvokesApiCaseList() async {
    apiCase.stubbedListResult = packageListResponse
    
    await viewModel.fetchPackages()
    
    XCTAssertTrue(apiCase.invokedList)
    
    XCTAssertEqual(viewModel.packages.first?.id, 56)
    XCTAssertEqual(viewModel.packages.first?.isAdded, true)
    XCTAssertEqual(viewModel.packages.first?.image, "https://static.bundle.app/contentChannel/packages/0ktrscxif00.png")
  }
}

extension PackageListViewModelTests {
  var bundle: Bundle { .init(for: Self.self) }
  
  var packageListResponse: APIResponse<[PackageItemResponse]> {
    JSONParser.decode(for: APIResponse<[PackageItemResponse]>.self,
                      fileName: "PackageListResponse",
                      bundle: bundle)
  }
}
