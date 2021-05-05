FactoryBot.define do
  factory :history do
    product { nil }
    action { 1 }
    object { "MyString" }
    stocke_manager { nil }
    note { "MyText" }
  end
end
