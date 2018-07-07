//
//  UIStyleSystem.swift
//  TIMII
//
//  Created by Daddy on 5/19/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
/*
import Foundation

enum UIStyleSystem : UIStyle
{
    case BottomNavBar, FullScreen, IdCircle, Input, Panel, TopNavBar, None
    
    var UIType: String
    {
        get { return self.getUITypeTextLabel() }
    }
    
    func getUITypeTextLabel() -> String
    {
        switch self
        {
        case .BottomNavBar:     return "BottomNavBar"
        case .FullScreen:       return "FullScreen"
        case .IdCircle:         return "IdCircle"
        case .Input:            return "Input"
        case .Panel:            return "Panel"
        case .TopNavBar:        return "TopNavBar"
        case .None:             return ""
        }
    }
}
*/
// https://stackoverflow.com/questions/24011170/how-to-make-an-enum-conform-to-a-protocol-in-swift//protocol
// ExampleProtocol {
//    var simpleDescription: String { get }
//    mutating func adjust()
//}
//
//enum ExampleEnum : ExampleProtocol {
//    case Base, Adjusted
//
//    var simpleDescription: String {
//        return self.getDescription()
//    }
//
//    func getDescription() -> String {
//        switch self {
//        case .Base:
//            return "A simple description of enum"
//        case .Adjusted:
//            return "Adjusted description of enum"
//        }
//    }
//
//    mutating func adjust() {
//        self = ExampleEnum.Adjusted
//    }
//}
//
//var c = ExampleEnum.Base
//c.adjust()
