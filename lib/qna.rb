require 'strscan'

class QnA

  attr_reader :questions, :answers

  def initialize(input, size=4)
    parse(standardize_input(input), size.to_i)
  end

  def standardize_input(input)
    @words_string = File.exists?(input) ? File.open(input).read : input
  end 

  def parse(word_string, size)
    @answers = []
    @questions = []
    word_scanner = StringScanner.new(word_string)
    word_string.split("\n").each do |word|
      (0..word.length-1).each do |i| 
        match = word[i..i+size-1]
        next if match.length < size
        word_scanner.reset
        regexp = Regexp.compile(match)
        word_scanner.scan_until(regexp)
        if !word_scanner.scan_until(regexp)
          @answers << word
          @questions << match
        end
      end
    end
    write_questions_and_answers
  end 

  def write_questions_and_answers
    File.open('answers.txt', 'w+') << @answers.join("\n")
    File.open('questions.txt', 'w+') << @questions.join("\n")
  end

end 

