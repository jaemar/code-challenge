# Use official Ruby image
FROM ruby:3.3.0

RUN apt-get update -qq && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    sqlite3 \
    nodejs \
    yarn && \
    rm -rf /var/lib/apt/list /var/cache/apt/archives

# Rails app lives here
WORKDIR /amenitiz

# Copy and install application gems
COPY ./backend/Gemfile ./backend/Gemfile.lock ./
RUN bundle install

# Copy application code
COPY ./backend .

# Set entrypoint
COPY ./backend/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port Rails server runs on
EXPOSE 3001

# Start server
CMD ["rails", "server", "-b", "0.0.0.0"]