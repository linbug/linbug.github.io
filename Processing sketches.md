---
layout: page
title: Processing sketches
---
</script><script src="processing.js"></script>

I first got into programming by making interactive games in [Processing](https://processing.org/). Processing is built on Java, but has a simplified syntax and a GUI where you can run your sketches. I found it to be a fun way to learn object-oriented programming principles.

Here are a couple of my sketches, based on the classic Pacman game (I call her PacWoman). Click on the sketch and use your arrow keys to control Pac. Source code [here]().

##PacWoman with array maze 

In this first sketch, I generated the maze by specifying an array of blocks where thePac and food can be generated.

<canvas data-processing-sources="Maze_for_Pacwoman/Maze_for_Pacwoman.pde"></canvas>

##PacWoman with image maze

This one is a little more freeform. The maze is an image I made in Adobe Illustrator, and Pac and food are not allowed to go wherever the teal coloured pixels are. This one allows me to generate funky angular maps :)  

<canvas data-processing-sources="Arty_PacWoman/Arty_PacWoman.pde"></canvas>