

import Foundation
import UIKit
import WWCalendarTimeSelector

class CustomCalendar : WWCalendarTimeSelectorProtocol{
    var selector : WWCalendarTimeSelector!
    let color = UIColor.init(red: 27/255, green: 94/255, blue: 32/255, alpha: 1.0)
    
    func configCalendar(showDays : Bool, showMonth:Bool,showYear:Bool){
        selector.optionCurrentDate = Date()
        
    selector.optionStyles.showTime(false)
    selector.optionStyles.showDateMonth(showDays)
    selector.optionStyles.showMonth(showMonth)
    selector.optionStyles.showYear(showYear)
    let color = UIColor.init(red: 52/255, green: 18/255, blue: 139/255, alpha: 1.0)
    let color2 = UIColor.init(red: 52/255, green: 18/255, blue: 139/255, alpha: 1.0)
     selector.optionClockBackgroundColorAMPMHighlight = color2
     selector.optionClockBackgroundColorHourHighlight = color2
     selector.optionClockBackgroundColorMinuteHighlight = color2
     selector.optionTopPanelBackgroundColor = color2
     selector.optionMainPanelBackgroundColor = color
     selector.optionSelectorPanelBackgroundColor = color2
     selector.optionBottomPanelBackgroundColor = color
     selector.optionButtonFontColorCancel = UIColor.white
     selector.optionButtonFontColorDone = UIColor.white
     selector.optionButtonFontColorCancelHighlight = UIColor.white
        selector.optionCalendarFontColorPastDates = .white
     selector.optionCalendarFontColorFutureDates = UIColor.white
        selector.optionCalendarFontColorPastDatesHighlight = .black
        selector.optionCalendarFontColorTodayHighlight = .black
        selector.optionCalendarFontColorFutureDatesHighlight = .black
        selector.optionCalendarFontColorFutureYearsHighlight = .white
        selector.optionCalendarFontColorPastYearsHighlight = .white
        selector.optionCalendarFontColorCurrentYearHighlight = .white
     selector.optionCalendarFontColorDays = .white
        selector.optionCalendarFontColorMonth = .white
        selector.optionCalendarBackgroundColorTodayHighlight = UIColor(red: 128/255, green: 203/255, blue: 196/255, alpha: 1)
     selector.optionCalendarBackgroundColorFutureDatesHighlight = UIColor(red: 128/255, green: 203/255, blue: 196/255, alpha: 1)
        selector.optionCalendarBackgroundColorPastDatesHighlight = UIColor(red: 128/255, green: 203/255, blue: 196/255, alpha: 1)
        //selector.optionButtonTitleDone = "Aceptar"
       // selector.optionButtonTitleCancel = "Cancelar"
    }
    
    func configHour(){
        selector.optionCurrentDate = Date()
           selector.optionStyles.showDateMonth(false)
            selector.optionStyles.showMonth(false)
            selector.optionStyles.showYear(false)
            selector.optionStyles.showTime(true)
        let color = UIColor.init(red: 27/255, green: 94/255, blue: 32/255, alpha: 1.0)
        selector.optionClockBackgroundColorAMPMHighlight = color
        selector.optionClockBackgroundColorHourHighlight = color
        selector.optionClockBackgroundColorMinuteHighlight = color
        selector.optionTopPanelBackgroundColor = color
        selector.optionMainPanelBackgroundColor = UIColor.white
        selector.optionSelectorPanelBackgroundColor = color
        selector.optionBottomPanelBackgroundColor = UIColor.white
        selector.optionButtonFontColorCancel = UIColor.red
        selector.optionButtonFontColorDone = UIColor.red
        selector.optionButtonFontColorCancelHighlight = UIColor.red
        //selector.optionButtonTitleDone = "Aceptar"
        //selector.optionButtonTitleCancel = "Cancelar"
    }
    
}
