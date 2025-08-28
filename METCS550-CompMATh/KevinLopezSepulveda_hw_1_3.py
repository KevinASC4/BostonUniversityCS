def is_leap_year(year):
    return (year % 4 == 0 and year % 100 != 0) or (year % 400 == 0)

def count_mondays_on_second():
    # Days in each month for a non-leap year
    month_days = [31, 28, 31, 30, 31, 30,
                  31, 31, 30, 31, 30, 31]

    # Jan 1, 1900 is Monday → day 0
    day_of_week = 0  # Monday

    # Move through year 1900 to reach 1901
    for month in range(12):
        if month == 1 and is_leap_year(1900):
            day_of_week = (day_of_week + 29) % 7
        else:
            day_of_week = (day_of_week + month_days[month]) % 7

    count = 0

    for year in range(1901, 2001):
        for month in range(12):
            # 2nd day of the month = one day after the 1st
            second_day = (day_of_week + 1) % 7
            if second_day == 0:  # Monday
                count += 1

            # Advance day_of_week by days in the current month
            if month == 1 and is_leap_year(year):
                day_of_week = (day_of_week + 29) % 7
            else:
                day_of_week = (day_of_week + month_days[month]) % 7

    return count

result = count_mondays_on_second()
print(f"Number of Mondays that fell on the 2nd of the month: {result}")