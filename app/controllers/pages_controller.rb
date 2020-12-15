class PagesController < ApplicationController
	before_action :ensure_logged_in, :only => :private

  def home

  end

   	UserQuery = Demo::Client.parse <<-'GRAPHQL'
		query($login: String!) {
		  	search (query: $login, type: USER, first: 1){
			    edges {
			      node {
			        ... on User {
			          avatarUrl
			          bio
			          company
			          location
			          login
			          name
			        }
			      }
			    }
			  }
		}


    GRAPHQL

  def private
  	login = current_user.login
  	resultUser = Demo::Client.query(UserQuery, variables: { login: login })
  	@users = resultUser.data.search
  end


end
