'use strict';
$(document).ready(function () {
    window.addEventListener("message", function(StateToContent) {
        if (StateToContent.data.type == "shop") {
            $("#wrapper").show("fast");

            var paddingBottom = 750;
            if (StateToContent.data.result.length > 10) {

                for (var i = 0; i < (StateToContent.data.result.length - 10) / 5; i++) {

                    paddingBottom = paddingBottom + 375;
                }
            }
            if (StateToContent.data.pos == "getVehicle") {//lấy xe gara
                for (var i = 0; i < StateToContent.data.result.length; i++) {

                    var engineHealthPercent = Math.floor(StateToContent.data.result[i].engineHealth / 1E3 * 100);

                    var bodyHealthPercent = Math.floor(StateToContent.data.result[i].bodyHealth / 1E3 * 100);

                    if (StateToContent.data.result[i].state == "1") {//xe trong garage
                        $("#wrapper").append(
                            '<div class = "image" id = ' + StateToContent.data.result[i].vehicle + 
                            " label = " + StateToContent.data.result[i].name + 
                            " plate = " + StateToContent.data.result[i].plate + 
                            " state = " + StateToContent.data.result[i].state + 
                            " garage = " + StateToContent.data.result[i].garage + 
                            " KindOfVehicle = " + StateToContent.data.result[i].KindOfVehicle +
                            `>
                            <h3 class = "h4">🚘 ` + StateToContent.data.result[i].name + 
                            `</h3>
                            <h4 class = "h4" style = "color : #42f54b;">🚧 Trong Garage</h4>
                            
                            <h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">` + StateToContent.data.result[i].plate +
                            `</span></h5><h5 class = "h4">Động cơ: ` + engineHealthPercent +
                            "% Thân xe: " + bodyHealthPercent +
                            `%</h5>
                            <div style = " margin-top: 3.704vh">
                            <button class = "button" id="buybutton" plate = "${StateToContent.data.result[i].plate}" number = ` + i + ` style = "style= width: 70px"> Lấy xe</button>
                            
                            <button class = "button" id = "changename" number = ` + i +` style = "style=  width: 70px"> Đổi Tên</button>
                            
                            </div>
                            
                            </div>`
                        );
                    } else {//xe ngoài garage
                        $("#wrapper").append(
                            '<div class = "image" id = ' + StateToContent.data.result[i].vehicle + 
                            " label = " + StateToContent.data.result[i].name + 
                            " plate = " + StateToContent.data.result[i].plate + 
                            " state = " + StateToContent.data.result[i].state + 
                            " garage = " + StateToContent.data.result[i].garage + 
                            " KindOfVehicle = " + StateToContent.data.result[i].KindOfVehicle + 
                            `>
                            <h3 class = \"h4\">🚘 ` + StateToContent.data.result[i].name + `</h3>
                            <h4 class = "h4" style = "color : #ed1325;">🚧 Ngoài Garage</h4>
                            <h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">` + StateToContent.data.result[i].plate + 
                            `</span></h5>
                            <h5 class = "h4">Động cơ: ` + engineHealthPercent + 
                            "% Thân xe: " + bodyHealthPercent + `%</h5>
                            <div style = " margin-top: 3.704vh">
                            <button class = "button" id = "buybutton" plate = "${StateToContent.data.result[i].plate}" number = ` + i + ` style = "style= width: 70px"> Chuộc xe (${StateToContent.data.price}$)</button>  
                            <button class = "button" id = "changename" number = ` + i + ` style = "style=  width: 70px"> Đổi Tên</button>
                            </div>
                            </div>`
                        );
                    }
                }
            } else {//chuộc xe gara
                for (var i = 0; i < StateToContent.data.result.length; i++) {
                    engineHealthPercent = Math.floor(StateToContent.data.result[i].engineHealth / 1E3 * 100);

                    bodyHealthPercent = Math.floor(StateToContent.data.result[i].bodyHealth / 1E3 * 100);

                    $("#wrapper").append(
                        '<div class = "image" id = ' + StateToContent.data.result[i].vehicle + 
                        " label = " + StateToContent.data.result[i].name + 
                        " plate = " + StateToContent.data.result[i].plate + 
                        " state = " + StateToContent.data.result[i].state + 
                        " garage = " + StateToContent.data.result[i].garage + 
                        " KindOfVehicle = " + StateToContent.data.result[i].KindOfVehicle + 
                        `>
                        <h3 class = \"h4\">🚘 ` + StateToContent.data.result[i].name + `</h3>
                        <h4 class = "h4" style = "color : #42f54b;">🚧 Trong Garage</h4>
                        <h5 class = "h4">💳 Biển Số: <span style="color: #03adfc">` + StateToContent.data.result[i].plate + `</span></h5>
                        <h5 class = "h4">Động cơ: ` + engineHealthPercent + "% Thân xe: " + bodyHealthPercent + `%</h5>
                        <div style = " margin-top: 3.704vh">
                        <button class = "button" id = "buybutton" plate = "${StateToContent.data.result[i].plate}" number = ` + i + ` style = "style= width: 3.646vw">Chuộc xe</button>
                        <button class = "button" id = "changename" number = ` + i + ` style = "style=  width: 3.646vw"> Đổi Tên</button>
                        </div></div>`
                    );
                }
            }
            $("#wrapper").append(' <h6 class = "h4" style = "right: 47.125%; position: absolute;" bottom = ' + (paddingBottom - 5) + "></h6>");
            if (StateToContent.data.owner == true) {
                $("#wrapper").append(`<button class = "button" id = "bossactions" style = "position: absolute; right: 15px; top: 5px;">Boss actions</button>`);
            }

            $("body").on("click", "#changename", function() {
                var last_fn = $(this).attr("number");
                var plate = StateToContent.data.result[last_fn].plate;
                $.post("http://lorraxs_garage/changeName", JSON.stringify({
                    "plate": plate
                }));
                location.reload(true);
                $("#wrapper").hide("fast");
            });
            $("body").on("click", "#buybutton", function() {
                var i = $(this).attr("number");
                var plate = $(this).attr("plate");
                var vehicle = StateToContent.data.result[i].vehicle;
                var audioOffsetX = StateToContent.data.result[i].x;
                var nodeTly = StateToContent.data.result[i].y;
                var v2Z = StateToContent.data.result[i].z;
                var Heading = StateToContent.data.result[i].Heading;
                var _0xde8910 = StateToContent.data.result[i].KindOfVehicle;
                var volumeState = StateToContent.data.result[i].state;
                var jiveUser = StateToContent.data.result[i].engineHealth;
                var workerstats = StateToContent.data.result[i].bodyHealth;
                // if (volumeState == "1" || StateToContent.data.pos == "returnVehicle") {
                    $.post("http://lorraxs_garage/spawnVehicle", JSON.stringify({
                        "vehicle": vehicle,
                        "x": audioOffsetX,
                        "y": nodeTly,
                        "z": v2Z,
                        "Heading": Heading,
                        "KindOfVehicle": _0xde8910,
                        "engineHealth": jiveUser,
                        "bodyHealth": workerstats,
                        "plate": plate
                    }));
                    $.post("http://lorraxs_garage/escape", JSON.stringify({}));
                    location.reload(true);
                    $("#wrapper").hide("fast");
                // } else {
                //     $.post("http://lorraxs_garage/notify", JSON.stringify({
                //         "msg": "Xe của bạn đã mất"
                //     }));
                // }
            });
            $("body").on("click", "#bossactions", function() {
                $.post("http://lorraxs_garage/bossactions", JSON.stringify({}));
                $.post("http://lorraxs_garage/escape", JSON.stringify({}));
                location.reload(true);
                $.post("http://lorraxs_garage/emptycart", JSON.stringify({}));
                $("#wrapper").hide("fast");
                $("#payment").hide("fast");
                $("#cart").hide("fast");
            });
        }
    });

    document.onkeyup = function(event) {
        if (event.which == 27) {
            $.post("http://lorraxs_garage/escape", JSON.stringify({}));
            location.reload(true);
            $.post("http://lorraxs_garage/emptycart", JSON.stringify({}));
            $("#wrapper").hide("fast");
            $("#payment").hide("fast");
            $("#cart").hide("fast");
        }
    };
});