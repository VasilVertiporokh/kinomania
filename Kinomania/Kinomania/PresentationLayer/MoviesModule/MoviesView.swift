//
//  MoviesView.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import UIKit
import Lottie

protocol MoviesViewDelegate: AnyObject {
    func fetchNextPage()
    func searchTextDidChange(text: String)
    func showMovieDetails(id: Int)
    func refreshData()
}

final class MoviesView: UIView {
    // MARK: - Subviews
    private let searchBar = UISearchBar()
    private let tableView = UITableView()

    // MARK: - Private proprties
    private let refreshControl = UIRefreshControl()

    private lazy var emptyView: UIView = {
        let containerView = UIView()
        let lottieView = LottieAnimationView(name: "emptyState")
        lottieView.loopMode = .loop
        lottieView.play()
        containerView.addSubview(lottieView, constraints: [
            lottieView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -80),
            lottieView.heightAnchor.constraint(equalToConstant: 250),
            lottieView.widthAnchor.constraint(equalTo: lottieView.heightAnchor)
        ])
        return containerView
    }()

    // MARK: - Internal properties
    weak var delegate: MoviesViewDelegate?

    // MARK: - Private properties
    private var dataSource: [MoviesDomainModel] = []

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDataSource
extension MoviesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(MovieTableViewCell.self, indexPath: indexPath)
        cell.configure(model: .init(movieModel: dataSource[indexPath.row]))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MoviesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showMovieDetails(id: dataSource[indexPath.row].id)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing(true)
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height / 2
        let height = scrollView.frame.size.height
        let currentValue = contentHeight - height

        guard offsetY > currentValue && currentValue > .zero else { return }
        delegate?.fetchNextPage()
    }
}

// MARK: - Internal extension
extension MoviesView {
    func setDataSource(model: [MoviesDomainModel]) {
        tableView.backgroundView = !model.isEmpty ? nil : emptyView
        dataSource = model
        handleRefreshControl()
        tableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension MoviesView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchTextDidChange(text: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endEditing(true)
    }
}

// MARK: - Private extenison
private extension MoviesView {
    func initialSetup() {
        setupLayout()
        setupUI()
    }

    func setupLayout() {
        addSubview(searchBar, constraints: [
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        addSubview(tableView, constraints: [
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupUI() {
        backgroundColor = Colors.primaryWhite.color
        searchBar.delegate = self
        searchBar.placeholder = Localization.Movies.searchBarPlaceholder
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.searchTextField.returnKeyType = .done

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(MovieTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    func handleRefreshControl() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    @objc func refreshData(_ sender: UIRefreshControl) {
        delegate?.refreshData()
    }
}
