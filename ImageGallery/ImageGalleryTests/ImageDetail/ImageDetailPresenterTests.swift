//
//  ImageDetailPresenterTests.swift
//  ImageGalleryTests
//
//  Created by Rodrigo Pacheco on 02/03/21.
//

import XCTest
import Quick
import Nimble

@testable import ImageGallery

class ImageDetailPresenterTests: QuickSpec {

    override func spec() {
        var view: ImageDetailViewSpy!
        var imageDetailPresenter: ImageDetailPresenter!
     
        func setup(imagesList: Image = .dummyImagesResponse1) {
            view = ImageDetailViewSpy()
            imageDetailPresenter = ImageDetailPresenter(image: Image.dummyImagesResponse1)
        }
        
        describe("ImageDetailPresenterTests") {
            describe("when the view is attached") {
                describe("and the api have a large image size to show") {
                    beforeEach {
                        setup()
                        imageDetailPresenter.attachView(view: view)
                    }
                    it("then you must show the image") {
                        expect(view.showImageCalled).to(beTrue())
                    }
                }
                
                describe("and the api DON'T  have a large image size to show") {
                    beforeEach {
                        setup()
                        imageDetailPresenter = ImageDetailPresenter(image: .dummyImagesResponse2)
                        imageDetailPresenter.attachView(view: view)
                    }
                    it("then you must show the alert") {
                        expect(view.showAlertCalled).to(beTrue())
                    }
                }
            }
        }
    }
}

class ImageDetailViewSpy: ImageDetailView {
    var showImageCalled: Bool?
    var showAlertCalled: Bool?
    var showImagePassed: String?
    var showAlertMessage: String?
    
    func showImage(_ imageUrl: String) {
        showImageCalled = true
        showImagePassed = imageUrl
    }
    
    func showAlert(_ message: String) {
        showAlertCalled = true
        showImagePassed = message
    }
}
