import Photos

protocol PhotoKitServiceProvider {
	var photoKitService: PhotoKitServiceProtocol { get }
}

protocol PhotoKitServiceProtocol {
    func getPhotoData(localIdentifier: String,
                      success: @escaping (Data) -> Void,
                      failure: @escaping (Error) -> Void)
}

final class PhotoKitService {
	
}

extension PhotoKitService: PhotoKitServiceProtocol {
    func getPhotoData(localIdentifier: String,
                      success: @escaping (Data) -> Void,
                      failure: @escaping (Error) -> Void) {
        let fetchAssetsResult = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil)
        guard let phAsset = fetchAssetsResult.firstObject else {
            failure(PhotoKitServiceError.phAssetNotFound(localIdentifier: localIdentifier))
            return
        }
        
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        PHImageManager.default().requestImageDataAndOrientation(for: phAsset,
                                                                options: options,
                                                                resultHandler: { data, _, _, info in
            if let error = info?[PHImageErrorKey] as? Error {
                failure(error)
            } else if let data = data {
                success(data)
            } else {
                failure(PhotoKitServiceError.missingData)
            }
        })
    }
}
