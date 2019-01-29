//
//  MemoryViewController.swift
//  Memorise
//
//  Created by Dan Korkelia on 29/01/2019.
//  Copyright © 2019 Dan Korkelia. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var item: MemoryItem!
    var blackCounter = 0
    
    let visiableText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.black
    ]
    
    let invisiableText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.clear,
        .strikethroughStyle: 1,
        .strikethroughColor: UIColor.black
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // assertions only crash your app at the development time, they don' et compiled at the app shipment time to AppStore.
        
        assert(item != nil, "You must provide a memory item before trying to show this view controller!")
        textView.attributedText = showText(for: item)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
        textView.addGestureRecognizer(tapRecognizer)
    }
    
    func showText(for memoryItem: MemoryItem) -> NSAttributedString {
        let words = memoryItem.text.components(separatedBy: " ")
        let output = NSMutableAttributedString()
        
        let space = NSAttributedString(string: " ", attributes: visiableText)
        
        for (index, word) in words.enumerated() {
            if index < blackCounter {
                let attributedWord = NSAttributedString(string: word, attributes: visiableText)
                output.append(attributedWord)
            } else {
                var strippedWord = word
                var punctuation: String?
                
                if ".,".contains(word.last!) {
                    punctuation = String(strippedWord.removeLast())
                }
                
                let attributedWord = NSAttributedString(string: strippedWord, attributes: invisiableText)
                output.append(attributedWord)
                
                if let symbol = punctuation {
                    let attributedPunctuation = NSAttributedString(string: symbol, attributes: visiableText)
                    output.append(attributedPunctuation)
                }
            }
            output.append(space)
        }
        return output
    }
    
    @objc func wordsTapped() {
        blackCounter += 1
        textView.attributedText = showText(for: item)
    }

}
