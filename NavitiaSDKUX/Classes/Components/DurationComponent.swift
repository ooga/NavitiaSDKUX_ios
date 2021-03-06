//
//  DurationComponent.swift
//  RenderTest
//
//  Created by Thomas Noury on 26/07/2017.
//  Copyright © 2017 Kisio. All rights reserved.
//

import Foundation
import Render

class DurationComponent: ViewComponent {
    var seconds: Int32 = 0
    
    override func render() -> NodeType {
        let computedStyles = self.styles
        var durationComponents: [NodeType] = []
        
        if self.seconds >= 3600 {
            let text = durationText(seconds: self.seconds)
            durationComponents = [
                ComponentNode(TextComponent(), in: self, props: {(component, hasKey: Bool) in
                    component.text = text
                    component.styles = self.digitsStyles
                }),
                ComponentNode(IconComponent(), in: self, props: {(component, hasKey: Bool) in
                    component.name = "arrow-right"
                    component.styles = self.arrowStyles
                })
            ]
        } else {
            durationComponents = [
                ComponentNode(TextComponent(), in: self, props: {(component, hasKey: Bool) in
                    component.text = String(Int(ceil(Double(self.seconds) / 60)))
                    component.styles = self.digitsStyles
                }),
                ComponentNode(TextComponent(), in: self, props: {(component, hasKey: Bool) in
                    component.text = "min"
                    component.styles = self.abbrStyles
                }),
                ComponentNode(IconComponent(), in: self, props: {(component, hasKey: Bool) in
                    component.name = "arrow-right"
                    component.styles = self.arrowStyles
                })
            ]
        }
        
        return ComponentNode(ViewComponent(), in: self, props: {(component, hasKey: Bool) in
            component.styles = computedStyles
        }).add(children: durationComponents)
    }
    
    let digitsStyles: [String: Any] = [
        "color": config.colors.tertiary,
        "fontWeight": "bold",
        "paddingRight": 4,
    ]
    let abbrStyles: [String: Any] = [
        "color": config.colors.tertiary,
        "paddingRight": 8,
    ]
    let arrowStyles: [String: Any] = [
        "color": config.colors.tertiary,
        "fontSize": 16,
        "marginRight": -4,
    ]
}
