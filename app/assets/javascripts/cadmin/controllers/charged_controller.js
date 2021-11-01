import {  Controller } from "stimulus"

export default class extends Controller {

  static targets = ['tag']

  change() {
    
    console.log('tag');
    if (this.tagTarget.classList.contains("default")) {
      this.tagTarget.classList.remove("default")
      this.tagTarget.classList.add('has-background-success')
      this.tagTarget.textContent = 'Cobrado'
    }else{
      this.tagTarget.classList.remove("has-background-success")
      this.tagTarget.classList.add('default')
      this.tagTarget.textContent = ''
    }
  }

}