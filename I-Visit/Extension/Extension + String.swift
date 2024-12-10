//
//  Extension + String.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 10/12/24.
//

import Foundation

extension String {
    /// Converts a date string from ISO 8601 format to the specified format.
    /// - Parameter outputFormat: The desired date format (e.g., "MMMM dd yyyy").
    /// - Returns: A formatted date string, or `nil` if conversion fails.
    func toDateFormat(outputFormat: String) -> String? {
        // Create a DateFormatter for parsing the input string
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistency

        // Convert the string to a Date object
        guard let date = inputFormatter.date(from: self) else {
            return nil
        }

        // Create another DateFormatter for the desired output format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat

        // Format the Date to the desired output string
        return outputFormatter.string(from: date)
    }
}

