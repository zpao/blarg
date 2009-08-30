/*
 * IE6
 * Adds a nice little message at the top of your page for your IE6 users.
 * Include it using conditional comments because that's the way you should browser sniff.
 *
 * Copyright 2009 Paul O’Shannessy
 *
 */

$(function () {
  $("body").prepend("<div id='ie6'>" + 
    "<h1>Your Browser is <blink>&ldquo;Special&rdquo;</blink></h1>" +
    "<p>Are you enjoying 2001? Don&rsquo;t you <em>looooooooooove</em> Comic Sans?</p>" +
    "<p>You should upgrade. " +
      "I suggest <a href='http://www.mozilla.com/en-US/'>Firefox</a>, but I&rsquo;m biased." +
    "</p></div>");
});