Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'
  devise_for :users
  namespace :api do                                                                            
    namespace :v1 do                                                                         
      devise_scope :user do                                                               
        post 'signup' => 'registrations#create'                                   
        post 'signin' => 'sessions#create'                                          
        delete 'signout' => 'sessions#destroy'                             
      end  
      #resources :company, :except => [:new, :edit]
      post 'index' => 'company#index'
      post 'create' => 'company#create'            
      put 'update' => 'company#update'  
      delete 'destroy'=>'company#destroy'   
      get 'show' =>'company#show'                                                                                                          
    end                                                                                             
  end                                                               
end
 