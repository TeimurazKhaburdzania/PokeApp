//
//  PokemonCell.swift
//  PokeApp
//
//  Created by Teimuraz on 28.12.21.
//

import UIKit
import SDWebImage

class PokemonCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        self.contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        contentView.addConstraints([stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                    stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                                    stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                    stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                                    imageView.widthAnchor.constraint(equalToConstant: 50),
                                    imageView.heightAnchor.constraint(equalToConstant: 50)
                                   ])
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        nameLabel.text = nil
    }
    
    func configure(with pokemon: Pokemon) {
        let url = URL(string: pokemon.imageURLStr)
        self.imageView.sd_setImage(with: url)
        self.nameLabel.text = pokemon.name
    }
}
