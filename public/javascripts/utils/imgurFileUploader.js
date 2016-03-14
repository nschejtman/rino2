function ImgurUploader(input) {
    var path = 'https://api.imgur.com/3/image';
    var clid = '164cfffc417f8af';

    function fileTypeIsImage(file) {
        return !!(file.type.match(/image/) && file.type !== 'image/svg+xml');
    }

    function upload(callback) {
        var file = input.files[0];
        if (file == undefined) {
            throw new Error('No se ha seleccionado ninguna imágen');
        } else if (!fileTypeIsImage(file)) {
            throw new Error('El archivo seleccionado no es una imágen');
        } else {
            var xhttp = new XMLHttpRequest();
            xhttp.open('POST', path, true);
            xhttp.setRequestHeader('Authorization', 'Client-ID ' + clid);
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4) {
                    if (this.status >= 200 && this.status < 300) {
                        var response = '';
                        try {
                            response = JSON.parse(this.responseText);
                        } catch (err) {
                            response = this.responseText;
                        }
                        callback.call(window, response);
                    } else {
                        throw new Error(this.status + " - " + this.statusText);
                    }
                }
            };
            var data = new FormData();
            data.append('image', file);
            xhttp.send(data);
        }
    }

    return {
        upload: upload
    }
}
