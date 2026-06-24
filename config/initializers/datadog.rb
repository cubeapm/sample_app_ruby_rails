Datadog.configure do |c|
  # 1. Global Settings
  # c.service = 'sample_app_ruby_rails'
  # c.env = 'development'
  # c.version = '1.0.0'

  # 2. Agentless Configuration (Send directly to CubeAPM) from the code.
  # c.agent.host = 'host.docker.internal'
  # c.agent.port = 3130

  # 3. Manual Plugin Instrumentation
  # If you remove "require: 'datadog/auto_instrument'" from your Gemfile,
  # you must manually enable plugins here:
  # c.tracing.instrument :rails
  # c.tracing.instrument :redis
  # c.tracing.instrument :faraday
  # c.tracing.instrument :mysql2
end