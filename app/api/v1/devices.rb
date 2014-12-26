module V1
  class Devices < Grape::API
    include Grape::Kaminari

    resource :devices do
      desc 'Returns a list of devices, paginated'
      paginate per_page: 10
      get '', rabl: 'devices/device' do
        devices = Device.all
        @devices = paginate(Kaminari.paginate_array(devices))
      end
    end
  end
end
