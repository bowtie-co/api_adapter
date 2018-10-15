# frozen_string_literal: true

require 'json'
require 'rest-client'
require 'active_support'
require 'active_support/core_ext'

##
# Base API class
#   - Handles building requests
#   - Supports defaults for body/params/headers
##
module Bowtie
  class BaseApi
    # Let instances access these variables
    attr_accessor :base_url
    attr_accessor :default_headers
    attr_accessor :default_params
    attr_accessor :default_body

    # Define constructor (only "base_url" is required)
    def initialize(base_url:, default_headers: {}, default_params: {}, default_body: {})
      # Sanitize base_url before storing in instance var
      @base_url = sanitize_base_url base_url

      # Set defaults (all default to empty hashes)
      @default_headers = default_headers
      @default_params = default_params
      @default_body = default_body
    end

    # Execute a GET request for the specified path
    #   - Optionally provide params/headers
    #   - params are url parameters (query string)
    #   - headers are standard HTTP headers
    def get(path:, params: {}, headers: {})
      # The options passed to a get request are all "headers", merge incoming with default
      options = @default_headers.merge(headers)

      # Since all options are passed with headers, add url params under :params symbol
      options[:params] = @default_params.merge(params)

      # Handle this GET request (returns parsed JSON response body)
      handle_response RestClient.get(build_url(path), options)
    end

    # Execute a POST request for the specified path
    #   - Optionally provide body/params/headers
    #   - body is the POST request "payload"
    #   - params are treated as url parameters
    #   - headers are standard HTTP headers
    def post(path:, body: {}, params: {}, headers: {})
      # Merge provided body with any defaults
      body = @default_body.merge(body)

      # Merge provided headers with any defaults
      headers = @default_headers.merge(headers)

      body = body.to_json if headers[:content_type] && headers[:content_type].to_s.include?('json')

      # Merge the provided params into headers with any defaults
      headers[:params] = @default_params.merge(params)

      # Handle this POST request (returns parsed JSON response body)
      handle_response RestClient.post(build_url(path), body, headers)
    end

    def patch(path:, body: {}, params: {}, headers: {})
      # Merge provided body with any defaults
      body = @default_body.merge(body)

      # Merge provided headers with any defaults
      headers = @default_headers.merge(headers)

      body = body.to_json if headers[:content_type] && headers[:content_type].to_s.include?('json')

      # Merge the provided params into headers with any defaults
      headers[:params] = @default_params.merge(params)

      # Handle this POST request (returns parsed JSON response body)
      handle_response RestClient.patch(build_url(path), body, headers)
    end

    def put(path:, body: {}, params: {}, headers: {})
      # Merge provided body with any defaults
      body = @default_body.merge(body)

      # Merge provided headers with any defaults
      headers = @default_headers.merge(headers)

      body = body.to_json if headers[:content_type] && headers[:content_type].to_s.include?('json')

      # Merge the provided params into headers with any defaults
      headers[:params] = @default_params.merge(params)

      # Handle this POST request (returns parsed JSON response body)
      handle_response RestClient.put(build_url(path), body, headers)
    end

    def delete(path:, params: {}, headers: {})
      # The options passed to a get request are all "headers", merge incoming with default
      options = @default_headers.merge(headers)

      # Since all options are passed with headers, add url params under :params symbol
      options[:params] = @default_params.merge(params)

      # Handle this GET request (returns parsed JSON response body)
      handle_response RestClient.delete(build_url(path), options)
    end

    private

    # Build the full request url
    #   - Basically just concat @base_url + path
    #   - Option to insert query string params as part of the request url string
    def build_url(path, qs = {})
      # Sanitize provided path
      path = sanitize_path path

      # Construct and return the full url
      "#{@base_url}/#{path}?#{qs.to_query}"
    end

    # Sanitize base_url (remove trailing slash)
    def sanitize_base_url(base_url)
      base_url = base_url[0..(base_url.length - 2)] if base_url.end_with? '/'

      base_url
    end

    # Sanitize path (remove leading slash)
    def sanitize_path(path)
      path = path[1..(path.length)] if path.start_with? '/'

      path
    end

    # Handle generic response
    def handle_response(response)
      # Attempt to parse & return response body as JSON
      response.body ? JSON.parse(response.body) : nil
    end
  end
end
