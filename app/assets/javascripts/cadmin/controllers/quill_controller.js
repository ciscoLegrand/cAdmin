import { Controller } from 'stimulus'
import Quill from 'https://cdn.skypack.dev/quill';

export default class extends Controller {
  static targets = ['content', 'editor']

  //!  https://quilljs.com/docs/modules/toolbar/
  toolbarOptions() {
    let toolbarOptions = [
      ['bold', 'italic', 'underline', 'strike','blockquote',{ 'header': [1, 2, 3, 4, 5, 6, false] }],        // toggled buttons
      // ['blockquote'],
      // [ 'code-block'],
      // [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
      // [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
      [{ 'font': [] }],
      // [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
      // [{ 'list': 'ordered'}, { 'list': 'bullet' }],
      // [{ 'direction': 'rtl' }],                         // text direction
      [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
      [{ 'align': [] }, 'clean'],
      
      
      // [{ 'header': 1 }, { 'header': 2}],               // custom button values
        // [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
      
      // ['clean']  
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