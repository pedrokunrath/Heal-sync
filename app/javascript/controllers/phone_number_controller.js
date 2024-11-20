import { Controller } from "@hotwired/stimulus"
import 'jquery-mask-plugin'
import $ from 'jquery'

export default class extends Controller {
  maskBehavior(val) {
    return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
  }

  onKeyPress(val, e, field, options){
    field.mask(this.maskBehavior.apply({}, arguments), options);
  }

  connect() {
    $(this.element).mask(this.maskBehavior.bind(this), {
      onKeyPress: this.onKeyPress.bind(this)
    })
  }

}
