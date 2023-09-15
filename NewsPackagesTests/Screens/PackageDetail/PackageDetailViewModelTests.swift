//
//  PackageDetailViewModelTests.swift
//  NewsPackagesTests
//
//  Created by Yasin Akbaş on 15.09.2023.
//

@testable import NewsPackages
import XCTest

final class PackageDetailViewModelTests: XCTestCase {
  var viewModel: PackageDetailViewModel!
  var apiCase: MockPackageDetailAPICase!
  
  override func setUp() async throws {
    apiCase = .init()
    viewModel = PackageDetailViewModel(parameters: .init(packageId: 57,
                                                         packageName: "Package_Name"),
                                       apiCase: apiCase)
  }

  @MainActor
  func test_fetchPackageDetail_InvokesApiCaseDetail() async {
    apiCase.stubbedDetailResult = packageDetailResponse
    
    await viewModel.fetchPackageDetail(packageId: 57)
    
    guard case .loaded(let result) = viewModel.state else {
      XCTFail("Package Detail is not fetched")
      return
    }
    XCTAssertTrue(apiCase.invokedDetail)
    XCTAssertEqual(result.first?.id, 48)
    XCTAssertEqual(result.first?.isAdded, false)
  }
}

extension PackageDetailViewModelTests {
  var bundle: Bundle { .init(for: Self.self) }
  
  var packageDetailResponse: [PackageSourceItemResponse] {
    JSONParser.decode(for: [PackageSourceItemResponse].self,
                      fileName: "PackageDetailResponse",
                      bundle: bundle)
  }
}

