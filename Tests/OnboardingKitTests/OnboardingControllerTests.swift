import XCTest
import Combine
@testable import OnboardingKit

final class OnboardingControllerTests: XCTestCase {
    var sut: OnboardingController!
    var mockViewModel: MockPreviewIntroViewModel!
    var mockNode: OnboardingNode!
    var mockDelegate: MockPreviewIntroDelegate!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockPreviewIntroViewModel()
        mockNode = OnboardingNode()
        mockDelegate = MockPreviewIntroDelegate()
        sut = OnboardingController(viewModel: mockViewModel, viewNode: mockNode)
        sut.delegate = mockDelegate
    }
    
    override func tearDown() {
        sut = nil
        mockViewModel = nil
        mockNode = nil
        mockDelegate = nil
        super.tearDown()
    }
    
    func testControllerInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testViewDidLoadSetsUpBindings() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.view)
    }
    
    func testDelegateCalledOnLoadingChange() {
        let expectation = expectation(description: "Delegate called")
        
        mockDelegate.onHandlePreviewCompletion = { isLoading in
            XCTAssertFalse(isLoading)
            expectation.fulfill()
        }
        
        sut.loadViewIfNeeded()
        mockViewModel.simulateLoadingComplete()
        
        waitForExpectations(timeout: 2.0)
    }
}
