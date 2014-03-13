class Api < Grape::API
  prefix 'api'
  
  mount Solife::Users
  mount Solife::Consumes
  mount Solife::Phone
end
