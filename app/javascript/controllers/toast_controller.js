import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="toast"
export default class extends Controller {
  DELAY = 5000;

  connect() {
    this.toast = new bootstrap.Toast(this.element, {
      delay: this.DELAY,
      autohide: true,
    });
    this.toast.show();
  }
}
