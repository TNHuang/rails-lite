require 'json'
require 'webrick'


module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    attr_accessor :session
    def initialize(req)
      @session = {}
      if !req.nil?
        req.cookies.each do |c|
           @session=JSON.parse(c.value)  if c.name == '_rails_lite_app'
        end
      end

    end

    def [](key)
      @session[key]
    end

    def []=(key, val)
      @session[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
       res.cookies << WEBrick::Cookie.new('_rails_lite_app', @session.to_json)
    end
  end
end
