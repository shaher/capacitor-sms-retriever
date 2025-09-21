import Foundation
import Capacitor
import KAPinField
import UIKit
import SnapKit

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorSmsRetrieverPlugin)
public class CapacitorSmsRetrieverPlugin: CAPPlugin {
    
    @objc func startListening(_ call: CAPPluginCall) {
        // SMS auto-retrieval is not supported on iOS
        // iOS apps need to use the present() method to show a PIN entry UI
        call.resolve(["body": "SMS auto-retrieval not supported on iOS. Use present() method instead."])
    }
    
    @objc func stopListening(_ call: CAPPluginCall) {
        // SMS auto-retrieval is not supported on iOS
        call.resolve()
    }

    @objc func present(_ call: CAPPluginCall) {
        let numberOfCharacters = call.getInt("numberOfCharacters") ?? 4
        let pinView = PinViewController(numberOfCharacters:numberOfCharacters,returnCall: call)
        
        DispatchQueue.main.async {
            self.bridge?.viewController?.present(pinView, animated: true)
           }
           
       }

    @objc func getHashCode(_ call: CAPPluginCall) {
        // App signature hash is not needed on iOS as SMS auto-retrieval is not supported
        call.reject("getHashCode method not supported on iOS. App signature hash is only required for Android SMS Retriever API.")
    }
}

class PinViewController: UIViewController, KAPinFieldDelegate {
    lazy var centerStackView = UIStackView()
    @IBOutlet var pinCodeTextField: KAPinField!
//    lazy var pinCodeTextField = KAPinField()
    private var returnCall : CAPPluginCall
    private var numberOfCharacters:Int
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }

    required init(numberOfCharacters: Int, returnCall: CAPPluginCall) {
        self.returnCall = returnCall
        self.numberOfCharacters = numberOfCharacters
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        self.view.backgroundColor = .white
        
        centerStackView.translatesAutoresizingMaskIntoConstraints = false
        centerStackView.axis = .vertical
        centerStackView.distribution = .fillEqually
        self.view.addSubview(pinCodeTextField)
        centerStackView.addArrangedSubview(pinCodeTextField)
        self.view.addSubview(centerStackView)
        pinCodeTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        pinCodeTextField.updateProperties { properties in
            properties.delegate = self
            properties.numberOfCharacters = numberOfCharacters // Default to 4

        }
//        pinCodeTextField.properties.delegate = self
//        pinCodeTextField.properties.numberOfCharacters = numberOfCharacters // Default to 4
        pinCodeTextField.becomeFirstResponder()
         
        centerStackView.snp.makeConstraints { (make) in
                        make.center.equalToSuperview()
                        make.width.equalToSuperview()
                        make.height.equalTo(100)
                    }

           
    }
    
    func pinField(_ field: KAPinField, didFinishWith code: String) {
      print("didFinishWith : \(code)")
        pinCodeTextField.animateSuccess(with: "✔️") {
        }
        returnCall.resolve(["code":code])
        self.dismiss(animated: true) {
            
        }
    }
}
