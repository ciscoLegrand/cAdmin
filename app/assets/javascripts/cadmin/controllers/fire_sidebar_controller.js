import { Controller } from 'stimulus'

export default class extends Controller {
    fire() {
        window.dispatchEvent(new CustomEvent("openSidebar"));
    }
}