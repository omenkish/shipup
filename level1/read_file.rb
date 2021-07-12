class FileReader
  def read_content_from_file(file_name)
    file = File.open(File.expand_path(file_name))
    data_hash = JSON.load(file)
    
    file.close
    
    data_hash
  end
end
