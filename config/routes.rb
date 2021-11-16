Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  # get 'welcome/index'
  # devise_for :users       
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

 namespace :api do                                                                            
     namespace :v1 do                                                                         
          devise_scope :user do                                                               
            post 'signup' => 'registrations#create'                                   
            post 'signin' => 'sessions#create'                                          
            delete 'signout' => 'sessions#destroy'                             
          end  
            post 'create' => 'company#create'            
            put 'update' => 'company#update'  
            delete 'destroy'=>'company#destroy'   
            get 'show' =>'company#show'                                                                              
     #  resources :company                                           
      end                                                                                             
  end                                                               

end
    

 