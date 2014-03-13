class API < Grape::API
  prefix 'api'
  
  mount Solife::Say
end
