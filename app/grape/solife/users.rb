#encoding: utf-8
module SOLife
  class Users < Grape::API
    format :json

	desc "recevie user infos"
	get "/solife/user" do
      { say: params[:token] || "hello" }
	end
  end
end
