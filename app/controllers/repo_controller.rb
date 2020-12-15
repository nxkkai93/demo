class RepoController < ApplicationController

    RepositoryQuery = Demo::Client.parse <<-'GRAPHQL'
		query($login: String!) {
		  	repositoryOwner(login: $login) {
			    repositories(first: 30) {
				   	totalCount
				    edges {
				        cursor
				        node {
					        ... on Repository {
						        name
						        stargazers(first: 2) {
						            totalCount
						            nodes {
						              	... on User {
						                	name
						              	}
						            }
						        }
						        issues(first: 2) {
						            totalCount
						            nodes {
						              	... on Issue {
						                	body
						              	}
						            }
						        }
					        }
					    }
				    }
			      	pageInfo {
	      				startCursor
						endCursor
						hasPreviousPage
						hasNextPage
					}

			    }
			  }
		}


    GRAPHQL

  	def index
  		@search = params[:search]
  		# @page = params.fetch(:page, 0).to_i


  		if params[:search] == nil
  			@works = nil
  		else
  			login = params[:search]
  			resultRepo = Demo::Client.query(RepositoryQuery, variables: { login: login })

  			if resultRepo.data.repository_owner == nil 
  				@works = nil
  			else
  				@works = resultRepo.data.repository_owner.repositories
  			end
  			
  		end
  		
 	end  	


	 # Define query for "Show more repositories..." AJAX action.
  	MoreQueryRepo = Demo::Client.parse <<-'GRAPHQL'
	    query($login: String!, $after: String!) {
	      repositoryOwner(login: $login) {
			    repositories(first: 30, after: $after) {
				   	totalCount
				    edges {
				        cursor
				        node {
					        ... on Repository {
						        name
						        stargazers(first: 2) {
						            totalCount
						            nodes {
						              	... on User {
						                	name
						              	}
						            }
						        }
						        issues(first: 2) {
						            totalCount
						            nodes {
						              	... on Issue {
						                	body
						              	}
						            }
						        }
					        }
					    }
				    }
			      	pageInfo {
	      				startCursor
						endCursor
						hasPreviousPage
						hasNextPage
					}

			    }
			}
	    }
  GRAPHQL

  # GET /repositories/more?after=CURSOR
  def more
    # Execute the MoreQuery passing along data from params to the query.
    resultRepo = Demo::Client.query(MoreQueryRepo, variables: { login: params[:search], after: params[:after] })
    @works = resultRepo.data.repository_owner.repositories
    @search = params[:search]
    # Using an explicit render again, just render the repositories list partial
    # and return it to the client.
    render partial: "repo"
  end

  	QueryStargazers = Demo::Client.parse <<-'GRAPHQL'
	    query($login: String!, $name: String!){
		  repositoryOwner (login: $login) {
		    repository(name: $name) {
		      stargazers(first: 30) {
		        totalCount
		        edges {
					    cursor
			              	node {
			          			... on User {
			            			name
			          			}
			        		}
			        	}
		          	pageInfo {
		                startCursor
			            endCursor
			            hasPreviousPage
			            hasNextPage
					}
		      	}
		    }
		  }
		}
  	GRAPHQL

  	def stargazers
	    # Execute the MoreQuery passing along data from params to the query.
	    resultStargazers = Demo::Client.query(QueryStargazers, variables: { login: params[:search], name: params[:name] })
	    @works = resultStargazers.data.repository_owner.repository
	    # @search = params[:search]
	    # Using an explicit render again, just render the repositories list partial
	    # and return it to the client.
	    render partial: "stargazers"
  	end

  	MoreQueryStargazers = Demo::Client.parse <<-'GRAPHQL'
	    query($login: String!, $name: String!, $after: String!){
		  repositoryOwner (login: $login) {
		    repository(name: $name) {
		      stargazers(first: 30, after: $after) {
		        totalCount
		        edges {
					    cursor
			              	node {
			          			... on User {
			            			name
			          			}
			        		}
			        	}
		          	pageInfo {
		                startCursor
			            endCursor
			            hasPreviousPage
			            hasNextPage
					}
		      	}
		    }
		  }
		}
  	GRAPHQL

  	def more_stargazers
	    # Execute the MoreQuery passing along data from params to the query.
	    resultStargazers = Demo::Client.query(MoreQueryStargazers, variables: { login: params[:search], name: params[:name], after: params[:after] })
	    @works = resultStargazers.data.repository_owner.repository
	    # @search = params[:search]
	    # Using an explicit render again, just render the repositories list partial
	    # and return it to the client.
	    render partial: "stargazers"
  	end

  	QueryIssues = Demo::Client.parse <<-'GRAPHQL'
	    query($login: String!, $name: String!){
		  repositoryOwner (login: $login) {
		    repository(name: $name) {
		      issues(first: 30) {
		        totalCount
		        edges {
					    cursor
			              	node {
			          			... on Issue {
			            			body
			          			}
			        		}
			        	}
		          	pageInfo {
		                startCursor
			            endCursor
			            hasPreviousPage
			            hasNextPage
					}
		      	}
		    }
		  }
		}
  	GRAPHQL

  	def issues
  		# Execute the MoreQuery passing along data from params to the query.
	    resultIssues = Demo::Client.query(QueryIssues, variables: { login: params[:search], name: params[:name] })
	    @works = resultIssues.data.repository_owner.repository
	    # @search = params[:search]
	    # Using an explicit render again, just render the repositories list partial
	    # and return it to the client.
	    render partial: "issues"
  	end

  	MoreQueryIssues = Demo::Client.parse <<-'GRAPHQL'
	    query($login: String!, $name: String!, $after: String!){
		  repositoryOwner (login: $login) {
		    repository(name: $name) {
		      issues(first: 30, after: $after) {
		        totalCount
		        edges {
					    cursor
			              	node {
			          			... on Issue {
			            			body
			          			}
			        		}
			        	}
		          	pageInfo {
		                startCursor
			            endCursor
			            hasPreviousPage
			            hasNextPage
					}
		      	}
		    }
		  }
		}
  	GRAPHQL

  	def more_issues
  		# Execute the MoreQuery passing along data from params to the query.
	    resultIssues = Demo::Client.query(MoreQueryIssues, variables: { login: params[:search], name: params[:name], after: params[:after] })
	    @works = resultIssues.data.repository_owner.repository
	    # @search = params[:search]
	    # Using an explicit render again, just render the repositories list partial
	    # and return it to the client.
	    render partial: "issues"
  	end

end
