//
//  DetailsView.swift
//  Kinomania
//
//  Created by Vasia Vertiporoh on 03/07/2024.
//

import UIKit
import Kingfisher

protocol DetailsViewDelegate: AnyObject {
    func posterDidTap()
    func playButtonDidTap()
}

final class DetailsView: UIView {
    // MARK: - Subviews
    private let scrollView = KScrollView(axis: .vertical)
    private let containerStackView = UIStackView()
    private let imageView = UIImageView()
    private let infoStackView = UIStackView()
    private let nameLabel = UILabel()
    private let countryLabel = UILabel()
    private let genresLabel = UILabel()
    private let ratingStackView = UIStackView()
    private let playPromoButton = UIButton(type: .system)
    private let ratingLabel = UILabel()
    private let descriptionLabel = UILabel()

    // MARK: - Internal proprties
    weak var delegate: DetailsViewDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal extension
extension DetailsView {
    func setDetails(model: Model) {
        imageView.kf.setImage(with: model.imageUrl)
        nameLabel.text = model.movieName
        countryLabel.text = "\(model.country) \(model.date)"
        genresLabel.text = model.genres
        ratingLabel.text = "\(Localization.MoviesDetails.ratingLabel) \(model.rating.roundToPlaces)"
        playPromoButton.isEnabled = model.isVideoAvailable
        playPromoButton.isHidden = false
        playPromoButton.alpha = model.isVideoAvailable ? 1 : 0.5
        descriptionLabel.text = model.description
    }

    struct Model {
        let imageUrl: URL?
        let movieName: String
        let country: String
        let date: String
        let year: String
        let genres: String
        let rating: Double
        let description: String
        let isVideoAvailable: Bool

        init(domainModel: MoviewDetailsDomainModel) {
            self.imageUrl = domainModel.posterUrl
            self.movieName = domainModel.title
            self.country = domainModel.productionCountries
            self.date = domainModel.shortDate
            self.year = domainModel.releaseDate
            self.genres = domainModel.genres
            self.rating = domainModel.voteAverage
            self.description = domainModel.overview
            self.isVideoAvailable = domainModel.isVideoAvailable
        }
    }
}

// MARK: - Private extenison
private extension DetailsView {
    func initialSetup() {
        setupLayout()
        setupUI()
    }

    func setupLayout() {
        addSubview(scrollView, withEdgeInsets: .zero)

        containerStackView.axis = .vertical
        containerStackView.isLayoutMarginsRelativeArrangement = true
        containerStackView.layoutMargins = .init(top: 0, left: 4, bottom: 0, right: 4)
        infoStackView.axis = .vertical
        infoStackView.isLayoutMarginsRelativeArrangement = true
        infoStackView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        ratingStackView.axis = .horizontal
        ratingStackView.alignment = .center

        containerStackView.addArrangedSubview(imageView)
        containerStackView.setCustomSpacing(16, after: imageView)
        containerStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.setCustomSpacing(8, after: nameLabel)
        infoStackView.addArrangedSubview(countryLabel)
        infoStackView.setCustomSpacing(16, after: countryLabel)
        infoStackView.addArrangedSubview(genresLabel)
        infoStackView.setCustomSpacing(8, after: genresLabel)
        infoStackView.addArrangedSubview(ratingStackView)
        ratingStackView.addArrangedSubview(playPromoButton)
        ratingStackView.addSpacer()
        ratingStackView.addArrangedSubview(ratingLabel)
        infoStackView.setCustomSpacing(16, after: ratingStackView)
        infoStackView.addArrangedSubview(descriptionLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        playPromoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 500),
            playPromoButton.heightAnchor.constraint(equalToConstant: 50),
            playPromoButton.widthAnchor.constraint(equalTo: playPromoButton.heightAnchor)
        ])

        scrollView.contentView.addSubview(containerStackView, withEdgeInsets: .zero)
    }

    func setupUI() {
        backgroundColor = .white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(posterDidTap(_ :)))
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(gesture)

        nameLabel.font = FontFamily.CodecPro.bold.font(size: 22)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2

        countryLabel.font = FontFamily.CodecPro.bold.font(size: 14)
        countryLabel.textColor = .black
        countryLabel.numberOfLines = 2

        genresLabel.font = FontFamily.CodecPro.bold.font(size: 18)
        genresLabel.textColor = .black
        genresLabel.numberOfLines = 2

        ratingLabel.font = FontFamily.CodecPro.bold.font(size: 24)
        ratingLabel.textColor = .black
        ratingLabel.textAlignment = .center

        playPromoButton.setImage(Assets.youtube.image.withRenderingMode(.alwaysOriginal), for: .normal)
        playPromoButton.isHidden = true
        playPromoButton.addTarget(self, action: #selector(playButtonDidTap), for: .touchUpInside)
        
        descriptionLabel.font = FontFamily.CodecPro.bold.font(size: 16)
        descriptionLabel.textColor = .black.withAlphaComponent(0.8)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = .zero
    }

    @objc func posterDidTap(_ sender: UITapGestureRecognizer) {
        delegate?.posterDidTap()
    }

    @objc func playButtonDidTap(_ sender: UIButton) {
        sender.alpha = sender.state == .selected ? 0.5 : 1
        delegate?.playButtonDidTap()
    }
}

