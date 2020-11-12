# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "postcode#index"
  post "/", to: "postcode#check"
end
