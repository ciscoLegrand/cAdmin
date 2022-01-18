import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    console.log("I am loaded")
    // let stripeMeta = document.querySelector('meta[name="stripe-key"]')
    // if (stripeMeta === null) { return }
    
    // let stripeKey = stripeMeta.getAttribute("content")
    let stripeKey = 'pk_test_51KGrN9A2MeySer7HkhQ0Dg3dMUlxUtd4KbUuguncf4P9D0ooyEfdProBubnL6ZsPE5ALdBpaxv2U1Bn3vot4aEUP00VWzEwvSW'
    const stripe = Stripe(stripeKey)
    this.stripe = stripe
    this.csrf = document.querySelector("meta[name='csrf-token']").getAttribute("content")
    
    console.log('this.stripe =>')
    console.log(this.stripe)

  }

  loadStripe(){
    console.log('loading stripe');
    fetch('/cadmin/checkout/create', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': this.csrf,
      },
    })
    .then(res => res.json())
    .then(session => {
      console.log(`session.id => ${session.id}`)
      console.log(`loadStripe = this.stripe => ${this.stripe}`)
      this.stripe.redirectToCheckout({ sessionId: session.id})
    })
    .then(res => { if (res.error) { console.log(res.error.message) } } )
    .catch(err => console.log(err))
    // .then(function(response) {
    //   return response.json();
    // })
    // .then(function(session) {
    //   console.log(`session.id => ${session.id}`)
    //   console.log(`loadStripe = this.stripe => ${this.stripe}`);
    //   this.stripe.redirectToCheckout({ sessionId: session.id })
    // })
    // .then(function (result) {
    //   // If `redirectToCheckout` fails due to a browser or network
    //   // error, you should display the localized error message to your
    //   // customer using `error.message`.
    //   if (result.error) alert(result.error.message)
    // })
    // .catch(function(error) {
    //   console.error('Error:', error);
    // });
  }
}