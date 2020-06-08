# frozen_string_literal: true

class LinksController < ApplicationController
  require 'net/http'

  def show
    @auto_follow = get_set_boolean_setting('auto_follow', false)
    @strip_utm = get_set_boolean_setting('strip_utm', true)

    if @url = params[:url]
      @unravelled = unravel(@url, @strip_utm)
      redirect_to @unravelled[:final_url] if @auto_follow
    end
  end

  def about
    reset_session
  end

  private

  def get_set_boolean_setting(name, default)
    val = if params.key? name
            ActiveModel::Type::Boolean.new.cast(params[name])
          elsif session.key? name
            ActiveModel::Type::Boolean.new.cast(session[name])
          else
            default
          end
    session[name] = val
    val
  end

  def unravel(url, strip_utm, unravelling = { items: [], cookies: [] })
    url = url.gsub(/&?utm_.+?(&|$)/, '').chomp('?') if strip_utm
    url = URI.parse(url.strip)
    request = Net::HTTP::Get.new(url.to_s, { 'User-Agent' => 'Ruby/SafeUnblock 1.0.0' })
    response = Rails.cache.fetch(url, expires_in: 1.day) do
      Net::HTTP.start(url.host,
                      url.port,
                      use_ssl: (url.scheme == 'https'),
                      verify_mode: OpenSSL::SSL::VERIFY_NONE) { |http| http.request request }
    end

    unravelling[:items] << {
      url: url,
      headers: response.header.as_json
    }

    if location = response.header[:location]
      unravelling[:cookies] << CGI::Cookie.parse(response.header['set-cookie'])
      location = URI.parse(location)
      location.host = url.host unless location.host
      location.scheme = url.scheme unless location.scheme
      unravel(location.to_s, strip_utm, unravelling)
    else
      unravelling[:final_url] = url.to_s
      unravelling
    end
  end
end
