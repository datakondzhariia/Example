//
//  MealsViewController.swift
//  Example
//
//  Created by Data Kondzhariia on 24.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol MealsDisplayLogic: class {
    
    func displayFetchMealsSuccess(viewModel: Meals.FetchMeals.ViewModel)
    func displayFetchMealsError(viewModel: Meals.FetchMeals.ViewModel)
}

class MealsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    public var interactor: MealsBusinessLogic?
    public var router: (NSObjectProtocol & MealsRoutingLogic & MealsDataPassing)?
    
    private var displayedMeals = [Meals.FetchMeals.ViewModel.DisplayedMeal]()
    
    private let refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = R.color.apple()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MealsConfigurator.shared.configure(self)
        
        setupUI()
        
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.black)

        fetchMeals()
    }
}

// MARK: - Private Methods
extension MealsViewController {
    
    private func setupUI() {
        
        setupTableView()
        setNavigationShadow()
    }
    
    private func setupTableView() {
        
        tableView.register(R.nib.mealsTableViewCell)
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    private func fetchMeals() {
        
        let request = Meals.FetchMeals.Request()
        interactor?.fetchMeals(request: request)
    }
}

// MARK: - Action
extension MealsViewController {
    
    @objc func refresh(sender: UIRefreshControl) {
        
        fetchMeals()
    }
}

// MARK: - Table View Data Source
extension MealsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mealsTableViewCell, for: indexPath)!
        let meal = displayedMeals[indexPath.row]
        cell.configure(meal)
        return cell
    }
}

// MARK: - Table View Data Source
extension MealsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Meals Display Logic
extension MealsViewController: MealsDisplayLogic {
    
    func displayFetchMealsSuccess(viewModel: Meals.FetchMeals.ViewModel) {
        
        SVProgressHUD.dismiss()
        refreshControl.endRefreshing()
        
        displayedMeals = viewModel.displayedMeals
        tableView.reloadData()
    }
    
    func displayFetchMealsError(viewModel: Meals.FetchMeals.ViewModel) {
        
        SVProgressHUD.dismiss()
        showErrorAlert(message: viewModel.error?.message)
    }
}
