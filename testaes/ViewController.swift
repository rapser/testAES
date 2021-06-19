//
//  ViewController.swift
//  testaes
//
//  Created by miguel tomairo on 6/15/21.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let key = "YwelHhJSRGV9KiApzfw7IkyfCb4AHhoK" // length == 32
        let iv = "gqLOHUioQ0QjhuvI" // length == 16
        let s = "Miguel estuvo aqui XD"
            
        let enc = try! s.aesEncrypt(key, iv: iv)
        let dec = try! enc.aesDecrypt(key, iv: iv)
        print(s) // string to encrypt
        print("enc:\(enc)") // 2r0+KirTTegQfF4wI8rws0LuV8h82rHyyYz7xBpXIpM=
        print("dec:\(dec)") // string to encrypt
        print("\(s == dec)") // true
                        
    }

}

extension String {
    
    func aesEncrypt(_ key: String, iv: String) throws -> String {
        let encrypted = try AES(key: key, iv: iv, padding: .pkcs7).encrypt([UInt8](self.data(using: .utf8)!))
        return Data(encrypted).base64EncodedString()
    }

    func aesDecrypt(_ key: String, iv: String) throws -> String {
        guard let data = Data(base64Encoded: self) else { return "" }
        let decrypted = try AES(key: key, iv: iv, padding: .pkcs7).decrypt([UInt8](data))
        return String(bytes: decrypted, encoding: .utf8) ?? self
    }
}
