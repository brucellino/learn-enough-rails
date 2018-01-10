class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def hello
    render html: "Hello World!"
  end

  def contact
  end

  def about
  end
end
