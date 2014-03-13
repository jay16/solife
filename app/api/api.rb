class Api < Grape::API
  prefix 'api'
  
  mount Solife::Say
end
