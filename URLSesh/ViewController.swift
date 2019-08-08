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
    }

}

