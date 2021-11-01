import flatpickr from 'https://esm.sh/stimulus-flatpickr?deps=stimulus@2.0.0';

// import { Spanish } from 'https://npmcdn.com/flatpickr@4.6.9/dist/l10n/es.js';
export default class extends flatpickr {
  initialize() {
    // sets your language (you can also set some global setting for all time pickers)
    this.config = {
      //TODO: research for spanish locales
      // locale: Spanish ,
      dateFormat: "d-m-Y",
      allowInput: true,
      position: "auto right"
    }
  }
}