//
//  ViewController.swift
//  plistSample
//
//  Created by ミズキ on 2022/04/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var outputbutton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tap(_ sender: Any) {
        guard let text = tf.text else { return }
        let plistManager = PlistManager.shared
        plistManager.saveText(text)
    }
    @IBAction func output(_ sender: Any) {
        let plistManager = PlistManager.shared
        let text = plistManager.getText()
        label.text = text
    }
    
    
}

class PlistManager {
    static let shared = PlistManager()
    private init() {}
    func saveText(_ text: String) {
            let fileManager = FileManager.default
            guard let documentDirectoryURL = fileManager.urls(for: .documentDirectory,
                                                  in: .userDomainMask).first else { return }
            let path = documentDirectoryURL.appendingPathComponent("textFile.txt")

        do {
                try text.write(to: path, atomically: true, encoding: .utf8)
            } catch {
                print("failed to write: \(error)")
            }
        }
    
    
    func getText() -> String {
        let fileManager = FileManager.default
        guard let documentDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                fatalError("フォルダURL取得エラー")
            }
            let path = documentDirectoryURL.appendingPathComponent("textFile.txt")
            guard let fileContents = try? String(contentsOf: path) else {
                fatalError("ファイル読み込みエラー")
            }
            return fileContents
    }
}

