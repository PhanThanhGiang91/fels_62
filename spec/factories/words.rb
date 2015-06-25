FactoryGirl.define do
  factory :word do
    category
    content Faker::Lorem.word

    factory :word_with_4_answer_sheets do
      after :create do |word|
        4.times do
          create :answers, word: word
        end
      end
    end
  end
end
