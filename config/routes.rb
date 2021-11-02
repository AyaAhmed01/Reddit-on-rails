Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do 
    member do 
      delete :unsubscribe 
      post :subscribe 
    end
  end
  resources :posts, except: :index do 
    resources :comments, only: :new 
    post 'upvote', on: :member
    post 'downvote', on: :member
  end
  resources :comments, only: [:create, :show] do 
    post 'upvote', on: :member
    post 'downvote', on: :member
  end
end
