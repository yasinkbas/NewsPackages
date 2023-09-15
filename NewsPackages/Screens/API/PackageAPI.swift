//
//  PackageAPI.swift
//  NewsPackages
//
//  Created by Yasin Akbaş on 14.09.2023.
//

import NLab

protocol PackageAPIInterface: AnyObject {
  func list() -> NLTaskDirector<APIResponse<[PackageItemResponse]>, Empty>
  func detail(packageId: Int) -> NLTaskDirector<[PackageSourceItemResponse], Empty>
}

final class PackageAPI: APIServiceInterface, PackageAPIInterface {
  func list() -> NLTaskDirector<APIResponse<[PackageItemResponse]>, Empty> {
    NLTaskPoint(client: client)
        .path("contentstore/packages/")
        .method(.get)
        .header(PackageHTTPHeaderProvider(.list))
        .build().and.direct()
  }
  
  func detail(packageId: Int) -> NLTaskDirector<[PackageSourceItemResponse], Empty> {
    NLTaskPoint(client: client)
        .path("contentstore/package/\(packageId)")
        .method(.get)
        .header(PackageHTTPHeaderProvider(.detail))
        .build().and.direct()
  }
}

final class PackageHTTPHeaderProvider: ExpressibleByHeaderLiteralClass<PackageHTTPHeaderProvider.HeaderType> {
  enum HeaderType: HTTPHeaderType {
    case list
    case detail
    
    static func make(_ headers: [HTTPHeaderType]) -> HeaderDict {
      var dict = HeaderDict()
      headers.forEach { header in
        switch header {
        case HeaderType.list, HeaderType.detail:
          dict["language"] = "TR"
          dict["country"] = "TR"
          dict["DeviceToken"] = "9aa43dab-d2ca-4dc1-b374-afb462b3b8e5"
          dict["Platform"] = "IOS"
        default:
          break
        }
      }
      return dict
    }
  }
  
  override func make(_ auths: [HeaderType]) -> HeaderDict {
      HeaderType.make(auths)
  }
}
