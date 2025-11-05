import XCTest
import Combine
@testable import OnboardingKit

final class OnboardingIntegrationTests: XCTestCase {
    
    func testCompleteFlowFromViewModelToController() {
        let items = [
            OnboardingScreen(headline: "Welcome", description: "Welcome screen"),
            OnboardingScreen(headline: "Features", description: "Features screen"),
            OnboardingScreen(headline: "Get Started", description: "Get started screen")
        ]
        
        let viewModel = OnboardingViewModelImpl(items: items, delay: 1.0)
        let node = OnboardingNode()
        let controller = OnboardingController(viewModel: viewModel, viewNode: node)
        
        XCTAssertNotNil(controller)
        
        controller.loadViewIfNeeded()
        
        XCTAssertNotNil(controller.view)
    }
    
    func testViewModelPublishersIntegration() {
        let items = [OnboardingScreen(headline: "Test", description: "Test")]
        let viewModel = OnboardingViewModelImpl(items: items, delay: 0.5)
        
        let loadingExpectation = expectation(description: "Loading updates")
        let previewExpectation = expectation(description: "Preview updates")
        
        var cancellables = Set<AnyCancellable>()
        var receivedLoadingStates: [Bool] = []
        var receivedPreview: OnboardingScreen?
        
        viewModel.isLoading
            .sink { isLoading in
                receivedLoadingStates.append(isLoading)
                if receivedLoadingStates.count == 2 {
                    loadingExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.currentPreview
            .compactMap { $0 }
            .sink { preview in
                receivedPreview = preview
                previewExpectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.startPreview(completion: nil)
        
        wait(for: [previewExpectation, loadingExpectation], timeout: 2.0)
        
        XCTAssertEqual(receivedLoadingStates, [true, false])
        XCTAssertNotNil(receivedPreview)
    }
}
