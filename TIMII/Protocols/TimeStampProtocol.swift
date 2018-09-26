//
//  TimeStampProtocol.swift
//  TIMII
//
//  Created by Dennis Huang on 9/16/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//
// Records the time and date when an component/object/item is created

import Foundation

protocol TimeStampProtocol
{
    var createdTimeStamp: Date { get set }
}
