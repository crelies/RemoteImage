//
//  MockPHAsset.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 14.12.19.
//

import Photos

final class MockPHAsset: PHAsset {
    static var fetchResult = MockPHAssetFetchResult()

    override class func fetchAssets(withLocalIdentifiers identifiers: [String], options: PHFetchOptions?) -> PHFetchResult<PHAsset> {
        fetchResult
    }
}
