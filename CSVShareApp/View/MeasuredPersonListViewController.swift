

import UIKit

class MeasuredPersonListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btSetting: UIButton!
    @IBOutlet weak var tfSearch: UITextField!
    
    var measuredPersons = [MeasuredPerson]()
    
    @IBOutlet weak var btDate: BackUIButton!
    @IBOutlet weak var btName: BackUIButton!
    @IBOutlet weak var lbBodyType: UILabel!
    
    var sortFunc = SortFunc.Name
    
    @IBOutlet weak var lbNodata: UILabel!
    @IBOutlet weak var lbNodata2: UILabel!
    @IBOutlet weak var ivNodata: UIImageView!
    
    
    @IBOutlet weak var ivTitle: CustomImageView!
    
    var addnewId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAdmin()
//        navigationController?.setNavigationBarHidden(false, animated: false)
        tableView.register(UINib(nibName: "MeasuredPersonTableViewCell", bundle: nil), forCellReuseIdentifier: "MeasuredPersonTableViewCell")
//        tfSearch.setLeftImage(leftImage: UIImage(named: "search")!)
        tfSearch.delegate = self
        tfSearch.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    override func viewWillAppear(_ animated: Bool) {
//        print("viewWillAppear")
        tfSearch.text = ""
//        ivTitle.image = styleList[currentUIStyleIndex].image
        measuredPersons = CoreDataManage.shared.loadAllMeasuredPerson()
        
        setSortFunc(sortFunc: sortFunc)
        tableView.reloadData()
        if measuredPersons.count == 0 {
            tableView.isHidden = true
            setNodata()
        }else{
            tableView.isHidden = false
            setHaveData()
        }
        
    }
    override func viewDidLayoutSubviews() {
//        print(btDate.titleLabel?.font.pointSize)
//        print(lbBodyType.font.pointSize)
        btName.titleLabel?.font = btDate.titleLabel?.font
        lbBodyType.font = btDate.titleLabel?.font
        
    }
    override func viewDidAppear(_ animated: Bool) {
//        print("viewDidAppear")
        if let addnewId = addnewId {
            for (index , mp ) in measuredPersons.enumerated() {
                if mp.idCode == addnewId {
                    tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: true)
                }
            }
        }
    }
    func setNodata(){
        lbNodata.isHidden = false
//        lbNodata2.isHidden = false
//        ivNodata.isHidden = false
    }
    func setHaveData() {
        lbNodata.isHidden = true
        lbNodata2.isHidden = true
        ivNodata.isHidden = true
    }
    
    @IBAction func clickSetting(_ sender: UIButton) { //借用來share
        let exportStr = createExportString(fetchedStatsArray: measuredPersons)
        saveAndExport(exportString: exportStr)
    }
    
    
    @IBAction func clickAdd(_ sender: UIButton) {
        performSegue(withIdentifier: "AddId", sender: self)
    }
    
    @IBAction func clickDate(_ sender: UIButton) {
        if sortFunc == SortFunc.Name || sortFunc == SortFunc.Dateup{
            sortFunc = SortFunc.Datedown
            setSortFunc(sortFunc: sortFunc)
        }else {
            sortFunc = SortFunc.Dateup
            setSortFunc(sortFunc: sortFunc)
        }
        tableView.reloadData()
    }
    
    @IBAction func clickName(_ sender: UIButton) {
        sortFunc = SortFunc.Name
        setSortFunc(sortFunc: sortFunc)
        tableView.reloadData()
    }
    
    func setSortFunc(sortFunc : SortFunc){
        switch sortFunc {
        case SortFunc.Name:
            sortName()
            break
        case SortFunc.Dateup:
            sortDateup()
            break
        case SortFunc.Datedown:
            sortDatedown()
            break
        }
    }
    func sortName(){
        btName.setImage(UIImage(named: "redarrow"), for: .normal)
        btDate.setImage(UIImage(named: "garyarrow"), for: .normal)
        measuredPersons.sort { mpA, mpB in
            return mpA.name!.localizedCompare(mpB.name!) == .orderedAscending
        }
    }
    func sortDateup(){
        btName.setImage(UIImage(named: "garyarrow"), for: .normal)
        btDate.setImage(UIImage(named: "topredarrow"), for: .normal)
        for m in measuredPersons {
            m.lastdate = CoreDataManage.shared.getLastTimeData(mp: m)?.date
        }
        measuredPersons.sort { mpA, mpB in
            if mpB.lastdate == nil {
                mpB.lastdate = Date(timeIntervalSince1970: 0)
            }
            if mpA.lastdate == nil {
                mpA.lastdate = Date(timeIntervalSince1970: 0)
            }
            return mpA.lastdate! > mpB.lastdate!
        }
    }
    func sortDatedown(){
        btName.setImage(UIImage(named: "garyarrow"), for: .normal)
        btDate.setImage(UIImage(named: "redarrow"), for: .normal)
        for m in measuredPersons {
            m.lastdate = CoreDataManage.shared.getLastTimeData(mp: m)?.date
        }
        measuredPersons.sort { mpA, mpB in
            if mpB.lastdate == nil {
                mpB.lastdate = Date()
            }
            if mpA.lastdate == nil {
                mpA.lastdate = Date()
            }
            return mpA.lastdate! < mpB.lastdate!
        }
    }
    func createAdmin(){
        if !CoreDataManage.shared.accountCheck(account: "admin") {
            let account = CoreDataManage.shared.insertAccount(account: "admin", password: "admin", permission: 0)
            if account != nil {
                CoreDataManage.currentAccount = account
            }
        }else{
            CoreDataManage.shared.accountLoginCheck(account: "admin", password: "admin")
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Setting" {
//            let vc = segue.destination as! SettingTableViewController
//            vc.logoutHandler = { [unowned self] in
//
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//                    dismiss(animated: false, completion: nil)
//                }
//            }
        }else if segue.identifier == "AddId" {
            if let vc = segue.destination as? AddMeasuredPersonTableViewController {
                vc.addNewHandler = { [unowned self] newId in
                    addnewId = newId
                }
            }
        }
    }
    enum SortFunc {
        case Dateup , Datedown , Name
    }

}
extension MeasuredPersonListViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        var text = textField.text!
//        text.append(string)
//
//        print(text)
//        measuredPersons = CoreDataManage.shared.searchMeasuredPerson(mpName : text)
//        setSortFunc(sortFunc: sortFunc)
//        tableView.reloadData()
        return true
    }
    @objc func textDidChange(_ textField:UITextField) {
        print(textField.text!)
        let text = textField.text!
        if text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "" {
            measuredPersons = CoreDataManage.shared.loadAllMeasuredPerson()
            setSortFunc(sortFunc: sortFunc)
            tableView.reloadData()
        }else{
            measuredPersons = CoreDataManage.shared.searchMeasuredPerson(mpName : text)
            setSortFunc(sortFunc: sortFunc)
            tableView.reloadData()
        }
        
     }

}
extension MeasuredPersonListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measuredPersons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeasuredPersonTableViewCell", for: indexPath) as! MeasuredPersonTableViewCell
        let measuredPerson = measuredPersons[indexPath.row]
        cell.lbIdCode.text = measuredPerson.idCode
        cell.lbName.text = measuredPerson.name
        cell.lbPosture.text = ""
        if let birthday = measuredPerson.birthday {
            cell.lbLastdate.text = dateFormatter(date: birthday)
        }else{
            cell.lbLastdate.text = ""
        }
        if measuredPerson.gender  {
            cell.lbPosture.text = "Male"
            cell.viewPosture.backgroundColor = .blue
        }else{
            cell.lbPosture.text = "Female"
            cell.viewPosture.backgroundColor = .red
        }
        
        if measuredPerson.idCode == addnewId {
            cell.view.addBorder()
        }else{
            cell.view.removeBorder()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let measuredPerson = measuredPersons[indexPath.row]
        CoreDataManage.currentMP = measuredPerson
        addnewId = ""
        performSegue(withIdentifier: "EditMP", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath:IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(
            style: .destructive,
                title: "",
                handler: { [unowned self](action, view, completion) in
                    //do what you want here
                    showAlertCheckCallback(message: "刪除資料確認！") { isCheck in
                        if isCheck {
                            CoreDataManage.shared.deleteMeasuredPerson(mp: measuredPersons[indexPath.row])
                            measuredPersons.remove(at: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                            
                        }
                    }
                    completion(true)
            })
        
        action.backgroundColor = .red
//        action.image = imageDelete
        let configuration = UISwipeActionsConfiguration(actions: [action])
//            configuration.performsFirstActionWithFullSwipe = false
        
            return configuration
    }
}
