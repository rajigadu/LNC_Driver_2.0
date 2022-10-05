//
//  SelfPartnerDetailsViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 28/09/22.
//

import UIKit

class SelfPartnerDetailsViewController: UIViewController {
    
    @IBOutlet weak var lbl_PartnerNameRef: UILabel!
    @IBOutlet weak var lbl_PartnerEmailRef: UILabel!
    @IBOutlet weak var lbl_PartnerMobileRef: UILabel!
    @IBOutlet weak var lbl_DriverAmountRef: UILabel!
    @IBOutlet weak var lbl_DriverTipRef: UILabel!
    @IBOutlet weak var lbl_PartnerAmountRef: UILabel!
    @IBOutlet weak var lbl_PartnerTipRef: UILabel!
    @IBOutlet weak var Customarnamelblref: UILabel!
    @IBOutlet weak var pickuplblref: UILabel!
    @IBOutlet weak var transactionlblref: UILabel!
    @IBOutlet weak var droplblref: UILabel!

    var dict_RidePartnerDetails :PaymentHistoryDatar?
    var loginDriverIDStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Partner Details"
        loginDriverIDStr = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        
        //NAME:
        var str_CurrentUsername = (dict_RidePartnerDetails?.first_name ?? "") ?? "" + " " + (dict_RidePartnerDetails?.last_name ?? "") ?? ""
        if str_CurrentUsername == "" {
            self.Customarnamelblref.text = ""
        } else {
            self.Customarnamelblref.text = "Customer Name : " + str_CurrentUsername
        }
        
        // user location pickup
        var str_pickup = dict_RidePartnerDetails?.pickup_address ?? ""
        self.pickuplblref.text = "Pickup Location : " + str_pickup
        
        // user drop  location
        var str_drop = dict_RidePartnerDetails?.drop_address ?? ""
        self.droplblref.text = "Drop Location : " + str_pickup
       
        // user transation id
        var transationid = dict_RidePartnerDetails?.transaction_id ?? "Payment Failed"
        self.transactionlblref.text = "TransactionID : " + transationid
        
        var str_RidedriverID = dict_RidePartnerDetails?.driver_id_for_future_ride ?? ""
        var str_RidePartnerID = dict_RidePartnerDetails?.future_partner_id ?? ""
        
        if str_RidedriverID == loginDriverIDStr {
            var str_PartnerName = dict_RidePartnerDetails?.partners_details?[0].partner_name ?? ""
            if str_PartnerName == "" {
                self.lbl_PartnerNameRef.text = "Partner Name :"
                self.lbl_PartnerNameRef.isHidden = true
            } else {
                self.lbl_PartnerNameRef.text = "Partner Name : " + str_PartnerName
                self.lbl_PartnerNameRef.isHidden = false
            }
            
            
            var str_PartnerEmail = dict_RidePartnerDetails?.partners_details?[0].partner_email ?? ""
            if str_PartnerEmail == "" {
                self.lbl_PartnerEmailRef.text = "Partner Email :"
                self.lbl_PartnerEmailRef.isHidden = true
            } else {
                self.lbl_PartnerEmailRef.text = "Partner Email : " + str_PartnerEmail
                self.lbl_PartnerEmailRef.isHidden = false
            }
            
            var str_PartnerMobile = dict_RidePartnerDetails?.partners_details?[0].partner_phone ?? ""
            if str_PartnerMobile == "" {
                self.lbl_PartnerMobileRef.text = "Partner Mobile :"
                self.lbl_PartnerMobileRef.isHidden = true
            } else {
                self.lbl_PartnerMobileRef.text = "Partner Mobile : " + str_PartnerMobile
                self.lbl_PartnerMobileRef.isHidden = false
            }
        } else if str_RidePartnerID == loginDriverIDStr {
            var str_PartnerName = dict_RidePartnerDetails?.partners_details?[0].partner_name ?? ""
            if str_PartnerName == "" {
                self.lbl_PartnerNameRef.text = "Driver Name :"
                self.lbl_PartnerNameRef.isHidden = true
            } else {
                self.lbl_PartnerNameRef.text = "Driver Name : " + str_PartnerName
                self.lbl_PartnerNameRef.isHidden = false
            }
            
            
            var str_PartnerEmail = dict_RidePartnerDetails?.partners_details?[0].partner_email ?? ""
            if str_PartnerEmail == "" {
                self.lbl_PartnerEmailRef.text = "Driver Email :"
                self.lbl_PartnerEmailRef.isHidden = true
            } else {
                self.lbl_PartnerEmailRef.text = "Driver Email : " + str_PartnerEmail
                self.lbl_PartnerEmailRef.isHidden = false
            }
            
            var str_PartnerMobile = dict_RidePartnerDetails?.partners_details?[0].partner_phone ?? ""
            if str_PartnerMobile == "" {
                self.lbl_PartnerMobileRef.text = "Driver Mobile :"
                self.lbl_PartnerMobileRef.isHidden = true
            } else {
                self.lbl_PartnerMobileRef.text = "Driver Mobile : " + str_PartnerMobile
                self.lbl_PartnerMobileRef.isHidden = false
            }
        }
        
    }

}
