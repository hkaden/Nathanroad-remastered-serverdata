var player;
var video_data;
var duration_data;
var booth_index

$(function () {
	window.addEventListener('message', function (event) {
		if (event.data.module == "nativemods_lighting") {
			if (event.data.event_call == "ui:toggle_ui") {
				let ui = document.getElementById('siren_controller')
				if (event.data.event_data) {
					ui.style.display = event.data.event_data
				} else {
					ui.style.display = ui.style.display == "flex" ? "none" : "flex"
				}
			} else if (event.data.event_call == "ui:change_value") {
				let elem = document.getElementById(event.data.element_id)
				if (event.data.element_id == "prim_button" || event.data.element_id == "seco_button" || event.data.element_id == "siren_button") {
					elem.className = event.data.event_data == true ? "light light_active" : "light"
				} else {
					elem.innerHTML = event.data.event_data
				}
			}
		}
	});
});