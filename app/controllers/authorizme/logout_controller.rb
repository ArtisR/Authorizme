module Authorizme
  class LoginController < AuthorizmeController
  
    def index
      logout
    end
  
  end
end