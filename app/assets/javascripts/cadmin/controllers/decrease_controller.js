import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["hidetext", "main", "changeIcon", "sidebar","arrow"]
	static values = {
		right: String,
		left: String
	}
  hide(e) {
    e.preventDefault()
    
    if (this.sidebarTarget.classList.contains("sidebar__w16")) { 
      this.sidebarTarget.classList.remove("sidebar__w16")
      this.sidebarTarget.classList.add("sidebar__w5")       
      this.mainTarget.classList.remove("main__is-10__is-offset-2")
      this.mainTarget.classList.add("main__w95")
      this.arrowTarget.setAttribute("src", this.rightValue);
      this.hidetextTargets.forEach( (elem) => { elem.classList.add("sidebar__w5__hidetext")  } )

    } else {      
      this.sidebarTarget.classList.remove("sidebar__w5")
      this.sidebarTarget.classList.add("sidebar__w16") 
      this.mainTarget.classList.remove("main__w95")
      this.mainTarget.classList.add("main__is-10__is-offset-2")
      this.arrowTarget.setAttribute("src",this.leftValue);
      this.hidetextTargets.forEach( (elem) => { elem.classList.remove("sidebar__w5__hidetext")  } )
    }
  }
}
