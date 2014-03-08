# Be sure to restart your server when you modify this file.

Littlefire::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes
