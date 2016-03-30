function TodDrawer() {

    var backgroundLayer = document.getElementById('background-layer');
    var textLayer = document.getElementById('text-layer');
    var $playerInputs = $('#team-of-the-day-container').find('input');

    function main() {
        //Check for support
        if (backgroundLayer.getContext && textLayer.getContext) {

            var backCtx = backgroundLayer.getContext('2d');
            var txtCtx = textLayer.getContext('2d');

            //improve definition
            backCtx.scale(2, 2);
            txtCtx.scale(2, 2);

            drawField(backCtx);

            drawPlayerCard(backCtx, 250, 45); //arquero
            drawPlayerCard(backCtx, 140, 120); //def izq
            drawPlayerCard(backCtx, 360, 120); //def der
            drawPlayerCard(backCtx, 140, 230); //med izq
            drawPlayerCard(backCtx, 360, 230); //med der
            drawPlayerCard(backCtx, 250, 310); //delantero

            //bind events
            $playerInputs.each(function (idx, input) {
                var $input = $(input);
                $input.keyup(function () {
                    redrawNames(txtCtx);
                });
            });
        } else {
            alert('No es posible crear el equipo del dia en este navegador! Por favor use Google Chrome');
        }
    }

    function draw(playerArray) {
        redrawNames(textLayer.getContext('2d'), playerArray);
    }


    function redrawNames(ctx, playerArray) {
        ctx.clearRect(0, 0, textLayer.width, textLayer.height);

        //if does not provide an array, extract from inputs
        if (playerArray == undefined) {
            $playerInputs.each(function (idx, input) {
                var $input = $(input);
                drawPlayerName(ctx, idx + 1, $input.val());
            });
        } else {
            var nOfPlayers = playerArray.length;
            if (nOfPlayers != 6) {
                notificationHandler.notifyError("Hay un problema con el equipo actual. Requerir asistencia.");
            } else {
                playerArray.forEach(function(playerName, idx){
                    drawPlayerName(ctx, idx + 1, playerName);
                });
            }
        }

    }

    function drawField(ctx) {
        //Basic shape
        ctx.beginPath();
        ctx.moveTo(100, 20);
        ctx.lineTo(20, 380);
        ctx.lineTo(480, 380);
        ctx.lineTo(400, 20);
        ctx.closePath();
        var grd = ctx.createRadialGradient(250, 180, 80, 250, 180, 300);
        grd.addColorStop(0, "#79AF51");
        grd.addColorStop(1, "#2D561E");
        ctx.fillStyle = grd;
        ctx.fill();
        ctx.stroke();

        ctx.strokeStyle = 'white';
        ctx.lineWidth = 2;

        //Middle line
        ctx.beginPath();
        ctx.moveTo(65, 180);
        ctx.lineTo(435, 180);

        //Back area
        ctx.moveTo(160, 21);
        ctx.lineTo(150, 80);
        ctx.lineTo(350, 80);
        ctx.lineTo(340, 21);

        //Front area
        ctx.moveTo(100, 379);
        ctx.lineTo(120, 280);
        ctx.lineTo(380, 280);
        ctx.lineTo(400, 379);
        ctx.stroke();
        ctx.save();

        //Center circle
        ctx.translate(250, 180);
        ctx.scale(1.5, 1);
        ctx.beginPath();
        ctx.arc(0, 0, 50, 0, Math.PI * 2, false);
        ctx.restore();
        ctx.stroke();
    }

    function drawPlayerCard(ctx, x, y) {
        ctx.save();
        ctx.translate(x, y);

        var grd = ctx.createLinearGradient(0, 0, 0, 80);
        grd.addColorStop("0", "#C89520");
        grd.addColorStop("0.5", "#E0C82A");
        grd.addColorStop("1.0", "#DFAB2D");

        var gradient = ctx.createLinearGradient(0, 0, 600, 0);
        gradient.addColorStop("0", "#EEE35C");
        gradient.addColorStop("0.1", "#BB7221");
        gradient.addColorStop("1.0", "#D7B832");

        ctx.fillStyle = grd;
        ctx.strokeStyle = gradient;
        ctx.lineWidth = 5;

        ctx.beginPath();
        ctx.moveTo(-45, -35.5);
        ctx.lineTo(-45, 35.5);
        ctx.lineTo(0, 50);
        ctx.lineTo(45, 35.5);
        ctx.lineTo(45, -35.5);
        ctx.closePath();
        ctx.stroke();
        ctx.fill();

        ctx.restore();
    }

    function drawPlayerName(ctx, pos, name) {
        ctx.save();
        ctx.font = '16px Arial';
        ctx.textAlign = 'center';
        ctx.fillStyle = 'white';
        ctx.shadowColor = 'black';
        ctx.shadowOffsetX = 1;
        ctx.shadowOffsetY = 1;
        ctx.shadowBlur = 10;
        switch (pos) {
            case 1:
                wrapText(ctx, name, 252, 45);
                break;
            case 2:
                wrapText(ctx, name, 142, 120);
                break;
            case 3:
                wrapText(ctx, name, 362, 120);
                break;
            case 4:
                wrapText(ctx, name, 142, 230);
                break;
            case 5:
                wrapText(ctx, name, 362, 230);
                break;
            case 6:
                wrapText(ctx, name, 252, 310);
                break;
            default:
                console.log('The selected position does not exist');
        }
        ctx.restore();
    }

    function wrapText(ctx, text, x, y) {
        var maxWidth = 60;
        var lineHeight = 18;
        var auxText = text.toUpperCase();
        var words = auxText.split(' ');
        var line = '';
        for (var n = 0; n < words.length; n++) {
            var testLine = line + words[n] + ' ';
            var metrics = ctx.measureText(testLine);
            var testWidth = metrics.width;
            if (testWidth > maxWidth && n > 0) {
                ctx.fillText(line, x, y);
                line = words[n] + ' ';
                y += lineHeight;
            }
            else {
                line = testLine;
            }
        }
        ctx.fillText(line, x, y);
    }

    main();

    return {
        draw: draw
    }
}