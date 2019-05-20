require 'net/http'

namespace :import_features do
  Feature.transaction do
    uri = URI('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')
    response = Net::HTTP.get(uri)
    new_features = JSON.parse(response)['features']
    new_features.map! do |row|
      { id: row['id'],
      mag: row['properties']['mag'],
      place: row['properties']['place'],
      time: row['properties']['time'],
      url: row['properties']['url'],
      tsunami: row['properties']['tsunami'],
      mag_type: row['properties']['magType'],
      title: row['properties']['title'],
      coordinates: { latitude: row['geometry']['coordinates'][0],
                     longitude: row['geometry']['coordinates'][1] }
      }
    end
    Feature.import new_features
  end
end
