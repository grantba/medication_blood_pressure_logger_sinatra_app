require 'bundler/setup'
Bundler.require

require_all './app'

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/meds_bps_log.sqlite"
)

