require_relative 'boot'

require 'rails/all'
require "graphql/client" #(追記)
require "graphql/client/http" #(追記)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Demo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

     config.middleware.use OmniAuth::Builder do 
    	provider :developer if Rails.env.development?
    	provider :github, 'b939e592652c1c699d52', '56c8700f9131e494107d133f33f259352abe7260'
    end
    
  end

  AUTH_HEADER = "Bearer 1c3a5b806d621b25324c67c147c90e7aaa8e6047"

	  HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do 
	  #上記には、接続したいAPIのエンドポイントURLを記入
	    def headers(context)
	      { "Authorization": AUTH_HEADER }
	    end
	  end
	  Schema = GraphQL::Client.load_schema(HTTP)
	  # 上記を使って API サーバーから GraphQL Schema 情報を取得
	  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
	  # 上記を使ってクライアントを作成

end
