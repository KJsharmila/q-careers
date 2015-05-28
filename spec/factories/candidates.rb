FactoryGirl.define do

  sequence(:name) {|n| "candidate#{n}" }
  sequence(:email) {|n| "candidate.#{n}@domain.com" }

  factory :candidate do
    name "Nayana"
    email "nayana@gmail.com"
    phone "9101214242"
    current_city "Mysore"
    native_city "Davangere"
    skills "C, C++, Java, HTML5, CSS3"
    resume { Rack::Test::UploadedFile.new('test/fixtures/test.pdf', 'test.pdf') }
  end

  factory :fresher, parent: :candidate do
    type "Fresher"
    year_of_passing { Fresher::YEAR_OF_PASSING_LIST.sample }
  end

  factory :experienced, parent: :candidate do
    type "Experienced"
    experience_in_years { Experienced::YEARS_LIST.sample }
  end

end
