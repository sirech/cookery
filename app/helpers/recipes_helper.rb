module RecipesHelper
  def main_picture_tag(recipe, size = :medium)
    picture_tag recipe.picture, size
  end

  def picture_tag(picture, size = :medium)
    image_tag picture.photo.url(size)
  end

  def difficulty_tag(difficulty, options = {})
    options = { class: '' }.merge(options)
    to_label = {
      'easy' => 'success',
      'medium' => 'warning',
      'difficult' => 'important'
    }
    to_icon = {
      'easy' => 'icon-white icon-thumbs-up',
      'medium' => '',
      'difficult' => 'icon-white icon-thumbs-down'
    }

    content_tag(:span, class: "difficulty label label-#{to_label[difficulty]} #{options[:class]}") do
      content_tag(:span, difficulty) +
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
    content_tag(:div, class: "duration small-boxed pull-right #{options[:class]}") do
      content_tag(:span, distance_of_time_in_words(duration)) +
      content_tag(:i, '', class: 'icon-time')
    end
  end
end
