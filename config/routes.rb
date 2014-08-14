Rails.application.routes.draw do
  get 'transactions/index'
  match 'devices/readXls' => 'devices#readXls', via: [:get, :post]
  root 'devices#index'

  get 'prices/index'
  get 'playlog/index'

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/logout' => 'session#destroy'


  get '/devices/device_report'
  get '/devices/getItems'

  post '/leases/addTransaction'
  delete '/leases/deleTransaction/:id' => 'leases#deleTransaction', :as => 'lease_deleTransaction'
  get '/leases/price_report'

  get '/log/index'
  get '/log/update_data'

  get '/songRecord' => 'log#songRecord'

  get '/songs/getParty' => 'songs#getParty'
  get '/singers/get' => 'singers#get'

  resources :leases
  resources :singers
  resources :songs
  resources :licensees
  resources :devices
  resources :users
  resources :dealers

  mount MongodbLogger::Server.new, :at => "/mongodb"
  mount MongodbLogger::Assets.instance, :at => "/mongodb/assets", :as => :mongodb_assets # assets
end
