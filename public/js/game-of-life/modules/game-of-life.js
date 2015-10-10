import Grid from './grid';
import { DEAD, ALIVE } from './constants';

export default class GameOfLife {
  constructor (height, width) {
    this.height = height;
    this.width = width;
    this.grid = new Grid(height, width);
    this.nextGrid = new Grid(height, width);
  }

  run (numIterations) {
    for (let i = 0; i < numIterations; i++) {
      this.updateGrid();
    }
  }

  updateGrid () {
    for (let x = 0; x < this.width; x++) {
      for (let y = 0; y < this.height; y++) {
        this.updateCell(x, y);
      }
    }

    // re-use grid as nextGrid
    this.swapGrids();
  }

  updateCell (x, y) {
    var numberOfLiveNeighbors = this.grid.numberOfLiveNeighbors(x, y);

    if (numberOfLiveNeighbors >= 4) {
      this.nextGrid.set(x, y, DEAD);
    } else if (numberOfLiveNeighbors === 3) {
      this.nextGrid.set(x, y, ALIVE);
    } else if (numberOfLiveNeighbors === 2) {
      let currentValue = this.grid.get(x, y);
      this.nextGrid.set(x, y, currentValue);
    } else if (numberOfLiveNeighbors <= 1) {
      this.nextGrid.set(x, y, DEAD);
    }
  }

  swapGrids () {
    var temp = this.grid;
    this.grid = this.nextGrid;
    this.nextGrid = temp;
  }
}
