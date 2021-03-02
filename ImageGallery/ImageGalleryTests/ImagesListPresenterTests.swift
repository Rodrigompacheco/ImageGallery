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
     
        func setup(imagesList: Image = .dummyImagesResponse) {
            service = ImagesInputSpy()
            view = ImagesListViewSpy()
            imagesListPresenter = ImageListPresenter(service: service)
        }
        
        describe("ImagesListPresenterTests") {
            
            beforeEach {
                setup()
            }
            
            describe("quando for instanciado") {
                beforeEach {
                    setup()
                }
                it("então deverá atribuir o output do serviço") {
                    expect(service.imagesOutput).to(beIdenticalTo(imagesListPresenter))
                }
            }
            
            describe("quando a view for anexada") {
                beforeEach {
                    setup()
                    imagesListPresenter.attachView(view: view)
                }
                
                it("então deverá carregar os dados") {
                    expect(service.fetchImagesCalled).to(beTrue())
                }
            }
            
            describe("quando o serviço de busca de imagens retornar") {
                beforeEach {
                    setup()
                }
                context("com sucesso") {
                    beforeEach {
                        setup()
                        imagesListPresenter.attachView(view: view)
                        imagesListPresenter.requestSucceded(images: [.dummyImagesResponse], state: .initial)
                    }
                    it("então deverá salvar as imagens") {
                        expect(imagesListPresenter.getTotalImages()).to(equal(1))
                    }
                    
                    it("então deverá chamar o serviço para fazer o dowload dos tamanhos de imagens") {
                        expect(service.fetchImageSizesCalled).to(beTrue())
                    }
  
                    it("então a imagem salva deverá estar correta") {
                        expect(imagesListPresenter.getImage(at: 0)).to(equal(.dummyImagesResponse))
                    }
                }
                
                context("com falha") {
                    beforeEach {
                        setup()
                        imagesListPresenter.attachView(view: view)
                        imagesListPresenter.requestFailed(error: .makeRequest)
                    }
                    it("então deverá mostrar um alerta") {
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
    
    static var dummyImagesResponse: Image {
        var img = Image(id: "123456789", title: "Dummy Image")
        img.sizes = [.dummyImagesSizesResponse]
        return img
    }
}



extension ImageSize {
    static var dummyImagesSizesResponse: ImageSize {
        return .init(label: "Dummy Size", source: "https://www.url.com")
    }
}
