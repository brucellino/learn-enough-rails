class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_raven_context
  include SessionsHelper

  def hello
    render html: "Hello World!"
  end

  def contact
  end

  def about
  end

  private

  def set_raven_context
    Raven.user_context(id: session[:remember_token]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
