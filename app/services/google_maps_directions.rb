require 'net/http'
require 'resolv-replace'

module GoogleMapsDirections

  MODE = 'transit' # public transport
  BASE_URL = "https://maps.googleapis.com/maps/api/directions/json?mode=#{MODE}&key=#{ENV["GOOGLE_API_KEY"]
}"

  def getUrl(origin, destination)
    origin_param ="origin=#{origin.latitude},#{origin.longitude}"
    destination_param ="destination=#{destination.latitude},#{destination.longitude}"
    "#{BASE_URL}&#{origin_param}&#{destination_param}"
  end

  def fetch_google_directions(origin, destination)
    response = Net::HTTP.get_response(URI(getUrl(origin, destination)))

    case response
    when Net::HTTPSuccess then
      route = JSON.parse(response.body)['routes'][0]['legs'][0]
      distance_m = route['distance']['value']
      duration_s = route['duration']['value']
      Hash[MODE, {distance_m: distance_m, duration_s: duration_s}]
    else
      # TODO Add error reporting (response.value is probably useful)
      {}
    end
  end
end
