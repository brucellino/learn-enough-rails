class StaticPagesController < ApplicationController
  include HTTParty
  require "awesome_print"
  def home
    @number = rand()
  end

  def help
  end

  def brucellino
    @user = HTTParty.get('https://api.github.com/users/brucellino').parsed_response
    ap @user
    @avatar = @user['avatar_url']
  end
end
