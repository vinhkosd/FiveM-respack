/*
██╗      ██████╗ ██████╗ ██████╗  █████╗ ██╗  ██╗███████╗
██║     ██╔═══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗██╔╝██╔════╝
██║     ██║   ██║██████╔╝██████╔╝███████║ ╚███╔╝ ███████╗
██║     ██║   ██║██╔══██╗██╔══██╗██╔══██║ ██╔██╗ ╚════██║
███████╗╚██████╔╝██║  ██║██║  ██║██║  ██║██╔╝ ██╗███████║
╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
*/

		window.addEventListener('message', function(e) {
			if (e.data.displayWindow == 'true') {
				$("#vongxoaytichdiem").css('display', 'block');
				
				

			}else if (e.data.displayWindow == 'false') {
				
						$("#vongxoaytichdiem").css('display', 'none');
						

			}

		});

		
   		var hieu_ung = {
			'el': '#img_quay',
			'stop_point': null,
			'interval_id': null,
			'stop_index': {
				1:[355,356,357,358,369,0,1,2,3,4,5,6,7,8,9,10,11], //50 Vpoint
				2:[13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29], //20 Vpoint
				3:[31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47],  //5 Vpoint
				4:[49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65], //90 - Máº·t máº¿u , 210 - Máº·t cÆ°á»i
				5:[67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83],   //40 Vpoint
				6:[85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101], //10 Vpoint
				7:[103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119], //30 Vpoint				
				8:[121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138],
				9:[139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155],//10 Vpoint
		        10:[157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173],
		        11:[175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191],
		        12:[193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209],
		        13:[211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227],
				14:[229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245],
		        15:[247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263],
		        16:[265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281],
		        17:[283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299],
		        18:[301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317],
				19:[319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335],
		        20:[337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353]
		         // flower
			},
			'rotate_count': Config.rotateCount,
			'old_point' : {
				'check' : false,
				'value_old' : null,
				'value_new' : null
			},

			'play': function()
			{
				if (!this.stop_point)
					return;
				// if(this.old_point.check){
				// 	console.log(this.stop_point)
				// 	this.stop_point;
				// }
				if(this.old_point.value_old == null){
					this.old_point.value_old = this.old_point.value_new;
				}
				
				$(this).css('-webkit-transform', 'rotate('+this.old_point.value_old+'deg)');
				$(this).css('-moz-transform', 'rotate('+this.old_point.value_old+'deg)');
				$(this).css('transform', 'rotate('+this.old_point.value_old+'deg)');
				//console.log('GiÃ¡ trá»‹ v_old : ' + this.old_point.value_old);

				var v_old = this.old_point.value_old;
				var v_stop = this.stop_point;
				var element = this.el;
				var v_this = this;

				//setTimeout(function(){
					//console.log(this.old_point.value_old);
					//v_stop = v_stop + (360 - v_old);
					//console.log(this.stop_point);
					//console.log(v_stop)
					$(this.el).animate({  transform: v_stop }, {
					    step: function(now,fx) {
							fx.start = v_old;
							//console.log(now);
							// if(now == 0){
							// 	now = v_old;
							// }
							//cubic-bezier(1,0,0,1)
							if(now >= v_old){
								$(this).css('-webkit-transform','rotate('+now+'deg)'); 
								$(this).css('-moz-transform','rotate('+now+'deg)');
								$(this).css('transform','rotate('+now+'deg)');
							}
					    },
					    duration: Config.timeRotate
					}, 'cubic-bezier(0.54, 0.24, 0, 0.94)'
					);
				//},0)
				
			},
			'stop': function ()
			{
				$(this.el).stop();
			},
			'setStopPoint': function(params)
			{
				if(this.stop_point != null){
					this.old_point.check = true;
				}
				var arr_point = this.stop_index[params.coupon_id];
				
				
				console.log(this.stop_point)
				var valueArrPoint = arr_point[Math.floor(Math.random() * arr_point.length)];
				console.log('GiÃ¡ trá»‹ tá»a Ä‘á»™ : ' + valueArrPoint);
				console.log('random : ' + params.coupon_id);
				this.stop_point = this.rotate_count*360 + valueArrPoint;
				console.log(this.stop_point);
				if(this.old_point.check){
					if(this.old_point.value_old == null)
					this.old_point.value_old = this.old_point.value_new;
					this.old_point.value_new = valueArrPoint;
					console.log(this.old_point.value);
				}else{
					this.old_point.value_old = 0;
					this.old_point.value_new = valueArrPoint;
				}
			}
		};


        var isBusying = false;
		function kiemtracoin() {
			if (!isBusying){
			$.post("http://vongquaymayman/kiemtracoin",JSON.stringify({
									coin: 'true',
									
								}));
		}
		};
		window.addEventListener('message', function(e) {
			if (e.data.type == 'thanhcong') {
				quay();
				document.getElementById("nut").style.animationPlayState = "running";
			}else if(e.data.type == 'update'){
				document.getElementById("coin").innerHTML = "Coin: "+e.data.coin;
			}
		}
		);
		var percent = 100;
        function quay() {
            if (!isBusying) {
                //$('#img_quay').addClass('unlimit');
                isBusying = true;
				var lorraxs = Math.floor(Math.random() * 9999) + 1;
				var lorraxs2 = Math.floor(Math.random() * 5) + 1;
				console.log('Lorraxs : '+lorraxs);
				console.log('Lorraxs2 : '+lorraxs2);
				if(getRandom((15 * Config.slot15percent.length), 100)){
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.slot15percent[Math.floor(Math.random() * Config.slot15percent.length)],
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				}else if(getRandom((10 * Config.slot10percent.length), percent - (15 * Config.slot15percent.length))){
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.slot10percent[Math.floor(Math.random() * Config.slot10percent.length)],
							//"Name": 1,
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				}else if(getRandom((5 * Config.slot5percent.length), percent - (10 * Config.slot10percent.length))){
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.slot5percent[Math.floor(Math.random() * Config.slot5percent.length)],
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				}else if(getRandom(4 * Config.slot4percent.length, percent - 5 * Config.slot5percent.length)){
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.slot4percent[Math.floor(Math.random() * Config.slot4percent.length)],
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				}else if(getRandom(1 * Config.slot1percent.length, percent - 4 * Config.slot4percent.length)){
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.slot1percent[Math.floor(Math.random() * Config.slot1percent.length)],
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				}else if(getRandom(0.5 * Config.slot05percent.length, percent - 1 * Config.slot1percent.length)){
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.slot05percent[Math.floor(Math.random() * Config.slot05percent.length)],
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				}else if(getRandom(0.2 * Config.slot02percent.length, percent - 0.5 * Config.slot05percent.length)){
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.slot02percent[Math.floor(Math.random() * Config.slot02percent.length)],
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				}else if(getRandom(0.05 * Config.slot005percent.length, percent - 0.2 * Config.slot02percent.length)){
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.slot005percent[Math.floor(Math.random() * Config.slot005percent.length)],
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				}else if(getRandom(0.001 * Config.slot001percent.length, percent - 0.05 * Config.slot005percent.length)){
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.slot001percent[Math.floor(Math.random() * Config.slot001percent.length)],
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				}else if(getRandom(0.005 * Config.slot0005percent.length, percent - 0.001 * Config.slot001percent.length)){
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.slot0005percent[Math.floor(Math.random() * Config.slot0005percent.length)],
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				}else{
					var response = {
						"Successfully": true,
						"Status": null,
						"GiftPart": {
							"Id": 0,
							"Point": 16,
							"Name": Config.rest[Math.floor(Math.random() * Config.rest.length)],
							"Label": "30",
							"Frequency": 0,
							"CampaignId": null
						},
						"TotalPoint": 0
					}
				};
				console.log(response.GiftPart.Name);
                setTimeout(function(){
                	if(1 == 1){
                		if (response.Successfully) {
                            hieu_ung.setStopPoint({ 'coupon_id': response.GiftPart.Name });
                            //$('#img_quay').removeClass('unlimit');
                            $('#ketqua').html('.');
                            hieu_ung.play();
                            //setTimeout(function () { alert("ChÃºc má»«ng báº¡n Ä‘Ã£ Ä‘Æ°á»£c tÃ­ch " + response.Data.Name + " Ä‘iá»ƒm vÃ o tÃ i khoáº£n."); isBusying = false; }, 9000);
                            setTimeout(function () {
                                isBusying = false;
                                var messageResult = 'Báº¡n nháº­n Ä‘Æ°á»£c ';
                                /*
                                1:[0], //50 Vpoint
								2:[30], //20 Vpoint
								3:[60,180,300],  //5 Vpoint
								4:[90,210], //90 - Máº·t máº¿u , 210 - Máº·t cÆ°á»i
								5:[120],   //40 Vpoint
								6:[150], //10 Vpoint
								7:[240], //30 Vpoint
								8:[270], //10 Vpoint
						        9:[330]  // flower
						        */
								
                                switch(response.GiftPart.Name){
                                	case 1:
                                		messageResult = '1';
                                		break;
                                	case 2:
                                		messageResult = '2';
                                		break;
                                	case 3:
                                		messageResult = '3';
                                		break;
                                	case 4:
                                		messageResult = '4';
                                		break;
                                	case 5:
                                		messageResult = '5';
                                		break;
                                	case 6:
                                		messageResult = '6';
                                		break;
                                	case 7:
                                		messageResult = '7';
                                		break;
                                	case 8:
                                		messageResult = '8';
                                		break;
                                	case 9:
                                		messageResult = '9';
                                		break;
									case 10:
                                		messageResult = '10';
                                		break;
									case 11:
                                		messageResult = '11';
                                		break;
									case 12:
                                		messageResult = '12';
                                		break;
									case 13:
                                		messageResult = '13';
                                		break;
									case 14:
                                		messageResult = '14';
                                		break;
									case 15:
                                		messageResult = '15';
                                		break;
									case 16:
                                		messageResult = '16';
                                		break;
									case 17:
                                		messageResult = '17';
                                		break;
									case 18:
                                		messageResult = '18';
                                		break;
									case 19:
                                		messageResult = '19';
                                		break;
									case 20:
                                		messageResult = '20';
                                		break;
                                	default :
                                		messageResult = 'Error!';
                                		break;
                                }
                                $.post("http://vongquaymayman/quayxong",JSON.stringify({
									thongtin: messageResult,
									
								}));
								document.getElementById("nut").style.animationPlayState = "paused";
                            }, Config.timeRotate);
                        } else {
                            var messageResult = "KhÃ´ng thÃ nh cÃ´ng!";
                            // if (response.Status === "Campaign_DoAction_BeLimitedMaximumPlayInDay") {
                            //     messageResult = "<p>HÃ´m nay báº¡n Ä‘Ã£ tham gia vÃ²ng quay may máº¯n</p> <p class='strong-title'>Vui lÃ²ng quay láº¡i sau</p>";
                            // }
                            $('#ketqua').html(messageResult);
                            isBusying = false;
                        }
                	}else{
                		isBusying = false;
                	}
                },0)               
            }
        }
$(document).ready(function () {	
	$("body").on("keyup", function (key) {
		if (event.which == 27 || event.keyCode == 27) {
			closeInventory();
			return false;
		}
		return true;
});
});
function closeInventory() {
    $.post("http://vongquaymayman/NUIFocusOff", JSON.stringify({}));
};
function getRandom(r, p) {
	percent = p;
	var result = p * Math.random();
	if (result <= r){
		console.log(percent + " true")
		return true;
	}else{
		console.log(percent + " false")
		return false;
	};
	/* if(r<50){
		var c = r;
		var d = 100 - r;
		var e = gete(d, c);
		var f = c + e;
		var result = Math.floor(((100 * Math.random()) + e) / f);
		console.log(c);
		console.log(d);
		console.log(e);
		console.log(f);
		console.log(result);
		if (result === 0){
			return true;
		}else{
			return false;
		};
	}else{
		var c = 100 - r;
		var d = r;
		var e = gete(d, c);
		var f = c + e;
		var result = Math.floor(((100 * Math.random()) + e) / f);
		console.log(c);
		console.log(d);
		console.log(e);
		console.log(f);
		console.log(result);
		if (result === 0){
			return false;
		}else{
			return true;
		};
	}; */
};

function gete(d, c) {
	var e = d - 1 - c + 0.001;
	//console.log(e);
	return e;
};

function colorchange(e) {
        
            e.style.animationPlayState = 'running';

        
    };

