
import UIKit

class EditMeasuredPersonTableViewController: UITableViewController {
    
    @IBOutlet weak var lbIdCode: UILabel!
    @IBOutlet weak var tfName: NoLineUITextField!
    @IBOutlet weak var tfBirthday: NoLineUITextField!
    @IBOutlet weak var tfHeight: NoLineUITextField!
    
    
    @IBOutlet weak var btMan: UIButton!
    @IBOutlet weak var btWoman: UIButton!
    
    
    var textFieldRealYPosition: CGFloat = 0.0
    
    var pickerView:UIPickerView?
    var datePicker:UIDatePicker?
    var calendar = Calendar.current
    
    var gender : Bool?
    var height : Double = 160.0
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.addGestureRecognizer(tap)
        
//        tfCodeID.delegate = self
        tfName.delegate = self
        tfBirthday.delegate = self
        tfHeight.delegate = self
        
        tfBirthday.placeholder = customDateFormatterList[customDateFormatterIndex].name
        setDatePicker()
        tfBirthday.inputView = datePicker
        tfBirthday.setToolbar()
        
        pickerView = UIPickerView()
        pickerView?.delegate = self
        tfHeight.inputView = pickerView
        tfHeight.setToolbar()
        
        btMan.unselected()
        btWoman.unselected()
        if let m = CoreDataManage.currentMP {
            lbIdCode.text = m.idCode
            tfName.text = m.name
            gender = m.gender
            if gender! {
                btMan.selected()
                
            }else{
                btWoman.selected()
            }
            height = Double(m.heightX1000) / 1000
            datePicker?.date = m.birthday!
            tfBirthday.text = dateFormatter(date: datePicker!.date)
            if meteringSystemIndex == 0 {
                tfHeight.text = "\(String(format:"%.1f", height)) cm"
            }else{
                let inch = height / 2.54
                let ft = Int(inch) / 12
                let inchInt = Int(inch) % 12
                let decimal = Int(inch * 10) % 10
                
                tfHeight.text = "\(ft) ft \(inchInt).\(decimal) in"
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = UIColor.green
        addKeyboardObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObserver()
    }
    func setDatePicker(){
        datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        }
        var dateComponents = DateComponents()
        
        dateComponents.calendar = calendar
        dateComponents.year = 2000
        dateComponents.month = 1
        dateComponents.day = 1
        
        datePicker!.date = dateComponents.date!
        datePicker!.datePickerMode = .date
        datePicker?.maximumDate = Date()
        datePicker?.minimumDate = calendar.date(byAdding: .year, value: -100, to: Date())
    }
    
    @objc func hideKeyboard() {
        tableView.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    func removeKeyboardObserver(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            print("view height\(self.view.frame.height)")
            let distanceBetweenTextfielAndKeyboard = self.view.frame.height - textFieldRealYPosition - keyboardSize.height
//            print("distanceBetweenTextfielAndKeyboard \(distanceBetweenTextfielAndKeyboard)"  )
            if distanceBetweenTextfielAndKeyboard < 0 {
                UIView.animate(withDuration: 0.4) {
                    DispatchQueue.main.async{
                        self.view.transform = CGAffineTransform(translationX: 0.0, y: distanceBetweenTextfielAndKeyboard)
                    }
                }
            }
        }
    }
    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.4) {
            DispatchQueue.main.async{
                self.view.transform = .identity
            }
        }
    }
    @IBAction func clickBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func clickSave(_ sender: UIButton){
//        let codeId = tfCodeID.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let name = tfName.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let birthday = tfBirthday.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strheight = tfHeight.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if gender == nil {
//            showAlert(title: strOk, message: strSelectGender)
            return
        }
        if  name == "" {
//            showAlert(title: strOk, message: strIDNameempty)
            return
        }
        if birthday == "" {
//            showAlert(title: strOk, message: strSelectBirthday)
            return
        }
        if strheight == "" {
//            showAlert(title: strOk, message: strSelectHeight)
            return
        }
       
        CoreDataManage.currentMP?.name = name
        CoreDataManage.currentMP?.birthday = datePicker!.date
        CoreDataManage.currentMP?.gender = gender!
        CoreDataManage.currentMP?.heightX1000 = Int64(height * 1000)
        CoreDataManage.shared.updateAccountStatus()
//        showAlertCallback(message: strSaveOK) { [unowned self] in
//            
//        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickMan(_ sender: UIButton) {
        btMan.selected()
        btWoman.unselected()
        gender = true
    }
    
    @IBAction func clickWoman(_ sender: UIButton) {
        btMan.unselected()
        btWoman.selected()
        gender = false
    }

    

}
extension EditMeasuredPersonTableViewController : UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if meteringSystemIndex == 0 {
            return 5
        }else {
            return 6
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if meteringSystemIndex == 0 {
            switch component {
            case 0:
                return 2
            case 1:
                return 10
            case 2:
                return 10
            case 3:
                return 1
            case 4:
                return 10
            default:
                return 0
            }
        }else {
            switch component {
            case 0:
                return 4
            case 1:
                return 1
            case 2:
                return 12
            case 3:
                return 1
            case 4:
                return 10
            case 5:
                return 1
            default:
                return 0
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if meteringSystemIndex == 0 {
            switch component {
            case 0:
                return String(row + 1)
            case 1:
                return String(row)
            case 2:
                return String(row)
            case 3:
                return "."
            case 4:
                return String(row)
            default:
                return String(row)
            }
        }else {
            switch component {
            case 0:
                return String(row + 3)
            case 1:
                return "ft"
            case 2:
                return String(row)
            case 3:
                return "."
            case 4:
                return String(row)
            case 5:
                return "in"
            default:
                return String(row)
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if meteringSystemIndex == 0 {

            var newnumber = ""
            newnumber.append("\(pickerView.selectedRow(inComponent: 0) + 1)")
            newnumber.append("\(pickerView.selectedRow(inComponent: 1))")
            newnumber.append("\(pickerView.selectedRow(inComponent: 2))")
            newnumber.append(".")
            newnumber.append("\(pickerView.selectedRow(inComponent: 4))")
            
            height  = Double(newnumber)!
            tfHeight.text = "\(String(format:"%.1f", height)) cm"

        }else {

            var newnumber = ""
            newnumber.append("\(pickerView.selectedRow(inComponent: 0) + 3)")
            newnumber.append(" ft ")
            newnumber.append("\(pickerView.selectedRow(inComponent: 2))")
            newnumber.append(".")
            newnumber.append("\(pickerView.selectedRow(inComponent: 4))")
            newnumber.append(" in ")
//            tfHeightFt.text = String(pickerView.selectedRow(inComponent: 0) + 3)
            let ft = Double(pickerView.selectedRow(inComponent: 0)) + 3
            let inch = Double(pickerView.selectedRow(inComponent: 2)) + Double(pickerView.selectedRow(inComponent: 4)) / 10
            height = (ft * 12 + inch) * 2.54
          
            tfHeight.text = "\(newnumber)"
            
        }
    }
    
}

extension EditMeasuredPersonTableViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField
        {
        case tfName:
            tfBirthday.becomeFirstResponder()
            break
        case tfBirthday:
            tfHeight.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
        }
        
        
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfHeight {
            if meteringSystemIndex == 0 {
                tfHeight.text = "\(String(format:"%.1f", height)) cm"
                pickerView?.selectRow((Int(height) / 100 % 10 ) - 1, inComponent: 0, animated: true)
                pickerView?.selectRow(Int(height) / 10 % 10, inComponent: 1, animated: true)
                pickerView?.selectRow(Int(height) % 10, inComponent: 2, animated: true)
                pickerView?.selectRow(Int(height * 10)  % 10, inComponent: 4, animated: true)
            }else {
                let inch = height / 2.54
                let ft = Int(inch) / 12
                let inchInt = Int(inch) % 12
                let decimal = Int(inch * 10) % 10
                
                tfHeight.text = "\(ft) ft \(inchInt).\(decimal) in"
    //            if let heightin = currentAccount?.heightInch , let heightFt = currentAccount?.heightft{
                pickerView?.selectRow(ft - 3, inComponent: 0, animated: true)
                pickerView?.selectRow(inchInt , inComponent: 2, animated: true)
                pickerView?.selectRow(decimal , inComponent: 4, animated: true)
    //            }
            }
        }
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
      textFieldRealYPosition = textField.frame.origin.y + textField.frame.height + 90
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == tfBirthday {
            tfBirthday.text = dateFormatter(date: datePicker!.date)
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        if textField == tfPermission {
////            print()
//            if let index = pickerView?.selectedRow(inComponent: 0) {
//                tfPermission.text = permissions[index + 1].name
//            }
//        }
    }
    
   
}
