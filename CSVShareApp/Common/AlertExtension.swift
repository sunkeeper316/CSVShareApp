import UIKit
import Foundation

extension UIViewController {
    func showAlertNetWorkError(){
        let alert = UIAlertController(title: "警告", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func showAlert(title : String , message : String){
        let alert = UIAlertController(title: "警告", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertCallback( message : String , completionHandler: @escaping () -> Void){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [unowned self] in
            dismiss(animated: true, completion: nil)
            completionHandler()
        }
    }
    func showAlertCheckCallback( message : String , completionHandler: @escaping (Bool) -> Void){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            completionHandler(true)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertOKCallback( message : String , completionHandler: @escaping (Bool) -> Void){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "", style: .default) { action in
            completionHandler(true)
        }
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertOKCallback( message : String ,ok:String , cancel:String, completionHandler: @escaping (Bool) -> Void){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: ok, style: .default) { action in
            completionHandler(true)
        }
        let cancelAction = UIAlertAction(title: cancel, style: .cancel) { action in
            completionHandler(false)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
//    func addKeyboardObserver() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//    }
//    func removeKeyboardObserver(){
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//    }
}
