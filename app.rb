require 'sinatra/base'
require 'github_api'
require 'json'

class GithubApp < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/info/:nickname' do |nickname|
    info = {
      repos: []
    }

    github = Github.new

    begin
      user_info = github.users.get(user: nickname)

      info[:user] = {
        name:     user_info.name,
        location: user_info.location,
        email:    user_info.email
      }

      github.repos.list(user: nickname) do |repo|
        info[:repos] << {
          url:      repo.svn_url,
          watchers: repo.watchers
        }
      end

      content_type 'application/json'
      info.to_json
    rescue Github::Error::NotFound => error
      status 404
    end
  end
end