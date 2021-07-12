require_relative '../level1/main.rb'
require_relative '../level1/read_file.rb'

class Deliveries2 < Deliveries
  def parse_date(date)
    super
  end

  def weekend?(date)
    parse_date(date).sunday? || parse_date(date).saturday?
  end
end

file_reader = FileReader.new
data_hash = file_reader.read_content_from_file('level1/data/input.json')
d2 = Deliveries2.new(data_hash)

puts d2.parse_date('2018-06-10')