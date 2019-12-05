//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Rushikesh on 03/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import UIKit
import PYSearch

class SearchViewController: BaseViewController {
    
    let presenter = SearchPresenter(locationService: LocationService())
    var locationViewData = [LocationViewData]()
    var searchViewController: PYSearchViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchButtonPressed)
        )
    }
    
    @objc func searchButtonPressed() {
          let hotSeaches = ["Oslo, City – large town, Oslo(Oslo)", "Oslo Airport, Gardermoen, Airport, Ullensaker(Akershus)", "Oslo - Disen, Meteorological station, Oslo(Oslo)", "Oslo - Vestli, Meteorological station, Oslo(Oslo)", "Oslo - Studenterlunden, Meteorological station, Oslo(Oslo)"]
            searchViewController = PYSearchViewController.init(hotSearches: hotSeaches, searchBarPlaceholder: "Search", didSearch: { (searchVC, searchBar, str) in
                let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                detailViewController.title = str
                self.navigationController?.pushViewController(detailViewController, animated: true)
            })
            
            if let vc = searchViewController {
                searchViewController.hotSearchStyle = PYHotSearchStyle.default
                searchViewController.searchHistoryStyle = PYSearchHistoryStyle.default
                searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowMode.modePush
                vc.delegate = self
                searchViewController.hotSearchTitle = "Places nearby"
                searchViewController.searchHistoryTitle = "PREVIOUS SEARCHES"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
}

extension SearchViewController: PYSearchViewControllerDelegate {
    
    func searchViewController(_ searchViewController: PYSearchViewController!, searchTextDidChange searchBar: UISearchBar!, searchText: String!) {
        self.presenter.getLocationSuggestion(query: searchText)
    }
}

extension SearchViewController: LocationSuggestionView {
    
    func startLoading(){
        showActivityIndicator(toggle: true)
    }
    
    func finishLoading(){
       showActivityIndicator(toggle: false)
    }
    
    func setLocationSuggestion(locationSuggestion: [String]){
        DispatchQueue.main.async {
            self.searchViewController.searchSuggestions = locationSuggestion
        }
    }
    
    func setEmptyLocationSuggestion(){
        showActivityIndicator(toggle: false)
    }
}

