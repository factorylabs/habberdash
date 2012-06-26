Habberdash::Engine.routes.draw do
  scope :module => 'habberdash' do
    resource :dashboard, only: [ :show, :update ]
    match 'widgets', to: 'dashboards#widgets'
    root to: 'dashboards#show'
  end
end
