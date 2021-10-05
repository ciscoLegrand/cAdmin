import { Controller } from 'stimulus'
import SlimSelect from 'https://cdn.skypack.dev/slim-select';
import { useDebounce } from 'https://cdn.skypack.dev/stimulus-use';

export default class extends Controller {
    static values = { url: String, useAjax: Boolean, options: Object }
    static debounces = ['searchResults']

    connect(){
        this.default()
        // if (this.useAjaxValue) {
        //     useDebounce(this)
        //     this.ajaxified()
        // } else {
        //     this.default()
        // }
    }

    default(){
        this.slimselect = new SlimSelect({
            select: this.element,
            options:[{...this.optionsValue}]
        })
    }

    // ajaxified(){
    //     self = this
    //     this.slimselect = new SlimSelect({
    //         select: this.element,
    //         ...this.optionsValue,
    //         ajax: function(search, callback) {
    //             self.searchResults(search, callback)
    //         }
    //     })
    // }

    // async searchResults(search, callback){
    //     if (search.length < 3) {
    //         callback('Mínimo 3 caracteres')
    //         return
    //     }

    //     let response = await fetch(`${this.urlValue}?q=${search}`, {
    //         //body: JSON.stringify(search),
    //         headers: {
    //             'Content-Type': 'application/json',
    //             'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
    //         }
    //     })
    //     let data = await response.json();
    //     let results = []
    //     data.forEach(result => {
    //         results.push({value: result.select_value, text: result.select_text})
    //     })

    //     try{
    //         callback(results)
    //     }catch {
    //         callback(false)
    //     }
    // }

    disconnect() {
        this.slimselect.destroy()
    }
}