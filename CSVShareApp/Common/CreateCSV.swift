import UIKit
import CoreData
import Foundation

extension UIViewController {
    
    func storeTranscription() {
            //retrieve the entity that we just created
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainerOld.viewContext
            let entity =  NSEntityDescription.entity(forEntityName: "ItemList", in: context)
            let transc = NSManagedObject(entity: entity!, insertInto: context) as! MeasuredPerson

            //set the entity values
//            transc.itemID = Double(itemid)
//            transc.productname = nametext
//            transc.amount = Double(amountDouble)
//            transc.stock = stockStatus
//            transc.inventoryDate = inventoryDate

            //save the object
            do {
                try context.save()
                print("saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {

            }
        }
            
        }
    
    func saveAndExport(exportString: String) {
            let exportFilePath = NSTemporaryDirectory() + "Data_\(dateTimeFormatterCSV(date: Date())).csv"
            print("exportFilePath \(exportFilePath)")
            let exportFileURL = NSURL(fileURLWithPath: exportFilePath)
            FileManager.default.createFile(atPath: exportFilePath, contents: NSData() as Data, attributes: nil)
            //var fileHandleError: NSError? = nil
            var fileHandle: FileHandle? = nil
            do {
                fileHandle = try FileHandle(forWritingTo: exportFileURL as URL)
            } catch let error{
                print("Error with fileHandle")
                print(error)
            }

            if fileHandle != nil {
                fileHandle!.seekToEndOfFile()
                let csvData = exportString.data(using: String.Encoding.utf8, allowLossyConversion: false)
                fileHandle!.write(csvData!)

                fileHandle!.closeFile()

                let firstActivityItem = NSURL(fileURLWithPath: exportFilePath)
                let activityViewController : UIActivityViewController = UIActivityViewController(
                    activityItems: [firstActivityItem], applicationActivities: nil)

                activityViewController.excludedActivityTypes = [
                    UIActivity.ActivityType.assignToContact,
                    UIActivity.ActivityType.saveToCameraRoll,
                    UIActivity.ActivityType.postToFlickr,
                    UIActivity.ActivityType.postToVimeo,
                    UIActivity.ActivityType.postToTencentWeibo
                ]

                self.present(activityViewController, animated: true, completion: nil)
            }
        }

    func createExportString(fetchedStatsArray : [NSManagedObject]) -> String {

            
            var export :String = ""
//            if let mp = CoreDataManage.currentMP {
//                var showGender = ""
//                if !mp.gender {
//                    showGender = "Female"
//                }else {
//                    showGender = "Male"
//                }
//                export += "ID, \(strUser), \(strGender),\(strBirthday) \n"
//                export += "\(mp.userId ?? ""), \(mp.name ?? ""), \(showGender),\(dateFormatter(date: mp.birthday ?? Date())) \n"
//            }
            
            export += NSLocalizedString("ID, Name, Birthday, Height(cm), Gender,  CreateTime \n", comment: "")
            for (index, itemList) in fetchedStatsArray.enumerated() {
                if index <= fetchedStatsArray.count - 1 {
                    let idCode = itemList.value(forKey: "idCode") as! String?
                    let name = itemList.value(forKey: "name") as! String?
                    let heightX1000 = itemList.value(forKey: "heightX1000") as! Int64
                    var birthdayStr = ""
                    var creatTimeStr = ""
                    if let birthday = itemList.value(forKey: "birthday") as! Date? {
                        birthdayStr = dateFormatter(date: birthday)
                    }
                    var genderStr = ""
                    let gender = itemList.value(forKey: "gender") as! Bool
                    if gender {
                        genderStr = "Male"
                    }else{
                        genderStr = "Female"
                    }
                    if let creatTime = itemList.value(forKey: "creatTime") as! Date? {
                        creatTimeStr = dateTimeFormatter(date: creatTime)
                    }
//                    let inventoryDateSting = "\(dateTimeFormatter(date: inventoryDatevar))"
                    export += "\(idCode ?? ""),\(name ?? ""),\(birthdayStr),\(Float(heightX1000) / 1000),\(genderStr),\(creatTimeStr) \n"
                }
            }
            print("This is what the app will export: \(export)")
            return export
        }

}

//            var height: NSDecimalNumber?
//            var gross_weight: NSDecimalNumber?
//            var tare_weight: NSDecimalNumber?
//            var net_weight: NSDecimalNumber?
//            var bmi: NSDecimalNumber?
//            var bsa: NSDecimalNumber?
//
//            var grip: NSDecimalNumber?
//            var avg: NSDecimalNumber?
//            var count: Int16?
//            var target_grip: NSDecimalNumber?
