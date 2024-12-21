require 'redis'

$redis = Redis.new(
  host: 'redis',  # Update to 'redis' if using Docker
  port: 6379,
  db: 0
)
