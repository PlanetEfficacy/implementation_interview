ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rails'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.formatter = :documentation
end

def create_10_LS2_shops
  create(:shop, name: "A", post_code: "LS2 XXX", chairs: 6)
  create(:shop, name: "B", post_code: "LS2 XXX", chairs: 18)
  create(:shop, name: "C", post_code: "LS2 XXX", chairs: 20)
  create(:shop, name: "D", post_code: "LS2 XXX", chairs: 20)
  create(:shop, name: "E", post_code: "LS2 XXX", chairs: 20)
  create(:shop, name: "F", post_code: "LS2 XXX", chairs: 51)
  create(:shop, name: "G", post_code: "LS2 XXX", chairs: 84)
  create(:shop, name: "H", post_code: "LS2 XXX", chairs: 96)
  create(:shop, name: "I", post_code: "LS2 XXX", chairs: 118)
  create(:shop, name: "J", post_code: "LS2 XXX", chairs: 140)
end

def large_shops
  [ Shop.find_by(name: "F"), Shop.find_by(name: "G"),
    Shop.find_by(name: "H"), Shop.find_by(name: "I"),
    Shop.find_by(name: "J") ]
end

def small_shops
  [ Shop.find_by(name: "A"), Shop.find_by(name: "B"),
    Shop.find_by(name: "C"), Shop.find_by(name: "D"),
    Shop.find_by(name: "E") ]
end
