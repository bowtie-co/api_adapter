require "bowtie/api_adapter/version"

module Bowtie
  module ApiAdapter
    def self.get(path:, params: {}, headers: {})
      BaseApi.get path: path, params: params, headers: headers
    end

    def self.post(path:, body: {}, params: {}, headers: {})
      BaseApi.post path: path, body: body, params: params, headers: headers
    end

    def self.patch(path:, body: {}, params: {}, headers: {})
      BaseApi.patch path: path, body: body, params: params, headers: headers
    end

    def self.put(path:, body: {}, params: {}, headers: {})
      BaseApi.put path: path, body: body, params: params, headers: headers
    end

    def self.delete(path:, params: {}, headers: {})
      BaseApi.delete path: path, params: params, headers: headers
    end
  end
end
