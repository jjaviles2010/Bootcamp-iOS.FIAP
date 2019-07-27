//
//  CategoriesTableViewController.swift
//  Bootcamp-iOS.FIAP
//
//  Created by Leandro Romano on 13/07/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        requestCategories()
    }
    
    fileprivate func setupView() {
        title = "Categories"
    }
    
    fileprivate func setupTableView() {
        tableView.tableFooterView = UIView()
        
        tableView.register(
            UINib(nibName: String(describing: CategoryTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: CategoryTableViewCell.identifier
        )
    }

    fileprivate func requestCategories() {
        let networkingProvider = NetworkProider()
        
        networkingProvider.request(Constants.categoriesUrl) {
            (result: Result<[String], NetworkError>) in
            if case .success(let categories) = result {
                self.categories = categories
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryTableViewCell.identifier,
            for: indexPath) as? CategoryTableViewCell
        else { return UITableViewCell() }
        cell.categoryNameLabel.text = categories[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "jokeSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? JokeViewController,
            let selectedRow = tableView.indexPathForSelectedRow?.row
        else { return }
        
        let selectedCategory = categories[selectedRow]
        
        destination.category = selectedCategory
    }
    
}
