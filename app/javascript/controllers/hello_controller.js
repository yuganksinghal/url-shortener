import { Controller } from "@hotwired/stimulus"
import chatChannel from "channels/chat_channel";

export default class extends Controller {
  static targets = ["message"];

  send(event) {
    console.log("CALLED");
    event.preventDefault();
    console.log(event);
    chatChannel.send({ user:'Yugank', message: this.messageTarget.value });
    this.messageTarget.value = "";
  }
}
