import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="monster"
export default class extends Controller {
  static classes = ["attackedState"];
  static targets = ["image", "atkButton"];

  connect() {}

  takeDamage() {
    this.imageTarget.classList.add(this.attackedStateClass);
  }

  takeDamageDone() {
    this.imageTarget.classList.remove(this.attackedStateClass);
  }
}
