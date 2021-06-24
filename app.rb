# frozen_string_literal: true

require 'cuba'
require 'securerandom'
require 'time'
require 'debug/open' if ENV['DEBUG'] == 'true'

# constants
ENVIRONMENT = ENV['RACK_ENV'] || 'development'
ROOT_PATH = File.expand_path(File.dirname(__FILE__))

# middlewares
Cuba.use Rack::Session::Cookie, :secret => ENV['SESSION_SECRET']

# includes / imports
Dir[File.join(ROOT_PATH, 'lib/helpers/*.rb')].each { |rb| require rb }
Dir[File.join(ROOT_PATH, 'routes/*.rb')].each { |rb| require rb }
Dir[File.join(ROOT_PATH, 'models/*.rb')].each { |rb| require rb }

# plugins
Cuba.plugin Helpers::Log
Cuba.plugin Helpers::Common
Cuba.plugin Helpers::Info
Cuba.plugin Helpers::Yello
Cuba.plugin Helpers::Auth
Cuba.plugin Helpers::Adapter
Cuba.plugin Helpers::Mock

# routes
Cuba.define do
  on root do
    log.info("GET /")

    res.text("Welcome to the NginxMockAuthAdapterApp!")
  end

  on "info" do
    run Routes::Info
  end

  on "yello" do
    run Routes::Yello
  end

  on "auth" do
    run Routes::Auth
  end

  on "adapter" do
    run Routes::Adapter
  end

  on "mock" do
    run Routes::Mock
  end
end
