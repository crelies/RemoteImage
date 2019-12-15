//
//  MockImageManager.swift
//  RemoteImageTests
//
//  Created by Christian Elies on 14.12.19.
//

import Photos

final class MockImageManager: PHImageManager {
    var imageRequestID = PHImageRequestID()
    var dataToReturn: Data?
    var infoToReturn: [AnyHashable:Any]?

    override func requestImageDataAndOrientation(for asset: PHAsset, options: PHImageRequestOptions?, resultHandler: @escaping (Data?, String?, CGImagePropertyOrientation, [AnyHashable : Any]?) -> Void) -> PHImageRequestID {
        resultHandler(dataToReturn, nil, .up, infoToReturn)
        return imageRequestID
    }
}
