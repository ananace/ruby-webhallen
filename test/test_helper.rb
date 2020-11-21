require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_filter '/vendor/'
end

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require 'webhallen'

require 'test/unit'
require 'mocha/test_unit'
