/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

/**
 *	Extension NSDate class for simple work with date.
 */
@interface NSDate (Utilities)
/**
 *	Creates and returns date with count of days one more than now.
 *
 *	@return	NSDate with count of seconds now plus D_DAY
 * @see D_DAY
 */
+ (NSDate *) dateTomorrow;
/**
 *	Creates and returns date with count of days one less than now.
 *
 *	@return	NSDate with count of seconds now minus D_DAY
 * @see D_DAY
 */
+ (NSDate *) dateYesterday;
/**
 *	Creates and returns date with count of days \b days more than now.
 *
  *	@param	days	The number of days to be added to the current date
 *
 *	@return	NSDate with count of seconds now plus \b days * D_DAY
 * @see D_DAY
 */
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
/**
 *	Creates and returns date with count of days \b days less than now.
 *
 *	@param	days	The number of days to be deleted from the current date
 *
 *	@return	NSDate with count of seconds now minus \b days * D_DAY
 * @see D_DAY
 */
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
/**
 *	Creates and returns date with count of hours \b dHours more than now.
 *
 *	@param	dHours	The number of hours to be added to the current date
 *
 *	@return	NSDate with count of seconds now plus \b dHours * D_HOUR
 * @see D_HOUR
 */
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
/**
 *	Creates and returns date with count of hours \b dHours less than now.
 *
 *	@param	dHours	The number of hours to be deleted from the current date
 *
 *	@return	NSDate with count of seconds now minus \b dHours * D_HOUR
 * @see D_HOUR
 */
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
/**
 *	Creates and returns date with count of minutes \b dMinutes more than now.
 *
 *	@param	dMinutes	The number of minutes to be added to the current date
 *
 *	@return	NSDate with count of seconds now plus \b dMinutes * D_MINUTE
 * @see D_MINUTE
 */
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
/**
 *	Creates and returns date with count of hours \b dMinutes less than now.
 *
 *	@param	dMinutes	The number of minutes to be deleted from the current date
 *
 *	@return	NSDate with count of seconds now minus \b dMinutes * D_MINUTE
 * @see D_MINUTE
 */
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;

/**
 *	Compares dates without hours, minutes and seconds. Checks years, months and days only.
 @code
 NSDate *nowDate = [NSDate date];
 NSDate *simpleDate = [NSDate dateWithHoursFromNow:1];
 BOOL result = [nowDate isEqualToDateIgnoringTime:simpleDate];
 @endcode
 If nwoDate is not more than 11pm then result is YES, otherwise NO.
 *	@param	aDate	Date to be compared with the current date.
 *
 *	@return	YES, if dates from one day, otherwise NO.
 */
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
/**
 *	Compares current date and [NSDate date]. Uses \b isEqualToDateIgnoringTime: method.
 *
 * @see -isEqualToDateIgnoringTime:
 *	@return	YES, if current day is today, otherwise NO.
 */
- (BOOL) isToday;
/**
 *	Compares current date and [NSDate dateTomorrow]. Uses \b isEqualToDateIgnoringTime: method.
 *
 * @see -isEqualToDateIgnoringTime:
 * @see -dateTomorrow
 *	@return	YES, if current day is tomorrow, otherwise NO.
 */
- (BOOL) isTomorrow;
/**
 *	Compares current date and [NSDate dateYesterday]. Uses \b isEqualToDateIgnoringTime: method.
 *
 * @see -isEqualToDateIgnoringTime:
 * @see -dateYesterday
 *	@return	YES, if current day is yesterday, otherwise NO.
 */
- (BOOL) isYesterday;
/**
 *	Compares two dates and checks weeks from it.
 * @see D_WEEK
 *	@param	aDate	Date to be compared with the current date.
 *
 *	@return	YES, if both dates from one week, otherwise NO.
 */
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
/**
 *	Compares current date and [NSDate date]. Uses \b isSameWeekAsDate: method.
 *@see -isSameWeekAsDate:
 *	@return	YES, if current date and now date from one week, otherwise NO.
 */
- (BOOL) isThisWeek;
/**
 *	Compares current date and [NSDate dateWithDaysFromNow:D_WEEK]. Uses \b isSameWeekAsDate: method.
 *@see -isSameWeekAsDate:
 * @see D_WEEK
 * @see -dateWithDaysFromNow:
 *	@return	YES, if current date and [NSDate dateWithDaysFromNow:D_WEEK] from one week, otherwise NO.
 */
- (BOOL) isNextWeek;
/**
 *	Compares current date and [NSDate dateWithDaysBeforeNow:D_WEEK]. Uses \b isSameWeekAsDate: method.
 *@see -isSameWeekAsDate:
 * @see D_WEEK
 * @see -dateWithDaysBeforeNow:
 *	@return	YES, if current date and [NSDate dateWithDaysBeforeNow:D_WEEK] from one week, otherwise NO.
 */
- (BOOL) isLastWeek;
/**
 *	Compares two dates and checks month and year from it.
 *
 *	@param	aDate	Date to be compared with current date.
 *
 *	@return	YES if both dates from one month, otherwise NO.
 */
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
/**
 *	Compares current date and [NSDate date] and checks month for it. Uses \b isSameMonthAsDate: method.
 * @see -isSameMonthAsDate:
 *	@return	YES, if current date and now date from one month, otherwise NO.
 */
- (BOOL) isThisMonth;

//without documentation

- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;
- (BOOL) isInFuture;
- (BOOL) isInPast;

// Date roles
- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

// Adjusting dates
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;
@end
