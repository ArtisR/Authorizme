module Authorizme
  class AuthorizmeController < ::ApplicationController
    respond_to :html, :json, :xml
    layout "authorizme/layouts/popup"
    before_filter :check_synchronize, :only => [:auth]

    def index
      @user = current_user
    end

    protected

      def check_synchronize
        if params[:synchronize]
          session[:synchronize] = true
        end
      end
      
      def logout
      	session[:user_id] = nil if session[:user_id] && session[:user_id] != nil
      	respond_with({status: "logged_out"}, :location => Authorizme::after_logout_path)
      end
      
      def render_popup_view
        render "popup", :layout => "authorizme/layouts/popup"
      end
      
      def respond_with_status status_name, attributes = nil
        status = {status: status_name}
        status = status.merge(attributes) if attributes
        respond_with status, :location => nil
      end
      
      def redirect_uri provider
        if Rails.env.development?
          "http://#{request.host}:#{request.port}/#{Authorizme::namespace}/login/#{provider}/callback"
        else
          "http://#{request.host}/#{Authorizme::namespace}/login/#{provider}/callback"
        end
      end
  end
end