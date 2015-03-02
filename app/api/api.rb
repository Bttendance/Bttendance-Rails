class API < Grape::API
  # Prefix all API routes with /api
  prefix 'api'
  # Specify default format
  format :json
  # Use the RABL JSON formatter
  formatter :json, Grape::Formatter::Rabl

  use ::WineBouncer::OAuth2

  rescue_from :all do |e|
    eclass = e.class.to_s
    message = "OAuth Error: #{e.to_s}" if eclass.match('WineBouncer::Errors')
    status = case
    when eclass.match('OAuthUnauthorizedError')
      401
    when eclass.match('OAuthForbiddenError')
      403
    else
      (e.respond_to? :status) && e.status || 500
    end
    opts = { error: "#{message || e.message}" }
    opts[:trace] = e.backtrace[0, 10] unless Rails.env.production?
    Rack::Response.new(opts.to_json, status).finish
  end

  # Before any route
  before do
    set_locale
  end

  private

  helpers do
    # Quickly get declared params
    def permitted_params
      declared(params, { include_missing: false })
    end

    # Set the locale based on the language of the browser/request
    def set_locale
      I18n.locale = parse_locale
    end

    def parse_locale
      # Prefer to get the language from the browser/request variable
      # Fallback to the Accept-Language header
      locale_string = request.env['HTTP_ACCEPT_LANGUAGE'] || headers['Accept-Language']

      if locale_string
        # Scan for the first 2-letter locale we find
        locale_string.scan(/^[a-z]{2}/).first
      else
        # Default to English if nothing else is set
        'en'
      end
    end

    # API error return helper
    def error_with(obj, status_code = nil)
      if obj.is_a?(Integer)
        status_code = obj
      end

      case status_code
      when 401
        error!({ message: "Authentication failed" }, 401)
      when 404
        error!({ message: "#{obj} does not exist" }, 404)
      when 422
        error!({ message: obj.errors.full_messages }, 422)
      end

    end
  end

  # Mount v1 of the REST API
  mount V1::Base
end
