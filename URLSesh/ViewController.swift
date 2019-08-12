//
//  ViewController.swift
//  URLSesh
//
//  Created by Michael Miles on 8/7/19.
//  Copyright © 2019 Michael Miles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var chuckLabel: UILabel!
    @IBOutlet weak var pastebinTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func chuckButtonPressed(_ sender: Any) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
            fatalError("Chuck Norris URL Error")
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dict = json as? [String : Any] {
                        if let value = dict["value"] as? String {
                            print(value)
                        }
                    }
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    @IBAction func pastebinButtonPressed(_ sender: Any) {
        let params = [
            "api_dev_key" : "YOUR_API_KEY_HERE",
            "api_option" : "paste",
            "api_paste_code" : pastebinTextField.text ?? "No text input"
        ]
        
        guard let url = URL(string: "https://pastebin.com/api/api_post.php") else {
            fatalError("Pastebin URL not available")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            fatalError("JSON serialization with httpBody in Pastebin did not work.")
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let dataString = String(data: data, encoding: String.Encoding.utf8) {
                    print(dataString)
                }
            }
        }.resume()
        
    }

}

