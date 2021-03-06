module JkoApi
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      if version_number = extract_version_number(env)
        ::JkoApi.current_version_number = version_number
      else
        ::JkoApi.reset
      end
      @app.call env
    end

    private

    def extract_version_number(env)
      accept_header = env['HTTP_ACCEPT']
      return false unless accept_header
      accept_header[ACCEPT_HEADER_REGEX, 2] ||
      accept_header[ACCEPT_HEADER_REGEX] && ::JkoApi.max_version_number
    end
  end
end
