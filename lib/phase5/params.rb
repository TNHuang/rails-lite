require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    attr_reader :params

    def initialize(req, route_params = {})
      @params ={}
      if !req.body.nil?
        @params.merge!(parse_www_encoded_form(req.body))
      end
      if !req.query_string.nil?
        @params.merge!(parse_www_encoded_form(req.query_string))
      end
      @params.merge!(route_params)

    end

    def [](key)

      @pararms[key].to_s
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      output = {"a" => []}
      branches = []

      kps = www_encoded_form.split(/&/)
      kps.each do |kp|
        keys, val = kp.split(/=/)
        keys = parse_key(keys)
        branches << assign_key_val(keys, val))
      end

      lead_branch = branches.first

      output
    end

    def assign_key_val(keys, val)
      return {keys.first => val} if keys.length == 1

      {keys.first => assign_key_val(keys.drop(1), val)}
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.scan(/\w+/)
    end
  end
end
