//
//  SourcesPresenterTests.swift
//  MLiteNewsTests
//
//  Created by Anang Nugraha on 25/09/22.
//

import XCTest
@testable import MLiteNews

class SourcesPresenterTests: XCTestCase {

    var presenter: SourcesPresenter?
    var mockWireframe: MockWireframe!
    var mockInteractor: MockInteractor!
    let category = "Tech"
    
    override func setUpWithError() throws {
         try super.setUpWithError()
        mockWireframe = MockWireframe()
        mockInteractor = MockInteractor()
        presenter = SourcesPresenter(interactor: mockInteractor, wireframe: mockWireframe, category: category)
    }

    override func tearDownWithError() throws {
        mockWireframe = nil
        mockInteractor = nil
        presenter = nil
        try? super.tearDownWithError()
    }
    
    func testResetData() {
        presenter?.resetData()
        XCTAssertEqual(presenter?.sourcesList?.count, 0)
    }
    
    func testResetResult() {
        presenter?.sourcesResult = mockSourceListModel().sources
        presenter?.resetResult()
        XCTAssertEqual(presenter?.sourcesList?.count, presenter?.sourcesResult?.count)
    }
    
    func testFetchSources() {
        presenter?.fetchSources()
        XCTAssertEqual(mockInteractor.getSourcesCategory, category)
        XCTAssertEqual(mockWireframe.isSetLoadingIndicatorCalled, true)
        XCTAssertEqual(mockWireframe.isLoadingHiddenState, false)
    }
    
    func testMoveToNewsBySource() {
        let source = mockSourceListModel().sources?.first!
        presenter?.moveToNewsBySource(with: source!)
        XCTAssertEqual(mockWireframe.pushToNewsBySourceId, source?.id)
    }
    
    func testFilterSource_withEmptyQuery() {
        presenter?.sourcesResult = mockSourceListModel().sources
        presenter?.filterSource(query: "")
        XCTAssertEqual(presenter?.sourcesList?.count, presenter?.sourcesResult?.count)
    }
    
    func testFilterSource_withNotEmptyQuery() {
        let mockQuery = "xcode"
        var mockData = mockSourceListModel().sources
        mockData![0].name = mockQuery
        presenter?.sourcesResult = mockSourceListModel().sources
        presenter?.filterSource(query: mockQuery)
        XCTAssertEqual(presenter?.sourcesList?.count, 0)
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
    
    func testGetSourcesDidSuccess() {
        let mockData = mockSourceListModel()
        presenter?.getSourcesDidSuccess(result: mockData)
        XCTAssertEqual(presenter?.sourcesList?.count, mockData.sources?.count)
        XCTAssertEqual(presenter?.sourcesResult?.count, mockData.sources?.count)
        XCTAssertEqual(presenter?.isLoadData, false)
        let expectation = expectation(description: "getSourcesDidSuccess")

        DispatchQueue.main.async {
            XCTAssertTrue(self.mockWireframe.isLoadingHiddenState)
            XCTAssertTrue(self.mockWireframe.isSetLoadingIndicatorCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)

    }
    

}

extension SourcesPresenterTests {
    class MockWireframe: SourcesWireframeProtocol {
        
        var isErrorAlertCalled = false
        var showErrorAlertMessage = ""
        var isSetLoadingIndicatorCalled = false
        var isLoadingHiddenState = false
        var isShowNoInternetAlertCalled = false
        var pushToNewsBySourceId = ""
        
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
        
        func pushToNewsBySource(with source: SourceModel) {
            pushToNewsBySourceId = source.id ?? ""
        }
        
    }
    
    class MockInteractor: SourcesInteractorProtocol {
        var getSourcesCategory = ""

        func getSources(category: String) {
            getSourcesCategory = category
        }
    }
}


extension SourcesPresenterTests  {
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
}
