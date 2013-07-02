module RecipesHelper
  def difficulty_tag difficulty
    to_label = {
      'easy' => 'success',
      'medium' => 'warning',
      'difficult' => 'important'
    }
    content_tag(:div,
      content_tag(:span, difficulty, class: "pull-right label label-#{to_label[difficulty]}"),
      class: 'span6')
  end
end
