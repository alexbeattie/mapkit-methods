//
//  AnnotationView.swift
//  Mapkit-Methods
//
//  Created by Alex Beattie on 8/20/17.
//  Copyright © 2017 Artisan Branding. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AnnotationView: MKAnnotationView {
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")

    }

    convenience override init(annotation: MKAnnotation!, reuseIdentifier: String!) {
        self.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        var frame = self.frame
        frame.size = CGSize(width: 80, height: 80)
        self.frame = frame
//        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.centerOffset = CGPoint(x: -5, y: -5)
        
    }
   
    
    override func draw(_ rect: CGRect) {
        UIImage(named:"alllistingsmap.png")?.draw(in: CGRect(x: 30, y: 30, width: 30, height: 30))
    }

}
