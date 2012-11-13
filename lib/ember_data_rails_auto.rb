require 'mharris_ext'

%w(model column).each do |f|
  load File.dirname(__FILE__) + "/ember_data_rails_auto/#{f}.rb"
end