require 'sidekiq'
require 'sinatra/base'
require 'active_record'
require 'sinatra/activerecord'

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}" }
end

class SomeWorker
  include Sidekiq::Worker
  def perform(id)
    thing = $redis.hget('things', id)
    sleep 10
    p "The work is done: #{thing}"
  end
end

class PrintWorker
  include Sidekiq::Worker
  def perform(user_id)
    user = User.find_by(user_id)
    puts user.first_name
  end
end
