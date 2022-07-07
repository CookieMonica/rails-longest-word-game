require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters].delete(" ")
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    user_serialized = URI.open(url).read
    result = JSON.parse(user_serialized) # Ruby object
    if result["found"] == false
      @display = "Sorry but #{@answer} does not seem to be a valid English word..."
    elsif @letters.include?(@answer) == false
      @display = "Sorry but #{@answer} can´t be built out of #{@letters}"
    elsif result["found"] && @letters.include?(@answer)
      @display = "Congratulations! #{@answer} is a valid word"
    end
  end
end
