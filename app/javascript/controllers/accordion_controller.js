import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="blog"
export default class extends Controller {
    static targets = ["question", "response", "icon"]

    connect() {

    }

    toggle() {
        this.responseTarget.classList.toggle('hidden')
    }

    rotateIcon() {
        this.iconTarget.classList.toggle('rotate-180')
    }


}
