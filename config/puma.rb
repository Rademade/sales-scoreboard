
# frozen_string_literal: true

threads_min_count = ENV.fetch('RAILS_MIN_THREADS') { 1 }
threads_max_count = ENV.fetch('RAILS_MAX_THREADS') { 1 }

threads threads_min_count, threads_max_count

port        ENV.fetch('PORT') { 3000 }

environment ENV.fetch('RAILS_ENV') { 'development' }

if %w[production staging].include? ENV.fetch('RAILS_ENV')
  workers ENV.fetch('WEB_CONCURRENCY') { 2 }

  preload_app!

  before_fork do
    ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
  end

  on_worker_boot do
    ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
  end

  plugin :tmp_restart
end
