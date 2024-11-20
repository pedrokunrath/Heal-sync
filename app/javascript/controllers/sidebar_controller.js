import { Controller } from "@hotwired/stimulus"
import { enter, leave } from 'el-transition'

export default class extends Controller {
    static targets = ["overlay", "menu"]

    connect() {
    }

    close() {
        Promise.all([leave(this.overlayTarget), leave(this.menuTarget)])
        this.enableScroll();
    }

    open() {
        Promise.all([enter(this.overlayTarget), enter(this.menuTarget)])
        this.disableScroll();
    }

    toggle() {
        Promise.all([toggle(this.overlayTarget), toggle(this.menuTarget)])
    }

    disableScroll() {
        document.body.style.overflow = 'hidden';
    }

    enableScroll() {
        document.body.style.overflow = '';
    }
}
