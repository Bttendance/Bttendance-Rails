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

    def error_with(obj)
      error!({ errors: obj.errors.full_messages }, 422)
    end
  end

  # Mount v1 of the REST API
  mount V1::Base
end
