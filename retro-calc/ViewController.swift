//
//  ViewController.swift
//  retro-calc
//
//  Created by Sagar Kataria on 7/4/16.
//  Copyright © 2016 Sagar Kataria. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    
    
    @IBOutlet weak var outputLabel : UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath:
            path!)
        do{
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numPressed(button : UIButton!){
        playSound()
        runningNumber += "\(button.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePress(sender: AnyObject) {
        processOperator(Operation.Divide)
    }
    
    @IBAction func onMultiplyPress(sender: AnyObject) {
        processOperator(Operation.Multiply)
    }
    
    @IBAction func onSubtractPress(sender: AnyObject) {
        processOperator(Operation.Subtract)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        processOperator(Operation.Add)
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        processOperator(currentOperation)
    }
    
    func processOperator(op:Operation){
        playSound()
        if currentOperation != Operation.Empty {
            //Run some math
            
            if runningNumber != "" {
                
            rightValString = runningNumber
                
            runningNumber = ""
            
            
            if currentOperation == Operation.Multiply{
                result = "\(Double(leftValString)! * Double(rightValString)!)"
            }
            else if currentOperation == Operation.Divide{
                result = "\(Double(leftValString)! / Double(rightValString)!)"
            }
            else if currentOperation == Operation.Subtract{
                result = "\(Double(leftValString)! - Double(rightValString)!)"
            }
            else {
                result = "\(Double(leftValString)! + Double(rightValString)!)"
            }
            
            leftValString = result
                
            outputLabel.text = leftValString
            }
            
            currentOperation = op
            
            
        } else{
          //First time an operator was pressed
            
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    
    }
    
    func playSound(){
        if buttonSound.playing{
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
}

