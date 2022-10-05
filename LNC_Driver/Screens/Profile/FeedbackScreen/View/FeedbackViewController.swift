//
//  FeedbackViewController.swift
//  LNC_Driver
//
//  Created by rajesh gandru on 02/10/22.
//

import UIKit
import Cosmos
class FeedbackViewController: UIViewController {
    var str_UserID = ""
    var str_Username = ""
    var str_UserImageUrl = ""
    var str_DriverLoginID = ""
    var str_RatingValue = ""
    @IBOutlet weak var imageview_UserProlfileRef: UIImageView!
    @IBOutlet weak var lbl_Usernameref: UILabel!
    @IBOutlet weak var view_ratingViewRef: CosmosView!
    @IBOutlet weak var textview_descriptionRef: UITextView!
    
    lazy var viewModel = {
        FeedbackViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feed back"
        self.cosmosViewSetUP()
        self.str_DriverLoginID = UserDefaults.standard.string(forKey: "DriverLoginID") ?? ""
        //User Image
        if let Str_UserImage = self.str_UserImageUrl as? String {
            self.imageview_UserProlfileRef.sd_setImage(with: URL(string: API_URl.API_IMAGEBASE_URL +  Str_UserImage), placeholderImage: UIImage(named: "personIcon"))
        }

        self.textview_descriptionRef.layer.cornerRadius = 5.0
        self.textview_descriptionRef.layer.masksToBounds = true
       // self.textview_descriptionRef.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_FeedbackSubmitActionRef(_ sender: Any) {
        if self.textview_descriptionRef.text.count ?? 0 > 0 || str_RatingValue != "" {
            self.ShowAlert(message: I18n.allFieldsEmpty)
        } else {
            //feedback api for user  Calling...
            self.feedbackAPIToUserBased(OnDriverID: str_DriverLoginID, withRating: str_RatingValue, withUserID: self.str_UserID, withMessage: self.textview_descriptionRef.text)
        }
    }
    
    func cosmosViewSetUP(){
        // Change the cosmos view rating
        view_ratingViewRef.rating = 5

        // Change the text
       // viewRating_DriverForFeedbackRef.text = "(123)"

        // Called when user finishes changing the rating by lifting the finger from the view.
        // This may be a good place to save the rating in the database or send to the server.
        view_ratingViewRef.didFinishTouchingCosmos = { rating in
            self.str_RatingValue = "\(rating)"
        }

        // A closure that is called when user changes the rating by touching the view.
        // This can be used to update UI as the rating is being changed by moving a finger.
        view_ratingViewRef.didTouchCosmos = { rating in
            
        }

    }
}
extension FeedbackViewController {
    //MARK: - Feedback API
    func feedbackAPIToUserBased(OnDriverID: String,withRating: String, withUserID: String,withMessage: String){
         indicator.showActivityIndicator()
        
       let perams = [
        "driverid":self.str_DriverLoginID,
        "rating":withRating,//str_UserLoginID,
        "userid":withUserID,
        "msg":withMessage,
         ]
        self.viewModel.requestForFeedbackAPIServices(perams: perams) { success, model, error in
            if success, let UserData = model {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.ShowAlertWithPush(message: UserData.userData?[0].message ?? "", className: "PaymentHistoryViewController", storyBoard: "RidesHistory", Animation: true)
                }
            } else {
                DispatchQueue.main.async { [self] in
                    indicator.hideActivityIndicator()
                    self.showToast(message: error ?? "No Such Email Address Found.", font: .systemFont(ofSize: 12.0))
                }
            }
            
        }
    }
}
