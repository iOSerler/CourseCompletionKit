//
//  File.swift
//  
//
//  Created by Ahror Jabborov on 7/1/22.
//

import Foundation
import SwiftUI
public protocol CourseCompletionAssets {
    var completeCourseIcon: String { get }
    var titleFont: String { get }
    var descriptionFont: String { get }
    var mainTextColor: UIColor { get }
    var descriptionTextColor: UIColor { get }
    var primaryColor: UIColor { get }
    var buttonTextColor: UIColor { get }
}
