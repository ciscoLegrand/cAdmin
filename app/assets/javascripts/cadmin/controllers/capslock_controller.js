// app/assets/javascripts/controllers/hello_controller.js
import { Controller } from "stimulus"


export default class extends Controller {
  static targets = [  "output" ]
  
  initialize() {   
    document.addEventListener('keyup', function (e) {
      e.getModifierState('CapsLock')
        ? document.getElementById('output').textContent='**Mayúsculas activadas!'      
        : document.getElementById('output').textContent=''
    })


  }
}
