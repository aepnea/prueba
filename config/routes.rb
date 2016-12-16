Rails.application.routes.draw do
  match 'maps/maps_view/:id' => 'maps#maps_view', :as => :maps_maps_view, via: [:get]

  resources :tracks

  #match 'mark/create' => 'marks#create', :as => :marks, via: [:post]
  match 'maps/create' => 'maps#create', :as => :maps, via: [:post]


  root 'tracks#index'


end
