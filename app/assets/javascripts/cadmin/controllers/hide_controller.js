import { Controller } from "stimulus"

export default class extends Controller {
    hide(){
        this.element.classList.add("is-hidden")
    }

    show(){
        this.element.classList.remove("is-hidden")
    }
}