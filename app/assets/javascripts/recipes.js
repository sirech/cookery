(function() {

  var tracker = function(trigger_field, callback) {
    return {
      track: function(parent) {
        $(parent).find(trigger_field).on('cocoon:after-insert', function(e, insertedItem) {
          callback(insertedItem);
        });
      }
    };
  };

  var picker_start = function(field_to_watch, field_to_modify) {

    var names = [],
        ingredients = {};

    $.get('/ingredients', null, function(data) {

      // Store two things: The ingredient names and a map to get
      // the whole ingredient from the name
      $.each(data, function(i, ingredient) {
        names.push(ingredient.name);
        ingredients[ingredient.name] = ingredient;
      });
    });

    return {
      activate: function(ancestor) {
        $(ancestor).find(field_to_watch).typeahead({
          source: names,
          updater: function(item) {
            var id = ingredients[item].id;
            this.$element.nextAll(field_to_modify).val(id);
            return item;
          }
        });
      }
    };
  };

  var video_info = function(field_to_watch, field_to_modify) {

    var video_id = function(url) {
      var parts = url.split('/'),
          last = parts[parts.length - 1];

      last = last.replace('watch?v=', '');
      return last;
    };

    return {
      activate: function() {
        $(document).on('change', field_to_watch, function() {
          var video = $(this).val(),
              output = $(this).parent().find(field_to_modify);

          if(video == "") {
            output.html("");
          } else {
            $.ajax({
              url: 'http://gdata.youtube.com/feeds/api/videos/' + video_id(video) + '?v=2&alt=json-in-script',
              dataType: 'jsonp'})
              .done(function(data, status, xhr) {
                output.html(data.entry.title.$t);
              });
          }
        });
      }
    };
  };

  $(function() {
    $('*[rel=tooltip]').tooltip();

    // Typeahead for existing ingredients
    var picker = picker_start('.ingredient_picker', '.ingredient_picker_id');
    picker.activate('.quantity');
    // For new ingredients
    var find_ingredients = tracker('.quantities-container', picker.activate);
    find_ingredients.track('.steps-container');

    // Now the tricky part: When a step is added, we have to complete
    // the ingredient that appears as part of the step and also check
    // when new ingredients are added
    var find_steps = tracker('.steps-container', function(step) {
      find_ingredients.track(step);
      picker.activate(step);
    });
    find_steps.track('body');

    video_info('.video .video-input', '.video-output').activate();
  });
})();
