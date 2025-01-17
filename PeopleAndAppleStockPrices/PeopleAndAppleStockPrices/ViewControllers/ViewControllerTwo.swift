//
//  ViewControllerTwo.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import  UIKit

class StockViewController:UIViewController {
  
    @IBOutlet weak var stockTableView: UITableView!
    
    var stocks = [Stocks]() {
        didSet {
            DispatchQueue.main.async {
                self.stockTableView.reloadData()
            }
        }
    }
    private func getData() {
        StockAPIClient.shared.fetchData { (results) in
            switch results {
            case .success(let user):
                self.stocks = user
            case .failure(let failure):
                print("could not retrieve Data \(failure)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUp()
        getData()
    }
}
extension StockViewController:UITableViewDelegate{}
extension StockViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stocks")
        cell?.textLabel?.text = "Date : \(stocks[indexPath.row].date)"
        cell?.detailTextLabel?.text = "Opening : \(stocks[indexPath.row].open.description)"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyBoard = storyboard?.instantiateViewController(withIdentifier: "DetailViewControllerStocks") as? DetailViewControllerStocks {
        
        storyBoard.passingInfo = stocks[indexPath.row]
        
        navigationController?.pushViewController(storyBoard, animated: true)
    }
        
    
    }

    func setUp() {
        stockTableView.dataSource = self
        stockTableView.delegate = self
    }
}
