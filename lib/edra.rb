puts "in EDRA load in gem"

require 'mharris_ext'

class Object
  def blank?
    to_s.strip == ''
  end
  def present?
    !blank?
  end
end

%w(ext model column association).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/edra/#{f}.rb"
end