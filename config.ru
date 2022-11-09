require 'rack'
require_relative './app.rb'

use Rack::Reloader, 0
run App.new
