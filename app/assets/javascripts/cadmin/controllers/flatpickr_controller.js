import flatpickr from 'https://cdn.skypack.dev/stimulus-flatpickr@v1.3.3';

import { Spanish } from 'https://esm.sh/flatpickr/dist/l10n/es.js';
export default class extends flatpickr {
  initialize() {
    // sets your language (you can also set some global setting for all time pickers)
    this.config = {
      locale: Spanish,
      dateFormat: "d-m-Y",
      allowInput: true,
      position: "auto right"
    }
  }
}