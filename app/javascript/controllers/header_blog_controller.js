import {Controller} from "@hotwired/stimulus"


export default class extends Controller {
    static targets = ["microHeader"]
    connect() {
        window.addEventListener("scroll",  () => {
            if (window.scrollY > 100) {
                const header = this.microHeaderTarget;
                header.classList.add('hidden');
            }
        });

        window.addEventListener("scroll",  () => {
            if (window.scrollY < 100) {
                const header = this.microHeaderTarget;
                header.classList.remove('hidden');
            }
        });
    }

}
