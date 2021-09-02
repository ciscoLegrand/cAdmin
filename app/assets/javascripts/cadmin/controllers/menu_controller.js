import { Controller } from "stimulus"

export default class extends Controller {

	 static targets = [ "dropdown", "link" ]

	 connect() {	    
	    this.dropdownTargets.forEach( (elem) => {
			set_active(localStorage.getItem('current-menu'), elem, "open-menu", "dropdown");			
	    } )

	    this.linkTargets.forEach( (elem) => {
			set_active(localStorage.getItem('current-menu-item'), elem, "vertical__active");
	    } )
	 }

	 set_active_menu(e) {
		localStorage.setItem("current-menu", e.target.dataset.menu);
		this.dropdownTargets.forEach( (elem) => {
			set_active(e.target.dataset.menu, elem, "open-menu", "dropdown");
		})
	 }

	 set_active_menu_item(e) {
	 	localStorage.setItem("current-menu-item", e.target.dataset.menuItem);
	 }	
}

function set_active( current, elem, class_css, previous_element = null ) {
	if ( previous_element != null ){

		if (current == elem.previousElementSibling.dataset.menu ){
			elem.classList.toggle(class_css);
		}
		else {
			elem.classList.toggle(class_css, false );
		}
	}
	else {
		if (current == elem.dataset.menuItem ){
			elem.classList.toggle(class_css, true );
		}
		else {
			elem.classList.toggle(class_css, false );
		}
	}
}