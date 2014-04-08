require "api_tool"

class Api < Grape::API
	prefix 'api'
	format :json

    helpers do
	  def current_user
	    return false unless params[:token]

		email, pwd = Solife::ApiTool.decode(params[:token])
		user = User.find_by_email(email)
		if user and user.valid_password?(pwd)
		  @current_user = user
		end
	  end

	  def authenticate!
		error!('401 Unauthorized', 401) unless current_user
	  end
    end

    resource :users do
	  #取得用户信息
	  #Example: 
	  #/api/users.json
	  get do
		authenticate!
		@current_user.to_json
	  end
	end
    
end
