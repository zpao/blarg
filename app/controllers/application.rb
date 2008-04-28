# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  attr_accessor :authorized

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '4b3def304d08c8491adc88ae51b54460'
  
  
  def auth_required
    authorized? || access_denied
  end

  helper_method :authorized?  
  def authorized?
    self.authorized || login_from_basic_auth
  end
  
  def access_denied
    respond_to do |format|
      format.html do
        request_http_basic_authentication "#{BLARG_CONFIG['blog']['title']} (admin)"
      end
    end
  end
  
  def login_from_basic_auth
    authenticate_with_http_basic do |username, password|
      self.authorized = username == BLARG_CONFIG['auth']['username'] && password == BLARG_CONFIG['auth']['password']
    end
  end
  
end
