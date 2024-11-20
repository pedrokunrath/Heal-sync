import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="blog"
export default class extends Controller {
    static targets = ["blogIndex", "blogContent"]

    connect() {

        this.putIdInIndex()
        this.putIndexInBlog()


    }

    putIdInIndex() {
        this.getIndexFromBlog().forEach((element, index) => {
            // remova acentos e caracteres especiais
            element.id = element.textContent.toLowerCase()
                .replace(/ /g, '-')
                .normalize('NFD')
                .replace(/[\u0300-\u036f]/g, "")
        })
    }

    getIndexFromBlog() {
        return this.blogContentTarget.querySelectorAll('h2')
    }

    putIndexInBlog() {
        // transform node list into array
        let nodeList = this.getIndexFromBlog()
        let array = Array.from(nodeList)
        this.blogIndexTarget.innerHTML = array.map((element) => {
            return `<li><a href="#${element.id}">${element.textContent}</a></li>`
        }).join(' ')
    }


}
