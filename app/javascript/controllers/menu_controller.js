import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["toggle"];

  connect() {
    this.dropdownEl = new bootstrap.Dropdown(this.toggleTarget);
  }

  toggle() {
    this.dropdownEl.show();
  }
}
