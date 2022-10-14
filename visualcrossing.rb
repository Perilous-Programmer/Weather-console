require 'net/http'
require 'json'

class VisualCrossing
    @@key = 'Z7KHG7S28BDP5RB6B3MBEZD3E'
    @@apiUrl = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline'
    @@apiParams = "unitGroup=metric&include=days&key=#{@@key}&contentType=json"

    def initialize()
        
    end

    def selectCityByAddress(address)
        @address = address
    end

    def getPastDaysWithTemperature(fromDate, toDate)
        parser = URI::Parser.new
        uri = URI(parser.escape("#{@@apiUrl}/#{@address}/#{fromDate}/#{toDate}?#{@@apiParams}"))
        res = Net::HTTP.get_response(uri)

        return  JSON.parse(res.body)["days"] if res.is_a?(Net::HTTPSuccess)

        return  res.body

    rescue Exception => e
        return e.message
    end
end
