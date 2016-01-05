var errorHandler = (function () {
    function handleErrorResponse(errorResponse, $modal) {
        $modal.modal('toggle');
        $.each(errorResponse.data, function (field, errors) {
                $.each(errors, function (index, error) {
                        $.notify(
                            {
                                message: field + ":" + error
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
