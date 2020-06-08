# frozen_string_literal: true

Rails.application.config.session_store :cookie_store, same_site: :strict, secure: true
