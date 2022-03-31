import UIKit

var meteringSystemIndex = 0
class AddMeasuredPersonTableViewController: UITableViewController {

    @IBOutlet weak var tfCodeID: NoLineUITextField!
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
    
    var addNewHandler:((String) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.addGestureRecognizer(tap)
        
        tfCodeID.delegate = self
        tfName.delegate = self
        tfBirthday.delegate = self
        tfHeight.delegate = self
        
//        tfBirthday.placeholder = customDateFormatterList[customDateFormatterIndex].name
        setDatePicker()
        tfBirthday.inputView = datePicker
        tfBirthday.setToolbar()
        
        pickerView = UIPickerView()
        
        pickerView?.delegate = self
        tfHeight.inputView = pickerView
        tfHeight.setToolbar()
        
        btMan.unselected()
        btWoman.unselected()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
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
        let codeId = tfCodeID.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let name = tfName.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let birthday = tfBirthday.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let strheight = tfHeight.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if gender == nil {
//            showAlert(title: strOk, message: strSelectGender)
            return
        }
        if codeId == "" , name == "" {
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
        if CoreDataManage.shared.MeasuredPersonCheck(idCode: codeId) {
//            showAlert(title: strOk, message: strDuplicateID)
            return
        }


        if CoreDataManage.shared.saveMeasuredPerson(idCode: codeId, name: name, birthday: datePicker!.date, height: Int(height * 1000), gender: gender!) {
            addNewHandler?(codeId)
//            showAlertCallback(message: strCreateCompleted) { [unowned self] in
//                dismiss(animated: true, completion: nil)
//            }
            dismiss(animated: true, completion: nil)
            
        }else{
//            showAlert(title: strOk, message: strfailure)
            return
        }
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
extension AddMeasuredPersonTableViewController : UIPickerViewDelegate , UIPickerViewDataSource {
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
            
//            if pickerView.selectedRow(inComponent: 0) == 1 { // 限制身高200
//                pickerView.selectRow(0, inComponent: 1, animated: true)
//                pickerView.selectRow(0, inComponent: 2, animated: true)
//                pickerView.selectRow(0, inComponent: 4, animated: true)
//            }
            var newnumber = ""
            newnumber.append("\(pickerView.selectedRow(inComponent: 0) + 1)")
            newnumber.append("\(pickerView.selectedRow(inComponent: 1))")
            newnumber.append("\(pickerView.selectedRow(inComponent: 2))")
            newnumber.append(".")
            newnumber.append("\(pickerView.selectedRow(inComponent: 4))")
            
            height  = Double(newnumber)!
            tfHeight.text = "\(String(format:"%.1f", height)) cm"
//            if let currentAccount = currentAccount {
//                currentAccount.height = infostring
//            }
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
//            print((ft * 12 + inch))
//            print(height)
//            let saveH = Int(height * 1000)
//            print(saveH)
//            let saveHin = Double(saveH) / 2.54 / 1000
//            print("\(String(format:"%.1f", saveHin)) in")
            
            tfHeight.text = "\(newnumber)"
            
            
        }
    }
    
}

extension AddMeasuredPersonTableViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfCodeID{
               if let text = textField.text, let range = Range(range, in: text) {
                   let newText = text.replacingCharacters(in: range, with: string)
                   if string == "" {
                       return true
                   }
                   guard match(string,regularEnum : .id) else {return false}
                   if newText.count > 16 {

                       return false
                   }
               }
        }
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField
        {
        case tfCodeID:
            tfName.becomeFirstResponder()
            break
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
