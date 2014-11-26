module V1
  class Devices < Grape::API
    resource :devices do
      desc 'Returns a list of devices'
      get do
        Device.all
      end
    end
  end
end
