var errorHandler = (function () {
    function handleErrorResponse(errorResponse, $modal) {
        $modal.modal('toggle');
        $.each(errorResponse.data, function (field, errors) {
                $.each(errors, function (index, error) {
                        $.notify(
                            {
                                message: error
                            }, {
                                type: 'danger',
                                animate: {
                                    enter: 'animated fadeInDown',
                                    exit: 'animated fadeOutUp'
                                }
                            }
                        )
                    }
                )
            }
        )

    }

    return {
        handle: handleErrorResponse
    }
})();
//TODO alter this to edit forms instead of showing notifications