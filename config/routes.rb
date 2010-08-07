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
  map.connect 'orders/find_by_month', :controller => 'orders', :action => 'find_by_month'
  map.connect 'orders/my', :controller => 'orders', :action => 'my'
  map.connect 'orders/monthly_report', :controller => 'orders', :action => 'monthly_report'
  map.connect 'orders/:year/:month',
              :controller => 'orders',
              :action     => 'find_by_month',
              :year       => /\d{4}/,
              :month      => /\d{1,2}/
  map.connect 'orders/:year/:month/:day',
              :controller => 'orders',
              :action     => 'find_all_by_date',
              :year       => /\d{4}/,
              :month      => /\d{1,2}/,
              :day        => /\d{1,2}/

  map.connect 'settings/lock_system', :controller => 'settings', :action => 'lock_system'
  map.connect 'settings/unlock_system', :controller => 'settings', :action => 'unlock_system'

  map.connect 'vendors/:id/notify_users',
              :controller => 'vendors',
              :action => 'notify_users',
              :id => /\d+/
  map.connect 'vendors/:id/mark_orders_complete',
              :controller => 'vendors',
              :action => 'mark_orders_complete',
              :id => /\d+/
  map.connect 'vendors/:id/mark_orders_new',
              :controller => 'vendors',
              :action => 'mark_orders_new',
              :id => /\d+/

  map.resource :account, :controller => "users"
  map.resource :user_session
  map.resources :users
  map.resources :lunches
  map.resources :orders
  map.resources :password_resets
  map.resource :settings
  map.resources :vendors

  map.root :controller => "user_sessions", :action => "new"
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
end
