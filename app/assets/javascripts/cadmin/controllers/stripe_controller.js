import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    let stripeKey = 'pk_test_51KGrN9A2MeySer7HkhQ0Dg3dMUlxUtd4KbUuguncf4P9D0ooyEfdProBubnL6ZsPE5ALdBpaxv2U1Bn3vot4aEUP00VWzEwvSW'
    const stripe = Stripe(stripeKey)
    this.stripe = stripe
    this.csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content")
  }

  loadStripe(){
    fetch('/cadmin/checkout/create', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': this.csrf,
      },
    })
    .then(res => res.json())
    .then(session => { this.stripe.redirectToCheckout({ sessionId: session.id}) })
    .then(res => { if (res.error) { console.log(res.error.message) } } )
    .catch(err => console.log(err))
  }
}