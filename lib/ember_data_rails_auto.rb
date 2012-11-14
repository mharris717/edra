puts "in EDRA load in gem"

require 'mharris_ext'

%w(ext model column association).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/ember_data_rails_auto/#{f}.rb"
end