module Solife
  module APIHelpers

    
    def current_user
	  token = params[:token] || "token"
	  @current_user ||= User.find_current_user(token)
	end
    
	#grape default method
	def authenticate!
	  error!({ "error" => "401 Unauthorized" }, 401) unless current_user
	end
  end
end
