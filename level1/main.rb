require 'json'
require 'date'

require_relative '../format_data.rb'
require_relative '../carrier.rb'

class Deliveries
  attr_reader :carrier, :data

  def initialize(carrier:, data:)
    @carrier = carrier
    @data = data
  end

  def format_data(method_name)
    deliveries_array = []
    formatted_hash = {}

    data.packages.each do |package|
      deliveries_hash = {}

      deliveries_hash[:package_id] = package[:id]
      deliveries_hash[:expected_delivery] = self.public_send(method_name, package)

      deliveries_array << deliveries_hash
    end

    formatted_hash[:deliveries] = deliveries_array
    formatted_hash.to_json
  end

  def parse_date(date)
    Date.strptime(date,"%Y-%m-%d")
  end
  
  def delivery_date(package)
    new_date = parse_date(package[:shipping_date])

    (new_date + expected_delivery_days(package)).to_s
  end

  def expected_delivery_days(package)
    carrier.calculate_delivery_days(package)
  end
end

# This is how to use the files with this class

# data = DataFormatter.new('level1/data/input.json')
# carrier = Carrier.new(data)

# d = Deliveries.new(carrier: carrier, data: data)
# puts d.format_data(:delivery_date)
