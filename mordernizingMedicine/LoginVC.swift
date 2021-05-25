//
//  LoginVC.swift
//  mordernizingMedicine
//
//  Created by Setu Desai on 5/14/21.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lblDate: UITextField!
    
    //private var datePickers = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        datePickers.datePickerMode = .dateAndTime
//        datePickers.addTarget(self, action: #selector(LoginVC.dateChanged(datePicker:)), for: .valueChanged)
//        lblDate.inputView = datePickers
    }
    
    @IBAction func onPressStart(_ sender: Any) {
        if ((txtName.text?.isEmpty) == true) || ((txtLastName.text?.isEmpty) == true) || ((lblDate.text?.isEmpty) == true) {
            let alert = UIAlertController(title: "Alert", message: "Fill in all the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ReportVC") as! ReportVC
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
//    @objc func dateChanged(datePicker : UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//        lblDate.text = dateFormatter.string(from: datePicker.date)
//        view.endEditing(true)
//    }
    @IBAction func onPressedDate(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
