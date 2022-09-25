//
//  HomePresenterTests.swift
//  MLiteNewsTests
//
//  Created by Anang Nugraha on 25/09/22.
//

import XCTest
@testable import MLiteNews

class HomePresenterTests: XCTestCase {

    var presenter: HomePresenter?
    var mockWireframe: MockWireframe!
    var mockInteractor: MockInteractor!
    
    override func setUpWithError() throws {
         try super.setUpWithError()
        mockWireframe = MockWireframe()
        mockInteractor = MockInteractor()
        presenter = HomePresenter(interactor: mockInteractor, wireframe: mockWireframe)
    }

    override func tearDownWithError() throws {
        mockWireframe = nil
        mockInteractor = nil
        presenter = nil
        try? super.tearDownWithError()
    }
    
    func testFetchHomeNews() {
        let mockQuery = "roger federer"
        let mockpage = 10
        presenter?.searchQuery = mockQuery
        presenter?.currentPage = mockpage
        presenter?.fetchHomeNews()
        XCTAssertEqual(mockWireframe.isSetLoadingIndicatorCalled, true)
        XCTAssertEqual(mockWireframe.isLoadingHiddenState, false)
        XCTAssertEqual(mockInteractor.getHomeNewsIsCalled, true)
        XCTAssertEqual(mockInteractor.getHomeNewsPage, mockpage)
        XCTAssertEqual(mockInteractor.getHomeNewsSearchQuery, mockQuery)
    }
    
    func testMoveToSourcesView() {
        let mockCategory = Category.Entertainment.rawValue
        presenter?.moveToSourcesView(category: mockCategory)
        XCTAssertEqual(mockWireframe.pushToSourcesViewCategory, mockCategory)
    }

    func testMoveToDetail() {
        let mockTitle = "tsunami"
        let mockUrlString = "https://google.com"
        let mockUrl = URL(string: mockUrlString)!
        presenter?.moveToDetail(url: mockUrl, title: mockTitle)
        XCTAssertEqual(mockWireframe.pushToDetailTitle, mockTitle)
        XCTAssertEqual(mockWireframe.pushToDetailUrl, mockUrlString)
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
    
    func testGetHomeNewsDidSuccess() {
        let mockData = mockNewsModel()
        let dataCurrentPage: Double = Double((mockData.totalResults!) / presenter!.newsPerPage).rounded(.up)
        presenter?.getHomeNewsDidSuccess(result: mockData)
        XCTAssertEqual(presenter?.newsArticleList?.count, mockData.articles?.count)
        XCTAssertEqual(presenter?.totalPage, Int(dataCurrentPage))
        XCTAssertEqual(presenter?.isLoadData, false)
        
        let expectation = expectation(description: "getHomeNewsDidSuccess")
        
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
}

extension HomePresenterTests {
    class MockWireframe: HomeWireframeProtocol {
        
        var isErrorAlertCalled = false
        var showErrorAlertMessage = ""
        var isSetLoadingIndicatorCalled = false
        var isLoadingHiddenState = false
        var isShowNoInternetAlertCalled = false
        var pushToSourcesViewCategory = ""
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
        
        func pushToSourcesView(category: String) {
            pushToSourcesViewCategory = category
        }
        
        func pushToDetail(url: URL, title: String) {
            pushToDetailUrl = url.absoluteString
            pushToDetailTitle = title
        }
        
    }
    
    class MockInteractor: HomeInteractorProtocol {
        
        var getHomeNewsIsCalled = false
        var getHomeNewsSearchQuery = ""
        var getHomeNewsPage = -1
        
        func getHomeNews(request: NewsRequest) {
            getHomeNewsIsCalled = true
            getHomeNewsSearchQuery = request.q
            getHomeNewsPage = request.page
        }
    }
}


extension HomePresenterTests  {
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
