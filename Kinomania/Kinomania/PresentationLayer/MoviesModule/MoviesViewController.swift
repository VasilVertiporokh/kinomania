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
    var presenter: MoviesPresenter!

    // MARK: - Life cycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
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
        presenter?.getNextPage()
    }

    func searchTextDidChange(text: String) {
        presenter?.search(text: text)
    }

    func showMovieDetails(id: Int) {
        presenter?.showMovie(movieId: id)
    }

    func refreshData() {
        presenter?.refreshData()
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
        presenter?.showFilters()
    }
}

