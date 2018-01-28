import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  decrease() {
    -- this.inputTarget.value
  }

  increase() {
    ++ this.inputTarget.value
  }
}
