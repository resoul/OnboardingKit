import UIKit
import Combine

public class OnboardingViewModelImpl: OnboardingViewModel {
    private let isLoadingSubject = CurrentValueSubject<Bool, Never>(true)
    private let currentPreviewSubject = CurrentValueSubject<OnboardingScreen?, Never>(nil)
    private var cancellables = Set<AnyCancellable>()
    private let previewItems: [OnboardingScreen]
    private let defaultDelay: TimeInterval

    public var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }

    public var currentPreview: AnyPublisher<OnboardingScreen?, Never> {
        currentPreviewSubject.eraseToAnyPublisher()
    }

    public func getPreview() -> OnboardingScreen {
        guard let item = previewItems.randomElement() else {
            fatalError("Preview must be provided")
        }

        return item
    }

    public func startPreview(completion: ((_ complete: @escaping () -> Void) -> Void)? = nil) {
        currentPreviewSubject.send(getPreview())
        
        if let completion = completion {
            completion { [weak self] in
                self?.isLoadingSubject.send(false)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + defaultDelay) { [weak self] in
                self?.isLoadingSubject.send(false)
            }
        }
    }

    private func validateItems(_ items: [OnboardingScreen]) throws {
        guard !items.isEmpty else {
            throw OnboardingError.emptyItems
        }

        for item in items {
            if item.animationDuration < 0.1 || item.animationDuration > 5.0 {
                throw OnboardingError.invalidAnimationDuration(item.animationDuration)
            }
        }
    }

    private func validateDelay(_ delay: TimeInterval) throws {
        guard delay > 0 else {
            throw OnboardingError.invalidDelay
        }
    }

    public init (items: [OnboardingScreen] = [], delay: TimeInterval = 1.5) {
        self.previewItems = items
        self.defaultDelay = delay
        do {
            try validateItems(items)
            try validateDelay(delay)
        } catch {
            fatalError("OnboardingViewModel initialization failed: \(error.localizedDescription)")
        }
    }

    deinit {
        cancellables.removeAll()
    }
}
