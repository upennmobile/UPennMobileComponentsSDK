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
    
    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter.cached(withFormat: UPennRFC3339DateFormat())
        formatter.timeStyle = DateFormatter.Style.medium //Set time style
        formatter.dateStyle = DateFormatter.Style.medium //Set date style
        formatter.timeZone = .current
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func dateNowFormatted() -> String {
        let date = self.getDateFromTimeInterval(Date().timeIntervalSince1970)
        return self.formatDate(date)
    }
    
    static func ConvertDateFormat(_ dateString: String, inputFormat: UPennDateFormat, outputFormat: UPennDateFormat) -> String {
        if let cachedFormatter = cachedFormatters[inputFormat.formatString] {
            return ApplyFormatter(cachedFormatter, dateString, inputFormat, outputFormat)
        }
        let formatter = MakeNewCachedDateFormatter(format: inputFormat)
        return ApplyFormatter(formatter, dateString, inputFormat, outputFormat)
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
        _ formatter: DateFormatter,
        _ dateString: String,
        _ inputFormat: UPennDateFormat,
        _ outputFormat: UPennDateFormat) -> String
    {
        formatter.dateFormat = inputFormat.formatString
        guard let date = formatter.date(from: dateString) else { return dateString }
        formatter.dateFormat = outputFormat.formatString
        let dateString = formatter.string(from: date)
        return dateString
    }
}
