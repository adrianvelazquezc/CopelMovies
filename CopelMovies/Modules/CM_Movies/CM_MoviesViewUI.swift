//
//  CM_MoviesViewUI.swift
//  CopelMovies
//
//  Created by Mac on 14/08/23.
//

import UIKit

protocol CM_MoviesViewUIDelegate {
    func notifyGenderSelected()
    func notifyMenuPressed()
    func notifyMoviesDetails(movieId: Int, isFavoriteMovie: Bool)
    func notifyUpdateFavorite(isFavorite: Bool, movieId: Int)
    func refreshMovies()
}

class CM_MoviesViewUI: UIView{
    var delegate: CM_MoviesViewUIDelegate?
    var navigationController: UINavigationController?
    let refreshControl = UIRefreshControl()
    
    public var movieList: [Movie]?
    public var favoriteList: [Movie] = []
    public var favoriteMovieIDs: Set<Int> = []
    public var valueSelected: MoviesCategories = .popular
    public var currentMovieId = 0
    public var isFavorite = false
    
    lazy private var navigationBar: CM_NavigationBar = {
        let navigationBar = CM_NavigationBar()
        navigationBar.buildComponents(titleText: "TV Shows", delegate: self)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    lazy private var moviesSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.removeAllSegments()
        
        for (index, value) in ["Popular", "Top Rated", "Upcoming", "Now Playing"].enumerated() {
            control.insertSegment(withTitle: value, at: index, animated: true)
        }
        let font = UIFont.systemFont(ofSize: 16)
        control.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        control.backgroundColor = .clear
        control.selectedSegmentIndex = 0
        let normalAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: font
        ]
        control.setTitleTextAttributes(normalAttributes, for: .normal)
        control.selectedSegmentTintColor = .lightGray
        control.addTarget(self, action: #selector(movieValueSelectedChanged(_:)), for: .valueChanged)
        return control
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 10) / 2, height: 340)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CM_MoviesCollectionViewCell.self, forCellWithReuseIdentifier: CM_MoviesCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = CM_NetworkManager.shared.backgroundColor
        return collectionView
    }()
    
    public convenience init(
        navigation: UINavigationController,
        delegate: CM_MoviesViewUIDelegate){
            self.init()
            self.delegate = delegate
            self.navigationController = navigation
            
            collectionView.addSubview(refreshControl)
            refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
            
            setUI()
            setConstraints()
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUI(){
        self.backgroundColor = CM_NetworkManager.shared.backgroundColor
        self.addSubview(navigationBar)
        self.addSubview(moviesSegmentedControl)
        self.addSubview(collectionView)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            moviesSegmentedControl.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 15),
            moviesSegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            moviesSegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            
            collectionView.topAnchor.constraint(equalTo: moviesSegmentedControl.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    
    @objc func movieValueSelectedChanged(_ sender: UISegmentedControl) {
        switch moviesSegmentedControl.selectedSegmentIndex {
        case 0:
            valueSelected = .popular
        case 1:
            valueSelected = .top_rated
        case 2:
            valueSelected = .upcoming
        case 3:
            valueSelected = .now_playing
        default:
            valueSelected = .popular
        }
        delegate?.notifyGenderSelected()
    }
    
    @objc func refreshData() {
        self.delegate?.refreshMovies()
        refreshControl.endRefreshing()
    }
    
}

extension CM_MoviesViewUI: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CM_MoviesCollectionViewCell.identifier, for: indexPath) as? CM_MoviesCollectionViewCell {
            if let list = movieList?[indexPath.row] {
                if favoriteMovieIDs.contains(list.id ?? 0) {
                    cell.isFavorite = true
                } else {
                    cell.isFavorite = false
                }
                cell.delegate = self
                cell.currentId = list.id ?? 0
                if let url = URL(string: CM_NetworkManager.shared.firstURL + (list.urlPic ?? "") ) {
                    let session = URLSession.shared
                    let task = session.dataTask(with: url) { (data, response, error) in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.posterPicture.image = image
                            }
                        }
                    }
                    task.resume()
                }
                cell.titleLabel.text = list.title
                cell.dateLabel.text = parseDate(list.date ?? "", oldDateFormat: "yyyy-MM-dd")
                if let averange = list.average {
                    cell.averangeLabel.text = "\(averange)"
                }
                cell.resumeLabel.text = list.over
                
            }
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let newId = movieList?[indexPath.row].id {
            currentMovieId = newId
            self.delegate?.notifyMoviesDetails(movieId: newId, isFavoriteMovie: favoriteMovieIDs.contains(currentMovieId))
        }
    }
}

extension CM_MoviesViewUI: CM_NavigationBarDelegate{
    func backTapped() {
        
    }
    
    func buttonTapped() {
        delegate?.notifyMenuPressed()
    }
}

extension CM_MoviesViewUI: CM_MoviesCollectionViewCellDelegate{
    func favorite(isFavorite: Bool, id: Int) {
        self.currentMovieId = id
        self.isFavorite = isFavorite
        self.delegate?.notifyUpdateFavorite(isFavorite: isFavorite, movieId: id)
    }
}
