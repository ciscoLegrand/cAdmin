import FullCalendar from 'fullcalendar'

export default class extends Controller {
  static targets = ["calendar"]
  connect() {

    this.init()
  }

  init() {

    this.calendar = new FullCalendar.Calendar(this.calendarTarget, {
      initialView: 'dayGridMonth',
    })

    this.calendar.render()
  }

}