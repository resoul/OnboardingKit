import UIKit
import Combine

public protocol PreviewIntroViewModel {
    var isLoading: AnyPublisher<Bool, Never> { get }
    var currentPreview: AnyPublisher<PreviewIntro?, Never> { get }

    func getPreview() -> PreviewIntro
    func startPreview(completion: ((_ complete: @escaping () -> Void) -> Void)?)
}

public class PreviewIntroViewModelImpl: PreviewIntroViewModel {
    private let isLoadingSubject = CurrentValueSubject<Bool, Never>(true)
    private let currentPreviewSubject = CurrentValueSubject<PreviewIntro?, Never>(nil)
    private var cancellables = Set<AnyCancellable>()
    private let previewItems: [PreviewIntro]
    private let defaultDelay: TimeInterval

    public var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }

    public var currentPreview: AnyPublisher<PreviewIntro?, Never> {
        currentPreviewSubject.eraseToAnyPublisher()
    }

    public func getPreview() -> PreviewIntro {
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

    public init (items: [PreviewIntro] = [], delay: TimeInterval = 1.5) {
        previewItems = items
        defaultDelay = delay
    }

    deinit {
        cancellables.removeAll()
    }
}
