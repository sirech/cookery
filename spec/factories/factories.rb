FactoryGirl.define do
  factory :category do
    name 'spanish'
  end

  factory :ingredient do
    sequence(:name) { |n| "Ingredient[#{n}]" }
    found_at 'Rewe'

    factory :ingredient_water do
      name 'water'
      found_at 'faucet'
    end
  end

  factory :step do
    factory :step_last do
      name 'rest'
      duration 5.minutes
    end

    factory :step_cook do
      name 'cook'
      duration 15.minutes

      ingredients { FactoryGirl.create_list(:ingredient, 5) }

      after :build do |step|
        step.children << FactoryGirl.build(:step_last)
      end
    end

    factory :step_first do
      name 'prepare'
      duration 10.minutes

      ingredients { [FactoryGirl.create(:ingredient_water)] }

      after :build do |step|
        step.children << FactoryGirl.build(:step_cook)
      end
    end
  end
end
