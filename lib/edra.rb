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

module EDRA
  def self.getSetupJs
    f = File.dirname(__FILE__) + "/edra/setup.js.coffee"
    coffee = File.read(f)
    CoffeeScript.compile coffee
  end
end

%w(ext model column association route).each do |f|
  load File.expand_path(File.dirname(__FILE__)) + "/edra/#{f}.rb"
end