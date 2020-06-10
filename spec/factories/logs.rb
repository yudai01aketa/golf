FactoryBot.define do
  factory :log do
    content { "グリーンがかなり転がります" }
    association :course
  end
end
