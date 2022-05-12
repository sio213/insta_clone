# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#               users_index GET    /users/index(.:format)                                                                   users#index
#          new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#              user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#      destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#         new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#        edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#             user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                           PUT    /users/password(.:format)                                                                devise/passwords#update
#                           POST   /users/password(.:format)                                                                devise/passwords#create
#  cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#     new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#    edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#         user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                           PUT    /users(.:format)                                                                         devise/registrations#update
#                           DELETE /users(.:format)                                                                         devise/registrations#destroy
#                           POST   /users(.:format)                                                                         devise/registrations#create
#                    signup GET    /signup(.:format)                                                                        devise/registrations#new
#                     login GET    /login(.:format)                                                                         devise/sessions#new
#                    logout DELETE /logout(.:format)                                                                        devise/sessions#destroy
#                      root GET    /                                                                                        posts#index
#                     users GET    /users(.:format)                                                                         users#index
#                      user GET    /users/:id(.:format)                                                                     users#show
#             post_comments POST   /posts/:post_id/comments(.:format)                                                       comments#create
#         edit_post_comment GET    /posts/:post_id/comments/:id/edit(.:format)                                              comments#edit
#              post_comment PATCH  /posts/:post_id/comments/:id(.:format)                                                   comments#update
#                           PUT    /posts/:post_id/comments/:id(.:format)                                                   comments#update
#                           DELETE /posts/:post_id/comments/:id(.:format)                                                   comments#destroy
#                     posts GET    /posts(.:format)                                                                         posts#index
#                           POST   /posts(.:format)                                                                         posts#create
#                  new_post GET    /posts/new(.:format)                                                                     posts#new
#                 edit_post GET    /posts/:id/edit(.:format)                                                                posts#edit
#                      post GET    /posts/:id(.:format)                                                                     posts#show
#                           PATCH  /posts/:id(.:format)                                                                     posts#update
#                           PUT    /posts/:id(.:format)                                                                     posts#update
#                           DELETE /posts/:id(.:format)                                                                     posts#destroy
#                     likes POST   /likes(.:format)                                                                         likes#create
#                      like DELETE /likes/:id(.:format)                                                                     likes#destroy
#             relationships POST   /relationships(.:format)                                                                 relationships#create
#              relationship DELETE /relationships/:id(.:format)                                                             relationships#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
    get 'login', to: 'devise/sessions#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end

  root 'posts#index'

  resources :users, only: [:index, :show]
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :likes, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end
