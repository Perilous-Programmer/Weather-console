require_relative 'visualcrossing'
require 'date'
require 'terminal-table'

currentDate = DateTime.now.strftime "%Y-%m-%d"
lastMonthDate = DateTime.now.prev_month.strftime "%Y-%m-%d"


def median(array)
    sorted_array = array.sort 
    count = sorted_array.count 

    if sorted_array.count % 2 == 0 
    first_half = (sorted_array[0...(count/2)])
    second_half = (sorted_array[(count/2)..-1])

    first_median = first_half[-1]
    second_median = second_half[0]

    true_median = ((first_median + second_median).to_f / 2.to_f)
    true_median
    else 
    true_median = sorted_array[(count/2).floor]
    true_median
    end 
end


cityAddressList = [
    'Copenhagen, Denmark',
    'Lodz, Poland',
    'Brussels, Belgium',
    'Islamabad, Pakistan'
] 

temp = VisualCrossing.new
rows = [["city", "wind_avg", "wind_median", "temp_avg", "temp_median"]]
cityAddressList.map { |address|
temp.selectCityByAddress(address)
days =  temp.getPastDaysWithTemperature(lastMonthDate, currentDate)
dayWind = days.map {|day| day["windspeed"]}
dayTemp = days.map {|day| day["temp"]}
rows << [address,dayWind.sum/2,median(dayWind), dayTemp.sum/2, median(dayTemp)]
}

table = Terminal::Table.new :rows => rows
puts table