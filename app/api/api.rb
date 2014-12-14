class API < Grape::API
  # Prefix all API routes with /api
  prefix 'api'
  # Specify default format
  format :json
  # Use the RABL JSON formatter
  formatter :json, Grape::Formatter::Rabl

  helpers do
    # Quickly get declared params
    def permitted_params
      declared(params, { include_missing: false })
    end

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
  end

  # Mount v1 of the REST API
  mount V1::Base
end
