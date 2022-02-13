//
//  ViewController.swift
//  MAD157-CarOptions-JacobM
//
//  Created by student on 2/13/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var buttonSelect: UIButton!
    @IBOutlet var optionItems: [UIButton]! // this a collection outlet of multiple UI elements
    
    @IBOutlet weak var labelStep: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    
    // MARK: Variables
    var choices: [String] = []
    var cost = 20000.00
    var currentStep = 1
    
    //MARK: Arrays, Dictionaries
    let stepName = [1:"Model", 2:"Engine", 3:"Transmission", 4:"Bed Size", 5:"Wheels", 6:"Exterior", 7:"Interior"]
    
    let stepOptions = [1:["Tradesman", "Big Horn", "Rebel"],
                       2:["3.6L V6", "5.7L V8 Hemi", "3.0L V6 Diesel", "Previous Option"],
                       3:["Auto", "Auto 4x4", "Manual", "Manual 4x4", "Previous Option"],
                       4:["5'7 bed", "6'4 bed", "Previous Option"],
                       5:["18inch rims", "20inch rims", "Previous Option"],
                       6:["Black", "Blue", "White", "Maroon", "Red", "Previous Option"],
                       7:["Cloth", "Leather", "Previous Option"]
    ]
    let stepPrices = ["Tradesman":0.00, "Big Horn":5000.00, "Rebel":8000.00, //Model
                      "3.6L V6":0.00, "5.7L V8 Hemi":2000.00, "3.0L V6 Diesel":4000.00,//Engine
                      "Auto":0.00, "Auto 4x4":800.00, "Manual":0.00, "Manual 4x4":0.00,//Transmission
                      "5'7 bed":0.00, "6'4 bed":0.00,//Truck bed
                      "18inch rims":0.00, "20inch rims":450.00,//Wheels
                      "Black":0.00, "Gray":0.00, "Blue":0.00, "White":0.00, "Maroon":0.00, "Red":0.00,//Exterior
                      "Cloth":0.00, "Leather":250.00
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonSelect.layer.cornerRadius = buttonSelect.frame.height / 2.0 //make button round
        optionItems.forEach{(option) in //get each element in the collection outlet
            option.layer.cornerRadius = option.frame.height / 2.0
            option.isHidden = true
        }
        setupStep()
    }
    // MARK: functions
    func setupStep(){
        var indexCount = 0
        labelTitle.text = ("My Truck, Cost: $\(cost)")
        
        if (currentStep <= 7){
            buttonSelect.setTitle("Select \(stepName[currentStep]!)", for: .normal)
            labelStep.text = ("Step \(currentStep)/7")
            
            optionItems.forEach{(option) in
                option.setTitle("", for: .normal) //clear button text out
            }
            stepOptions[currentStep]?.forEach{(optionName) in
                optionItems[indexCount].setTitle(optionName, for: .normal) //set button text to option
                indexCount = indexCount + 1
            }
        }
        else{
            labelStep.text = ("Summary")
            buttonSelect.setTitle("Truck Summary", for: .normal)
            optionItems.forEach{(option) in
                option.setTitle(choices[indexCount], for: .normal)
                indexCount = indexCount + 1
            }
        }
    }
        
    
    // MARK: Actions
    @IBAction func optionSelect(_ sender: UIButton) {
        optionItems.forEach{(option) in
            UIView.animate(withDuration: 0.4, animations: { // creates the animation
                option.isHidden = !option.isHidden //flips the value
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func optionConfirmed(_ sender: UIButton) {
        if let optionLabel = sender.titleLabel?.text {
            print(optionLabel)
            if (optionLabel == "Previous Option"){
                if currentStep > 1 {
                    // checks to keep in range
                    if ((currentStep - 1) < 1){
                        print("out of range index; set to 1")
                        currentStep = 1
                    }
                    else{
                        print("lowering step")
                        currentStep = currentStep - 1
                    }
                    if (stepPrices[choices[(currentStep-1)]] != nil){
                        cost = cost - stepPrices[choices[(currentStep-1)]]!
                        choices.remove(at: currentStep-1)
                        setupStep()
                    }
                }
            }
            else{
                print("next step")
                currentStep = currentStep + 1
                cost = cost + stepPrices[optionLabel]!
                choices.append(optionLabel)
                setupStep()
            }
        }
    }
}

