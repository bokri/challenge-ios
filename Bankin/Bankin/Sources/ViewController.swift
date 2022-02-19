//
//  ViewController.swift
//  Bankin
//
//  Created by Aymen Bokri on 19/02/2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties

    private var loadingView: LoadingView
    private var errorView: ErrorView
    private var viewModel: ViewModel
    private var tableView: UITableView
    
    // MARK: - Constructors
    
    init() {
        self.loadingView = LoadingView()
        self.errorView = ErrorView()
        self.viewModel = ViewModel()
        self.tableView = UITableView()
        
        super.init(nibName: nil, bundle: nil)
        
        self.setupView()
        self.title = Strings.appName
        self.viewModel.setupDelegate(delegate: self)
        
        self.viewModel.loadingFlow()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.errorView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        self.loadingView.isHidden = true
        self.tableView.isHidden = true
        self.errorView.isHidden = true

        self.errorView.setupDelegate(delegate: self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.register(cellType: TableViewCell.self)

        self.view.addSubview(self.loadingView)
        self.view.addSubview(self.errorView)
        self.view.addSubview(self.tableView)
        
        self.loadingView.allAnchors.constraint(equalTo: self.view.allAnchors).isActive(true)
        self.errorView.allAnchors.constraint(equalTo: self.view.allAnchors).isActive(true)
        self.tableView.allAnchors.constraint(equalTo: self.view.allAnchors).isActive(true)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.viewModel.countries.count > section {
            return self.viewModel.countries[section]
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.countries.count > section {
            let key = self.viewModel.countries[section]
            
            return self.viewModel.banks.value[key]?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(with: TableViewCell.self, for: indexPath)
        
        if self.viewModel.countries.count > indexPath.section {
            let key = self.viewModel.countries[indexPath.section]
            
            if let value = self.viewModel.banks.value[key],
               value.count > indexPath.row {
                
                let element = value[indexPath.row]
                
                cell.setup(logoUrl: element.logoUrl, name: element.name)
            }
        }

        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: CGPoint                 = scrollView.contentOffset
        let bounds: CGRect                  = scrollView.bounds
        let size: CGSize                    = scrollView.contentSize
        let inset: UIEdgeInsets             = scrollView.contentInset
        let currentBottomOffset: CGFloat    = offset.y + bounds.size.height - inset.bottom
        let height: CGFloat                 = size.height

        let distanceBeforeEndToLoadNext: CGFloat = 50.0
        
        // When scrolling attempts 50 pt before the end : Load next page
        if currentBottomOffset >= height - distanceBeforeEndToLoadNext {
            self.viewModel.loadNextPage()
        }
    }
}

// MARK: - ErrorViewDelegate
extension ViewController: ErrorViewDelegate {
    func errorButtonTouchUp() {
        self.viewModel.loadingFlow()
    }
}

// MARK: - ViewDelegate
extension ViewController: ViewDelegate {
    func showError() {
        self.errorView.isHidden = false
        self.loadingView.isHidden = true
        self.tableView.isHidden = true
    }
    
    func showLoading() {
        self.errorView.isHidden = true
        self.loadingView.isHidden = false
        self.tableView.isHidden = true
    }
    
    func showSuccess() {
        self.errorView.isHidden = true
        self.loadingView.isHidden = true
        self.tableView.isHidden = false
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
}
