//
//  BaseViewController.swift
//  Projects
//
//  Created by Damian on 6/25/22.
//


import Combine
import Foundation
import UIKit

class BaseViewController: UIViewController {
    let viewModel: ViewModel
    var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    var loading: Bool = false {
        didSet {
            _ = loading ? startLoading() : stopLoading()
        }
    }
    
    private let progressIndicator = UIActivityIndicatorView()

    var shouldAllowInteractivePop: Bool {
        return true
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(progressIndicator)
        NSLayoutConstraint.activate([
            progressIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func startLoading() {
        progressIndicator.isHidden = false
        progressIndicator.startAnimating()
    }
    
    private func stopLoading() {
        progressIndicator.isHidden = true
        progressIndicator.stopAnimating()
    }
}

