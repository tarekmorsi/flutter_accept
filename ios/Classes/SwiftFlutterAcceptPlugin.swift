import Flutter
import UIKit
import AcceptSDK

public class SwiftFlutterAcceptPlugin: NSObject, FlutterPlugin, AcceptSDKDelegate {
    
    var result: FlutterResult?;
    
    public func userDidCancel() {
        result!("cancelled");
    }
    
    public func paymentAttemptFailed(_ error: AcceptSDKError, detailedDescription: String) {
        result!("failed");
        
    }
    
    public func transactionRejected(_ payData: PayResponse) {
        result!("rejected");
        
    }
    
    public func transactionAccepted(_ payData: PayResponse) {
        result!("accepted");
        
    }
    
    public func transactionAccepted(_ payData: PayResponse, savedCardData: SaveCardResponse) {
        result!("accepted");
        
    }
    
    public func userDidCancel3dSecurePayment(_ pendingPayData: PayResponse) {
        result!("cancelled3d");
        
    }
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_accept", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterAcceptPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "getPlatformVersion" ) {
            result("iOS " + UIDevice.current.systemVersion)
        } else if(call.method == "init" ){
            
            guard let args : [String:Any] = call.arguments as? [String : Any] else {
                result("iOS could not recognize flutter arguments in method: (sendParams)");
                return;
            }
            
            
            let billingData: [String : String] = args["billingData"] as! [String : String];
            let buttonsColor: String = args["buttonsColor"] as! String;
            let maskedPanNumber: String = args["maskedPanNumber"] as! String;
            let paymentKey: String = args["paymentKey"] as! String;
            let saveCardDefault: Bool = args["saveCardDefault"] as! Bool;
            let showAlerts: Bool = args["showAlerts"] as! Bool;
            let showSaveCard: Bool = args["showSaveCard"] as! Bool;
            let token: String = args["token"] as! String;
            
            print("iOS WeAccept: request call invoked");
            
            self.result = result;
            self.pay(billingData, buttonsColor, maskedPanNumber, paymentKey, saveCardDefault, showAlerts, showSaveCard, token);
        }else{
            result(FlutterMethodNotImplemented);
        }
        
    }
    
    
    @objc func handleResponse(notification: Notification, result: FlutterResult) {
        
        print("handleResponse in pod")
        
        if let response = notification.userInfo?["response"] as? String {
            print(response);
            //            result(response);
        }
        
    }
    
    
    
    public func  pay(_ billingData: [String : String], _ buttonsColor: String, _ maskedPanNumber: String, _ paymentKey:String, _ saveCardDefault:Bool, _ showAlerts: Bool, _ showSaveCard: Bool, _ token: String){
        
        let accept = AcceptSDK();
        accept.delegate = self;
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            do {
                
                try accept.presentPayVC(vC: navigationController, billingData: billingData, paymentKey: paymentKey,  saveCardDefault: saveCardDefault, showSaveCard: showSaveCard, showAlerts: showAlerts, token: token, maskedPanNumber: maskedPanNumber, buttonsColor: getColor(buttonsColor))
            } catch AcceptSDKError.MissingArgumentError(let errorMessage) {
                print(errorMessage)
            } catch let error {
                print(error.localizedDescription)
            }
        }else{
            let controller : UIViewController = UIApplication.shared.keyWindow!.rootViewController!;
            do {
                try accept.presentPayVC(vC: controller, billingData: billingData, paymentKey: paymentKey,  saveCardDefault: saveCardDefault, showSaveCard: showSaveCard, showAlerts: showAlerts, buttonsColor: getColor(buttonsColor))
            } catch AcceptSDKError.MissingArgumentError(let errorMessage) {
                print(errorMessage)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func getColor(_ colorName : String) -> UIColor{
        if(colorName == "red"){
            return UIColor.red;
        }else if(colorName == "green"){
            return UIColor.green;
        }else if(colorName == "blue"){
            return UIColor.blue;
        }else{
            return UIColor.black;
        }
        
    }
}
