//
//  NewsPresenterTests.swift
//  MLiteNewsTests
//
//  Created by Anang Nugraha on 25/09/22.
//

import XCTest
@testable import MLiteNews

class NewsPresenterTests: XCTestCase {

    var presenter: NewsPresenter?
    var mockWireframe: MockWireframe!
    var mockInteractor: MockInteractor!
    
    override func setUpWithError() throws {
         try super.setUpWithError()
        mockWireframe = MockWireframe()
        mockInteractor = MockInteractor()
        presenter = NewsPresenter(interactor: mockInteractor, wireframe: mockWireframe, source: (mockSourceListModel().sources?.first)!)
    }

    override func tearDownWithError() throws {
        mockWireframe = nil
        mockInteractor = nil
        presenter = nil
        try? super.tearDownWithError()
    }
    
    func testServiceRequestDidFail() {
        let error = NSError(domain: "", code: 401, userInfo: ["error": "request error"])
        presenter?.serviceRequestDidFail(error)
        
        let expectation = expectation(description: "serviceRequestDidFail")
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockWireframe.isLoadingHiddenState)
            XCTAssertTrue(self.mockWireframe.isSetLoadingIndicatorCalled)
            XCTAssertTrue(self.mockWireframe.isErrorAlertCalled)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testGetNewsDidSuccess() {
        let mockData = mockNewsModel()
        let dataCurrentPage: Double = Double((mockData.totalResults!) / presenter!.newsPerPage).rounded(.up)
        presenter?.getNewsDidSuccess(result: mockData)
        XCTAssertEqual(presenter?.newsArticleList?.count, mockData.articles?.count)
        XCTAssertEqual(presenter?.totalPage, Int(dataCurrentPage))
        XCTAssertEqual(presenter?.isLoadData, false)
        
        let expectation = expectation(description: "getNewsDidSuccess")
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.mockWireframe.isLoadingHiddenState)
            XCTAssertTrue(self.mockWireframe.isSetLoadingIndicatorCalled)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testResetData() {
        presenter?.resetData()
        XCTAssertEqual(presenter?.newsArticleList?.count, 0)
        XCTAssertEqual(presenter?.totalPage, 1)
        XCTAssertEqual(presenter?.currentPage, 1)
    }
    
    func testMoveToDetail() {
        let mockTitle = "tsunami"
        let mockUrlString = "https://google.com"
        let mockUrl = URL(string: mockUrlString)!
        presenter?.moveToDetail(url: mockUrl, title: mockTitle)
        XCTAssertEqual(mockWireframe.pushToDetailTitle, mockTitle)
        XCTAssertEqual(mockWireframe.pushToDetailUrl, mockUrlString)
    }
    
    func testFetchNews() {
        let mockQuery = "roger federer"
        let mockpage = 10
        presenter?.searchQuery = mockQuery
        presenter?.currentPage = mockpage
        presenter?.fetchNews()
        XCTAssertEqual(mockWireframe.isSetLoadingIndicatorCalled, true)
        XCTAssertEqual(mockWireframe.isLoadingHiddenState, false)
        XCTAssertEqual(mockInteractor.getHomeNewsIsCalled, true)
        XCTAssertEqual(mockInteractor.getHomeNewsPage, mockpage)
        XCTAssertEqual(mockInteractor.getHomeNewsSearchQuery, mockQuery)
    }
}

extension NewsPresenterTests {
    class MockWireframe: NewsWireframeProtocol {
        
        var isErrorAlertCalled = false
        var showErrorAlertMessage = ""
        var isSetLoadingIndicatorCalled = false
        var isLoadingHiddenState = false
        var isShowNoInternetAlertCalled = false
        var pushToDetailUrl = ""
        var pushToDetailTitle = ""
        
        func setLoadingIndicator(isHidden: Bool) {
            isLoadingHiddenState = isHidden
            isSetLoadingIndicatorCalled = true
        }
        
        func showNoInternetAlert() {
            isShowNoInternetAlertCalled = true
        }
        
        func showErrorAlert(_ message: String) {
            isErrorAlertCalled = true
            showErrorAlertMessage = message
        }
        
        func pushToDetail(url: URL, title: String) {
            pushToDetailUrl = url.absoluteString
            pushToDetailTitle = title
        }

    }
    
    class MockInteractor: NewsInteractorProtocol {
        
        var getHomeNewsIsCalled = false
        var getHomeNewsSearchQuery = ""
        var getHomeNewsPage = -1
        
        func getNews(request: NewsRequest) {
            getHomeNewsIsCalled = true
            getHomeNewsSearchQuery = request.q
            getHomeNewsPage = request.page
        }
    }
}

extension NewsPresenterTests  {
    func mockSourceListModel() -> SourceListModel {
        let decoder = JSONDecoder()
        
        guard
            let pathString = Bundle.main.url(forResource: "SourceListModel", withExtension: "json"),
            let dataJson = try? Data(contentsOf: pathString, options: .mappedIfSafe),
            let model = try? decoder.decode(SourceListModel.self, from: dataJson)
        else {
            fatalError()
        }
                
        return model
    }
    
    func mockNewsModel() -> NewsModel {
        let decoder = JSONDecoder()
        
        guard
            let pathString = Bundle.main.url(forResource: "NewsModel", withExtension: "json"),
            let dataJson = try? Data(contentsOf: pathString, options: .mappedIfSafe),
            let model = try? decoder.decode(NewsModel.self, from: dataJson)
        else {
            fatalError()
        }
                
        return model
    }
}
