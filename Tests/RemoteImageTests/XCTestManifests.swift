import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DefaultRemoteImageCacheTests.allTests),
        testCase(PhotoKitServiceErrorTests.allTests),
        testCase(PhotoKitServiceTests.allTests),
        testCase(RemoteImageTests.allTests),
        testCase(RemoteImageServiceDependenciesTests.allTests),
        testCase(RemoteImageServiceErrorTests.allTests),
        testCase(RemoteImageServiceFactoryTests.allTests),
        testCase(RemoteImageServiceTests.allTests),
        testCase(RemoteImageStateTests.allTests),
        testCase(URLSession_RemoteImageURLDataPublisherTests.allTests)
    ]
}
#endif
