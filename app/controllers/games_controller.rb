class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample(1).join
    end
    @letters
  end

  def score
    @word = params['word'].downcase
    @grid = params['grid'].downcase

    if !english_word?(@word)
      @result = "Sorry but #{@word} is not an english word"
    elsif !word_in_grid?(@word, @grid)
      @result = "Sorry but #{@word} can't be build out of #{params['grid'].chars.join(', ')}"
    else
      @result = 'Well done buddy'
    end
  end

  private

  def word_in_grid?(word, grid)
    grid_arr = grid.split('')
    word.split('').each do |letter|
      if grid_arr.index(letter)
        grid_arr.delete_at(grid_arr.index(letter))
      else
        return false
      end
    end
  end

  def english_word?(word)
    # checker que le mot existe (sinon renvoyer 0 et une erreur)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    url_serialized = open(url).read
    word_dico = JSON.parse(url_serialized)
    word_dico['found']
  end
end
