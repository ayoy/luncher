ActionController::Routing::Routes.draw do |map|
  map.connect 'lunches/find_by_date', :controller => 'lunches', :action => 'find_by_date'
  map.connect 'lunches/show_by_date', :controller => 'lunches', :action => 'show_by_date'
  map.connect 'lunches/:year/:month/:day',
              :controller => 'lunches',
              :action     => 'find_by_date',
              :year       => /\d{4}/,
              :month      => /\d{1,2}/,
              :day        => /\d{1,2}/

  map.connect 'orders/today', :controller => 'orders', :action => 'today'
  map.connect 'orders/find_by_date', :controller => 'orders', :action => 'find_by_date'
  map.connect 'orders/find_all_by_date', :controller => 'orders', :action => 'find_all_by_date'
  map.connect 'orders/my', :controller => 'orders', :action => 'my'
  map.connect 'orders/:year/:month/:day',
              :controller => 'orders',
              :action     => 'find_all_by_date',
              :year       => /\d{4}/,
              :month      => /\d{1,2}/,
              :day        => /\d{1,2}/

  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :lunches
  map.resource :user_session
  map.resources :orders
  map.resources :password_resets
  map.resources :vendors
  
  map.root :controller => "user_sessions", :action => "new"
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
end
