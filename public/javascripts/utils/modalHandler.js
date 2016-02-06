function ModalUI($modal) {
    //Dom vars
    var $modalContent = $modal.find('.modal-dialog .modal-content');
    var $modalTitle = $modalContent.find('.modal-header .modal-title');
    var $modalFooter = $modalContent.find('.modal-footer');
    var $modalConfirmButton = $modalFooter.find('.btn-primary');
    var $modalDismissButton = $modalFooter.find('.btn-default');
    var $modalConfirmButtonSpinner = $modalConfirmButton.find('img');

    //Aux vars
    var isBlocked = false;

    //Bind events
    $modal.keyup(function (event) {
        if (event.keyCode == 13) {
            $modalConfirmButton.click();
        }
    });

    function blockConfirmButton() {
        isBlocked = true;
        $modalConfirmButton[0].disabled = 'disabled';
        $modalConfirmButtonSpinner.toggleClass('hidden', false);
    }

    function unblockConfirmButton() {
        isBlocked = false;
        $modalConfirmButton[0].disabled = null;
        $modalConfirmButtonSpinner.toggleClass('hidden', true);
    }

    function onClose(func) {
        $modal.on('hidden.bs.modal', func);
    }

    function onShow(func){
        $modal.on('shown.bs.modal', func);
    }

    function show() {
        $modal.modal('show');
    }

    function close() {
        $modal.modal('hide');
    }

    function setTitle(title) {
        $modalTitle.html(title);
    }

    function isVisible() {
        return $modal.is(":visible");
    }

    function isConfirmButtonBlocked() {
        return isBlocked;
    }

    this.blockConfirmButton = blockConfirmButton;
    this.unblockConfirmButton = unblockConfirmButton;
    this.show = show;
    this.close = close;
    this.isVisible = isVisible;
    this.setTitle = setTitle;
    this.isConfirmButtonBlocked = isConfirmButtonBlocked;
    this.onClose = onClose;
    this.onShow = onShow;


}