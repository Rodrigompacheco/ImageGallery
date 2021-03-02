//
//  ImageGalleryTests.swift
//  ImageGalleryTests
//
//  Created by Rodrigo Pacheco on 23/02/21.
//

import XCTest
import Quick
import Nimble

@testable import ImageGallery

class ImagesListPresenterTests: QuickSpec {

    override func spec() {
        var service: ImagesInputSpy!
        var view: ImagesListViewSpy!
        var imagesListPresenter: ImageListPresenter!
     
        func setup(imagesList: Image = .dummyImagesResponse1) {
            service = ImagesInputSpy()
            view = ImagesListViewSpy()
            imagesListPresenter = ImageListPresenter(service: service)
        }
        
        describe("ImagesListPresenterTests") {
            
            beforeEach {
                setup()
            }
            
            describe("when it is instantiated") {
                beforeEach {
                    setup()
                }
                it("then you should assign the service output") {
                    expect(service.imagesOutput).to(beIdenticalTo(imagesListPresenter))
                }
            }
            
            describe("when the view is attached") {
                beforeEach {
                    setup()
                    imagesListPresenter.attachView(view: view)
                }
                
                it("then you must load the data") {
                    expect(service.fetchImagesCalled).to(beTrue())
                }
            }
            
            describe("when the image search service returns") {
                beforeEach {
                    setup()
                }
                context("success") {
                    beforeEach {
                        setup()
                        imagesListPresenter.attachView(view: view)
                        imagesListPresenter.requestSucceded(images: [.dummyImagesResponse1], state: .initial)
                    }
                    it("then you should save the images") {
                        expect(imagesListPresenter.getTotalImages()).to(equal(1))
                    }
                    
                    it("then you should call the service to download the image sizes") {
                        expect(service.fetchImageSizesCalled).to(beTrue())
                    }
  
                    it("then the saved image must be correct") {
                        expect(imagesListPresenter.getImage(at: 0)).to(equal(.dummyImagesResponse1))
                    }
                }
                
                context("failed") {
                    beforeEach {
                        setup()
                        imagesListPresenter.attachView(view: view)
                        imagesListPresenter.requestFailed(error: .makeRequest)
                    }
                    it("then it should show an alert") {
                        expect(view.showAlertCalled).to(beTrue())
                        expect(view.showAlertMessage).to(equal("An error occured. Try again later."))
                    }
                }
            }
        }
    }
}

class ImagesInputSpy: ImagesInput {
    var fetchImagesCalled: Bool?
    var fetchImageSizesCalled: Bool?
    var loadingStatusCalled: Bool?
    var hasMoreToDownloadStatusCalled: Bool?
    var imagesOutput: ImagesOutput?
    var imageSizesOutput: ImageSizesOutput?
    
    func fetchImages() {
        fetchImagesCalled = true
    }
    
    func fetchImageSizes(id: String) {
        fetchImageSizesCalled = true
    }
    
    func loadingStatus() -> Bool {
        loadingStatusCalled = true
        return true
    }
    
    func hasMoreToDownloadStatus() -> Bool {
        hasMoreToDownloadStatusCalled = true
        return true
    }
}

class ImagesListViewSpy: ImagesListView {
    var updateScrollTopBackCalled: Bool?
    var reloadDataCalled: Bool?
    var showAlertCalled: Bool?
    var showAlertMessage: String?
    
    func updateScrollTopBack(_ status: Bool) {
        updateScrollTopBackCalled = true
    }
    
    func reloadData(_ state: DataState) {
        reloadDataCalled = true
    }
    
    func showAlert(_ message: String) {
        showAlertCalled = true
        showAlertMessage = message
    }
}

extension Image: Equatable  {
    public static func == (lhs: Image, rhs: Image) -> Bool {
        let areEqual = lhs.id == rhs.id && lhs.title == rhs.title
        return areEqual
    }
    
    static var dummyImagesResponse1: Image {
        var img = Image(id: "123456789", title: "Dummy Image")
        img.sizes = [.dummyImagesSizesWithLargeSizeResponse]
        return img
    }
    
    static var dummyImagesResponse2: Image {
        var img = Image(id: "987654321", title: "Dummy Image")
        img.sizes = [.dummyImagesSizesWithMediumSizeResponse]
        return img
    }
}



extension ImageSize {
    static var dummyImagesSizesWithLargeSizeResponse: ImageSize {
        return .init(label: "Large", source: "https://www.url.com")
    }
    
    static var dummyImagesSizesWithMediumSizeResponse: ImageSize {
        return .init(label: "Medium", source: "https://www.url.com")
    }
}
