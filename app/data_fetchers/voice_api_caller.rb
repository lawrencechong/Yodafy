require 'pry'
VAAS_APPLICATION = "EVAL_1657340"
VAAS_URL = "http://vaas.acapela-group.com/Services/Synthesizer"
VAAS_LOGIN = "EVAL_VAAS"
VAAS_PASSWORD = "la5fcj4b"

require 'net/http'
require 'uri'
require 'cgi'
require 'open-uri'
require 'launchy'

class Voice_Api
  def speak(text, voice="rachel22k")
    
    hash = {"prot_vers" => "2", "cl_env" => "APACHE_2.2.9_PHP_5.5", "cl_vers" => "1-00", "cl_login" => VAAS_LOGIN,
            "cl_app" => VAAS_APPLICATION, "cl_pwd" => VAAS_PASSWORD, "req_voice" => voice, 
            "req_text" => text}

    url = URI.parse(VAAS_URL)
    res = Net::HTTP.post_form(url, hash)
    
    res.body.split("&").map{|pair| 
      if pair.split("=")[0] == "snd_url"
        return pair.split("=")[1]
      end}
  end

  # Not Used
  # def download_mp3(url)
  #   uri = URI.parse(url)
  #   Net::HTTP.start(uri.host){ |http|
  #     resp = http.get(uri.path)
  #     ret_file = File.new("short-#{(1000 * Time.now.utc.to_f).to_i}.mp3", "wb")
  #     ret_file.write(resp.body)
  #     ret_file.rewind
  #     ret_file
  #   }
  # end

  def hear(url)
    #Launchy.open("http://vaas.acapela-group.com/MESSAGES/009086065076095086065065083/EVAL_1657340/sounds/498951041_dbb84414f7295.mp3")
    Launchy.open(url)
  end

end
