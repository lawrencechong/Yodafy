require 'pry'

class YodaCLI

  def welcome
     puts "This app will connect you to the infinite wisdom of the world through the expression of Yoda."
     puts "\nYoda knows all that needs to be known and due to a loophole in his contract, we can provide" + 
        "snippets of wisdom that can help you throughout your day."
     puts "\nWhat wisdom seek do you, young padawan, hmm?  Herh herh herh. ╰◝◟≖◞౪◟≖◞◜╯"
     run
   end

  def get_user_input
   gets.chomp.strip
  end

  def run
    puts "\nYou can search by keyword or by author name. If you need help, ask Yoda for 'help': "
    input = get_user_input
      if input == "help"

        help
      elsif input == "exit"
        exit
      else
        quotes_array = Quote_scraper.new.make_quotes(input)

        result = ""

        if quotes_array == []
          puts "\nFind what you were looking for sorry I could not.  This helps I hope.  Hmmmmmm."
          quotes_array = Quote_scraper.new.make_random("http://www.brainyquote.com/quotes_of_the_day.html")
        end

        quotes_array.each{ |auth|
        auth.quote.each{ |quotes|
          puts "\nquote: " + quotes #+ yoda.yoda_thinks(quotes)
          puts "author: " + auth.author 

          puts "\nHelp you understand, yoda can. If thinking too hard, yoda is, the program might crash.  Yes,Hmmmmmm.(Y/N)"
          result = get_user_input.downcase
          if result == "y"
            yodafy (quotes)
          end

          puts "\nNext Quote?(Y/N)"
          result = get_user_input.downcase
          if result == "n"
            run
          end
          }
        }

      end
    run
  end

  def yodafy (input)
    begin
      yoda = Yoda_Api_Caller.new
      yoda_quote = yoda.yoda_thinks(input)
      voice = Voice_Api.new
      voice.hear(voice.speak(yoda_quote))
    rescue 
      puts "Yoda crash. Yoda crash. Having a hard time getting information, yoda is.  Very sorry, yoda is.  Yeesssssss."
    end
  end

  def help
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
    #add more info later when we build more functionality
    run
  end

  def exit
    abort("May the force be with you! hmmm....")
  end

end