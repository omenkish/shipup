require_relative '../level1/main.rb'
require_relative '../read_file.rb'
require_relative '../carrier.rb'

class Deliveries2 < Deliveries
  def initialize(carrier:, data:)
    super(carrier: carrier, data: data)
  end

  def sunday?(date)
    Date.parse(date.to_s).sunday?
  end

  def calculate_delivery_date(package)
    new_expected_delivery_days = expected_delivery_days(package)
    new_date = parse_date(package[:shipping_date]) + expected_delivery_days(package)

    parse_date(package[:shipping_date]).upto(new_date) do |date|
      new_expected_delivery_days += 1 if sunday?(date)
      new_expected_delivery_days += 1 if add_day_for_saturday(date, package)
    end

    (parse_date(package[:shipping_date]) + new_expected_delivery_days).to_s
  end

  def can_call_carrier_method?(package)
    carrier.will_work_on_saturday?(package) if carrier.respond_to?('will_work_on_saturday?')
  end

  def add_day_for_saturday(date, package)
    Date.parse(date.to_s).saturday? && !can_call_carrier_method?(package)
  end
end

# This is how to use the files with this class

# data = DataFormatter.new('level2/data/input.json')
# carrier = Carrier.new(data)

# d2 = Deliveries2.new(carrier: carrier, data: data)
# puts d2.format_data(:calculate_delivery_date)
