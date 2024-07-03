//
//  MoviesViewController.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import UIKit

protocol MoviesViewInput: BaseViewProtocol {
    func setInitialDataSource(model: [MoviesDomainModel])
    func setTitle(title: String)
}

final class MoviesViewController: BaseViewController {
    // MARK: - Content view
    private let contentView = MoviesView()
    
    // MARK: - Internal properires
    var output: MoviesViewOutput!
    
    // MARK: - Life cycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.onViewDidLoad()
        initialSetup()
    }
}

// MARK: - MoviesViewInput
extension MoviesViewController: MoviesViewInput {
    func setInitialDataSource(model: [MoviesDomainModel]) {
        contentView.setDataSource(model: model)
    }
    
    func setTitle(title: String) {
        self.title = title
    }
}

// MARK: - MoviesViewDelegate
extension MoviesViewController: MoviesViewDelegate {
    func fetchNextPage() {
        output?.getNextPage()
    }

    func searchTextDidChange(text: String) {
        output?.search(text: text)
    }

    func showMovieDetails(id: Int) {
        output?.showMovie(movieId: id)
    }

    func refreshData() {
        output?.refreshData()
    }
}

// MARK: - Private extenison
private extension MoviesViewController {
    func initialSetup() {
        configureNavigationBar()
        contentView.delegate = self
    }
    
    func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: .init(systemName: "line.3.horizontal.decrease.circle"),
            style: .plain,
            target: self,
            action: #selector(rightButtonDidTap)
        )
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func rightButtonDidTap() {
        output?.showFilters()
    }
}

