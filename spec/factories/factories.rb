FactoryGirl.define do
  factory :ingredient do
    sequence(:name) { |n| "Ingredient[#{n}]" }
    found_at 'Rewe'

    factory :ingredient_water do
      name 'water'
      found_at 'faucet'
    end
  end

  factory :category do
    sequence(:name) { |n| "Category[#{n}]" }
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

  factory :recipe do
    sequence(:name) { |n| "Recipe[#{n}]" }
    difficulty 'medium'

    categories { FactoryGirl.create_list(:category, 3) }

    first_step { FactoryGirl.create(:step_last) }

    factory :recipe_multi_step do
      first_step { FactoryGirl.create(:step_first) }
    end

    after :build do |r|
      r.steps.map do |step|
        step.recipe = r
        step.save
      end
    end
  end
end
