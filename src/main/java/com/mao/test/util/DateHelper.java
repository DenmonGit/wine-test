package com.mao.test.util;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;


public class DateHelper {
	private static final Log log = LogFactory.getLog(DateHelper.class);
	public static final String LONG_DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	public static final String LONG_DATE_FORMAT = "yyyy-MM-dd";
	public static final String SHORT_DATE_FORMAT = "MM-dd";
	public static final String LONG_TIME_FORMAT = "HH:mm:ss";

	public static Date toDate(String date, String format) {
		ParsePosition pos = new ParsePosition(0);
		Date d = toDate(date, format, pos);
		if ((null != d) && (pos.getIndex() != date.length())) {
			d = null;
		}
		return d;
	}

	public static Date toDate(String date, String format, ParsePosition pos) {
		if (date == null) {
			return null;
		}
		Date d = null;
		SimpleDateFormat formater = new SimpleDateFormat(format);
		try {
			formater.setLenient(false);
			d = formater.parse(date, pos);
		} catch (Exception e) {
			log.error(e);
			d = null;
		}
		return d;
	}

	public static Date toDate(String date) {
		Date d = toDate(date, "yyyy-MM-dd HH:mm:ss");
		if (null == d) {
			d = toDate(date, "yyyy-MM-dd");
		}
		if (null == d) {
			d = toDate(date, "HH:mm:ss");
		}
		return d;
	}

	public static boolean isDate(String date) {
		return isDate(date, "yyyy-MM-dd");
	}

	public static boolean isDate(String date, String format) {
		if (null == date) {
			return false;
		}

		Date d = null;
		ParsePosition pos = new ParsePosition(0);
		d = toDate(date, format, pos);
		return (null != d) && (pos.getIndex() == date.length());
	}

	public static String toString(Date date, String format) {
		if (date == null) {
			return "";
		}
		String result = null;
		SimpleDateFormat formater = new SimpleDateFormat(format);
		try {
			result = formater.format(date);
		} catch (Exception e) {
			log.error(e);
		}
		return null == result ? "" : result;
	}

	public static Date currentDate() {
		return new Date();
	}

	public static Date getEarliestTime(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(11, 0);
		calendar.set(12, 0);
		calendar.set(13, 0);
		return calendar.getTime();
	}

	public static Date getLatestTime(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(11, 23);
		calendar.set(12, 59);
		calendar.set(13, 59);
		return calendar.getTime();
	}

	public static String getDateString(Date date) {
		return getDateString(date, "yyyy-MM-dd HH:mm:ss");
	}

	public static String getDateString2(Date date) {
		return getDateString(date, "yyyy-MM-dd-HH-mm-ss");
	}

	public static String getDateString3(Date date) {
		return getDateString(date, "yyyyMMddHHmmss");
	}

	public static String getDateString4(Date date) {
		return getDateString(date, "yyyyMMdd");
	}

	// //毫秒级别
	public static String getDateString5(Date date) {
		return getDateString(date, "yyyyMMddHHmmssSSS");
	}

	// //毫秒级别
	public static String getMsDateString(Date date) {
		return getDateString(date, "yyMMddHHmmssSSS");
	}

	public static String getDateString6(Date date) {
		return getDateString(date, "yyyy-MM-dd HH:mm");
	}
	
	public static String getDateString7(Date date) {
		return getDateString(date, "yyyy-MM-dd");
	}

	public static String getHourAndMinus(Date date) {
		return getDateString(date, "HH:mm");
	}

	public static String getDateString(Date date, String sFormat) {
		SimpleDateFormat format = new SimpleDateFormat(sFormat);
		if (date != null) {
			return format.format(date);
		}
		return "";
	}

	public static Date currentTime() {
		return new Date();
	}

	public static int getDaysOfMonth(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month - 1, 1);
		return calendar.getActualMaximum(5);
	}

	public static Date getFirstDateOfWeek(Date weekDate) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(weekDate);
		calendar.add(7, calendar.getFirstDayOfWeek() - calendar.get(7));

		Date date = calendar.getTime();
		zeroTimeOfDate(date);
		return date;
	}

	public static Date getFirstDateOfNextWeek(Date weekDate) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(weekDate);
		calendar.add(6, 8 - calendar.get(7));
		Date date = calendar.getTime();
		zeroTimeOfDate(date);
		return date;
	}

	public static Date getFirstDateOfMonth(Date monthDate) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(monthDate);
		calendar.set(5, 1);
		Date date = calendar.getTime();
		zeroTimeOfDate(date);
		return date;
	}

	public static Date getFirstDateOfNextMonth(Date monthDate) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(monthDate);
		calendar.add(2, 1);
		Date date = calendar.getTime();
		zeroTimeOfDate(date);
		return date;
	}

	public static Date getDateOfPrevDay() {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(currentDate());
		calendar.add(5, -1);
		Date date = calendar.getTime();
		return date;
	}

	public static Date getDateOfNexts(Date d, int day) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(d);
		calendar.add(5, day);
		Date date = calendar.getTime();
		return date;
	}

	public static Date getDateOfNexts(int day) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(currentDate());
		calendar.add(5, day);
		Date date = calendar.getTime();
		return date;
	}

	/**
	 * 通过小时，获取未来时间
	 * 
	 * @param hours
	 * @return
	 */
	public static Date getDateOfNextsByHours(int hours) {
		return getDateOfNextsByHours(currentDate(), hours);
	}

	/**
	 * 基于某个时间点和之后几个小时，获取未来时间
	 * 
	 * @param hours
	 * @return
	 */
	public static Date getDateOfNextsByHours(Date startDate, int hours) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(startDate);
		calendar.add(Calendar.HOUR_OF_DAY, hours);
		Date date = calendar.getTime();
		return date;
	}

	public static Date getDateOfMonths(Date d, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(d);
		calendar.add(Calendar.MONTH, month);
		Date date = calendar.getTime();
		return date;
	}

	private static void zeroTimeOfDate(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(11, 0);
		calendar.set(12, 0);
		calendar.set(13, 0);
	}

	public static int getYear(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(1);
	}

	public static int getMonth(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(2) + 1;
	}

	public static int getDayOfYear(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(Calendar.DAY_OF_YEAR);
	}

	public static String getTodayDateString() {
		return toString(new Date(), "yyyy-MM-dd");
	}

	public static String getNowTimeString() {
		return toString(new Date(), "yyyy-MM-dd HH:mm:ss");
	}

	public static String getNowHourAndMiTime() {
		return toString(new Date(), "HH:mm");
	}

	public static Date getDateAfterAddMonth(Date date, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(2, month);
		Date date_new = calendar.getTime();
		return date_new;
	}

	public static int getYearAfterAddMonth(int year, int month, int n) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month - 1, 1);
		calendar.add(2, n);
		return calendar.get(1);
	}

	public static int getMonthAfterAddMonth(int year, int month, int n) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month - 1, 1);
		calendar.add(2, n);
		return calendar.get(2) + 1;
	}

	public static String getNowTime() {
		String dateStr = "";
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(new Date().getTime());
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日");
		dateStr = dateFormat.format(c.getTime());

		String str = getWeekDayName(GetDateTime());

		return dateStr + " " + str;
	}

	public static String GetDateTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String sDate = sdf.format(new Date());
		return sDate;
	}

	/***
	 * 星期....
	 * 
	 * @param strDate
	 * @return
	 */
	public static String getWeekDayName(String strDate) {
		// System.out.println("strDate: "+strDate);
		String mName[] = { "日", "一", "二", "三", "四", "五", "六" };
		int iWeek = getWeekDay(strDate);
		iWeek = iWeek - 1;
		return "星期" + mName[iWeek];
	}

	public static int getWeekDay(String strDate) {
		Calendar cal = parseDateTime(strDate);
		return cal.get(Calendar.DAY_OF_WEEK);
	}

	public static Calendar parseDateTime(String baseDate) {
		Calendar cal = null;
		cal = new GregorianCalendar();
		int yy = Integer.parseInt(baseDate.substring(0, 4));
		int mm = Integer.parseInt(baseDate.substring(5, 7)) - 1;
		int dd = Integer.parseInt(baseDate.substring(8, 10));
		int hh = 0;
		int mi = 0;
		int ss = 0;
		if (baseDate.length() > 12) {
			hh = Integer.parseInt(baseDate.substring(11, 13));
			mi = Integer.parseInt(baseDate.substring(14, 16));
			ss = Integer.parseInt(baseDate.substring(17, 19));
		}
		cal.set(yy, mm, dd, hh, mi, ss);
		return cal;
	}


	/**
	 * 转中文日期
	 * 
	 * @param date
	 * @return
	 */
	public static String formatChineseDate(Date date) {
		if (date == null) {
			return "";
		}
		return new SimpleDateFormat("yyyy年M月d日").format(date);
	}

	/**
	 * 转中文日期及时间
	 * 
	 * @param date
	 * @param containSecond
	 *            是否包含秒
	 * @return
	 */
	public static String formatChineseDateTime(Date date, boolean containSecond) {
		if (date == null) {
			return "";
		}
		String formatter = "yyyy年M月d日 HH时mm分ss秒";
		if (!containSecond) {
			formatter = "yyyy年M月d日 HH时mm分";
		}
		return new SimpleDateFormat(formatter).format(date);
	}

	public static Date getMonthFirstDay() {
		Calendar calendar = Calendar.getInstance();
		int month = calendar.get(Calendar.MONTH);
		calendar.set(Calendar.MONTH, month - 1);
		calendar.set(Calendar.DAY_OF_MONTH,
				calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
		return calendar.getTime();
	}

	public static Date getMonthLastDay() {
		Calendar calendar = Calendar.getInstance();
		int month = calendar.get(Calendar.MONTH);
		calendar.set(Calendar.MONTH, month - 1);
		calendar.set(Calendar.DAY_OF_MONTH,
				calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		return calendar.getTime();
	}

	public static int getYearFromDate(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.YEAR);
	}

	public static int getMonthFromDate(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.MONTH) + 1;
	}

	/**
	 * 返回时间戳（秒级别(10位数字)）
	 * 
	 * @param date
	 * @return
	 */
	public static long getTimestampSS(Date date) {
		long timeSS = date.getTime();
		return (timeSS / 1000);
	}
}

