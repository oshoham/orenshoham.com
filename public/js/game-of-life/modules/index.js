import GameOfLife from './game-of-life';

var $ = require('../node_modules/jquery');

$(function () {
  var elem = document.getElementById('draw-container');
  var windowWidth = $(window).width();
  var windowHeight = $(window).height();
  var gridWidth = 50;
  var gridHeight = 80;

  var gameOfLife = new GameOfLife({
    gridHeight: gridHeight,
    gridWidth: gridWidth,
    windowHeight: windowHeight,
    windowWidth: windowWidth,
    elementToRenderTo: elem
  });

  gameOfLife.run();
});
