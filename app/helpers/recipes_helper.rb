module RecipesHelper
  def main_picture_tag(recipe, size = :medium)
    picture_tag recipe.picture, size
  end

  def picture_tag(picture, size = :medium)
    image_tag picture.photo.url(size), class: 'picture img-responsive'
  end

  def difficulty_tag(difficulty, options = {})
    options = { class: '' }.merge(options)
    to_label = {
      'easy' => 'success',
      'medium' => 'warning',
      'difficult' => 'danger'
    }
    to_icon = {
      'easy' => 'glyphicon glyphicon-thumbs-up',
      'medium' => '',
      'difficult' => 'glyphicon glyphicon-thumbs-down'
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
      content_tag(:i, '', class: 'glyphicon glyphicon-time')
    end
  end

  def add_association_button(f, association)
    link_to_add_association f, association, class: 'btn btn-success',
                            force_non_association_create: f.object.send(association).any?,
                            'data-association-insertion-traversal' => 'siblings',
                            'data-association-insertion-node' => ".#{association}",
                            'data-association-insertion-method' => 'append' do
      content_tag(:i, '', class: 'icon-plus-sign icon-white') +
      association.to_s.singularize.titlecase
    end
  end
end
