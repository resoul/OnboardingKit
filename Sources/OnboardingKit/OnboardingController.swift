import UIKit
import Combine

open class OnboardingController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    public weak var delegate: OnboardingDelegate?
    private let viewModel: OnboardingViewModel
    private let viewNode: OnboardingNode

    open override func viewDidLoad() {
        super.viewDidLoad()
        viewNode.automaticallyManagesSubnodes = true
        setupView()
        setupBindings()
    }

    private func setupBindings() {
        viewModel.currentPreview
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                self?.viewNode.configure(with: item)
            }
            .store(in: &cancellables)

        viewModel.isLoading
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.delegate?.handleOnboardCompletion(isLoading: isLoading)
            }
            .store(in: &cancellables)
    }

    private func setupView() {
        view = viewNode.view
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.startPreview(completion: nil)
    }

    public init(viewModel: OnboardingViewModel, viewNode: OnboardingNode) {
        self.viewModel = viewModel
        self.viewNode = viewNode
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        cancellables.removeAll()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
