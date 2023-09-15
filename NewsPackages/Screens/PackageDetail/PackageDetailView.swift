//
//  PackageDetailView.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 14.09.2023.
//

import SwiftUI

struct PackageDetailView: View {
  @StateObject var viewModel: PackageDetailViewModel
  
  var body: some View {
    NavigationStack {
      VStack {
        switch viewModel.state {
        case .loading:
          ProgressView()
        case .loaded(let sources):
          List {
            Section(header: Text("Package Sources")) {
              ForEach(sources) { source in
                PackageDetailListItemView(title: source.name, sourceId: source.id, sourceIsAdded: source.isAdded) {
                  viewModel.isAddedButtonTapped(id: source.id)
                }
              }
            }
            .headerProminence(.increased)
          }
        case .failed:
          EmptyView()
        }
      }
      .navigationTitle(viewModel.packageName)
      .navigationBarTitleDisplayMode(.inline)
    }
    .onAppear(perform: viewModel.onAppear)
  }
}

struct PackageDetailIsAddedButtonView: View {
  let sourceId: Int
  let isAdded: Bool
  let buttonTapHandler: () -> Void
  
  var body: some View {
    Button {
      buttonTapHandler()
    } label: {
      if isAdded {
        Image(systemName: "checkmark.square")
          .foregroundColor(.black)
      } else {
        Image(systemName: "square")
          .foregroundColor(.black)
      }
    }
  }
}

struct PackageDetailListItemView: View {
  let title: String
  let sourceId: Int
  let sourceIsAdded: Bool
  let isAddedButtonTapHandler: () -> Void
  
  var body: some View {
    HStack {
      Text(title)
        .font(.subheadline)
        .fontWeight(.semibold)
      Spacer()
      PackageDetailIsAddedButtonView(sourceId: sourceId,
                                     isAdded: sourceIsAdded,
                                     buttonTapHandler: isAddedButtonTapHandler)
    }
  }
}
