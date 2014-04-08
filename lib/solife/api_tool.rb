#encoding: utf-8
require 'base64'

#		email = "i_am_jay@solife.us"
#		pwd   = "hello world"
<<<<<<< HEAD
#		dd = Solife::ApiTool.encode(email,pwd)
=======
#
#		dd = SOLife::ApiTool.encode(email,pwd)
>>>>>>> 0962647787fdc6e198dc1c52e3c02e67807e5c79
#		puts dd
#		puts "*"*10
#		kk = SOLife::ApiTool.decode(dd).join("-")
#		puts kk

<<<<<<< HEAD
module Solife
=======
module SOLife
>>>>>>> 0962647787fdc6e198dc1c52e3c02e67807e5c79
  class ApiTool
    class << self


		def encode(a,b)
		  k_1 = (a.length > b.length ? 1 : 0)
		  k_2 = (k_1 == 1 ? b.length : a.length)
		  kk = "#{k_1}#{k_2.to_s.length}#{k_2}"+(k_1 == 1 ? _merge(a,b) : _merge(b,a))
          Base64.encode64(kk)
		end

		def _merge(a,b)
		  i, array = 0, []
		  a.each_char do |c|
		   array.push c
		   array.push b[i]
		   i += 1  
		  end
		  return array.join
		end


		def decode(d)
		  dd = Base64.decode64(d)

		  k_1 = dd[0].to_i
		  k_2 = dd[1].to_i
		  k_3 = dd[2...k_2+2].to_i

		  i, a, b = 0, "", ""
		  dd[2+k_2,dd.size-1].to_s.each_char do |c|
		    a << c if i%2 == 0 or i > k_3*2 
		    b << c if i <= k_3*2 and i%2 == 1
		    i += 1
		  end
		  k_1 == 1 ? [a, b] : [b, a]
		end

    end
  end
end
