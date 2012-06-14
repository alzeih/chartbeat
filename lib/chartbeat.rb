require "chartbeat/version"
require "crack"
require "rest_client"

module Chartbeat
  BASE_URL = 'api.chartbeat.com'
  AUTHENTICATION_OPTIONS = [:apikey, :host]
  METHODS = {
    histogram: { prefix: 'live', args: { required: [:keys, :breaks], optional: [:path, :jsonp] } },
    pathsummary: { prefix: 'live', args: { required: [:keys, :types], optional: [:jsonp] } },
    quickstats: { prefix: 'live', args: { required: [], optional: [:jsonp] } },
    recent: { prefix: 'live', args: { required: [], optional: [:path, :limit, :jsonp] } },
    referrers: { prefix: 'live', args: { required: [], optional: [:path, :limit, :jsonp] } },
    summary: { prefix: 'live', args: { required: [:keys], optional: [:path, :limit, :jsonp] } },
    toppages: { prefix: 'live', args: { required: [], optional: [:limit, :jsonp] } },
    geo: { prefix: 'live', args: { required: [], optional: [:section, :author, :path, :limit, :jsonp] } },
    alerts: { prefix: 'historical/dashapi', args: { required: [:since], optional: [:jsonp] } },
    snapshots: { prefix: 'historical/dashapi', args: { required: [:api, :timestamp], optional: [:jsonp] } },
    stats: { prefix: 'historical/dashapi', args: { required: [], optional: [:jsonp] } },
    data_series: { prefix: 'historical/dashapi', args: { required: [:days, :minutes, :type], optional: [:val, :jsonp] } },
    day_data_series: { prefix: 'historical/dashapi', args: { required: [:type, :timestamp], optional: [:jsonp] } },
  }

  class InvalidOptions < StandardError; end

  class API
    def initialize(opts = {})
      @default_options = opts || {}
    end

    METHODS.keys.each do |method|
      define_method method do |args = {}|
        args = @default_options.select do |k|
          (AUTHENTICATION_OPTIONS + METHODS[method][:args][:required] + METHODS[method][:args][:optional]).include? k
        end.merge args
        check_params args, METHODS[method][:args][:required], METHODS[method][:args][:optional]
        data = Crack::JSON.parse RestClient.get("http://#{BASE_URL}/#{METHODS[method][:prefix]}/#{method.to_s}/", params: args)
      end
    end

    private

    def check_params(params, required, optional)
      required |= AUTHENTICATION_OPTIONS
      raise InvalidOptions, "Missing required arguments: #{required.select { |k| !params.keys.include? k }}" unless required.all? { |k| params.keys.include? k }
      raise InvalidOptions, "Invalid arguments: #{params.keys.select { |k| !(required + optional).include? k }}" if params.keys.any? { |k| !(required + optional).include? k }
    end
  end
end
