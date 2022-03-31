
import Foundation

class CustomDateFormatter {
    var id : Int?
    var name : String?
    var dateFormat : String?
    
    init (id :Int?, name : String , dateFormat : String){
        self.id = id
        self.name = name
        self.dateFormat = dateFormat
    }
}

let customDateFormatter0 = CustomDateFormatter(id: 0, name: "yyyy/MM/dd", dateFormat: "yyyy/MM/dd")
let customDateFormatter1 = CustomDateFormatter(id: 1, name: "MM/dd/yyyy", dateFormat: "MM/dd/yyyy")
let customDateFormatter2 = CustomDateFormatter(id: 2, name: "dd/MM/yyyy", dateFormat: "dd/MM/yyyy")

let customDateFormatterList = [customDateFormatter0 , customDateFormatter1 , customDateFormatter2]

var customDateFormatterIndex = 0

func dateFormatter(date:Date) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = customDateFormatterList[customDateFormatterIndex].dateFormat
    return formatter.string(from: date)
}
func dateFormatter(date:String) -> Date?{
    let formatter = DateFormatter()
    formatter.dateFormat = customDateFormatterList[customDateFormatterIndex].dateFormat
    return formatter.date(from: date)
}
func dateTimeFormatter(date:Date) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = "\(customDateFormatterList[customDateFormatterIndex].dateFormat!)  HH:mm:ss"
    return formatter.string(from: date)
}
func dateTimeFormatter(date:String) -> Date?{
    let formatter = DateFormatter()
    formatter.dateFormat = "\(customDateFormatterList[customDateFormatterIndex].dateFormat!)  HH:mm:ss"
    return formatter.date(from: date)
}
class DateHelper: NSObject {
    static var shared = DateHelper()
    
    
    lazy var dateFormatterCurrent: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = customDateFormatterList[customDateFormatterIndex].dateFormat
        return formatter
    }()
    lazy var dateFormatterOne: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    lazy var dateFormatterTwo: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter
    }()
    lazy var dateFormatter3: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
}
