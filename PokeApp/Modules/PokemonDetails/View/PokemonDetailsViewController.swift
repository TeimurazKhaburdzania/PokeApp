//
//  PokemonDetailsViewController.swift
//  Pokemons
//
//  Created by Teimuraz on 28.12.21.
//

import UIKit

protocol PokemonDetailsView: AnyObject {
    func updateView(pokemonDetals: PokemonDetails)
}

class PokemonDetailsViewController: UIViewController {
    
    let viewModel: PokemonDetailsViewModel
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    var statsStackView: UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }
    
    init(viewModel: PokemonDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        viewModel.getData()
    }
    
    func setupView() {
        addSubview()
        setupConstraints()
    }
    
    func addSubview() {
        view.addSubview(imageView)
        view.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 30).isActive = true
        imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        NSLayoutConstraint(item: mainStackView, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: mainStackView, attribute: .left, relatedBy: .equal, toItem: imageView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mainStackView, attribute: .right, relatedBy: .equal, toItem: imageView, attribute: .right, multiplier: 1, constant: 0).isActive = true
    }
    
    func getNameLabel(with statName: String) -> UILabel {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        nameLabel.text = "\(statName):"
        return nameLabel
    }
    
    func getValueLabel(with value: Int) -> UILabel {
        let valueLabel = UILabel()
        valueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        valueLabel.textColor = .blue
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        valueLabel.textAlignment = .right
        valueLabel.text =  String(value)
        return valueLabel
    }
    
    
    func getStatView(stat: PokemonDetailStat) -> UIStackView {
        let nameLabel = getNameLabel(with: stat.name)
        let valueLabel = getValueLabel(with: stat.value)
        let stackView = UIStackView(arrangedSubviews: [nameLabel,valueLabel])
        stackView.spacing = 9
        return stackView
    }
    
    func configureStatsStackView(with stats: [PokemonDetailStat]) {
        let firstPart = Array(stats[0 ..< stats.count / 2])
        let secondPart = Array(stats[stats.count / 2 ..< stats.count])
        let firstStack = getStatsStackView(from: firstPart)
        let secondStack = getStatsStackView(from: secondPart)
        mainStackView.addArrangedSubview(firstStack)
        mainStackView.addArrangedSubview(secondStack)
    }
    
    func getStatsStackView(from stats: [PokemonDetailStat]) -> UIStackView {
        let stackView = statsStackView
        stats.forEach {
            let view = getStatView(stat: $0)
            stackView.addArrangedSubview(view)
        }
        return stackView
    }
}

extension PokemonDetailsViewController: PokemonDetailsView {
    
    func updateView(pokemonDetals: PokemonDetails) {
        self.title = pokemonDetals.name
        configureStatsStackView(with: pokemonDetals.stats)
        let url = URL(string: pokemonDetals.imageURLStr)
        imageView.sd_setImage(with: url)
    }
    
}
