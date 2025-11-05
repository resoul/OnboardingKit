import XCTest
import Combine
import AsyncDisplayKit
@testable import OnboardingKit

final class OnboardingNodeTests: XCTestCase {
    var sut: OnboardingNode!
    
    override func setUp() {
        super.setUp()
        sut = OnboardingNode()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testNodeInitialization() {
        XCTAssertNotNil(sut)
        XCTAssertTrue(sut.automaticallyManagesSubnodes)
    }
    
    func testConfigureWithPreview() {
        let preview = OnboardingScreen(
            headline: "Test Headline",
            description: "Test Description",
            backgroundColor: .red,
            headlineColor: .blue,
            descriptionColor: .green
        )
        
        sut.configure(with: preview)
        
        XCTAssertEqual(sut.backgroundColor, .red)
    }
    
    func testLayoutSpecNotNil() {
        let constrainedSize = ASSizeRange(
            min: CGSize(width: 0, height: 0),
            max: CGSize(width: 400, height: 800)
        )
        
        let layoutSpec = sut.layoutSpecThatFits(constrainedSize)
        
        XCTAssertNotNil(layoutSpec)
    }
}
