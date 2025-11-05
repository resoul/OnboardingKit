import XCTest
@testable import OnboardingKit

final class OnboardingScreenTests: XCTestCase {
    
    func testPreviewIntroInitializationWithDefaults() {
        let preview = OnboardingScreen(
            headline: "Test Headline",
            description: "Test Description"
        )
        
        XCTAssertEqual(preview.headline, "Test Headline")
        XCTAssertEqual(preview.description, "Test Description")
        XCTAssertNil(preview.image)
        XCTAssertEqual(preview.backgroundColor, .systemBackground)
        XCTAssertEqual(preview.headlineColor, .label)
        XCTAssertEqual(preview.descriptionColor, .label)
        XCTAssertEqual(preview.animationDuration, 0.8)
    }
    
    func testPreviewIntroInitializationWithCustomValues() {
        let testImage = UIImage()
        let preview = OnboardingScreen(
            headline: "Custom",
            description: "Custom Description",
            image: testImage,
            backgroundColor: .red,
            headlineColor: .blue,
            headlineFont: .systemFont(ofSize: 24),
            descriptionColor: .green,
            descriptionFont: .systemFont(ofSize: 16),
            transitionStyle: .scale,
            animationDuration: 1.5
        )
        
        XCTAssertEqual(preview.headline, "Custom")
        XCTAssertEqual(preview.description, "Custom Description")
        XCTAssertNotNil(preview.image)
        XCTAssertEqual(preview.backgroundColor, .red)
        XCTAssertEqual(preview.headlineColor, .blue)
        XCTAssertEqual(preview.descriptionColor, .green)
        XCTAssertEqual(preview.animationDuration, 1.5)
    }
}
