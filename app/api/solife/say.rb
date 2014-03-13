module Solife
  class Say < Grape::API
    format :json

	desc "hello world"
	get "/solife/say/:what" do
      { say: params[:what] || "hello" }
	end
  end
end
