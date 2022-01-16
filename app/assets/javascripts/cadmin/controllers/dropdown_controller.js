import { Controller } from "stimulus"

export default class extends Controller {

	static targets = [ "button", "productfeatures" ]

	show_options() {
	 	this.buttonTarget.classList.toggle('is-block');	 	
	}

	display_product_features(e) {
		e.preventDefault()
		this.productfeaturesTarget.classList.contains("is-hidden") ?
		this.productfeaturesTarget.classList.remove('is-hidden') : 
		this.productfeaturesTarget.classList.add('is-hidden')
	}
}