import GameOfLife from './game-of-life';

var $ = require('../node_modules/jquery');

$(function () {
  var elem = document.getElementById('draw-container');
  var params = { width: $(window).width(), height: $(window).height() };
  var two = new Two(params).appendTo(elem);

  // two has convenience methods to create shapes.
  var circle = two.makeCircle(72, 100, 50);
  var rect = two.makeRectangle(213, 100, 100, 100);

  // The object returned has many stylable properties:
  circle.fill = '#FF8000';
  circle.stroke = 'orangered'; // Accepts all valid css color
  circle.linewidth = 5;

  rect.fill = 'rgb(0, 200, 255)';
  rect.opacity = 0.75;
  rect.noStroke();

  // Don't forget to tell two to render everything
  // to the screen
  two.update();

  var gameOfLife = new GameOfLife(100, 100);
});
