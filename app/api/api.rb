require "helpers"

class Api < Grape::API
  prefix 'api'
  #error_format :json

  #helpers APIHelpers

  # Authentication:
  # APIs marked as 'require authentication' should be provided the user's private token,
  # either in post body or query string, named "token"
  
  #mount Solife::Users
  #mount Solife::Consumes
  #mount Solife::Phone
end
