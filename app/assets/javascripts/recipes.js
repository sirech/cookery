(function() {

  var stepCreator = function(modal, send, form) {

    var success = function(data) {
      // $(this).each(function(){
      //   this.reset();
      // });
      $(modal)
        .trigger('step:created', data)
        .modal('hide');
    };

    var error = function(status, data) {
      console.log(status + " " + data);
    };

    return {
      observe: function() {
        $(send).click(function() {
          $(form).submit();
        });

        $(form)
          .bind('ajax:complete', function(e, xhr) {
            if(xhr.status <= 300) {
              success(xhr.responseJSON);
            } else {
              error(xhr.status, xhr.responseJSON);
            }
          });
      }
    };
  };

  var stepUpdater = function(modal, steps_container) {

    var field = $(steps_container).find('input');
    var steps = [];
    var ids = [];

    return {
      observe: function() {
        $.addTemplateFormatter({
          ingredients: function (value, template) {
            list = '';
            $.each(value, function(index, ingredient) {
              list += $('<li></li>').html(ingredient.name).prop('outerHTML');
            });
            return list;
          }
        });

        $(modal)
          .on('step:created', function(e, data) {
            steps.push(data);
            $(steps_container).find('.accordion')
              .loadTemplate($('#step-template'), steps);
            ids.push(data.id);
            field.val(ids);
          });
      }
    };
  };

  var ingredientPicker = function(ingredients_field, selected) {

    var container = $(selected);
    var field = $(ingredients_field);
    var ingredients = [];
    var add_ingredient = function(ingredient) {
      if($.inArray(ingredient, ingredients) != -1) {
        return;
      }

      ingredients.push(ingredient);
      container.find('input').val(ingredients);
      container.append(
        $("<span></span")
          .html(ingredient)
          .addClass('badge badge-info'));
    };

    var create_ingredient = function() {
      var ingredient = field.find('#ingredients').val();
      $.post('/ingredients', { ingredient: { name: ingredient }})
        .done(function(data) {
          add_ingredient(data.name);
        });
      field.find('#ingredients').val('');
    };

    return {
      observe: function() {

        $.get('/ingredients', null, function(data) {
          var ingredients = $.map(data, function(ingredient) {
            return ingredient.name;
          });

          field.find('#ingredients').typeahead({
            source: ingredients,
            updater: function(item) {
              add_ingredient(item);
              return '';
            }
          });
        });

        field.find('button').on('click', function() {
          create_ingredient();
        });

        $(ingredients_field).on('keypress', function(e) {
          if(e.which == 13) {
            create_ingredient();
          }
        });
      }
    };
  };

  $(function() {
    $('*[rel=tooltip]').tooltip();

    stepCreator('#add-step', '#add-step-confirm', '#add-step-form').observe();
    stepUpdater('#add-step', '#steps').observe();
    ingredientPicker('#ingredients-group', '#selected-ingredients').observe();
  });
})();
