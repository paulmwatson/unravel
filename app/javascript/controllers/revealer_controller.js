// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="revealer">
//  ...
//  <button data-action="click->revealer#toggle">
//    Reveal
//  </button>
//  ...
//  <div class="is-hidden" data-target="revealer.reveal"
//    ...
//  </div>
//  ...
// </div>

import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['reveal']

  toggle() {
    for (let target of this.revealTargets) {
      target.classList.toggle('is-hidden')
    }
  }
}
