//
//  PackageListViewModel.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 13.09.2023.
//

import Foundation
import NLab

final class PackageListViewModel: ObservableObject {
  private let apiCase: PackageListAPICaseInterface
  @Published var packages: [PackageItemResponse] = []
  
  init(apiCase: PackageListAPICaseInterface = PackageListAPICase()) {
    self.apiCase = apiCase
  }
  
  func onAppear() {
    Task {
      await fetchPackages()
    }
  }
  
  @MainActor 
  func fetchPackages() async {
    packages = await apiCase.list()?.data ?? []
  }
}
