require "entities"
require "helpers"

module SOLife
  class API < Grape::API
    prefix "api"
    error_format :json

    helpers APIHelpers

    # Authentication:
    # APIs marked as 'require authentication' should be provided the user's private token,
    # either in post body or query string, named "token"

    resource :consumes do
      
      post "create" do
	ret, ret_info, consume = 0, "", {}
	params.delete_if { |p| %w(action controller).include?(p) }

	if params.empty?
	  ret_info = "params is empty"
	else
	  consume = User.find_by_email("android_app@solife.us")
	    .consumes.create(params[:consume])

	  if consume.save
	    ret, ret_info, consume = 1, "OK", consume.to_json
	  else
	    ret, ret_info = 0, consume.errors.full_messages
	  end
	end
        
        render :json => { :ret => ret, :ret_info => ret_info, :consume => consume}
      end

      get "list" do
	consumes = User.find_by_email("android_app@solife.us").consumes
	render :json => consumes.to_json
      end
    end

  end
end
