function scriptFor(controller, action, fn) {
  $(function(){
    if (controller != $("body").data("controller")) {
      return;
    }
    if (typeof action !== "string") {
      fn = action;
      fn();
    } else if (action != $("body").data("action")) {
      return;
    } else {
      fn();
    }
  });
}