FactoryGirl.define do
  factory :badge do
    sequence(:name) { |n| "Badge #{n}" }
    description "MyText"
    proposer_id 1
    status "MyString"
    proposal_date "2015-06-13"
    levels 1
    level_1 "MyText"
    level_2 "MyText"
    level_3 "MyText"
    level_4 "MyText"
    level_5 "MyText"
    level_6 "MyText"
    level_7 "MyText"
    level_8 "MyText"
    level_9 "MyText"
  end

end
