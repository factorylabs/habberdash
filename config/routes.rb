Habberdash::Engine.routes.draw do
  scope :module => 'habberdash' do
    resource :configuration, only: [ :show, :update ], controller: 'dashboards'
    match 'widgets', to: 'dashboards#widgets'
    root to: 'dashboards#show'
  end
end
