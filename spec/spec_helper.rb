$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'edra'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec::Matchers.define :be_equal_lines do |expected|
  match do |actual|
    exp = expected.split("\n").map { |x| x.strip }.select { |x| x.present? }
    act = actual.split("\n").map { |x| x.strip }.select { |x| x.present? }
    exp == act
  end
end

RSpec.configure do |config|
  
end
