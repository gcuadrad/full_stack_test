require 'net/http'

namespace :features do
  desc 'Import features from https://earthquake.usgs.gov'
  desc <<-DESC
    Import features from earthquake.usgs.gov (see full doc `rake -D`)'
    Usage:
      Params:
        Number with BATCH_SIZE default value 1000.
      bundle exec rake features:import [BATCH_SIZE=500]
  DESC
  task import: :environment do
    puts "task import features running..."
    batch_size = ENV.fetch('BATCH_SIZE', 1_000)
    Feature.transaction do
      uri = URI('https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson')
      response = Net::HTTP.get(uri)
      new_features = JSON.parse(response)['features']
      new_features.map! do |row|
        { feature_id: row['id'],
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
      Feature.import new_features, validate: true, on_duplicate_key_ignore: true, batch_size: batch_size
      puts "task import features done!"
    end
  end
end
