
require 'nokogiri'
require 'open-uri'
require 'pry'

class Quote_scraper

  def make_quotes (input)

    query = input.gsub(/[ ]/, '+')
    url = "http://www.brainyquote.com/search_results.html?q=" + query
    html = open(url)
    brainyquote_html = Nokogiri::HTML(html)

    quotes = []

    brainyquote_html.css("div.clearfix").each do |info|
      quote = info.css("div.boxyPaddingBig span a").text
      author = info.css("div.boxyPaddingBig div a").text

      author_exist = false
      quotes.each{ |auth|
        if auth.author == author
          auth.quote << quote
          author_exist = true
          break
        end
      }

      if !author_exist
        quotes <<  Author.new(quote, author)
      end
    end
    return quotes
  end

  def make_random (url)
    html = open(url)
    brainyquote_html = Nokogiri::HTML(html)

    quotes = []

    brainyquote_html.css("div.boxy.bqQt.bqShare").each do |info|
      quote = info.css("div.boxyPaddingBig span a").text
      author = info.css("div.boxyPaddingBig div a").text

      author_exist = false
      quotes.each{ |auth|
        if auth.author == author
          auth.quote << quote
          author_exist = true
          break
        end
      }

      if !author_exist
        quotes <<  Author.new(quote, author)
      end
    end
    return quotes
  end

end