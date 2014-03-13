#encoding: utf-8
module Solife
  class Users < Grape::API
    format :json

	desc "recevie user infos"
	get "/solife/users/:token" do
      { say: params[:token] || "hello" }
	end
  end
end
