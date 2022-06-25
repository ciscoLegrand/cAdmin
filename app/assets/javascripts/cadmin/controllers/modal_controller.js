import { Controller } from 'stimulus'

export default class extends Controller {
    static targets = ["modal", "button"]
    connect(){
    }

    open(e){
        e.preventDefault()
        this.modalTarget.classList.add("is-active")
    }

    close(e){
        e.preventDefault()      
        this.modalTarget.classList.remove("is-active")
    }

    disconnect(e) {
        e.preventDefault()
        this.modalTarget.classList.remove("is-active")
    }
}