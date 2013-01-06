Rolemaster::Application.routes.draw do
 
  get "roadmap/index"

  get "bizadmins/blank"

  #get "password_resets/new"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

 
  get "maintenance/display_message" => "maintenance#display_message" , :as => "display_message"

  get "public/home"
  get "public/tos"


  get "public/club/:club_id" => "public#club" 

  match "agendas/print"  
   
  get "contest" => "contest_signups#signup" 
  get "remove" => "contest_signups#remove" 

  get "batch/toggle" => "batch#toggle" 
  get "batch/run" => "batch#run" 
  get "batch/bootstrap" => "batch#bootstrap" 
  get "batch/bring_up" => "batch#bring_up" 
  
  #get "agenda_definitions/agenda_intro" => "agenda_definitions#agenda_intro", :as => "agenda_intro"

  get "test/email"
  get "sessions/revoke_admin"
  get "sessions/revoke_super_user"
  get "all_members" => "sysadmins#all_members"
  get "all_clubs" => "sysadmins#all_clubs"
  get "admins/blank/:id" => "admins#blank", :as => "admin"
  get "sysadmins/blank" => "sysadmins#blank", :as => "sysadmins"
  get "bizadmins/blank" => "bizadmins#blank", :as => "bizadmins"

  get "sessions/select" => "sessions#select", :as => "select"


  get "railsthemes/home"
  get "railsthemes/inner"
  get "railsthemes/landing"
  get "railsthemes/jquery_ui"


  get "enrollments/new"
  get "updates/new" => "updates#new"
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => 'users#new', :as => 'sign_up'


  post "select" => "sessions#select", :as => "select"
  post "enrollments/create"
  


  

  resources :sys_configurations
  resources :agreements
  resources :updates

  
  #root :to => 'public#home'
  root :to => 'sessions#new'


  resources :clubs
 
  resources :sessions
  resources :enrollments

  

  resources :users do
      put "update_password" => "users#update_password"
      put "update_email" => "users#update_email"
      get "edit_password" => "users#edit_password"
      get "edit_email"    => "users#edit_email"
  end


  resources :password_resets
  



  resources :notification_types


  resources :contest_signups

  resources :clubs do
   
    resources :members do
     
      resources :assignments do
        collection do
          get 'signup_for_role'
          get 'signup_for_role_multi_club'
          get 'display_success'
          get 'past_activity'
        end
      end
      resources :absences
      resources :member_notification_preferences 
      put "update_email_preferences" => "member_notification_preferences#update_email_preferences"

  
    end
    resources :roles 
    resources :meeting_types 
    
    resources :role_groups  do
      resources :role_group_associations do
        collection do
          put "replace" => "role_group_associations#replace"
        end
      end
    end

    resources :password_resets

    resources :meetings do
      get 'forassignment', :on => :collection
      get 'print'
      post 'print_notes'
      get 'print_notes_setup'
      resources :assignments
    end
  end  




  resources :clubs do
    resources :meetings do
      resources :meeting_notes
      resources :agenda_definitions do
        get 'print' => "agendas#show"
      end 
    end
    resources :agenda_definitions do
      resources :agenda_tops 
      resources :agenda_line_items do
          get 'toggle_inclusion'  
      end
      resources :agenda_bottoms
    end
  end


  resources :agenda_definitions do
      get 'include_all_lines'  
      post 'sort_line_items' => "agenda_line_items#sort" 
  end

   
  resources :clubs do
    resources :assignments do
      post 'generate', :on => :collection 
    end
    resources :absences do
      get 'list', :on => :collection
    end
    resources :leaders
  end


    

  match 'railsthemes/landing' => 'railsthemes#landing'
  match 'railsthemes/inner' => 'railsthemes#inner'
  match 'railsthemes/jquery_ui' => 'railsthemes#jquery_ui'
end
