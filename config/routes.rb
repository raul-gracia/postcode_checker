Rails.application.routes.draw do
  root to: redirect("/dashboard")
  get "/dashboard", to: "dashboard#index"
  post "/dashboard", to: "dashboard#check"
end
