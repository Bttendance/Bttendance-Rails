class API < Grape::API
  # Prefix all API routes with /api
  prefix 'api'
  # Specify default format
  format :json
  # Use the RABL JSON formatter
  formatter :json, Grape::Formatter::Rabl

  helpers do
    # API-wide helper to declare params
    def permitted_params
      declared(params, { include_missing: false })
    end
  end

  # Mount v1 of the REST API
  mount V1::Base
end
