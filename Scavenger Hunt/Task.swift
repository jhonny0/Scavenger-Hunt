//
//  Task.swift
//  Scavenger Hunt
//
//  Created by Jonathan Fernandez on 3/2/24.
//

import Foundation
import UIKit
import CoreLocation

struct Task: Identifiable {
    let id: UUID = UUID()
    let title: String
    let description: String
    var isCompleted: Bool = false
    var attachedPhoto: UIImage? = nil
    var photoLocation: CLLocation? = nil
}
