import Cocoa

class TabItemView: NSView {
    var tabIndex: Int
    
    init(tabIndex: Int) {
        self.tabIndex = tabIndex
        super.init(frame: .zero)
        
        let textView = NSTextField(labelWithString: String(tabIndex))
        self.addSubview(textView)
        
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MainViewController: NSViewController {
    
    override func loadView() {
        self.view = NSView(frame: NSRect(x: 0, y: 0, width: 500, height: 500))
    }
    
    override func viewDidLoad() {
        let tabIDs = 0..<100
        
        super.viewDidLoad()
        
        let stackViewPadding: CGFloat = 10
        
        let scrollView = NSScrollView(frame: view.bounds)
        scrollView.hasVerticalScroller = true
        scrollView.autoresizingMask = [.width, .height]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.drawsBackground = false
        
        let stackView = NSStackView()
        stackView.orientation = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let flippedView = FlippedView()
        flippedView.addSubview(stackView)
        scrollView.documentView = flippedView
        
        for tabID in tabIDs {
            let tabView = TabItemView(tabIndex: tabID)
            stackView.addArrangedSubview(tabView)
        }
        
        let height = stackView.fittingSize.height
        scrollView.documentView?.frame.size = CGSize(width: scrollView.contentSize.width, height: height)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: stackViewPadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: stackViewPadding),
        ])
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
}
