

import Foundation

func getGender(gender:Bool) -> String{
    if gender {
        return "Male"
    }else{
        return "Female"
    }
}

func getSex(gender:Bool) -> String{
    if gender {
        return "Man"
    }else{
        return "Woman"
    }
}

func getAge(birthday:Date) -> Int{
    let calendar = Calendar.current

    let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
    let age = ageComponents.year!
    
    return age
}
func setlbShow(mp:MeasuredPerson) -> String{
    var height : Double = Double(mp.heightX1000 ) / 1000
    var strHeight = "\(String(format:"%.1f", height)) cm"
    
    if meteringSystemIndex == 1 {
        height = height / 2.54
        let ft = Int(height) / 12
        let inchInt = Int(height) % 12
        let decimal = Int(height * 10) % 10
        
        strHeight = "\(ft) \' \(inchInt).\(decimal) \""
    }else{
        strHeight = "\(String(format:"%.1f", height))"
    }
    
    let show = "|  \(strHeight)  |  \(getSex(gender:mp.gender))  |  \(getAge(birthday:mp.birthday!)) years"
    
    return show
}
//確認文字格式可以判斷email或電話等等格式
func match(_ input: String, regular: String = "", regularEnum: Regular = .none) -> Bool {
    
    let regular = regularEnum == .none ? regular : regularEnum.rawValue
    
    let regex = try? NSRegularExpression(pattern: regular, options: .caseInsensitive)
    
    if let matches = regex?.matches(in: input, range: NSMakeRange(0, input.count)) {
        return matches.count > 0
    } else {
        return false
    }
}
enum Regular: String {
    //用户名验证（允许使用小写字母、数字、下滑线、横杠，一共3~16个字符）
    case userName = "^[a-z0-9_-]{3,16}$",
    eMail = "^([a-z0-9_.-]+)@([da-z.-]+).([a-z.]{2,6})$",
    phone = "^1[0-9]{10}$",
    url = "^(https?://)?([da-z.-]+).([a-z.]{2,6})([/w.-]*)*/?$",
    ip = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",
    html = "^<([a-z]+)([^<]+)*(?:>(.*)</1>|s+/>)$",
    pureNumber = "^[0-9]*$",
    password = "^[\\x21-\\x7E]{8,16}$",
    id = "^[a-zA-Z0-9]{1,16}$",
    none = ""
}
