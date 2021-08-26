component singleton accessors="true" {

    property name="i18n" inject="resourceService@cbi18n";

    variables.MINUTES_IN_DAY = 1440;
    variables.MINUTES_IN_ALMOST_TWO_DAYS = 2520;
    variables.MINUTES_IN_MONTH = 43200;
    variables.MINUTES_IN_TWO_MONTHS = 86400;

    public string function formatDistance(
        required date date,
        date baseDate = now(),
        boolean includeSeconds = false,
        string locale = variables.i18n.geti18n().getFWLocale()
    ) {
        var comparison = dateCompare( arguments.date, arguments.baseDate );

        var dateLeft = arguments.date;
        var dateRight = arguments.baseDate;
        if ( comparison < 0 ) {
            dateLeft = arguments.baseDate;
            dateRight = arguments.date;
        }

        var seconds = dateDiff( "s", dateRight, dateLeft );
        var minutes = dateDiff( "n", dateRight, dateLeft );
        var months = 0;

        // 0 up to 2 mins
        if ( minutes < 2 ) {
            if ( arguments.includeSeconds ) {
                if ( seconds < 5 ) {
                    return variables.i18n.getResource( resource = "lessThanXSeconds", values = 5, locale = arguments.locale );
                } else if ( seconds < 10 ) {
                    return variables.i18n.getResource( resource = "lessThanXSeconds", values = 10, locale = arguments.locale );
                } else if ( seconds < 20 ) {
                    return variables.i18n.getResource( resource = "lessThanXSeconds", values = 20, locale = arguments.locale );
                } else if ( seconds < 40 ) {
                    return variables.i18n.getResource( resource = "halfAMinute", locale = arguments.locale );
                } else if ( seconds < 60 ) {
                    return variables.i18n.getResource( resource = "lessThanAMinute", locale = arguments.locale );
                } else {
                    return variables.i18n.getResource( resource = "oneMinute", locale = arguments.locale );
                }
            } else {
                if ( minutes == 0 ) {
                    return variables.i18n.getResource( resource = "lessThanAMinute", locale = arguments.locale );
                } else {
                    return minutes == 1 ?
                        variables.i18n.getResource( resource = "oneMinute", locale = arguments.locale ) :
                        variables.i18n.getResource( resource = "xMinutes", values = minutes, locale = arguments.locale );
                }
            }
            // 2 mins up to 0.75 hrs
        } else if ( minutes < 45 ) {
            return minutes == 1 ?
                variables.i18n.getResource( resource = "oneMinute", locale = arguments.locale ) :
                variables.i18n.getResource( resource = "xMinutes", values = minutes, locale = arguments.locale );
            // 0.75 hrs up to 1.5 hrs
        } else if ( minutes < 90 ) {
            return variables.i18n.getResource( resource = "aboutAnHour", locale = arguments.locale );
            // 1.5 hrs up to 24 hrs
        } else if ( minutes < variables.MINUTES_IN_DAY ) {
            var hours = round( minutes / 60 );
            return hours == 1 ?
                variables.i18n.getResource( resource = "aboutAnHour", locale = arguments.locale ) :
                variables.i18n.getResource( resource = "aboutXHours", values = hours, locale = arguments.locale );
            // 1 day up to 1.75 days
        } else if ( minutes < variables.MINUTES_IN_ALMOST_TWO_DAYS ) {
            return variables.i18n.getResource( resource = "aDay", locale = arguments.locale );
            // 1.75 days up to 30 days
        } else if ( minutes < variables.MINUTES_IN_MONTH ) {
            var days = round( minutes / variables.MINUTES_IN_DAY );
            return days == 1 ?
                variables.i18n.getResource( resource = "aDay", locale = arguments.locale ) :
                variables.i18n.getResource( resource = "xDays", values = days, locale = arguments.locale );
            // 1 month up to 2 months
        } else if ( minutes < variables.MINUTES_IN_TWO_MONTHS ) {
            months = round( minutes / variables.MINUTES_IN_MONTH );
            return months == 1 ?
                variables.i18n.getResource( resource = "aboutAMonth", locale = arguments.locale ) :
                variables.i18n.getResource( resource = "aboutXMonths", values = months, locale = arguments.locale );
        }

        months = dateDiff( "m", dateRight, dateLeft );

        // 2 months up to 12 months
        if ( months < 12 ) {
            var nearestMonth = round( minutes / variables.MINUTES_IN_MONTH );
            return nearestMonth == 1 ?
                variables.i18n.getResource( resource = "aMonth", locale = arguments.locale ) :
                variables.i18n.getResource( resource = "xMonths", values = nearestMonth, locale = arguments.locale );
            // 1 year up to max Date
        } else {
            var monthsSinceStartOfYear = months % 12;
            var years = floor( months / 12 );

            // N years up to 1 years 3 months
            if ( monthsSinceStartOfYear < 3 ) {
                return years == 1 ?
                    variables.i18n.getResource( resource = "aboutAYear", locale = arguments.locale ) :
                    variables.i18n.getResource( resource = "aboutXYears", values = years, locale = arguments.locale );
                // N years 3 months up to N years 9 months
            } else if ( monthsSinceStartOfYear < 9 ) {
                return years == 1 ?
                    variables.i18n.getResource( resource = "overAYear", locale = arguments.locale ) :
                    variables.i18n.getResource( resource = "overXYears", values = years, locale = arguments.locale );
                // N years 9 months up to N year 12 months
            } else {
                return variables.i18n.getResource( resource = "almostXYears", values = years + 1, locale = arguments.locale );
            }
        }
    }

}
