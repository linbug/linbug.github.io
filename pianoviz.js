

function executeCode(dataArray, div){
		
		var height = 500;														//Set the height of the chart											

		var barWidth = 10;														//Set the width of the bars

		var width = dataArray.length * (barWidth + 10);							//Set the width of the canvas
		
		var heightScale = 	d3.scale.linear()									//Scales the input data to a height between 25 - 500 px
							.domain([0, d3.max(dataArray)]) 		
							.range([0, height ]);

		var heightAxis = 	d3.scale.linear()									
							.domain([27, 900]) 									//the input is the possible range of freqs		
							.range([height, 0 ]);									//the output is the height of the canvas

		var yAxis = d3.svg.axis()
    					.scale(heightAxis)
    					.orient("left")
		    					

		var canvas = d3.select("div#example" + div)											//Make the canvas and set attribute
						.append("svg")
						.attr("width", width + 50)
						.attr("height", height + 50)
						.append("g")											
						.attr("transform", "translate(50,530)") 				//Move so that the convas will fill the screen after we flip it
						

	

		var pianoScale = d3.scale.linear()										//Scales the input data to a value between 27 - 900 hz
							.domain([0, d3.max(dataArray)])
							.range([27, 900]);
											
						
		

		var colorScale = d3.scale.linear()										//Scales the input data to a colour 
							.domain([0, d3.max(dataArray)]) 
							.range(["blue","green"]);

		var simHertz =  function(hz) {													//Converts input number to that sound in hz
			    var audio = new Audio();
			    var wave = new RIFFWAVE();
			    var data = [];
			    wave.header.sampleRate = 44100;
			    var seconds = 2;
			    for (var i = 0; i < wave.header.sampleRate * seconds; i ++) {
			        data[i] = Math.round(128 + 127 * Math.sin(i * 2 * Math.PI * hz / wave.header.sampleRate));
			    }
			    wave.Make(data);
			    audio.src = wave.dataURI;
			    return audio;
				}

		var myMouseoverFunction = function(data) {									
				var rectangle_col = d3.select(this);
				var audio = simHertz(pianoScale(data));							//On mouseover, makes sound proportional to size of bar
					audio.play();
				rectangle_col.transition()
				.duration(100)
				.attr("fill", "purple")											//fills bar in purple
				.transition()
				.duration(800)
				.attr("height", rectangle_col.attr("height")*1 - 20)			//decreases height
				.ease("elastic")
			}

		var myMouseoutFunction = function() {
				var rectangle_col = d3.select(this);
				rectangle_col.transition()
				.duration(800)
				.ease("elastic")
				.attr('fill', this.getAttribute('initialcolor'))				//On mouseoff, return colour to initial colour
				.attr('height', this.getAttribute('initialheight'))				//Return height to initial height
			}

		var bars = canvas.selectAll("rect")
							.data(dataArray)
							.enter()
								.append("rect")
								.attr("height", 0)								
								.attr("width", barWidth)
								.attr("x", function(d,i){ return i*(-barWidth-5); })			//initiate bars at posiitons x
								.attr("transform", "rotate(180)")								//rotate the bars by 180 degrees so they are now columns that 																go UP
								.attr("initialcolor", function(d,i){return colorScale(d)}) 		//Set initial colour attr for each bar
								.attr("initialheight", function(d){ return heightScale(d);})	//Set initial height attr
								.attr("fill", function(d,i){return colorScale(d)	} )			//Actually colour the bars
								.on("mouseover", myMouseoverFunction)				
								.on("mouseout", myMouseoutFunction)
									.transition()
									//.delay(function(d, i) { return i * 600 })
									.duration(500)
									.attr("height", function(d){ return heightScale(d);});		//grow bars at the start
			


			canvas.append("g")						
						
						.attr("class","axis")
						.attr("transform", "translate(-20,-500)")
						.call(yAxis)	

			canvas.append("text")
					    .attr("class", "ylabel")
					    .attr("text-anchor", "end")
					    .attr("x", 500)
					    .attr("y", -10)
					    .attr("transform", "rotate(-90)")
					    .attr("fill", "black")
					    .attr("font-family", "sans-serif")
					    .attr("font-size", "10px")
					    .text("Frequency (hz)");
					
}

var dataArraysin = [];

		for (var i=0, t=50; i<t; i++) {
    		dataArraysin.push(Math.sin((i/10)))
		};	

var dataArraylin = [];

		for (var i=0, t=50; i<t; i++) {
    		dataArraylin.push(i)
		};	

var dataArraylog = [];

		for (var i=0, t=50; i<t; i++) {
    		dataArraylog.push(Math.log(i))
		};

var heartasks = [900, 523.251, 123.471, 130.813, 164.8, 261.626, 123.471, 261.626,123.471, 130.813, 123.471,293.665, 27 ]

executeCode(dataArraylin, 3);

executeCode(dataArraysin, 2);

executeCode(dataArraylog, 4);

executeCode(heartasks, 5);

