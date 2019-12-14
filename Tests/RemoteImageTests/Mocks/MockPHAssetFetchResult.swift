//
//  MockPHAssetFetchResult.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 14.12.19.
//

import Photos

final class MockPHAssetFetchResult: PHFetchResult<PHAsset> {
    var firstObjectToReturn: PHAsset?

    override var firstObject: PHAsset? { firstObjectToReturn }
}
