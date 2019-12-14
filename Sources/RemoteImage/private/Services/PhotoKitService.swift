import Photos

protocol PhotoKitServiceProvider {
	var photoKitService: PhotoKitServiceProtocol { get }
}

protocol PhotoKitServiceProtocol {
    func getPhotoData(localIdentifier: String,
                      _ completion: @escaping (Result<Data, Error>) -> Void)
}

final class PhotoKitService {
    static var asset: PHAsset.Type = PHAsset.self
    static var imageManager: PHImageManager = PHImageManager.default()
}

extension PhotoKitService: PhotoKitServiceProtocol {
    func getPhotoData(localIdentifier: String,
                      _ completion: @escaping (Result<Data, Error>) -> Void) {
        let fetchAssetsResult = Self.asset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil)
        guard let phAsset = fetchAssetsResult.firstObject else {
            completion(.failure(PhotoKitServiceError.phAssetNotFound(localIdentifier: localIdentifier)))
            return
        }

        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        Self.imageManager.requestImageDataAndOrientation(for: phAsset,
                                                         options: options,
                                                         resultHandler: { data, _, _, info in
            if let error = info?[PHImageErrorKey] as? Error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(PhotoKitServiceError.missingData))
            }
        })
    }
}
