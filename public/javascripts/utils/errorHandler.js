function UIErrorHandler($form) {

    function displayError(field, error) {
        var $formInput = $form.find('[name=' + field + ']');
        var $formGroup = $formInput.parent('.form-group');
        var $crossIcon = $formGroup.find('.form-control-feedback');
        $formGroup.toggleClass("has-error", true);
        $formGroup.toggleClass("has-feedback", true);
        $crossIcon.toggleClass("hidden", false);
        $formGroup.append($('<span class="help-block">' + error + '</span>'));
    }

    function clearErrors(field) {
        var $formInput = $form.find('input[name=' + field + ']');
        var $formGroup = $formInput.parent('.form-group');
        var $crossIcon = $formGroup.find('.form-control-feedback');
        $formGroup.toggleClass("has-error", false);
        $formGroup.toggleClass("has-feedback", false);
        $crossIcon.toggleClass("hidden", true);
        $formGroup.find('.help-block').each(function () {
            this.remove()
        });
    }

    function clearAllErrors() {
        var $inputs = $form.find('input');
        $.each($inputs, function (pos, input) {
            clearErrors($(input).attr('name'));
        });

    }

    this.displayError = displayError;
    this.clearErrors = clearErrors;
    this.clearAllErrors = clearAllErrors;

}