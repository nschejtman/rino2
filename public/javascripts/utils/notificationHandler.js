var notificationHandler = (function () {
    function notifySuccess(message) {
        $.notify(
            {
                message: message
            }, {
                type: 'success',
                animate: {
                    enter: 'animated fadeInDown',
                    exit: 'animated fadeOutUp'
                }
            }
        )
    }

    function notifyError(message) {
        $.notify(
            {
                message: message
            }, {
                type: 'danger',
                animate: {
                    enter: 'animated fadeInDown',
                    exit: 'animated fadeOutUp'
                }
            }
        )
    }

    return {
        notifySuccess: notifySuccess,
        notifyError: notifyError
    }
})();