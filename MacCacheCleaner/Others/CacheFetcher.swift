//
//  CacheFetcher.swift
//  MacCacheCleaner
//
//  Created by Kaunteya Suryawanshi on 02/07/18.
//  Copyright © 2018 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation

struct SourceJSON: Decodable {
    let version: Int
    let items: [CacheItem]
}

struct CacheFetcher {
    let url: URL

    func fromNetwork(completion: @escaping([CacheItem]) -> Void,
                 failure: ((Error?) -> Void)?) {

        URLSession.shared.jsonDecodableTask(with: url) { (result:Result<SourceJSON>)  in
            switch result {
            case .success(let decoded):
                assert(decoded.version == 1)
                completion(decoded.items)
            case .failure(let error): failure?(error)
            }
        }.resume()
    }
}
