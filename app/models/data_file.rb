class DataFile < ActiveRecord::Base
  def self.save(upload)
    name =  Time.now.to_f.to_s + upload['path'].original_filename
    directory = "data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['path'].read) }
    p path
    return path
  end
end
