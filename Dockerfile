FROM ruby:2.5.1

# By default image is built using RAILS_ENV=production.
# You may want to customize it:
#
#   --build-arg RAILS_ENV=development
#
# See https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables-build-arg
#
ARG RAILS_ENV=production

# Devise requires secret key to be set during image build or it raises an error
# preventing from running any scripts.
# Users should override this variable by passing environment variable on container start.
ENV RAILS_ENV=${RAILS_ENV} \
    APP_HOME=/home/app \
    DEVISE_SECRET_KEY='62363a59925a0331f946bf3271c6652384c8c211b05a82075e402cc2a514b62414df188585313ecd911b1f3cd0c9847fa2e1bf8ff0fb35a042d0d9c8a21988c9' \
    SECRET_KEY_BASE='92e7de6877d36ea42ce364e1c2b93171c0d10869d31b998c0cbc61285784697c0077686203ff85f53496809975f4731fa4a6458ad39523f0be114a7812777a10' \
    JWT_SHARED_SECRET_KEY='LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcFFJQkFBS0NBUUVBdU4wbkhOaFUycm5lNXhNUkxCbVh2bDRBcWtBcU1LT0JBVGk4NDRpeU1HdU5uT0EyCmRQRHRmcTJYeENYY0FvQW4yc0dhdFRuWnhnSlpkd1Y3Q050VzdKRzg4bVExWGFBTFdlVEd6VGkwTVZsMHNHUVYKT1MycWY3a21mWlFKaDhDRU1ZNS9oQ1JKQzBxZzZMN09LcmpuT2FaZ3BGWXVoNUdxQ05ONkI1V2Nmd3g5TksrWApWK3h5eHJEb2l4eG15ZEhBMkViT1MrWXh2S1JlVXJXS3k1TElSVWlpQzA0TVB2WXRrcW5CY3dyek5mY21UTU1MCnB0MjhiWVl5elQ0S09jcDFvVTFnUnNqa0kwWmJNYUdFRlNjWk1EU2l5NGsrSnZ6dmJubXphcExDSTFPcHJWMmYKZW1TRzYydi9DaWVaOU5Hbm82YUh3bGNXR0lVTmN6TXgvVUp5dlFJREFRQUJBb0lCQVFDMDlRYU1YZGJ5SkcvbAprZXlGVnFnTFdNa2QzcUZ0Nng4a3F2MTdYUnZQK2ZndFQreittN2hmQUY1SFN5Z0o2cGtZc2R0VytzSUo2ZExaCmh5dmdoNVNYRGpIK3M4anBWUGpIamdKc2NNMHlZWGF3RThnU3FIajFmYkFIelJsbklUUkZyazkwY25CdDlTZDkKclFqekdQeCttamFQcHl6MDE4bXh5aER4eTZuZFVoaTRNMVNVRUVmWGdRMitoWHM4WS82RzVoZzZwMnFJWnhCUgp4d2oxeEIvMHZnUENQVmRMdUIzZ0poR1ZoellDVUV0QkdNTEViZDhnQU0xWGNDSnRvaUpHdldGY2xBT056L3pqCjYvYStHQmxNZVNOdEJVMHNtVHVLL1NvTFMxSVhpc2h3cjVJMmpta1BiaSt3M0ttSVVNZW1QMEQxS0w0QVc5ZHUKSDVvWmpCTUJBb0dCQU80cU9IZHhycVlsaGVZRE9CNkNKVUlnbDZIYTZ2d01PbU5vREdUL1JMUnBBeFRlcWJxUwo2VnJHdHNGSU9WWTZLTzBpMm9SczNNdW9OZ0o4SGVWQ1dhNS9zbVhYeE0rQTZRR1A1ZEhuM3YrV25vVDU2RVRPCkh3a2I1d2FhbHpaMS8wUm9GbGR5a2QwN0hweGdxVjJTRER1SUUycGhaeGxJTlQveklSOFJjYWlwQW9HQkFNYTEKSGFkcmdXWXZpOWpPd0NNYzNkYVBzbDZYV3dhQmd0QjBRYXVqRWhHMzBvYlNDV0tHR0RiSU92TnFSK2o5TDJEWApCR0h6U2dBeTJHdDRzSS9ialhJMW40c0NyUDJzYUJrSWx1aWhuak95R0MwTjFieGxjNGNibU1DaXNWVVRScXNUCk1IblcrZmFKN3JPb1U1TmIvbmlQNFBzamFhdC9tWnkraEtZZWRHSDFBb0dBY0pnSFAvaS9yNDZYd2NrTjArYUYKUk1EeHpyUVhXWGRTZDBKdWNhVDR6eTNDSmpDcUh5bHJKdDVBOGhsNStkamZGbFRlNTdJcnBDQnZBRGU3VG5KUwp3WnRmTktTUVIrVlN3c2xMeGpPUGlsZWpzNHdPRWRFOGZPcnpDbjAxTmFzTk5rTGJKUlpsL1NnQTdiOEk4dEtqCjg5VCtFTkhoa3VNL1FXOW8zaTQ2QkprQ2dZRUF4UmRvTG1Obm1kK1hLcGtINHN3RERZckNOU2lUVk1TbzUvSW8KSVFKQ0xlalNuSDlBWjhUeHg0U2JWRTBhdm5KQ3lCNzliZHBPa0J2ZXBkcXo1anl5ODVGVWlpRkJUT3Z3NU1PcwpTMW5pL1F1dEJ5TXQyUXdYcHU4c2VBWG5OcWREOVBPM3BXSWgxUFBERzlmZDdjL1ZlK2ZhRTc5d1ZIYmYrcVRPCkZhY25jUEVDZ1lFQTNLTjNxZ3E5Y3ZqM3E5cTJUekt6MFpLYVVkbm1yY0txbVBzdU1VeXpoUlpHa0RyYmlnZG0KMU1jSU90VVlOZy81aWVUYWc4bEpXcW9yL1RCRjhaNmRTV0VDd3hURy9LakU5Vk1BcS94QVU3YUZ0TUFOT1h0TApaVFVkNUl3Z2N1STcweCtYQVRGZ1JldGFrcDVHSCtRYmhoYTNOUnl2UEJGcUd2NS8yNnlHV1VZPQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo='

RUN groupadd -r app --gid=1000 \
 && useradd -r -m -g app -d /home/app --uid=1000 app \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install -y imagemagick nodejs yarn

WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock $APP_HOME/

# Install dependencies
RUN mkdir -p /opt/vendor/bundle && chown -R app:app /opt/vendor \
 && su app -s /bin/bash -c "bundle install --path /opt/vendor/bundle"

# Copy the main application.
COPY . $APP_HOME

RUN chown -R app:app $APP_HOME

USER app

# Initialize application configuration & assets.
RUN ./bin/init_config \
    && bundle exec rake tmp:create yarn:install assets:precompile

# Expose port 8080 to the Docker host, so we can access it
# from the outside.
EXPOSE 8080

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "puma", "--config", "config/puma.rb"]
