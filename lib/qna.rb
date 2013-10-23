require 'strscan'

class QnA

  attr_reader :questions, :answers

  def initialize(input, size=4, answers_outfile='answers.txt', questions_outfile='questions.txt')
    @answers, @questions = parse(standardize_input(input), size.to_i)
    write_questions_and_answers(@answers, @questions, answers_outfile, questions_outfile)
  end

  def standardize_input(input)
    File.exists?(input.to_s) ? File.open(input).read : input
  end 

  def parse(word_string, size)
    answers = []
    questions = []
    word_scanner = StringScanner.new(word_string)
    word_string.split("\n").each do |word|
      (0..word.length-1).each do |i| 
        match = word[i..i+size-1]
        next if match.length < size
        word_scanner.reset
        regexp = Regexp.compile(match)
        word_scanner.scan_until(regexp)
        if !word_scanner.scan_until(regexp)
          answers << word
          questions << match
        end
      end
    end
    [answers, questions]
  end 

  def write_questions_and_answers(answers, questions, answers_outfile, questions_outfile)
    File.open(answers_outfile, 'w+') << answers.join("\n")
    File.open(questions_outfile, 'w+') << questions.join("\n")
  end

end 

