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

    var error = function(data) {
      console.log(data);
    };

    return {
      observe: function() {
        $(send).click(function() {
          $(form).submit();
        });

        $(form)
          .bind('ajax:complete', function(e, xhr) {
            if(xhr.status == 0) {
              success(xhr.responseJSON);
            } else {
              error(xhr.responseJSON);
            }
          });
      }
    };
  };

  var stepUpdater = function(modal, steps_container) {

    field = $(steps_container).find('input');
    steps = [];
    ids = []

    return {
      observe: function() {
        $(modal)
          .on('step:created', function(e, data) {
            steps.push(data);
            $(steps_container).find('.accordion')
              .loadTemplate($('#step-template'), steps);
            ids.push(data.id)
            field.val(ids);
          });
      }
    };
  };

  $(function() {
    $('*[rel=tooltip]').tooltip();

    stepCreator('#add-step', '#add-step-confirm', '#add-step-form').observe();
    stepUpdater('#add-step', '#steps').observe();
  });
})();
