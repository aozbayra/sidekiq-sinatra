require './app'
require 'sidekiq/web'

config.autoload_paths += %W(#{config.root}/lib)
config.eager_load_paths += %W(#{config.root}/lib)

run Rack::URLMap.new('/' => App, '/sidekiq' => Sidekiq::Web)
