import { Controller } from "stimulus"
import Notification from 'https://cdn.skypack.dev/stimulus-notification'
export default class extends Notification {
    close(){
        this.element.remove()
    }
}