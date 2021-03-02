//
//  ImageListServiceTests.swift
//  ImageGalleryTests
//
//  Created by Rodrigo Pacheco on 02/03/21.
//

import XCTest
import Quick
import Nimble

@testable import ImageGallery

class ImagesListServiceTests: QuickSpec {

    override func spec() {
        var api: APIProviderSpy!
        var sut: ImageListService!
        var output: ImagesOutputSpy!
     
        func setup() {
            api = APIProviderSpy()
            output = ImagesOutputSpy()
            sut = ImageListService(api: api)
            sut.imagesOutput = output
        }
        
        describe("ImagesListServiceTests") {
            describe("when `fetchImages` is called") {
                beforeEach {
                    setup()
                    sut?.fetchImages()
                }
                it("then you should call the image search service") {
                    expect(api?.requestCalled).to(beTrue())
                    expect(api?.url).to(equal("https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f9cc014fa76b098f9e82f1c288379ea1&tags=kitten&page=1&per_page=15&format=json&nojsoncallback=1"))
                }
            }
            
            describe("when `fetchImageSizes` is called") {
                beforeEach {
                    setup()
                    sut?.fetchImageSizes(id: Image.dummyImagesResponse1.id)
                }
                it("then you should call the image size search service") {
                    expect(api?.requestCalled).to(beTrue())
                    expect(api?.url).to(equal("https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=f9cc014fa76b098f9e82f1c288379ea1&photo_id=123456789&format=json&nojsoncallback=1"))
                }
            }
        }
    }
}

private class APIProviderSpy: Provider {
    var url: String?
    var requestCalled: Bool?
    
    func request<T>(for endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            url = try endpoint.makeUrl().absoluteString
        } catch {
            url = ""
        }
        requestCalled = true
    }
}

private class ImagesOutputSpy: ImagesOutput {
    var requestSuccededCalled: Bool?
    var requestFailedCalled: Bool?
    var imagesPassed: [Image]?
    var statePassed: DataState?
    var errorPassed: APIError?

    func requestSucceded(images: [Image], state: DataState) {
        requestSuccededCalled = true
        imagesPassed = images
    }
    
    func requestFailed(error: APIError) {
        requestFailedCalled = true
        errorPassed = error
    }
}
