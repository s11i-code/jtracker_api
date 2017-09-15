require 'net/http'
require 'resolv-replace'

module GoogleMapsDirections

  MODES = ['transit', 'driving']
  BASE_URL = "https://maps.googleapis.com/maps/api/directions/json?key=#{ENV["GOOGLE_API_KEY"]
}"

  def get_url(origin, destination, mode)
    origin_param = "origin=#{origin.latitude},#{origin.longitude}"
    destination_param = "destination=#{destination.latitude},#{destination.longitude}"
    "#{BASE_URL}&#{origin_param}&#{destination_param}&mode=#{mode}"
  end

  def fetch_google_directions_for_mode(origin, destination, mode)
    response = Net::HTTP.get_response(URI(get_url(origin, destination, mode)))

    case response
    when Net::HTTPSuccess then
      route = JSON.parse(response.body)['routes'][0]['legs'][0]
      distance_m = route['distance']['value']
      duration_s = route['duration']['value']
      Hash[mode, {distance_m: distance_m, duration_s: duration_s}]
    else
      # TODO Add error reporting (response.value is probably useful)
      {}
    end
  end

  def fetch_google_directions(origin, destination)
    MODES.map{ |mode| [mode,  fetch_google_directions_for_mode(origin, destination, mode)] }.to_h
  end
end
