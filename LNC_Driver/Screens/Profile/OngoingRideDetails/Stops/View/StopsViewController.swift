//
//  StopsViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 03/10/22.
//

import UIKit

class StopsViewController: UIViewController {
    
    @IBOutlet weak var tableviewref: UITableView!
    @IBOutlet weak var nodataavilablelblref: UILabel!
    var dict_AdditionalStops :[DriverFutureRideDetailsPlanned_address] = []
    var str_plannedstops = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Additional Stops"
        self.tableviewref.estimatedRowHeight = 1000
        self.tableviewref.rowHeight = UITableView.automaticDimension
        
//        if str_plannedstops == "0" || str_plannedstops == "" {
//            nodataavilablelblref.hidden = false
//            tableviewref.hidden = true
//        } else {
            nodataavilablelblref.isHidden = true
//            tableviewref.hidden = false
//        }
    }
 

}
//MARK: - UITABLEVIEW DATASOURCE AND DELEGATE METHODS
extension StopsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections_nodata(in: tableView, ArrayCount: dict_AdditionalStops.count, numberOfsections: 1, data_MSG_Str: "No records found!")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dict_AdditionalStops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:AdditionalStopsCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalStopsCell", for: indexPath) as? AdditionalStopsCell else {return UITableViewCell()}
        cell.Locationlblref.text = "location : " + (dict_AdditionalStops[indexPath.row].location ?? "") 
        cell.selectionStyle = .none
       return cell
    }
}
