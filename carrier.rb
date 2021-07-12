require_relative './format_data.rb'

class Carrier
  attr_reader :data

  EXPECTED_DELIVERY_DAYS = 4

  def initialize(data)
    @data = data
  end
  def will_work_on_saturday?(package)
    format_carriers[package[:carrier]][:saturday_deliveries]
  end

  def calculate_delivery_days(package)
    package[:carrier] == 'colissimo' ? EXPECTED_DELIVERY_DAYS : EXPECTED_DELIVERY_DAYS - 1
  end

  def format_carriers
    carrier_hash = {}

    data.carriers.each do |carrier|
      code = carrier[:code]
      delivery_promise = carrier[:delivery_promise]
      saturday_deliveries = carrier[:saturday_deliveries]

      carrier_hash[code] = {delivery_promise: delivery_promise, saturday_deliveries: saturday_deliveries}.compact
    end

    carrier_hash
  end
end
