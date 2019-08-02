require "minitest/autorun"
require "minitest/hooks/default"
require "minitest-power_assert"
require "minitest/reporters"
require "rr"

module Configure
  include Minitest::Hooks
  
  before(:all) do
    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: File.dirname(__FILE__) + '/../tmp/test.sqlite3'
    )
  end
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
