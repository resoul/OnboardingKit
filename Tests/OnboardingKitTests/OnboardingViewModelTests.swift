import XCTest
import Combine
@testable import OnboardingKit

final class OnboardingViewModelTests: XCTestCase {
    var sut: OnboardingViewModelImpl!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testViewModelInitializationWithValidItems() {
        let items = createMockPreviewItems(count: 3)
        
        XCTAssertNoThrow {
            self.sut = OnboardingViewModelImpl(items: items, delay: 2.0)
        }
    }
    
    func testViewModelInitializationWithEmptyItemsThrows() {
        let emptyItems: [OnboardingScreen] = []
        
        XCTAssertThrowsError(try validateItems(emptyItems)) { error in
            XCTAssertTrue(error is OnboardingError)
            if case OnboardingError.emptyItems = error {
                XCTAssertTrue(true)
            } else {
                XCTFail("Wrong error type")
            }
        }
    }
    
    func testViewModelInitializationWithInvalidDelayThrows() {
        XCTAssertThrowsError(try validateDelay(-1.0)) { error in
            XCTAssertTrue(error is OnboardingError)
            if case OnboardingError.invalidDelay = error {
                XCTAssertTrue(true)
            } else {
                XCTFail("Wrong error type")
            }
        }
    }
    
    func testViewModelInitializationWithInvalidAnimationDuration() {
        let invalidItem = OnboardingScreen(
            headline: "Test",
            description: "Test",
            animationDuration: 10.0
        )
        
        XCTAssertThrowsError(try validateAnimationDuration(invalidItem.animationDuration)) { error in
            XCTAssertTrue(error is OnboardingError)
        }
    }
    
    func testGetPreviewReturnsValidItem() {
        let items = createMockPreviewItems(count: 3)
        sut = OnboardingViewModelImpl(items: items, delay: 1.0)
        
        let preview = sut.getPreview()
        
        XCTAssertNotNil(preview)
        XCTAssertTrue(items.contains(where: { $0.headline == preview.headline }))
    }
    
    func testIsLoadingInitiallyTrue() {
        let items = createMockPreviewItems(count: 1)
        sut = OnboardingViewModelImpl(items: items, delay: 1.0)
        
        let expectation = expectation(description: "Initial loading state")
        var receivedValue: Bool?
        
        sut.isLoading
            .sink { value in
                receivedValue = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedValue, true)
    }
    
    func testStartPreviewUpdatesCurrentPreview() {
        let items = createMockPreviewItems(count: 2)
        sut = OnboardingViewModelImpl(items: items, delay: 1.0)
        
        let expectation = expectation(description: "Current preview updated")
        var receivedPreview: OnboardingScreen?
        
        sut.currentPreview
            .compactMap { $0 }
            .sink { preview in
                receivedPreview = preview
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.startPreview(completion: nil)
        
        waitForExpectations(timeout: 2.0)
        XCTAssertNotNil(receivedPreview)
    }
    
    func testStartPreviewWithCompletionCallback() {
        let items = createMockPreviewItems(count: 1)
        sut = OnboardingViewModelImpl(items: items, delay: 1.0)
        
        let completionExpectation = expectation(description: "Completion callback called")
        let loadingExpectation = expectation(description: "Loading state changes")
        
        var finalLoadingState: Bool?
        
        sut.isLoading
            .dropFirst()
            .sink { isLoading in
                finalLoadingState = isLoading
                loadingExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.startPreview { complete in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                complete()
                completionExpectation.fulfill()
            }
        }
        
        wait(for: [completionExpectation, loadingExpectation], timeout: 2.0)
        XCTAssertEqual(finalLoadingState, false)
    }
    
    func testStartPreviewWithoutCompletionUsesDelay() {
        let items = createMockPreviewItems(count: 1)
        let delay: TimeInterval = 1.0
        sut = OnboardingViewModelImpl(items: items, delay: delay)
        
        let expectation = expectation(description: "Loading completes after delay")
        var finalLoadingState: Bool?
        
        sut.isLoading
            .dropFirst()
            .sink { isLoading in
                finalLoadingState = isLoading
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.startPreview(completion: nil)
        
        waitForExpectations(timeout: delay + 1.0)
        XCTAssertEqual(finalLoadingState, false)
    }
    
    // MARK: - Helper Methods
    
    private func createMockPreviewItems(count: Int) -> [OnboardingScreen] {
        (0..<count).map { index in
            OnboardingScreen(
                headline: "Headline \(index)",
                description: "Description \(index)",
                transitionStyle: .fade,
                animationDuration: 0.8
            )
        }
    }
    
    private func validateItems(_ items: [OnboardingScreen]) throws {
        guard !items.isEmpty else {
            throw OnboardingError.emptyItems
        }
        
        for item in items {
            try validateAnimationDuration(item.animationDuration)
        }
    }
    
    private func validateDelay(_ delay: TimeInterval) throws {
        guard delay > 0 else {
            throw OnboardingError.invalidDelay
        }
    }
    
    private func validateAnimationDuration(_ duration: TimeInterval) throws {
        if duration < 0.1 || duration > 5.0 {
            throw OnboardingError.invalidAnimationDuration(duration)
        }
    }
}
