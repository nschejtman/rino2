function ModalUI($modal) {
    //Dom vars
    this.$modal = $modal;
    this.$modalContent = this.$modal.find('.modal-dialog .modal-content');
    this.$modalTitle = this.$modalContent.find('.modal-header .modal-title');
    this.$modalFooter = this.$modalContent.find('.modal-footer');
    this.$modalConfirmButton = this.$modalFooter.find('.btn-primary');
    this.$modalDismissButton = this.$modalFooter.find('.btn-default');
    this.$modalConfirmButtonSpinner = this.$modalConfirmButton.find('img');

    //Aux vars
    this.isBlocked = false;

    this.blockConfirmButton = function () {
        this.isBlocked = true;
        this.$modalConfirmButton[0].disabled = 'disabled';
        this.$modalConfirmButtonSpinner.toggleClass('hidden', false);
    };

    this.unblockConfirmButton = function () {
        this.isBlocked = false;
        this.$modalConfirmButton[0].disabled = null;
        this.$modalConfirmButtonSpinner.toggleClass('hidden', true);
    };

    this.show = function () {
        this.$modal.modal('toggle', true);
    };

    this.close = function () {
        this.$modal.modal('toggle', false);
    };

    this.setTitle = function (title) {
        this.$modalTitle.html(title);
    };

    this.isVisible = function () {
        return this.$modal.is(":visible");
    };

    this.isConfirmButtonBlocked = function () {
        return this.isBlocked;
    };


}