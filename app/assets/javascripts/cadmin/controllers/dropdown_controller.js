import { Controller } from "stimulus"

export default class extends Controller {

	static targets = [ "button" ]

	show_options() {
	 	this.buttonTarget.classList.toggle('is-block');	 	
	}
}