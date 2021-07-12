require_relative './read_file.rb'

class DataFormatter
  include ReadFile

  attr_reader :path
  def initialize(path)
    @path = path
  end

  def carriers 
    deliveries["carriers"].map { |carrier| carrier.transform_keys(&:to_sym) }
  end

  def packages
    deliveries["packages"].map { |package| package.transform_keys(&:to_sym) }
  end

  private

  def deliveries
    read_content_from_file(path)
  end

end