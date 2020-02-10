require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
  end

  def score
    @word = params[:word]
    @result = false
    @answer = ''
    @word_count = @word.upcase.chars.all? { |letter| @word.upcase.count(letter) <= 10 }
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    serialised_def = open(url).read
    definition = JSON.parse(serialised_def)
    @word_api = definition["found"]
    @valid_word = @word_count && @word_api
    if @valid_word
      @result = true
      @answer = "Bravo, t'as trouvé #{@word}, un mot anglais pour une fois"
    elsif !@word_count
      @answer = "T'as triché lol"
    else
      @answer = "#{@word} ? T'as trouvé ça où ? Arrête de jouer t'es désespérant..."
    end
  end
end
