import { Controller } from 'stimulus'
import Swal from 'https://cdn.skypack.dev/sweetalert2/dist/sweetalert2.js';

export default class extends Controller {
  static values = { options: Object }
    //static values = { title: String, text: String, icon: String, confirm: String, cancel: String }
    //static classes = [ "confirm", "cancel" ]

  fire(event){
    event.preventDefault();
    Swal.fire(this.optionsValue)
        .then((result) => {
          if (result.isConfirmed) {
            this.element.parentElement.requestSubmit();
          }
        });
  }
}