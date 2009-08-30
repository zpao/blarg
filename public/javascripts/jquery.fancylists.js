/*
 * Fancy Lists
 * A super simple jQuery script that will add a span with a specified character
 * (html encoded) to the front of every <li> in each <ul> with a fancylist
 * class. This works best for lists that have list-style:none.
 *
 * This may be expanded one day to be flexible, but don't hold your breath.
 *
 * Copyright 2008 Paul O'Shannessy
 *
 */

$(function () {
  var char = "&#x2708;"
  $("ul.fancylist li").prepend("<span class='fancy'>" + char + "</span>");
});