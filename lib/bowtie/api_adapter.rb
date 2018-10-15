require "bowtie/api_adapter/version"
require "bowtie/api_adapter/base_api"

module Bowtie
  module ApiAdapter
    def self.new(base_url:, default_headers: {}, default_params: {}, default_body: {})
      api = BaseApi.new(
        base_url: base_url,
        default_headers: default_headers,
        default_params: default_params,
        default_body: default_body
      )
    end
    
    def self.get(path:, params: {}, headers: {})
      api.get path: path, params: params, headers: headers
    end

    def self.post(path:, body: {}, params: {}, headers: {})
      api.post path: path, body: body, params: params, headers: headers
    end

    def self.patch(path:, body: {}, params: {}, headers: {})
      api.patch path: path, body: body, params: params, headers: headers
    end

    def self.put(path:, body: {}, params: {}, headers: {})
      api.put path: path, body: body, params: params, headers: headers
    end

    def self.delete(path:, params: {}, headers: {})
      api.delete path: path, params: params, headers: headers
    end
  end
end
