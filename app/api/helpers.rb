require "api_tool"

module SOLife
  module APIHelpers

    
    def current_user
	  @current_user = nil unless params[:token]
	  email, pwd = SOLife::ApiTool.decode(params[:token])

	  @current_user ||= User.find_current_user(token)
	end
    
	#grape default method
	def authenticate!
	  error!({ "error" => "401 Unauthorized" }, 401) unless current_user
	end
  end
end
