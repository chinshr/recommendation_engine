require "rails/all"
require "bundler/setup"
require "rubygems"
require "test/unit"
require "active_record"
require "active_support"
#require "sqlite3"
require "active_record/fixtures"
require 'rails/test_help'
require 'ruby-debug'

# If you want to see the ActiveRecord log, invoke the tests using `rake test LOG=true`
if ENV["LOG"]
  require "logger"
  ActiveRecord::Base.logger = Logger.new($stdout)
end

# Provide basic Rails methods for testing purposes
unless defined?(Rails)
  module Rails
    extend self
    def env; "test"; end
    def root; Pathname.new(File.expand_path("..", __FILE__)); end
    def version; "2.1.0"; end
  end
end

require "recommendation_engine"

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => ":memory:"
ActiveRecord::Migration.verbose = false

# config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
# ActiveRecord::Base.establish_connection(config[ENV['DB'] || 'sqlite3'])

#require "schema"
require File.expand_path("../schema", __FILE__)
#load(File.dirname(__FILE__) + "/schema.rb") if File.exist?(File.dirname(__FILE__) + "/schema.rb")

if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures"
  # $LOAD_PATH.unshift(Test::Unit::TestCase.fixture_path)
end

module ActiveRecord
  module TestFixtures
    extend ActiveSupport::Concern
    included do
      class_attribute :use_instantiated_fixtures   # true, false, or :no_instances
    end
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module ActiveSupport
  class TestCase
    require 'test/unit'
    
    # Turn off transactional fixtures if you're working with MyISAM tables in MySQL
    # self.use_transactional_fixtures = true

    # Instantiated fixtures are slow, but give you @david where you otherwise would need people(:david)
    # self.use_instantiated_fixtures  = true
    
    # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
    #
    # Note: You'll currently still have to declare fixtures explicitly in integration tests
    # -- they do not yet inherit this setting
    fixtures :all
  end
end

module Rails
  class Cache
    @@data = {}
   
     class << self
      def fetch(key, options = {})
        @@data[key] ||= yield
      end
      
      def write(key, value)
        @@data[key] = value
      end
      
      def read(key)
        @@data[key]
      end
     end
  end
  
  def self.cache
    return Cache
  end
  
  def self.version
    '2.1.0'
  end
end

# require "#{File.dirname(__FILE__)}/../init"