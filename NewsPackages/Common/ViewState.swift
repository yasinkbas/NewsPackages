//
//  ViewState.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 15.09.2023.
//

import Foundation

enum ViewState<T> {
  case loading
  case loaded(result: T)
  case failed(message: String)
}
