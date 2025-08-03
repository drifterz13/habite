import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="list-modal"
export default class extends Controller {
  static values = {
    idx: Number,
  };

  connect() {
    console.log("List modal connected: ", { idx: this.idxValue });
  }

  getIdx() {
    return this.idxValue;
  }

  setIdx(val) {
    this.idxValue = val;
  }
}
