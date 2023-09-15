//
//  PackageListView.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 13.09.2023.
//

import SwiftUI

private extension PackageListView {
  enum Constants {
    static let packageItemHeight: CGFloat = 60
    static let columnSpacing: CGFloat = 15
  }
}

struct PackageListView: View {
  @ObservedObject var viewModel: PackageListViewModel = .init()
  
  let columns: [GridItem] = [GridItem(.flexible()),
                             GridItem(.flexible())]
  
  var body: some View {
    NavigationStack {
      ScrollView {
        PackageListCardsView(packages: viewModel.packages,
                             columns: columns,
                             columnSpacing: Constants.columnSpacing,
                             packageItemHeight: Constants.packageItemHeight)
          .padding()
      }
      .background(Color(UIColor.systemGroupedBackground))
      .navigationTitle("Packages")
    }
    .onAppear(perform: viewModel.onAppear)
  }
}

struct PackageListImageView: View {
  let url: String
  
  var body: some View {
    AsyncImage(url: URL(string: url)) { phase in
      if let image = phase.image {
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      } else {
        ProgressView()
      }
    }
  }
}

struct PackageListCardTitleView: View {
  let title: String
  
  var body: some View {
    VStack(alignment: .leading) {
      Spacer()
      HStack {
        Text(title)
          .foregroundColor(.white)
          .font(.caption)
          .fontWeight(.semibold)
          .padding(.all, 5)
        Spacer()
      }
    }
  }
}

struct PackageListAddedOverlayView: View {
  var body: some View {
    ZStack {
      Color.green.opacity(0.4)
      Image(systemName: "checkmark.diamond")
        .foregroundColor(.white)
    }
  }
}

struct PackageListCardItemView: View {
  let package: PackageItemResponse
  let height: CGFloat
  
  var body: some View {
    ZStack {
      PackageListImageView(url: package.image)
      PackageListCardTitleView(title: package.description)
      if package.isAdded {
        PackageListAddedOverlayView()
      }
    }
    .cornerRadius(8)
    .fixedSize(horizontal: false,
               vertical: true)
    .frame(height: height)
  }
}

struct PackageListCardsView: View {
  let packages: [PackageItemResponse]
  let columns: [GridItem]
  let columnSpacing: CGFloat
  let packageItemHeight: CGFloat
  
  var body: some View {
    LazyVGrid(columns: columns, spacing: columnSpacing) {
      ForEach(packages) { package in
        NavigationLink {
          let parameters = PackageDetailParameters(packageId: package.id,
                                                   packageName: package.name)
          PackageDetailView(viewModel: .init(parameters: parameters))
        } label: {
          PackageListCardItemView(package: package,
                                  height: packageItemHeight)
        }
      }
    }
  }
}
