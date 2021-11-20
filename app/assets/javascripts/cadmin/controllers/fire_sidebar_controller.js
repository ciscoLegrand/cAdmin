import { Controller } from 'stimulus'

export default class extends Controller {
    fire(e) {
        e.preventDefault();
        window.dispatchEvent(new CustomEvent("openSidebar"));
    }
}