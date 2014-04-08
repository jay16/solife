require "api_tool"

module ApiHelpers

	def current_user
	  return false unless params[:token]

	  email, pwd = SOLife::ApiTool.decode(params[:token])
	  if user = User.find_by_email(email)
		@current_user = user if user.valid_password?(pwd)
	  end
	end

	#grape default method
	def authenticate!
	  error!({ "error" => "401 Unauthorized" }, 401) unless current_user
	end
end
