require 'unirest'

class Yoda_Api_Caller 
  def yoda_thinks (input)
    string = input.gsub(/[ ]/, '+')
    response = Unirest.get "https://yoda.p.mashape.com/yoda?sentence=" + string,
      headers:{
        "X-Mashape-Key" => "5jcF3INh7Cmsh6NWPDhNVgelFa29p1D2PW1jsnE58XnyfawBHV",
        "Accept" => "text/plain"
      }

  return response.body
  end
end

