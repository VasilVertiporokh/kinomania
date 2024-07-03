//
//  MovieTableViewCell.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 02/07/2024.
//

import UIKit
import Kingfisher

final class MovieTableViewCell: UITableViewCell {
    // MARK: - Subviews
    private let containerView = UIView()
    private let movieImageView = UIImageView()
    private let titleLabel = UILabel()
    private let infoStackView = UIStackView()
    private let genresLabel = UILabel()
    private let ratingLabel = UILabel()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        setShadow()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        titleLabel.text = nil
        ratingLabel.text = nil
        genresLabel.text = nil
    }
}

// MARK: - Internal extension
extension MovieTableViewCell {
    func configure(model: Model) {
        movieImageView.kf.setImage(with: model.imageUrl)
        titleLabel.text = "\(model.title) \(model.releaseDate)"
        ratingLabel.text = model.rating
        genresLabel.text = model.genres
    }

    struct Model {
        let title: String
        let releaseDate: String
        let genres: String
        let rating: String
        var imageUrl: URL?

        init(movieModel: MoviesDomainModel) {
            self.title = movieModel.title
            self.releaseDate = movieModel.shortDate
            self.genres = movieModel.genresString
            self.rating = "\(movieModel.voteAverage.roundToPlaces)"
            self.imageUrl = movieModel.posterUrl
        }
    }
}

// MARK: - Private extenison
private extension MovieTableViewCell {
    func initialSetup() {
        setupLayout()
        setupUI()
    }

    func setupLayout() {
        infoStackView.axis = .horizontal
        infoStackView.spacing = 8
        infoStackView.alignment = .center

        contentView.addSubview(containerView, constraints: [
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        containerView.addSubview(movieImageView, constraints: [
            movieImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            movieImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 500)
        ])

        movieImageView.addSubview(titleLabel, constraints: [
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -16)
        ])

        infoStackView.addArrangedSubview(genresLabel)
        infoStackView.addSpacer()
        infoStackView.addArrangedSubview(ratingLabel)

        movieImageView.addSubview(infoStackView, constraints: [
            infoStackView.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -16)
        ])
    }

    func setupUI() {
        selectionStyle = .none
        backgroundColor = .white
        contentView.backgroundColor = backgroundColor
        containerView.backgroundColor = .clear

        titleLabel.textColor = Colors.primaryWhite.color
        titleLabel.font = FontFamily.CodecPro.bold.font(size: 32)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 3

        genresLabel.textColor = Colors.primaryWhite.color
        genresLabel.font = FontFamily.CodecPro.bold.font(size: 18)
        genresLabel.textAlignment = .left
        genresLabel.numberOfLines = 2

        ratingLabel.textColor = Colors.primaryWhite.color
        ratingLabel.font = FontFamily.CodecPro.bold.font(size: 24)
        ratingLabel.textAlignment = .center
        ratingLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    func setShadow() {
        containerView.layer.cornerRadius = 16
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowRadius = 4
        containerView.layer.masksToBounds = false

        movieImageView.layer.cornerRadius = 16
        movieImageView.layer.masksToBounds = true

        containerView.layer.shadowPath = UIBezierPath(
            roundedRect: containerView.bounds,
            cornerRadius: containerView.layer.cornerRadius
        ).cgPath
    }
}
