import { Controller } from 'stimulus'
import Quill from 'https://cdn.skypack.dev/quill';

export default class extends Controller {
  static targets = ['content', 'editor']

  //!  https://quilljs.com/docs/modules/toolbar/
  toolbarOptions() {
    let toolbarOptions = [
      ['bold', 'italic', 'underline', 'strike','blockquote',{ 'header': [1, 2, 3, 4, 5, 6, false] }],        // toggled buttons
      [{ 'font': [] }],
      [{ 'color': [] }, { 'background': [] }],
      [{ 'align': [] }],
      [{ 'script': 'sub'}, { 'script': 'super' }],
      ['blockquote', 'code-block'],      
      [ 'link', 'image'],
      ['clean']  
    ];
    return toolbarOptions;
  }

  connect() {
    this.init()
  }

  init(){        
    this.quill = new Quill(this.editorTarget, {
      modules: {
        toolbar: this.toolbarOptions(),
      },
      theme: 'snow'
    });    
  }

  //? callit in form view and useit when form is submitted
  save(e) {
    this.contentTarget.value = this.quill.root.innerHTML
  }
}