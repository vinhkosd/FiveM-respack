Object.prototype.addMultiListener = function(eventNames, listener) {
	var events = eventNames.split(' ');

	if (NodeList.prototype.isPrototypeOf(this) == true) {
		for (var x=0, xLen=this.length; x<xLen; x++) {
			for (var i=0, iLen=events.length; i<iLen; i++) { this[x].addEventListener(events[i], listener, false); }
		}
	}

	else if (HTMLElement.prototype.isPrototypeOf(this) == true) {
		for (var i=0, iLen=events.length; i<iLen; i++) { this.addEventListener(events[i], listener, false); }
	}
}


var eventCallback = {
	ui: function(data) {
		var config = data.config;

		if (config.showWalletMoney == true) { document.querySelector('#wallet').style.display = 'block'; }
		if (config.showBankMoney == true) { document.querySelector('#bank').style.display = 'block'; }
		if (config.showBlackMoney == true) { document.querySelector('#blackMoney').style.display = 'block'; }
		if (config.showSocietyMoney == true) { document.querySelector('#society').style.display = 'block'; }

		if (config.showHealth == true) { document.querySelector('#health').style.display = 'block'; }
		if (config.showArmor == true) { document.querySelector('#armor').style.display = 'block'; }
		if (config.showStamina == true) { document.querySelector('#stamina').style.display = 'block'; }
		if (config.showHunger == true) { document.querySelector('#hunger').style.display = 'block'; }
		if (config.showThirst == true) { document.querySelector('#thirst').style.display = 'block'; }

		if (config.showJob == true) { document.querySelector('#job').style.display = 'block'; }
		if (config.showDate == true) { document.querySelector('#date').style.display = 'block'; }
		if (config.showLocation == true) { document.querySelector('#location').style.display = 'block'; }
		if (config.showVoice == true) { document.querySelector('#voice').style.display = 'block'; }

	},
	element: function(data) {
		if (data.task == 'enable') { document.querySelector('#'+data.value).style.display = 'block'; }
		else if (data.task == 'disable') { document.querySelector('#'+data.value).style.display = 'none'; }
	},
	setText: function(data) {
		var key = document.querySelector('#'+data.id+' span');
		var html = data.value;
		saferInnerHTML(key, html);
	},
	setFont: function(data) {
		document.querySelector('#font').href = data.url;
		document.body.style.fontFamily = data.name;
	},
	setLogo: function(data) { document.querySelector('#server img').setAttribute('src', data.value); },
	setMoney: function(data) {
		data.value = parseInt(data.value).toLocaleString();
		document.querySelector('#'+data.id).classList.add('pulse');
		eventCallback['setText'](data);
	},
	isTalking: function(data) {
		var voiceId = document.querySelector('#voice');
		if (data.value) { voiceId.classList.add('speak'); }
		else { voiceId.classList.remove('speak'); }
	},
	setVoiceDistance: function(data) {
		var voiceId = document.querySelector('#voice');
		var voiceIdWithClasses = voiceId.classList;

		voiceIdWithClasses.remove('whisper', 'normal', 'shout');
		voiceIdWithClasses.add(data.value);
	},
	setStatus: function(data) {

		if (data.isdead == true) {
			if (document.querySelector('#health').classList.contains('dead') == false) {
				document.querySelector('#health').classList.add('dead');
				for (i = 0; i < data.status.length; i++) { document.querySelector('#'+data.status[i].name+' span').style.height = '0'; }	
			}
		}
		else {
			for (i = 0; i < data.status.length; i++) {
				document.querySelector('#'+data.status[i].name+' span').style.height = data.status[i].value+'%';
				if (data.status[i].value <= 35) {
					if (document.querySelector('#'+data.status[i].name).classList.contains('dying') == false) {
						document.querySelector('#'+data.status[i].name).classList.add('dying');	
					}
				}
				else { document.querySelector('#'+data.status[i].name).classList.remove('dying'); }
			}
			if (document.querySelector('#health').classList.contains('dead')) { document.querySelector('#health').classList.remove('dead'); }
		}
	},

	updateVehicle: function(data) {

		var vehicleInfo = document.querySelector('.info.vehicle');
		var vehicleSeatbelt = document.querySelector('#seatbelt');
		var vehicleLights = document.querySelector('#lights');
		var vehicleSignals = document.querySelector('#signals');
		var vehicleFuel = document.querySelector('#fuel');
		var vehicleCruiser = document.querySelector('#vehicle-speed strong');

		if (data.status == true) {	
			if (vehicleInfo.classList.contains('inactive')) {
				vehicleInfo.classList.remove('inactive');
				vehicleInfo.classList.add('active', 'fadeIn');
			}


			if (vehicleInfo.classList.contains('updated') == false) {

				var vehicleSpeedUnit = data.config.speedUnit.slice(0,2)+'/'+data.config.speedUnit.slice(-1);
				var vehicleAverageSpeed = Math.ceil(data.config.maxSpeed / 6);

				vehicleInfo.classList.add('updated');
				saferInnerHTML(vehicleCruiser,vehicleSpeedUnit);

			}




			var previousGear = document.querySelector('#vehicle-gear span').innerHTML;
			var currentGear = data.gear;
			if (previousGear != currentGear) { document.querySelector('#vehicle-gear').classList.add('pulse') }
			saferInnerHTML(document.querySelector('#vehicle-gear span'), data.gear);







			document.querySelector('#progress-speed svg circle.speed').style.strokeDashoffset = data.nail;
			saferInnerHTML(document.querySelector('#vehicle-speed span'), data.speed);








			if ( (data.seatbelt.status == true) && (vehicleSeatbelt.classList.contains('on') == false) ) {
				vehicleSeatbelt.classList.remove('off');
				vehicleSeatbelt.classList.add('on');

				eventCallback.sound('sounds/seatbelt-buckle.ogg', { volume: '0.50' });
			}
			else if ( (data.seatbelt.status == false) && (vehicleSeatbelt.classList.contains('off') == false) ) {
				vehicleSeatbelt.classList.remove('on');
				vehicleSeatbelt.classList.add('off');

				eventCallback.sound('sounds/seatbelt-unbuckle.ogg', { volume: '0.50' });
			}










			if (vehicleCruiser.classList.contains(data.cruiser) == false) {
				vehicleCruiser.classList.remove('on','off');
				vehicleCruiser.classList.add(data.cruiser);
			}










			if (vehicleLights.classList.contains(data.lights) == false) {
				vehicleLights.classList.remove('normal','high','off');
				vehicleLights.classList.add(data.lights);

				if (data.lights == 'high') { vehicleLights.querySelector('i img').src = 'img/vehicle-lights-high.png'; }
				else { vehicleLights.querySelector('i img').src = 'img/vehicle-lights.png'; }
			}










			if (vehicleSignals.classList.contains(data.signals) == false) {

				vehicleSignals.querySelector('i').className = 'fa fa-arrows-alt-h';
				vehicleSignals.classList.remove('left','right','both','off');

				if ( (data.signals == 'left') || (data.signals == 'right') || (data.signals == 'both') ) {

					var classSignal = 'fa-long-arrow-alt-'+data.signals;
					if (data.signals == 'both') { classSignal = 'fa-arrows-alt-h'; }

					vehicleSignals.querySelector('i').classList.add('fas',classSignal);
					vehicleSignals.classList.add(data.signals, 'dying');

					eventCallback.sound('sounds/car-indicators.ogg', { loop: 'loop' });
				}

				else if (data.signals == 'off') {
					vehicleSignals.querySelector('i').classList.add('fas','fa-arrows-alt-h');
					vehicleSignals.classList.remove('dying');
					vehicleSignals.classList.add(data.signals);

					eventCallback.sound();
				}


			}
			
			










			vehicleFuel.querySelector('span').style.height = data.fuel+'%';

			if (data.fuel <= 35) {
				if (vehicleFuel.classList.contains('dying') == false) { vehicleFuel.classList.add('dying');	}
			}
			else { vehicleFuel.classList.remove('dying'); }

		}
		else {
			if (vehicleInfo.classList.contains('active')) {
				vehicleSeatbelt.classList.remove('on');
				vehicleCruiser.classList.remove('on');

				vehicleInfo.classList.remove('active');
				vehicleInfo.classList.add('inactive', 'fadeOut');
			}

		}
		
	},
	
	toggleUi: function(data) {
		var uiID = document.querySelector('#ui');
		if (data.value == true) {
			uiID.style.display = 'block';
			if (document.querySelector('#notify').classList.contains('fadeOutRight')) {
				document.querySelector('#notify').style.display = 'none';
			}
		}
		else {
			uiID.style.display = 'none';
		}
	},

	sendNotification: function(data) {
		var notifyID = document.querySelector('#notify');
		var notifyIcon = '';
		notifyID.style.display = 'block';

		saferInnerHTML(notifyID.querySelector('.title span'), data.title);
		saferInnerHTML(notifyID.querySelector('.msg'), data.message);

		notifyID.classList.remove('fadeInRight', 'fadeOutRight', 'normal', 'red', 'rainbow');

		if (data.type == 'normal') {
			notifyIcon = 'fa-twitter';
			notifyID.querySelector('i').classList.remove('fas', 'fab');
			notifyID.querySelector('i').classList.add('fab');
		}
		else {
			if (data.type == 'red') { notifyIcon = 'fa-exclamation-circle'; }
			else if (data.type == 'rainbow') { notifyIcon = 'fa-rainbow'; }

			notifyID.querySelector('i').classList.remove('fas', 'fab');
			notifyID.querySelector('i').classList.add('fas');
		}

		notifyID.querySelector('i').classList.remove('fa-twitter', 'fa-exclamation-circle', 'fa-rainbow');
		notifyID.querySelector('i').classList.add(notifyIcon);
		notifyID.classList.add('fadeInRight', data.type);

		setTimeout(function(){ notifyID.classList.add('fadeOutRight'); }, 18000);
	},

	sound: function(file = null, args = null) {
		var sound = document.querySelector('#sounds');
		var soundFile = file;
		var args = args;

		for (i = 0; i < sound.attributes.length; i++) { 
			if (sound.attributes[i].name != 'id') { sound.removeAttribute(sound.attributes[i].name); }
		}

		if (soundFile == null) { sound.setAttribute('src', ''); }
		else {
			if (args == null) { }
			else {
				for (var key in args) {
					if (key != 'addMultiListener') {
						if (key == 'volume') { sound.volume = args[key]; }
						else { sound.setAttribute(key, args[key]); }
					}
				}
			}

			sound.setAttribute('src', soundFile);
			sound.play();
		}


	}
};



document.querySelectorAll('.icon i').addMultiListener('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () { this.parentElement.classList.remove('pulse') });

document.querySelectorAll('.info.vehicle').addMultiListener('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
	this.classList.remove('fadeOut', 'fadeIn');
});

window.addEventListener('message', function(event) {
	eventCallback[event.data.action](event.data);
});