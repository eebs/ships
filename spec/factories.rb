FactoryGirl.define do
  factory :character do
    sequence(:name) { |n| "example_name#{n}" }
    password "secret"
    admin false
    
    factory :admin do
      admin true
    end
  end
end