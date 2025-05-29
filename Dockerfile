FROM ubuntu:22.04

# Set environment variables to avoid tzdata prompts
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC

ARG RUBY_VERSION=3.3.6

RUN apt-get update -qq && apt-get install --no-install-recommends -y curl nodejs yarn build-essential libpq-dev libjemalloc2 libvips libssl-dev libreadline-dev zlib1g-dev git pkg-config ca-certificates gnupg2 tzdata && rm -rf /var/lib/apt/lists/*

# Import RVM's GPG keys to fix signature verification error
RUN curl -sSL https://rvm.io/mpapis.asc | gpg2 --import - && \
    curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -

# Install Ruby using the version specified in the argument
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby=$RUBY_VERSION && \
    /bin/bash -l -c "source /usr/local/rvm/scripts/rvm && rvm install $RUBY_VERSION" && \
    /bin/bash -l -c "source /usr/local/rvm/scripts/rvm && rvm use $RUBY_VERSION --default"

# Create the /rails directory before setting ownership
RUN mkdir -p /rails && \
    groupadd --system --gid 1001 rails || true && \
    useradd rails --uid 1000 --gid 1001 --create-home --shell /bin/bash && \
    chown -R rails:rails /rails

# Install libmysqlclient-dev as root (before switching to non-root user)
RUN apt-get install -y libmysqlclient-dev

# Change ownership of RVM installation directory to the rails user
RUN chown -R rails:rails /usr/local/rvm

# Set environment variables to include Ruby from RVM
ENV PATH="/usr/local/rvm/rubies/ruby-$RUBY_VERSION/bin:$PATH" \
    GEM_HOME="/usr/local/rvm/gems/ruby-$RUBY_VERSION" \
    BUNDLE_PATH="/rails/bundle" \
    RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_WITHOUT="development"

# Switch to non-root user for security
USER rails

# Create necessary directories and set permissions
RUN mkdir -p /rails/tmp/cache /rails/tmp/pids /rails/tmp/sockets && \
    mkdir -p /rails/log && \
    chmod -R 755 /rails/tmp && \
    chmod -R 755 /rails/log

COPY Gemfile Gemfile.lock ./

WORKDIR /rails

# Install Bundler gem (force installation of the required version)
RUN /bin/bash -l -c "gem install bundler -v '2.5.23' --no-document"

RUN /bin/bash -l -c "bundle install"

COPY . .

# Ensure the Rails application directory and subdirectories are owned by the correct user
USER root
RUN chown -R rails:rails /rails
USER rails

# Precompile assets (production) with Ruby environment sourced (uncomment if needed)
RUN /bin/bash -l -c "SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile"

# Set up the entrypoint for the Rails application
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 9000

CMD ["bin/rails", "server"]
