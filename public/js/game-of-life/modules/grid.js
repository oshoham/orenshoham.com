import { DEAD, ALIVE } from './constants';

// A modulo function that works for negative numbers
var mod = function (dividend, divisor) {
  return ((dividend % divisor) + divisor) % divisor;
};

export default class Grid {
  constructor(height, width) {
    this.height = height;
    this.width = width;

    let board = [];
    for (let x = 0; x < width; x++) {
      board[x] = [];
      for (let y = 0; y < height; y++) {
        board[x][y] = DEAD;
      }
    }
    this.board = board;
  }

  get(x, y) {
    if (x < 0 || x >= this.width || y < 0 || y >= this.height) {
      throw new Error(`Coordinates out of bounds: ${x}, ${y}`);
    }
    return this.board[x][y];
  }

  set(x, y, value) {
    if (x < 0 || x >= this.width || y < 0 || y >= this.height) {
      throw new Error(`Coordinates out of bounds: ${x}, ${y}`);
    }

    if ([DEAD, ALIVE].indexOf(value) === -1) {
      throw new Error(`Value must be ${DEAD} or ${ALIVE}`);
    }

    this.board[x][y] = value;

    return value;
  }

  numberOfLiveNeighbors (x, y) {
    if (x < 0 || x >= this.width || y < 0 || y >= this.height) {
      throw new Error(`Coordinates out of bounds: ${x}, ${y}`);
    }

    var liveNeighbors = 0;

    for (let i = x-1; i <= x+1; i++) {
      for (let j = y-1; j <= y+1; j++) {
        if (i === x && j === y) {
          continue;
        }

        // Wrap out of bounds indices to the other side of the grid
        i = mod(i, this.width);
        j = mod(j, this.height);

        let neighborValue = this.get(i, j);
        if (neighborValue === ALIVE) {
          liveNeighbors++;
        }
      }
    }

    return liveNeighbors;
  }
}
