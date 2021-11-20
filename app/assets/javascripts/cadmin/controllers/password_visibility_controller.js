import { Controller } from "stimulus"

export default class extends Controller {
	static targets = [ 'input','icon']
	static values = {
		show: String,
		hide: String
	}

	change() {
		if (this.inputTarget.type == "password") {
			this.inputTarget.type = 'text';
			this.iconTarget.setAttribute("src", this.hideValue);
		}
		else {
			this.inputTarget.type = 'password';
			this.iconTarget.setAttribute("src", this.showValue);
		}
	}
}