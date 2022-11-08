//
//  Dateformatter+UPenn.swift
//  Change Request
//
//  Created by Rashad Abdul-Salam on 10/26/18.
//  Copyright © 2018 University of Pennsylvania Health System. All rights reserved.
//

import Foundation

public protocol UPennDateFormatted {
    var formatString: String { get set }
}

open class UPennDateFormat : UPennDateFormatted {
    public var formatString: String
    
    public init(_ string: String) {
        self.formatString = string
    }
}

open class UPennBasicHoursMinSecsDateFormat : UPennDateFormat {
    public convenience init() {
        self.init("yyyy-MM-dd'T'HH:mm:ss")
    }
}

open class UPennISO8601DateFormat : UPennDateFormat {
    public convenience init() {
        self.init("yyyy-MM-dd'T'HH:mm:ss.SSSXXX")
    }
}

open class UPennRFC3339DateFormat : UPennDateFormat {
    public convenience init() {
        self.init("yyyy-MM-dd'T'HH:mm:ssZZZZZ")
    }
}

open class UPennUNIXEPOCHDateFormat : UPennDateFormat {
    public convenience init() {
        self.init("1970-01-01T00:00:00Z")
    }
}

open class UPennMonthDayYearTimeDateFormat : UPennDateFormat {
    public convenience init() {
        self.init("MMM d, yyyy h:mm a")
    }
}

private var cachedFormatters = [String : DateFormatter]()
public extension DateFormatter {
    
    static func formatString(_ dateString: String, format: UPennDateFormat = UPennISO8601DateFormat()) -> String {
        /*
         * 1. Create date object from cached formatter,
         * 2. Update to desired dateFormat
         * 3. Set dateString from formatter
         * 4. Reset cached formatter dateFormat
         */
        return ConvertDateFormat(dateString, inputFormat: format, outputFormat: UPennMonthDayYearTimeDateFormat())
    }
    
    static func cached(withFormat format: UPennDateFormat) -> DateFormatter {
        if let cachedFormatter = cachedFormatters[format.formatString] { return cachedFormatter }
        return MakeNewCachedDateFormatter(format: format)
    }
    
    static func formatDate(_ date: Date, format: UPennDateFormat=UPennRFC3339DateFormat()) -> String {
        let formatter = DateFormatter.cached(withFormat: format)
        if format is UPennRFC3339DateFormat {
            formatter.timeStyle = DateFormatter.Style.medium //Set time style
            formatter.dateStyle = DateFormatter.Style.medium //Set date style
        }
        formatter.timeZone = .current
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func dateNowFormatted() -> String {
        let date = self.getDateFromTimeInterval(Date().timeIntervalSince1970)
        return self.formatDate(date)
    }
    
    static func ConvertDateFormat(_ dateString: String, inputFormat: UPennDateFormat, outputFormat: UPennDateFormat) -> String {
        let inputFormatter = cachedFormatters[inputFormat.formatString] ?? MakeNewCachedDateFormatter(format: inputFormat)
        let outputFormatter = cachedFormatters[outputFormat.formatString] ?? MakeNewCachedDateFormatter(format: outputFormat)
        return ApplyFormatter(dateString, inputFormatter, outputFormatter)
    }
    
    static func GetDateFromString(_ dateString: String, with dateFormat: UPennDateFormat = UPennMonthDayYearTimeDateFormat()) -> Date {
        let formatter = cachedFormatters[dateFormat.formatString] ?? MakeNewCachedDateFormatter(format: dateFormat)
        return formatter.date(from: dateString) ?? Date()
    }
}

private extension DateFormatter {
    static func getDateFromTimeInterval(_ interval: TimeInterval) -> Date {
        return Date(timeIntervalSince1970: interval)
    }
    
    static func MakeNewCachedDateFormatter(format: UPennDateFormat) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format.formatString
        formatter.locale = Locale(identifier: "en_US_POSIX")
        cachedFormatters[format.formatString] = formatter
        return formatter
    }
    
    static func ApplyFormatter(
        _ dateString: String,
        _ inputFormatter: DateFormatter,
        _ outputFormatter: DateFormatter) -> String
    {
        guard let date = inputFormatter.date(from: dateString) else { return dateString }
        let dateString = outputFormatter.string(from: date)
        return dateString
    }
}
