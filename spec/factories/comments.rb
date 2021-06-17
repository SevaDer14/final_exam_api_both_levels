FactoryBot.define do
  factory :comment do
    body { "MyString" }
    association :user
    association :article
  end
end
