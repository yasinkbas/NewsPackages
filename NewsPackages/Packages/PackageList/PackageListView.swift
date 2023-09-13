//
//  PackageListView.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 13.09.2023.
//

import SwiftUI

struct PackageListView: View {
  @ObservedObject var viewModel: PackageListViewModel = .init()
  
  var body: some View {
    ZStack {
      
    }
    .onAppear(perform: viewModel.onAppear)
  }
}

struct PackageListView_Previews: PreviewProvider {
  static var previews: some View {
    PackageListView()
  }
}
