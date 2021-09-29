import { Controller } from 'stimulus'

import Uppy from 'https://cdn.skypack.dev/@uppy/core';
import DragDrop from 'https://cdn.skypack.dev/@uppy/drag-drop';
import XHRUpload from 'https://cdn.skypack.dev/@uppy/xhr-upload';
import spanishLocale from 'https://cdn.skypack.dev/@uppy/locales/lib/es_ES'

export default class extends Controller {
    static targets = ['container', 'input', 'preview']
    static values = { fileId: String }

    connect() {
        this.uppy = new Uppy({
            locale: spanishLocale,
            autoProceed: true,
            restrictions: {
                maxNumberOfFiles: 1
            }
        })

        this.uppy
            .use(DragDrop, {
                target: this.containerTarget
            })
            .use(XHRUpload, {
                endpoint: '/upload',
                headers: { 'X-CSRF-Token': document.querySelector("[name='csrf-token']").content }
            })

        this.uppy
            .on('upload-success', this.uploadSuccess.bind(this))
    }

    uploadSuccess(file, response) {
        this.fileIdValue = file.id
        this.inputTarget.value = JSON.stringify(response.body.data)
        this.previewTarget.parentElement.classList.add('active')
        this.previewTarget.href = response.uploadURL
        this.previewTarget.innerHTML = file.data.name
    }

    removeFile(){
        this.uppy.removeFile(this.fileIdValue)
        this.previewTarget.parentElement.classList.remove('active')
    }

    disconnect() {
        this.uppy.close()
    }
}