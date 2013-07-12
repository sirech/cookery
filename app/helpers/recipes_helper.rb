module RecipesHelper
  def picture_tag(recipe, size=:medium)
    image_tag recipe.picture.photo.url(size), class: 'img-rounded'
  end

  def difficulty_tag(difficulty)
    to_label = {
      'easy' => 'success',
      'medium' => 'warning',
      'difficult' => 'important'
    }
    content_tag(:div,
      content_tag(:span, difficulty,
        class: "pull-right label label-#{to_label[difficulty]}"),
      class: 'span6')
  end

  def amount_tag(amount, unit)
    unit = unit.pluralize if amount > 1
    content_tag(:span,
      "#{amount} #{unit}",
      class: 'amount'
    )
  end

  def duration_tag(duration, options = {})
    options = { class: '' }.merge(options)
    content_tag(:div, class: "duration boxed #{options[:class]}") do
      content_tag(:span, distance_of_time_in_words(duration)) +
      content_tag(:i, '', class: 'icon-time')
    end
  end
end
