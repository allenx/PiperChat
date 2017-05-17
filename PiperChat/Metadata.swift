//
//  Metadata.swift
//  PiperChat
//
//  Created by Allen X on 5/15/17.
//  Copyright © 2017 allenx. All rights reserved.
//

import Foundation
import UIKit

struct Metadata {
    
    struct Color {
        
        //HEX: 69DAC1
        static let accentColor = UIColor(hex6: 0x69DAC1)
        
        static let naviTextColor = UIColor(hex6: 0xFFFFFF)
        
        
        // Color for secondary texts like "view more"
        // Hex = 999999
        static let secondaryTextColor = UIColor(hex6: 0x999999)
    }
    
    struct Font {
        
        static let messageFont = UIFont.systemFont(ofSize: 16)
        
    }
    
    struct Size {
        
        struct Screen {
            
            static let width = UIScreen.main.bounds.width
            static let height = UIScreen.main.bounds.height
        }
        
        
        
        
    }
    
    struct Time {
        
    }
}

