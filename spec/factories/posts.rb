FactoryBot.define do
  factory :post do
    title { "Sample Post Title" }
    content { "This is a sample post content." }
    association :user
  end
end
