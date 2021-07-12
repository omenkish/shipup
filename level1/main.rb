require 'json'
require 'date'

require_relative './read_file.rb'

class Deliveries
  attr_reader :deliveries
  EXPECTED_DELIVERY_DAYS = 4

  def initialize(data)
    @deliveries = data
  end

  def varying_delivery_date(id:, date:)
    return delivery_date_less_one(date) if id == 2

    delivery_date(date)
  end

  def format_data
    deliveries_array = []
    formatted_hash = {}

    packages.each do |package|
      deliveries_hash = {}
      deliveries_hash[:package_id] = package['id']
      deliveries_hash[:expected_delivery] = varying_delivery_date(date: package['shipping_date'], id: package['id'])

      deliveries_array << deliveries_hash
    end

    formatted_hash[:deliveries] = deliveries_array
    formatted_hash.to_json
  end

  def parse_date(date)
    Date.strptime(date,"%Y-%m-%d")
  end

  private
  
  
  def delivery_date(date)
    new_date = parse_date(date)

    (new_date + EXPECTED_DELIVERY_DAYS).to_s
  end

  def delivery_date_less_one(date)
    new_date = parse_date(date)
    new_delivery_date = EXPECTED_DELIVERY_DAYS - 1
    (new_date + new_delivery_date).to_s
  end

  def packages
    deliveries["packages"]
  end

end

# This is how to use the file reader with this class


# file_reader = FileReader.new
# data_hash = file_reader.read_content_from_file('level1/data/input.json')

# d = Deliveries.new(data_hash)
#  d.format_data
