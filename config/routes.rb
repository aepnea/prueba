Rails.application.routes.draw do

  # CRUD para crear Races
  resources :tracks

  # Configurando el Index
  root 'tracks#index'

  # Vista de los mapas
  match 'maps/maps_view/:id' => 'maps#maps_view', :as => :maps_maps_view, via: [:get]

  # Creando y borrando  Markers
  match 'maps/create' => 'maps#create', :as => :maps, via: [:post]
  match 'maps/destroy/:id' => 'maps#destroy', :as => :maps_destroy, via: [:get]





end
