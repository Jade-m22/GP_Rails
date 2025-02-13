// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./controllers/user_suggestions"
import Rails from "@rails/ujs";
Rails.start();
