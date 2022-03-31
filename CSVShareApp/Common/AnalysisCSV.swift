

import Foundation

func analysisData(data:Data){
//    let dataBytes = [UInt8](data)
    let str = String(decoding: data, as: UTF8.self)
    let strList = str.components(separatedBy: "\n")
    print(str)
//    print("strList.count \(strList.count)")
    for (index , s) in strList.enumerated(){
        
        if index != 0 {
            print(s)
            let dataList = s.components(separatedBy: ",")
//            print("index\(index) \(dataList.count)")
            if dataList.count == 6 {
                let userID = dataList[0]
                let name = dataList[1]
                let birthday = dataList[2]
                let height = dataList[3]
                let gender = dataList[4]
                let createTime = dataList[5]
                let heightValue = Int((Float(height) ?? 0) * 1000 )
                var g : Bool! = true
                if gender == "Male" {
                    g = true
                }else{
                    g = false
                }
                if CoreDataManage.shared.saveMeasuredPersonForData(idCode: userID, name: name, birthday: dateFormatter(date: birthday) ?? Date(), height: heightValue, gender: g, createTime: dateFormatter(date: createTime) ?? Date()){
                    print("存擋成功")
                }else{
                    print("失敗")
                }
                
                
            }
            
        }
    }
    
}
