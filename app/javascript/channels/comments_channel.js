import consumer from "./consumer"

var channel = consumer.subscriptions.create("CommentsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('Comment channel is connected...')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    // console.log(data)
    $('#messages').prepend(data)
  }
});


document.addEventListener("devise:login", function() {
  channel.connect();
});