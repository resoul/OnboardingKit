import XCTest
import Combine
@testable import OnboardingKit

final class OnboardingTransitionStyleTests: XCTestCase {
    
    func testFadeTransitionStyle() {
        let preview = OnboardingScreen(
            headline: "Test",
            description: "Test",
            transitionStyle: .fade
        )
        
        // Verify that transition style is set correctly
        switch preview.transitionStyle {
        case .fade:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected fade transition style")
        }
    }
    
    func testSlideTransitionStyle() {
        let preview = OnboardingScreen(
            headline: "Test",
            description: "Test",
            transitionStyle: .slide
        )
        
        switch preview.transitionStyle {
        case .slide:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected slide transition style")
        }
    }
    
    func testScaleTransitionStyle() {
        let preview = OnboardingScreen(
            headline: "Test",
            description: "Test",
            transitionStyle: .scale
        )
        
        switch preview.transitionStyle {
        case .scale:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected scale transition style")
        }
    }
    
    func testSlideFromBottomTransitionStyle() {
        let preview = OnboardingScreen(
            headline: "Test",
            description: "Test",
            transitionStyle: .slideFromBottom
        )
        
        switch preview.transitionStyle {
        case .slideFromBottom:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected slideFromBottom transition style")
        }
    }
    
    func testCustomTransitionStyle() {
        let customAnimation: (OnboardingNode, @escaping () -> Void) -> Void = { node, completion in
            completion()
        }
        
        let preview = OnboardingScreen(
            headline: "Test",
            description: "Test",
            transitionStyle: .custom(customAnimation)
        )
        
        switch preview.transitionStyle {
        case .custom:
            XCTAssertTrue(true)
        default:
            XCTFail("Expected custom transition style")
        }
    }
}
