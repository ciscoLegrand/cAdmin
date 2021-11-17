import { Controller } from 'stimulus'
import TomSelect from 'https://cdn.skypack.dev/tom-select'

export default class extends Controller {
  static targets = ['servicesField', 'tagsField']
  connect(){
    this.tags()
    // this.default()
  }

  default() {
    new TomSelect(this.servicesFieldTarget, {
      plugins: {
        remove_button:{
          title:'Remove this item',
        }
      },
      placeholder: "Añadir",
      hideSelected: true,
      // persist: false,
      // create: true,
      onDelete: function(values) {
        return confirm(values.length > 1 ? 'Are you sure you want to remove these ' + values.length + ' items?' : 'Are you sure you want to remove "' + values[0] + '"?');
      }
    });
  }

  tags() {
    new TomSelect(this.tagsFieldTarget, {
      plugins: {
        remove_button:{
          title:'Remove this item',
        }
      },
      placeholder: "Añadir",
      hideSelected: true,
      persist: true,
      create: true,
      onDelete: function(values) {
        return confirm(values.length > 1 ? 'Are you sure you want to remove these ' + values.length + ' items?' : 'Are you sure you want to remove "' + values[0] + '"?');
      }
    });
  }
}
