var ErrorResponseHandler = (function () {
    function displayInForm(errorResponse, errorHandler, modal) {
        $.each(errorResponse.data, function (field, errors){
            $.each(errors, function(pos, error){
                errorHandler.displayError(field, error);
            })
        });
        modal.unblockConfirmButton()

    }

    function notify(errorResponse, notificationHandler, modal){
        $.each(errorResponse.data, function (field, errors){
            $.each(errors, function(pos, error){
                notificationHandler.notifyError(error);
            })
        });
        if (modal != null && modal != undefined){
            modal.unblockConfirmButton()
        }
    }

    return {
        displayInForm : displayInForm,
        notify : notify
    }
})();