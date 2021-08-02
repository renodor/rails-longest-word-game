require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    letters = params[:letters].split('')
    word = params[:word] || ''

    @is_from_original_grid = word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    @is_an_english_word = is_an_english_word?(word)
  end

  private

  def is_an_english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
