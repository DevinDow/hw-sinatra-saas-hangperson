class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    #puts "HangpersonGame.word = #{word}"
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def word_with_guesses
    word_with_guesses = ''
    @word.each_char do |letter|
      if @guesses.include? letter 
        word_with_guesses.concat letter 
      else
        word_with_guesses.concat '-'
      end
    end
    return word_with_guesses  
  end
  
  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
    
  end
  

  def guess(letter)
    #puts "Guessed '#{letter}'"

    if letter.nil? or ! /^\w$/.match letter
      raise ArgumentError
    end
    
    letter = letter.downcase
    
    if @guesses.include? letter or @wrong_guesses.include? letter
      puts "Letter '#{letter}' already guessed : '#{guesses}' & '#{wrong_guesses}'"
      return false
    end
    
    if @word.include? letter
      guesses.concat letter
    else
      wrong_guesses.concat letter
    end
    
    return true
  end


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
