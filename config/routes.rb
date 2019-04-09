Rails.application.routes.draw do
  root 'application#hello'
  get 'top', to: 'home#top'
  get 'about', to: 'home#about'
end
