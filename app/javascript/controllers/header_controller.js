import {Controller} from "@hotwired/stimulus"


export default class extends Controller {
    connect() {

        window.addEventListener("scroll", function () {
            const header = document.querySelectorAll('header');
            header.forEach(function (element) {
                element.classList.toggle('scroll', window.scrollY > 150);
            });
        });
    }

}
