//
//  BrightnessTableViewCell.swift
//  TribalHome
//
//  Created by TSL043 on 11/15/17.
//  Copyright © 2017 TribalScale. All rights reserved.
//

import HomeKit
import UIKit

let brightnessTableViewCellNibName = "BrightnessTableViewCell"

class BrightnessTableViewCell: UITableViewCell {

    private var characteristic: HMCharacteristic! {
        
        didSet {
            
            brightnessValueLabel.text = nil
            
            characteristic.readValue(completionHandler: { error in
                
                guard error == nil else {
                    
                    return
                }
                
                self.brightnessValueLabel.text = (self.characteristic.value as AnyObject).description
                self.brightnessSlider.setValue(self.characteristic.value as! Float, animated: false)

            })
            
        }
        
    }
    
    @IBOutlet weak var brightnessValueLabel: UILabel!

    @IBOutlet weak var brightnessSlider: UISlider!
    
    @IBAction func brightnessSliderValueChanged(_ sender: UISlider) {
        
        characteristic.writeValue(Int(brightnessSlider.value), completionHandler: { error in
            
            guard error == nil else {
                
                return
                
            }
            
            self.brightnessValueLabel.text = (self.characteristic.value as AnyObject).description
            self.brightnessSlider.setValue(self.characteristic.value as! Float, animated: true)
            
        })
        
    }
    
}

extension BrightnessTableViewCell {
    
    func configure(with characteristic: HMCharacteristic) {
        
        self.characteristic = characteristic
                
    }
    
}