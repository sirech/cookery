module RecipesHelper
  def main_picture_tag(recipe, size = :medium)
    picture_tag recipe.picture, size
  end

  def picture_tag(picture, size = :medium)
    image_tag picture.photo.url(size)
  end

  def difficulty_tag(difficulty)
    to_label = {
      'easy' => 'success',
      'medium' => 'warning',
      'difficult' => 'important'
    }
    to_icon = {
      'easy' => 'icon-thumbs-up',
      'medium' => '',
      'difficult' => 'icon-thumbs-down'
    }
    content_tag(:div, class: 'span4') do
      content_tag(:span, difficulty, class: "pull-right label label-#{to_label[difficulty]}") +
      content_tag(:i, '', class: to_icon[difficulty])
    end
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
