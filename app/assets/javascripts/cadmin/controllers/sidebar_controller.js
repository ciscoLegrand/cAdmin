import { Controller } from "stimulus"

export default class extends Controller {
    open(){
        if (!this.element.classList.contains("open"))
            this.element.classList.add("open") 
        else
            this.element.classList.remove("open")
    }

    close(){
        this.element.classList.remove("open")
    }
}