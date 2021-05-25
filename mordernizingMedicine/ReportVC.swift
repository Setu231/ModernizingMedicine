//
//  ReportVC.swift
//  mordernizingMedicine
//
//  Created by Setu Desai on 5/14/21.
//

import UIKit

class ReportVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrRecords = [[String: String]]()
    var strBloodPressure = String()
    var flag = false
    var index = -1
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var txtSystolic: UITextField!
    @IBOutlet weak var txtDiastolic: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var btnDatePicker: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var emptyTableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.allowsMultipleSelectionDuringEditing = false
        addView.layer.cornerRadius = 20
        show()
    }
    override func viewWillAppear(_ animated: Bool) {
        show()
    }
    //MARK:- TableView Delegate and DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportTableViewCell", for: indexPath) as! ReportTableViewCell
        let eachRow = arrRecords[indexPath.row] as? [String:String]
        cell.lblDiaSys.text = eachRow?["bloodPressure"]
        cell.lblDate.text = eachRow?["date"]
        cell.lblBloodPressure.text = eachRow?["name"]
        cell.imgHeart.image = UIImage(named: "heart")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.4, animations: { [self] in
            let split = arrRecords[indexPath.row]
            let arr = split["bloodPressure"]?.components(separatedBy: "/")
            txtDiastolic.text = arr?[1].trimmingCharacters(in: .whitespacesAndNewlines)
            txtDate.text = split["date"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            txtSystolic.text = arr?[0].trimmingCharacters(in: .whitespacesAndNewlines)
            hiddenView.isHidden = false
            flag = true
            index = indexPath.row
        })
    }
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .delete) {
            arrRecords.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    //MARK:- IBActions
    @IBAction func onPressedCloseDate(_ sender: Any) {
        dateView.isHidden = false
    }
    @IBAction func onPressedDoneDate(_ sender: Any) {
        let dateFormatter = DateFormatter()

            dateFormatter.dateStyle = DateFormatter.Style.long
            dateFormatter.timeStyle = DateFormatter.Style.short

            let strDate = dateFormatter.string(from: datePicker.date)
            txtDate.text = strDate
        dateView.isHidden = false
    }
    @IBAction func onPressClose(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4, animations: { [self] in
            txtDiastolic.text = ""
            txtDate.text = ""
            txtSystolic.text = ""
            hiddenView.isHidden = true
            tableView.deselectRow(at: IndexPath(row: index, section: 0), animated: true)
        })
    }
    @IBAction func onPressDateBtn(_ sender: Any) {
        dateView.isHidden = false
    }
    @IBAction func onPressInsideAdd(_ sender: UIButton) {
        if ((txtSystolic.text?.isEmpty) == true) || ((txtDiastolic.text?.isEmpty) == true || txtDate.text?.isEmpty == true){
            let alert = UIAlertController(title: "Alert", message: "Fill in all the fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            UIView.animate(withDuration: 0.4, animations: { [self] in
                if(!flag) {
                var dictDetails: [String:String] = [:]
                var diastolic = Int()
                var systolic = Int()
                diastolic = Int(txtDiastolic.text!) ?? 0
                systolic = Int(txtSystolic.text!) ?? 0
                if diastolic < 120 && systolic < 80 {
                    dictDetails["name"] = "Normal"
                }else if (diastolic >= 120 && diastolic <= 129) && systolic < 80{
                    dictDetails["name"] = "Elevated"
                }else if (diastolic >= 120 && diastolic <= 129) || (systolic >= 80 && systolic <= 89){
                    dictDetails["name"] = "Hypertension - Stage 1"
                }else if diastolic > 180 || systolic > 120 {
                    dictDetails["name"] = "Hypertensive Crisis"
                }else if diastolic >= 140 || systolic >= 90 {
                    dictDetails["name"] = "Hypertension - Stage 2"
                }
                dictDetails["date"] = txtDate!.text
                dictDetails["bloodPressure"] = "\(txtSystolic.text!) / \(txtDiastolic.text!)"
                arrRecords.append(dictDetails)
                }else{
                    var dictDetails: [String:String] = [:]
                    var diastolic = Int()
                    var systolic = Int()
                    diastolic = Int(txtDiastolic.text!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
                    systolic = Int(txtSystolic.text!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
                    if systolic < 120 && diastolic < 80 {
                        dictDetails["name"] = "Normal"
                        
                    }else if (systolic >= 120 && systolic <= 129) && diastolic < 80{
                        dictDetails["name"] = "Elevated"
                    }else if (systolic >= 120 && systolic <= 129) || (diastolic >= 80 && diastolic <= 89){
                        dictDetails["name"] = "Hypertension - Stage 1"
                    }else if systolic > 180 || diastolic > 120 {
                        dictDetails["name"] = "Hypertensive Crisis"
                    }else if systolic >= 140 || diastolic >= 90 {
                        dictDetails["name"] = "Hypertension - Stage 2"
                    }
                    dictDetails["date"] = txtDate!.text
                    dictDetails["bloodPressure"] = "\(txtSystolic.text!) / \(txtDiastolic.text!)"
                    arrRecords[index] = dictDetails
                    tableView.deselectRow(at: IndexPath(row: index, section: 0), animated: true)
                }
                hiddenView.isHidden = true
                tableView.reloadData()
                flag = false
            })
        }
        show()
    }
    @IBAction func onPressAddButton(_ sender: Any) {
        UIView.animate(withDuration: 0.4, animations: { [self] in
            txtDiastolic.text = ""
            txtDate.text = ""
            txtSystolic.text = ""
            hiddenView.isHidden = false
        })
    }
    
    func show() {
        if(arrRecords.isEmpty == true) {
            emptyTableView.isHidden = false
            tableView.isHidden = true
        }else{
            emptyTableView.isHidden = true
            tableView.isHidden = false
        }
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
