class API < Grape::API
  # Prefix all API routes with /api
  prefix 'api'
  # Specify default format
  format :json
  # Use the RABL JSON formatter
  formatter :json, Grape::Formatter::Rabl

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

    # Api error return helper
    def error_with(obj, status_code)
      if obj.is_a?(Integer)
        status_code = obj
      end

      case status_code
      when 401
        error!({ errors: ['Authentication failed'] }, 401)
      when 404
        error!({ errors: ["#{obj} does not exist"] }, 404)
      when 422
        error!({ errors: obj.errors.full_messages }, 422)
      end
    end

    # set the locale based on the language header
    def set_locale
      Rails.logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
      I18n.locale = extract_locale_from_accept_language_header || 'en'
      Rails.logger.debug "* Locale set to '#{I18n.locale}'"
    end

    # locale parsing from http header
    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
  end

  # Mount v1 of the REST API
  mount V1::Base
end
