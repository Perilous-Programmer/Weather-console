require 'net/http'
require 'json'

class VisualCrossing
    @@key = 'GGZL8333FPWLS96G2SHJXCGV2'
    @@apiUrl = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline'
    @@apiParams = "unitGroup=metric&include=days&key=#{ENV["API_KEY"]||@@key}&contentType=json"

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
