require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'qna'

describe QnA, "the Question and Answer parser" do

  describe "when run against a words list" do
      
    let(:word_list) { File.open('test/fixtures/test-words.txt').read }
    let(:qna) { QnA.new(word_list, 4, 'tmp/answers.txt', 'tmp/questions.txt') }
    
    it ":answers should be an array" do
      assert qna.answers.is_a?(Array)
    end

    it ":questions should be an array" do
      assert qna.questions.is_a?(Array)
    end

    it ":questions should include 'syzy'" do
      assert qna.questions.include?("syzy")
    end

    it ":questions should not include 'summ'" do
      assert !qna.questions.include?("summ")
    end

    it ":questions should not include 'suit'" do
      assert !qna.questions.include?("suit")
    end

  end 

  describe "when run against the full words list" do
      
    let(:word_list) { File.open('test/fixtures/words.txt').read }
    let(:qna) { QnA.new(word_list, 4, 'tmp/answers.txt', 'tmp/questions.txt') }
    
    it ":questions should include 'syzy'" do
      assert qna.questions.include?("syzy")
    end

    it ":questions should not include 'summ'" do
      assert !qna.questions.include?("summ")
    end

    it ":questions should not include 'suit'" do
      assert !qna.questions.include?("suit")
    end

  end 

  after do
    `rm tmp/questions.txt`
    `rm tmp/answers.txt`
  end 

end 
