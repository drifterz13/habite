import { Controller } from "@hotwired/stimulus";
import "bootstrap";

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    this.modal = new bootstrap.Modal(this.element);
  }

  show() {
    this.modal.show();
  }
}
