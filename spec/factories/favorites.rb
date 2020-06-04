FactoryBot.define do
  factory :favorite do
    association :course
    association :user
  end
end
