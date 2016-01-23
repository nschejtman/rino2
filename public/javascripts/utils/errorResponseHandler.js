var ErrorResponseHandler = (function () {
    function handle(errorResponse, errorHandler, modal) {
        $.each(errorResponse.data, function (field, errors){
            $.each(errors, function(pos, error){
                errorHandler.displayError(field, error);
            })
        });
        modal.unblockConfirmButton()

    }

    return {
        takeCareOfMyProblems : handle
    }
})();