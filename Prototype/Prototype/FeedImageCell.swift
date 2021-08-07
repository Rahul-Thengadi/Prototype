//
//  FeedImageCell.swift
//  Prototype
//
//  Created by Rahul Thengadi on 06/08/21.
//

import UIKit

public class FeedImageCell: UITableViewCell {
    // MARK: - Properties
    
    static let identifier = "FeedImageCell"
    
    private lazy var stackView: UIStackView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: 16))
        let stack = UIStackView(arrangedSubviews: [view, locationContainer, feedImageContainer, descriptionLabel, view])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    public lazy var locationContainer: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pinContainer, locationLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillProportionally
        return stack
    }()
    
    public lazy var pinContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 14))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinIcon)
        return view
    }()
    
    public let pinIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pin"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 3, width: 10, height: 14)
        return imageView
    }()
    
    public let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1) // #9b9b9b
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    public lazy var feedImageContainer: UIView = {
        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.addSubview(feedImageView)
        imageContainer.layer.cornerRadius = 22
        imageContainer.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        imageContainer.contentMode = .scaleAspectFit
        imageContainer.clipsToBounds = true
        imageContainer.autoresizesSubviews = true
        return imageContainer
    }()
    
    public let feedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1) // #4a4a4a
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 6
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.addSubview(stackView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func awakeFromNib() {
        superview?.awakeFromNib()
        
        feedImageView.alpha = 0
        feedImageView.startShimmering()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        feedImageView.alpha = 0
        feedImageView.startShimmering()
    }
    
    // MARK: - Helpers
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 6),
            stackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 6)
        ])
        
        NSLayoutConstraint.activate([
            locationContainer.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            feedImageContainer.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            feedImageContainer.heightAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    // MARK: - Animation
    
    func fadeIn(_ image: UIImage?) {
        feedImageView.image = image
        
        UIView.animate(
            withDuration: 0.25,
            delay: 1.25,
            options: [],
            animations: {
                self.feedImageView.alpha = 1
            }, completion: { completed in
                if completed {
                    self.feedImageView.stopShimmering()
                }
            }
        )
    }
}

private extension UIView {
    private var shimmerAnimationKey: String {
        return "shimmer"
    }
    
    func startShimmering() {
        let white = UIColor.white.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.7).cgColor
        let width = bounds.width
        let height = bounds.height
        
        let gradient = CAGradientLayer()
        gradient.colors = [alpha, white, alpha]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.6)
        gradient.locations = [0.4, 0.5, 0.6]
        gradient.frame = CGRect(x: -width, y: 0, width: width*3, height: height)
        layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: shimmerAnimationKey)
    }
    
    func stopShimmering() {
        layer.mask = nil
    }
}


