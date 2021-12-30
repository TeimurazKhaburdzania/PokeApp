//
//  ViewController.swift
//  Pokemons
//
//  Created by Teimuraz on 28.12.21.
//

import UIKit

protocol PokemonsView: AnyObject {
    func reloadData()
    func reloadRow(at index: Int)
    func showVC(vc: UIViewController)
    func showAlert(text: String)
}

class PokemonsViewController: UIViewController {
    
    let viewModel: PokemonsViewModel
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        layout.minimumInteritemSpacing = 10
        return collectionView
    }()
    
    init(viewModel: PokemonsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        viewModel.fetchPokemons()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.title = "Pokemons"
    }
    
    func setupCollectionView() {
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: "PokemonCell")
        self.view.addSubview(collectionView)
        view.addConstraints([collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                       collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                       collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                       collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)])
    }
}

// MARK: - UICollectionView data source & delegate

extension PokemonsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - Constants.scrollingBottomEdgeInset - scrollView.bounds.size.height {
            viewModel.didScrollToBottom()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getPokemonsCount()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell {
            let item = viewModel.getPokemon(for: indexPath.item)
            cell.configure(with: item)
            viewModel.fetchImage(index: indexPath.item)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.item)
    }
    
    
}

extension PokemonsViewController: PokemonsView {
    
    func showAlert(text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "close", style: .default)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showVC(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadRow(at index: Int) {
        collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
    
    
    func reloadData() {
        collectionView.reloadData()
    }
}

extension PokemonsViewController {
    struct Constants {
        static let scrollingBottomEdgeInset: CGFloat = 100
        static let cellHeight: CGFloat = 100
    }
}
