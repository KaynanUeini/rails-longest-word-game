require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    answer = params[:user_answer].split("")
    given_letters = params[:sorted_letters].split("")

    x = []

    answer.each do |letter|
      if given_letters.include?(letter)
        x << letter
      end
    end

    if x.length != answer.length
      @score = 'You lost'
    else
      url = "https://wagon-dictionary.herokuapp.com/#{params[:user_answer]}"
      word_serialized = open(url).read
      word = JSON.parse(word_serialized)
      @score = (word["found"] ? "You won" : "You lost")
    end
  end
end
