
import Foundation
import CoreData
import UIKit


class CoreDataManage : NSObject {
    
    static var shared = CoreDataManage()
    static var currentAccount : Account?
    static var currentMP : MeasuredPerson?
    
    func insertAccount(account:String , password : String , permission : Int) -> Account?{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            if let newAccount = NSEntityDescription.insertNewObject(forEntityName: "Account", into: context) as? Account {
                
                newAccount.creatTime = Date()
                newAccount.permission = Int16(permission)
                newAccount.account = account
                newAccount.password = password
                do {
                    if context.hasChanges {
                        try context.save()
                        return newAccount
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        return nil
    }
    func accountGet(account:String) -> Account?{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Account>(entityName: "Account")
            request.predicate = NSPredicate(format: "account == %@ ", argumentArray: [account])
            do {
                let results = try context.fetch(request)
                if results.first != nil {
//                    print("帳號x重複：\(result.account ?? "")")
                    return results.first
                }else if results.count == 0 {
                    return nil
                }
            } catch let error {
                print(error.localizedDescription)
                return nil
                
            }
        }
        return nil
    }
    func accountCheck(account:String) -> Bool{ // true = 重複
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Account>(entityName: "Account")
            request.predicate = NSPredicate(format: "account == %@ ", argumentArray: [account])
            do {
                let results = try context.fetch(request)
                if results.first != nil {
//                    print("帳號x重複：\(result.account ?? "")")
                    return true
                }else if results.count == 0 {
                    return false
                }
            } catch let error {
                print(error.localizedDescription)
                return false
                
            }
        }
        return false
    }
    func accountLoginCheck(account:String , password : String) -> Bool{ // true = 登入
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Account>(entityName: "Account")
            request.predicate = NSPredicate(format: "account == %@  AND password == %@", argumentArray: [account , password])
            do {
                let results = try context.fetch(request)
                if let result = results.first {
                    CoreDataManage.currentAccount = result
                    return true
                }else if results.count == 0 {
                    return false
                }
            } catch let error {
                print(error.localizedDescription)
                return false
                
            }
        }
        return false
    }
    func loadAllAccount() -> [Account]{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Account>(entityName: "Account")
            do {
                let accounts = try context.fetch(request)
                return accounts
                
            }catch let error {
                
                print(error.localizedDescription)
            }
        }
        return []
    }
    func deleteAccountForAccount(account:String){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Account>(entityName: "Account")
            request.predicate = NSPredicate(format: "account == %@ ", argumentArray: [account])
            do {
                let results = try context.fetch(request)
                if let result = results.first {
                    print("刪除\(result.account ?? "")")
                    context.delete(result)
                }
                if context.hasChanges {
                    try context.save()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    func deleteAccount(account:Account){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            do {
                context.delete(account)
                if context.hasChanges {
                    try context.save()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    func updateAccountStatus(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            do {
                if context.hasChanges {
                    try context.save()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    func MeasuredPersonCheck(idCode:String) -> Bool{ // true = 重複
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<MeasuredPerson>(entityName: "MeasuredPerson")
            request.predicate = NSPredicate(format: "idCode == %@ ", argumentArray: [idCode])
            do {
                let results = try context.fetch(request)
                if results.first != nil {
                    //                    print("帳號x重複：\(result.account ?? "")")
                    return true
                }else if results.count == 0 {
                    return false
                }
            } catch let error {
                print(error.localizedDescription)
                return false
                
            }
        }
        return false
    }
    func saveMeasuredPerson(idCode:String,name:String , birthday:Date, height:Int , gender : Bool) -> Bool{
        if let currentAccount = CoreDataManage.currentAccount {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let context = appDelegate.persistentContainerOld.viewContext
                if let measuredPerson = NSEntityDescription.insertNewObject(forEntityName: "MeasuredPerson", into: context) as? MeasuredPerson {
                    measuredPerson.creatTime = Date()
                    measuredPerson.name = name
                    measuredPerson.idCode = idCode
                    measuredPerson.birthday = birthday
                    measuredPerson.heightX1000 = Int64(height)
                    measuredPerson.gender = gender
                    measuredPerson.account = currentAccount
                    do {
                        if context.hasChanges {
                            try context.save()
                            return true
                        }
                    } catch let error {
                        print(error.localizedDescription)
                        return false
                    }
                }
            }
        }
        return false
    }
    func deleteMeasuredPerson(mp:MeasuredPerson){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            do {
                context.delete(mp)
                if context.hasChanges {
                    try context.save()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    func getLastTimeData(mp:MeasuredPerson) -> Measurement_data? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Measurement_data>(entityName: "Measurement_data")
            request.predicate = NSPredicate(format: "measuredPerson == %@ ", argumentArray: [mp])
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchLimit = 1
            do {
                let results = try context.fetch(request)
                if let result = results.first {
                    return result
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func getFristTimeData(mp:MeasuredPerson) -> Measurement_data? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Measurement_data>(entityName: "Measurement_data")
            request.predicate = NSPredicate(format: "measuredPerson == %@ ", argumentArray: [mp])
            let sort = NSSortDescriptor(key: "date", ascending: true)
            request.sortDescriptors = [sort]
            request.fetchLimit = 1
            do {
                let results = try context.fetch(request)
                if let result = results.first {
                    return result
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func getNextData(mp:MeasuredPerson , data : Measurement_data) -> Measurement_data? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Measurement_data>(entityName: "Measurement_data")
            request.predicate = NSPredicate(format: "measuredPerson == %@ AND date > %@", argumentArray: [mp , data.date!])
            let sort = NSSortDescriptor(key: "date", ascending: true)
            request.sortDescriptors = [sort]
            request.fetchLimit = 1
            do {
                let results = try context.fetch(request)
                if let result = results.first {
                    return result
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func getLastData(mp:MeasuredPerson , data : Measurement_data) -> Measurement_data? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Measurement_data>(entityName: "Measurement_data")
            request.predicate = NSPredicate(format: "measuredPerson == %@ AND date < %@", argumentArray: [mp , data.date!])
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchLimit = 1
            do {
                let results = try context.fetch(request)
                if let result = results.first {
                    return result
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func getLast7Data(mp:MeasuredPerson , data : Measurement_data) -> [Measurement_data] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Measurement_data>(entityName: "Measurement_data")
            request.predicate = NSPredicate(format: "measuredPerson == %@ AND date <= %@", argumentArray: [mp , data.date!])
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchLimit = 7
            do {
                let results = try context.fetch(request)
                return results
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return []
    }
    
    func getWeekData(mp:MeasuredPerson , data : Measurement_data) -> [Measurement_data]{
        let start = data.date!
        let end = Calendar.current.date(byAdding: .day, value: -7, to: start)!
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Measurement_data>(entityName: "Measurement_data")
            request.predicate = NSPredicate(format: "measuredPerson == %@ AND date <= %@ AND date > %@", argumentArray: [mp , data.date! , end])
            let sort = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [sort]
            
//            request.fetchLimit = 1
            do {
                let results = try context.fetch(request)
//                results.reduce(results[0]) { r, data in
//                    return r += Float(data.deviceId)
//                }
//                for r in results {
//                    print(dateTimeFormatter(date: r.date!))
//                }
                return results
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return []
    }
    func loadAllMeasuredPerson() -> [MeasuredPerson]{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<MeasuredPerson>(entityName: "MeasuredPerson")
            do {
                let measuredPersons = try context.fetch(request)
                return measuredPersons
            }catch let error {
                print(error.localizedDescription)
            }
        }
        return []
    }
    func searchMeasuredPerson(mpName : String) -> [MeasuredPerson] {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<MeasuredPerson>(entityName: "MeasuredPerson")
            request.predicate = NSPredicate(format: "name CONTAINS %@ OR idCode CONTAINS %@", argumentArray: [mpName , mpName])
            
            do {
                let results = try context.fetch(request)
                return results
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return []
    }

//    func saveData(deviceId:Int,analysisObject:AnalysisObject) -> Bool{
//        if let mp = CoreDataManage.currentMP {
//            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//                let context = appDelegate.persistentContainerOld.viewContext
//                if let measurement_data = NSEntityDescription.insertNewObject(forEntityName: "Measurement_data", into: context) as? Measurement_data {
//                    measurement_data.date = Date()
//                    measurement_data.deviceId = Int16(deviceId)
//                    measurement_data.measuredPerson = mp
//                    
//                    for index in 0...37 {
//                        let measurementfunc = Measurement_func(context: context)
//                        measurementfunc.func_Id = Int16(index)
//                        switch index {
//                        case 0:
//                            measurementfunc.numberX10 = Int64(Int16((analysisObject.getWeight() ?? 0) * 100))
//                            measurementfunc.times = 100
//                        case 1:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBmi() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 2:
//                            measurementfunc.numberX10 = Int64(analysisObject.getVat() ?? 0)
//                            measurementfunc.times = 1
//                        case 3:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFat() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 4:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatMass() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 5:
//                            measurementfunc.numberX10 = Int64((analysisObject.getSmm() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 6:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatRightArm() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 7:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatLeftArm() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 8:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatTrunk() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 9:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatRightLeg() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 10:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatLeftLeg() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 11:
//                            measurementfunc.numberX10 = Int64((analysisObject.getMuscleMess() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 12:
//                            measurementfunc.numberX10 = Int64((analysisObject.getMuscleMessRightArm() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 13:
//                            measurementfunc.numberX10 = Int64((analysisObject.getMuscleMessLeftArm() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 14:
//                            measurementfunc.numberX10 = Int64((analysisObject.getMuscleMessTrunk() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 15:
//                            measurementfunc.numberX10 = Int64((analysisObject.getMuscleMessRightLeg() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 16:
//                            measurementfunc.numberX10 = Int64((analysisObject.getMuscleMessLeftLeg() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 17:
//                            measurementfunc.numberX10 = Int64((analysisObject.getSmr() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 18:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyWaterRate() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 19:
//                            measurementfunc.numberX10 = Int64(analysisObject.getBodyAge() ?? 0)
//                            measurementfunc.times = 1
//                        case 20:
//                            measurementfunc.numberX10 = Int64(analysisObject.getBmr() ?? 0)
//                            measurementfunc.times = 1
//                        case 21:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBone() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 22:
//                            measurementfunc.numberX10 = Int64(analysisObject.getPosture() ?? -1)
//                            measurementfunc.times = 1
//                        case 23:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatMassRightArm() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 24:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatMassLeftArm() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 25:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatMassTrunk() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 26:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatMassRightLeg() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 27:
//                            measurementfunc.numberX10 = Int64((analysisObject.getBodyFatMassLeftLeg() ?? 0) * 10)
//                            measurementfunc.times = 10
//                        case 28:
//                            measurementfunc.numberX10 = Int64((analysisObject.fatIndexRightArm ?? 0))
//                            measurementfunc.times = 1
//                        case 29:
//                            measurementfunc.numberX10 = Int64((analysisObject.fatIndexLeftArm ?? 0))
//                            measurementfunc.times = 1
//                        case 30:
//                            measurementfunc.numberX10 = Int64((analysisObject.fatIndexTrunk ?? 0))
//                            measurementfunc.times = 1
//                        case 31:
//                            measurementfunc.numberX10 = Int64((analysisObject.fatIndexRightLeg ?? 0))
//                            measurementfunc.times = 1
//                        case 32:
//                            measurementfunc.numberX10 = Int64((analysisObject.fatIndexLeftLeg ?? 0))
//                            measurementfunc.times = 1
//                        case 33:
//                            measurementfunc.numberX10 = Int64((analysisObject.muscleIndexRightArm ?? 0))
//                            measurementfunc.times = 1
//                        case 34:
//                            measurementfunc.numberX10 = Int64((analysisObject.muscleIndexLeftArm ?? 0))
//                            measurementfunc.times = 1
//                        case 35:
//                            measurementfunc.numberX10 = Int64((analysisObject.muscleIndexTrunk ?? 0))
//                            measurementfunc.times = 1
//                        case 36:
//                            measurementfunc.numberX10 = Int64((analysisObject.muscleIndexRightLeg ?? 0))
//                            measurementfunc.times = 1
//                        case 37:
//                            measurementfunc.numberX10 = Int64((analysisObject.muscleIndexLeftLeg ?? 0))
//                            measurementfunc.times = 1
//                        default:
//                            break
//                        }
//                        measurement_data.addToMeasurementFunc(measurementfunc)
//                    }
//                            
//                    do {
//                        if context.hasChanges {
//                            try context.save()
//                            return true
//                        }
//                    } catch let error {
//                        print(error.localizedDescription)
//                        return false
//                    }
//                }
//            }
//        }
//        return false
//    }
    func loadData() -> [Measurement_data]{
        if let mp = CoreDataManage.currentMP {
            if let datas = mp.measurementData?.allObjects as? [Measurement_data] {
                
                return datas
            }
        }
        return []
    }
    func deleteData(data:Measurement_data){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            do {
                context.delete(data)
                if context.hasChanges {
                    try context.save()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    func getFuncs(data:Measurement_data) -> [Measurement_func]{
        if let funcs = data.measurementFunc?.allObjects as? [Measurement_func] {
            return funcs
        }
        return []
    }
    func getFunc(data:Measurement_data , funcid : Int16) -> Measurement_func? {
        if let funcs = data.measurementFunc?.allObjects as? [Measurement_func] {
            for f in funcs {
                if f.func_Id == funcid {
                    return f
                }
            }
            
        }
        return nil
    }
    func getListFuncs(data:Measurement_data) -> [Measurement_func]{ // 總共拿11項顯示清單
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Measurement_func>(entityName: "Measurement_func")
            request.predicate = NSPredicate(format: "measurementData == %@ AND ( func_Id == 0 || func_Id == 1 || func_Id == 2 || func_Id == 3 ||  func_Id == 4 ||  func_Id == 5 ||func_Id == 11 || func_Id == 18 || func_Id == 19 || func_Id == 20 || func_Id == 21 )", argumentArray: [data])
            let sort = NSSortDescriptor(key: "func_Id", ascending: true)
            request.sortDescriptors = [sort]
            
            do {
                let results = try context.fetch(request)
                return results
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return []
    }
    func getWeightFunc(data:Measurement_data) -> Measurement_func? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Measurement_func>(entityName: "Measurement_func")
            request.predicate = NSPredicate(format: "measurementData == %@ AND func_Id == 0", argumentArray: [data])
            
            do {
                let results = try context.fetch(request)
                if let result = results.first {
                    return result
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func getPostureFunc(data:Measurement_data) -> Measurement_func? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Measurement_func>(entityName: "Measurement_func")
            request.predicate = NSPredicate(format: "measurementData == %@ AND func_Id == 22", argumentArray: [data])
            do {
                let results = try context.fetch(request)
                if let result = results.first {
                    return result
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
   
    
    func saveMemo(memoContent:String) -> Bool {
        if let currentMP = CoreDataManage.currentMP {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let context = appDelegate.persistentContainerOld.viewContext
                if let memo = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: context) as? Memo {
                    memo.memo = memoContent
                    memo.editTime = Date()
                    memo.measuredPerson = currentMP
                    do {
                        if context.hasChanges {
                            try context.save()
                            return true
                        }
                    } catch let error {
                        print(error.localizedDescription)
                        return false
                    }
                }
            }
        }
        return false
    }
    func loadMemo() -> String{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let request = NSFetchRequest<Memo>(entityName: "Memo")
            request.predicate = NSPredicate(format: "measuredPerson == %@ ", argumentArray: [CoreDataManage.currentMP!])
            let sort = NSSortDescriptor(key: "editTime", ascending: false)
            request.sortDescriptors = [sort]
            request.fetchLimit = 1
            do {
                let results = try context.fetch(request)
                if let result = results.first {
                    return result.memo ?? ""
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return ""
    }
}
