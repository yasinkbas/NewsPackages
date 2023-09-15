//
//  PackageDetailViewModel.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 14.09.2023.
//

import Foundation

struct PackageDetailParameters {
  let packageId: Int
  let packageName: String
}

final class PackageDetailViewModel: ObservableObject {
  @Published var state: ViewState<[PackageSourceItemResponse]> = .loading

  var sources: [PackageSourceItemResponse] = [] {
    didSet {
      state = .loaded(result: sources)
    }
  }
  
  private let parameters: PackageDetailParameters
  private let apiCase: PackageDetailAPICaseInterface
  
  var packageName: String {
    parameters.packageName
  }
  
  init(parameters: PackageDetailParameters,
       apiCase: PackageDetailAPICaseInterface = PackageDetailAPICase()) {
    self.parameters = parameters
    self.apiCase = apiCase
  }
  
  func onAppear() {
    Task {
      await fetchPackageDetail(packageId: parameters.packageId)
    }
  }
  
  @MainActor
  func fetchPackageDetail(packageId: Int) async {
    state = .loading
    guard let sources = await apiCase.detail(packageId: packageId) else {
      state = .failed(message: "Service Failed")
      return
    }
    self.sources = sources
    state = .loaded(result: sources)
  }

  func isAddedButtonTapped(id: Int) {
    guard let sourceIndex = sources.firstIndex(where: { $0.id == id }) else { return }
    sources[sourceIndex].isAdded.toggle()
  }
}
