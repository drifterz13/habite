import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="battle"
export default class extends Controller {
  static classes = ["heroAttack", "monsAttacked"];
  static targets = ["hero", "monster", "atkButton"];

  connect() {}

  attack() {
    this.heroTarget.classList.add(this.heroAttackClass);
  }

  attackDone() {
    this.monsterTarget.classList.add(this.monsAttackedClass);
  }

  takeDamageDone() {
    this.monsterTarget.classList.remove(this.monsAttackedClass);
    this.heroTarget.classList.remove(this.heroAttackClass);
  }
}
