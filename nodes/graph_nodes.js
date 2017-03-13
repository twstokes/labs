/* Tanner Stokes - www.tannr.com */

function Node(container, name, x, y, rad) {
  // the svg container that holds our graphics
  this.container = container;
  this.name = name;
  this.x = x;
  this.y = y;
  this.rad = rad;
  this.connectedNodes = [];
  this.connectedEdges = [];
  
  this.circle = null;
  this.visited = false;
  
  console.log("Created new node '" + this.name + "' at "+this.x+','+this.y+' with radius of '+this.rad+'.');
}

Node.prototype.calculateDistanceTo = function(node) {
  var distance = Math.sqrt(Math.pow(this.x-node.x, 2) + Math.pow(this.y-node.y, 2));
  return distance;
}

Graph.prototype.findShortestPath = function(startNode, endNode) {

  var shortestPath = [];
  var nodeFound = false;
  
  if(startNode.connectedNodes.length > 0 && nodeFound == false) {
    
    for(nodeObject in startNode.connectedNodes) {
      node = startNode.connectedNodes[nodeObject];
      console.log('Checking '+ node.name);
      if(endNode == node) {
        console.log('Found the node. I am node ' + endNode.name + '.');
        nodeFound = true;
        return true;
      } else {
        if(node.visited != true) {
          node.visited = true;
          if(this.findShortestPath(node, endNode) == true) {
              console.log('I am node ' + node.name + '.');
          } 
        }
      }  
    }
    
    
  } else {
    console.log("No connected nodes! Couldn't find the shortest path!");
  }
  
  return shortestPath;
}

Node.prototype.draw = function(node) {
  this.circle = this.createCircle(this.x, this.y, this.rad, this);
}

Node.prototype.connectNode = function(node) {
  console.log('Connecting this node ('+this.name+') to '+node.name+'.');
  this.connectedNodes.push(node);
}

Node.prototype.connectEdge = function(edgeObject) {
  // NOTE - this is more than an edge, it is an edge and which end of the edge (1 or 2)
  //edgeObject.object = edge;
  //edgeObject.side = 1 or 2;
  this.connectedEdges.push(edgeObject);
}

Node.prototype.findClosestConnected = function() {
  
  closestNode = null;
  
  if(this.connectedNodes.length > 0) {
    var closestNode = this.connectedNodes[0];
    var closestNodeDistance = this.calculateDistanceTo(closestNode);
  
    for(node in this.connectedNodes) {
      var currentNode = this.connectedNodes[node];
      var distance = this.calculateDistanceTo(currentNode);
      console.log(distance);
      if(distance < closestNodeDistance) {
        closestNode = currentNode;
        closestNodeDistance = distance;
      }
    }
      console.log('Closest node is ' +closestNodeDistance+' pixels.');
  } else {
    console.log("No connected nodes! Can't calculate closest.");
  }
  
  return closestNode;
}

Node.prototype.createCircle = function(x, y, rad, node) {
    var svgNS = "http://www.w3.org/2000/svg";
   	var xlinkNS = "http://www.w3.org/1999/xlink";
 	
    var newCircle = document.createElementNS(svgNS,"circle");
    newCircle.setAttributeNS(null,"cx", x);	
    newCircle.setAttributeNS(null,"cy", y);
    newCircle.setAttributeNS(null,"r", rad);	

    newCircle.setAttributeNS(null,"fill","rgb(255,112,80)");
    
    // don't know if we should fix this - we have a node referencing its circle,
     // and the circle also referencing the node
    newCircle.node = node;
     
    $(newCircle).bind('mousedown', function(e) {
      console.log('Clicked ' +this.node.name+ '.');
      window.grabbedNode = node;
    }).mouseup(function() {
      console.log('Moved '+this.node.name+ ' to ' +node.x+',' +node.y+'.');
      console.log('Released ' +this.node.name+ '.');
    }).hover(function() {
      hoveredNode = node;
      console.log('Hovering over ' + this.node.name);
    });
     
		$(this.container).append(newCircle);
			
		return newCircle;
}

function Graph(container, wrapper) {
  // the div that wraps our container
  this.wrapper = wrapper;
  // the svg container that holds our graphics
  this.container = container;
  this.nodes = [];
  this.edges = [];
  this.nodeCount = 0;
  
    // get the offset of our wrapper so that the mouse always aligns
   positionData = $(this.wrapper).offset();
   // what node is grabbed
   grabbedNode = null
   previouslyGrabbedNode = null;
   hoveredNode = null;
   mouseDown = false;
    
    $(this.wrapper).mousedown(function(e) {
      // to prevent Firefox dragging of the background image
      e.preventDefault();

      if(grabbedNode != null) {
        if(grabbedNode.connectedEdges.length == 1) {
            console.log('Node has ' + grabbedNode.connectedEdges.length + ' connected edge.');
        } else {
        console.log('Node has ' + grabbedNode.connectedEdges.length + ' connected edges.');   
        }  
      }

      mouseDown = true;
      
    }).mouseup(function(e) {
      window.previouslyGrabbedNode = window.grabbedNode;
      window.grabbedNode = null;
      mouseDown = false;
      
    }).mousemove(function(e){
      if(mouseDown && !shiftDown && window.grabbedNode) {
        // if we have a grabbed node, move it
        if(grabbedNode != null) {
          var xPos = e.pageX - positionData.left;
          var yPos = e.pageY - positionData.top;

          grabbedNode.circle.setAttribute('cx', xPos);
          grabbedNode.circle.setAttribute('cy', yPos);
          grabbedNode.x = xPos;
          grabbedNode.y = yPos;
          
          // update the new line positions
          $(grabbedNode.connectedEdges).each(function() {
           this.object.graphicalLine.setAttributeNS(null, "x"+this.side, xPos);
           this.object.graphicalLine.setAttributeNS(null, "y"+this.side, yPos);
          });
        }
      }

      }).dblclick(function(e) {
     var offset = positionData;
     var xPos = e.pageX - offset.left;
     var yPos = e.pageY - offset.top;
     newNode = graph.addNode('node'+graph.nodeCount, xPos, yPos);
     newNode.draw();
   });
}

function Edge(container, x1, y1, x2, y2) {
  // the svg container that holds our graphics
  this.container = container;
  this.x1 = x1;
  this.y1 = y1;
  this.x2 = x2;
  this.y2 = y2;
  this.graphicalLine = null;
}

Edge.prototype.draw = function() {
  var svgNS = "http://www.w3.org/2000/svg";
  var xlinkNS = "http://www.w3.org/1999/xlink";
  
	var newEdge = document.createElementNS(svgNS,"line");

	newEdge.setAttributeNS(null, "x1", this.x1);
	newEdge.setAttributeNS(null, "x2", this.x2);
	newEdge.setAttributeNS(null, "y1", this.y1);
	newEdge.setAttributeNS(null, "y2", this.y2);
	newEdge.setAttributeNS(null, "stroke-width", 5);

	$(this.container).append(newEdge);
	
	// add the graphical line to the object
  this.graphicalLine = newEdge;
	
	return newEdge;
}
 
Graph.prototype.addNode = function(name, x, y, rad) {
  if(!rad) var rad = 20;
  var newNode = new Node(this.container, name, x, y, rad);
  this.nodes[name] = newNode;
  // increase our node count
  this.nodeCount++;
  return newNode;
}


Graph.prototype.addEdge = function(node1, node2) {
  
  var newEdge = new Edge(this.container, this.nodes[node1].x, this.nodes[node1].y, this.nodes[node2].x, this.nodes[node2].y);
  this.edges.push(newEdge);
  this.nodes[node1].connectNode(this.nodes[node2]);
  this.nodes[node2].connectNode(this.nodes[node1]);
  
  // this is where we add the edge to the node and specify which end it got
  var node1Edge = [];
  var node2Edge = [];
  
  node1Edge.object = newEdge;
  node1Edge.side = 1;
  this.nodes[node1].connectEdge(node1Edge);
  node2Edge.object = newEdge;
  node2Edge.side = 2;
  this.nodes[node2].connectEdge(node2Edge);
  
  return newEdge;
  
}
 
Graph.prototype.drawEdges = function() {
 // draw edges
 $(this.edges).each(function() {
    this.draw();
 });
}

Graph.prototype.drawNodes = function() {
 // draw nodes 
 for(node in this.nodes) {
   this.nodes[node].draw();
 }
}

// link a parent node to children nodes where the children circle around it
Graph.prototype.linkChildrenRadial = function(parent, childNodes) {
  console.log("Adding the following children as radial nodes around node "+parent.name+":");
  // this loop is used just for logging
  for(node in childNodes) {
    console.log(childNodes[node].name);
  }
  
  nodeCount = childNodes.length;
  
  for(node in childNodes) {

    childNodes[node].x = parent.x + (Math.cos((2 * Math.PI / nodeCount)*node)) * 3 * parent.rad;
    childNodes[node].y = parent.y + (Math.sin((2 * Math.PI / nodeCount)*node)) * 3 * parent.rad;
     
    this.addEdge(parent.name, childNodes[node].name);
  }
  
}
