function UIErrorHandler ($form) {

    this.displayError = function(field, error) {
        var $formInput = $form.find('input[name=' + field + ']');
        var $formGroup = $formInput.parent('.form-group');
        var $crossIcon = $formGroup.find('.form-control-feedback');
        $formGroup.toggleClass("has-error", true);
        $formGroup.toggleClass("has-feedback", true);
        $crossIcon.toggleClass("hidden", false);
        $formGroup.append($('<span class="help-block">' + error + '</span>'));
    };

    this.clearErrors = function(field){
        var $formInput = $form.find('input[name=' + field + ']');
        var $formGroup = $formInput.parent('.form-group');
        var $crossIcon = $formGroup.find('.form-control-feedback');
        $formGroup.toggleClass("has-error", false);
        $formGroup.toggleClass("has-feedback", false);
        $crossIcon.toggleClass("hidden", true);
        $formGroup.find('.help-block').each(function(){this.remove()});
    };

    this.clearAllErrors = function(){
        var $inputs = $form.find('input');
        $.each($inputs, function(pos, input){
            var $formInput = $form.find('input[name=' + $(input).attr("name") + ']');
            var $formGroup = $formInput.parent('.form-group');
            var $crossIcon = $formGroup.find('.form-control-feedback');
            $formGroup.toggleClass("has-error", false);
            $formGroup.toggleClass("has-feedback", false);
            $crossIcon.toggleClass("hidden", true);
            $formGroup.find('.help-block').each(function(){this.remove()});
            //this.$rootScope.clearErrors($(input).attr('name'));
        });

    }

}