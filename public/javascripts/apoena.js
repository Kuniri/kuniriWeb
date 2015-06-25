/**** TODO *****

- Make move and click events for Diagram classes
- Extend Line class to support the diagram class model
- Make animationRequestFrame stop when mouse outside (performance)
- Make animationRequestFrame start when mouse over canvas if not started (performance)
- Smart lines, now it always go right-down from A to B
- Separate variables and methods of DiagramObj

***************/

/****** Base ******/
function canvasMouseClickListener(event) {
  for(var i=0; i < apo.entitylist.length; i++) {
    apo.entitylist[i].mouseclick(event);
  }
};
function canvasMouseMoveListener(event) {
  for(var i=0; i < apo.entitylist.length; i++) {
    apo.entitylist[i].mousemove(event);
  }
};
var apo = {
  cavas: document.getElementById('samplecanvas'),
  ctx: null,
  getMousePos: function(event) {
    var rect = apo.canvas.getBoundingClientRect();
    return {x: event.clientX - rect.left, y: event.clientY - rect.top }
  },
  reloadCanvas: function(canvasID) {
    this.canvas = document.getElementById(canvasID);
    if (!this.canvas.getContext) {
      console.log("Canvas not supported");
      return false;
    }
    this.ctx = this.canvas.getContext('2d');
    this.canvas.addEventListener('click', canvasMouseClickListener);
    this.canvas.addEventListener('mousemove', canvasMouseMoveListener);
    return true;
  },
  entitylist: [],
  draw: function() {
    apo.ctx.clearRect(0, 0, apo.canvas.width, apo.canvas.height);
    for(var i=0; i < apo.entitylist.length; i++){
      apo.entitylist[i].draw();
    }
    window.requestAnimationFrame(apo.draw);
  }
};

/******* Classes *******/

function Point() {
  this.x = 0;
  this.y = 0;
};

function Point(x, y) {
  this.x = x;
  this.y = y;
};

function Drawable() {
  this.name = 'draw';
};

Drawable.prototype.draw = function() {
  console.log('draw function not implemented');
};

Drawable.prototype.mousemove = function(event){
};

Drawable.prototype.mouseclick = function(event){
};

/// ---- Line class ---- ///
Line.prototype = new Drawable();
Line.prototype.constructor=Line;

function Line() {
  //Drawable.call(this);
  this.points = [new Point(), new Point(), new Point()];
  this.A = null;
  this.B = null;
  apo.entitylist.push(this);
  this.textA = '';
  this.textB = '';
};

Line.prototype.recalculateLine = function(A, B) {

  if(typeof A != 'undefined')
    this.A = A;
  if(typeof B != 'undefined')
    this.B = B;

  var cax = this.A.x+this.A.width/2.0;
  var cay = this.A.y+this.A.height/2.0;
  var cbx = this.B.x+this.B.width/2.0;
  var cby = this.B.y+this.B.height/2.0;

  this.points[0].x = cax; this.points[0].y = cay;
  this.points[1].x = cbx; this.points[1].y = cay;
  this.points[2].x = cbx; this.points[2].y = cby;


  // Set lines to the boundary of the diagram
  if(this.points[0].x < this.points[1].x) {
    this.points[0].x += this.A.width/2.0;
  }else{
    this.points[0].x -= this.A.width/2.0;
  }
  if(this.points[2].y < this.points[1].y) {
    this.points[2].y += this.B.height/2.0;
  }else{
    this.points[2].y -= this.B.height/2.0;
  }
};

Line.prototype.calculateLine = function(A, B) {
  this.recalculateLine(A, B);
  A.lines.push(this);
  B.lines.push(this);
};

Line.prototype.draw = function() {
  if(this.points.length == 0) return;

  apo.ctx.beginPath();
  apo.ctx.fillStyle = "Black";
  apo.ctx.moveTo(this.points[0].x, this.points[0].y);

  for(var i=1; i < this.points.length; i++) {
    apo.ctx.lineTo(this.points[i].x, this.points[i].y);
  }
  apo.ctx.stroke();

  apo.ctx.font = "12px Times New Roman";
  apo.ctx.fillStyle = "Black";
  if(this.textA) {
    var dx = 0;
    if(this.points[0].x > this.points[1].x){
      dx = apo.ctx.measureText(this.textA).width+10;
    }
    apo.ctx.fillText(this.textA, this.points[0].x+5-dx, this.points[0].y-12);
  }
  if(this.textB) {
    var dy = 0;
    if(this.points[2].y < this.points[1].y){
      dy = 30;
    }
    var lastI = this.points.length-1;
    apo.ctx.fillText(this.textB, this.points[lastI].x+5, dy+this.points[lastI].y-12);
  }
};

InheritanceLine.prototype = new Line();
InheritanceLine.prototype.constructor=InheritanceLine;

function InheritanceLine() {
  Line.call(this);
};

InheritanceLine.prototype.draw = function() {
  if(!this.A || !this.B) return;
  Line.prototype.draw.call(this);
  var path = new Path2D();

  var px = this.points[0].x;
  var py = this.points[0].y;
  var size = 10;

  var horizontalArrow = true
  if(px == this.points[1].x){
    horizontalArrow = false;
  }

  if(horizontalArrow) {
    if(px > this.points[1].x) {
      size = -size;
    }
    path.moveTo(px, py);
    path.lineTo(px+size, py-size);
    path.lineTo(px+size, py+size);
  } else {
    if(py < this.points[1].y){
      size = -size;
    }
    path.moveTo(px, py);
    path.lineTo(px+size, py+size);
    path.lineTo(px-size, py+size);
  }
  apo.ctx.fill(path);
};

/// ---- Diagram class ---- ///
DiagramObject.prototype = new Drawable();
DiagramObject.prototype.constructor=DiagramObject;

function DiagramObject(name) {
  Drawable.call(this);

  if(typeof name != 'undefined')
    this.name = name;
  else
    this.name="DiagramObject";
  this.x = 0;
  this.y = 0;
  apo.ctx.font = "20px Times New Roman";
  this.width = apo.ctx.measureText(this.name).width+10;
  this.height = 30+20;
  this.properties = [];
  this.lines = [];
  this.drag = false;

  this.offset = {x:0, y:0}

  apo.entitylist.push(this);
  console.log("Diagram created");
};

DiagramObject.prototype.mousemove = function(event) {
  if(this.drag) {
    var rect = apo.canvas.getBoundingClientRect();
    this.x = event.clientX - rect.left - this.offset.x;
    this.y = event.clientY - rect.top - this.offset.y;
    this.reloadLines();
  }
};

DiagramObject.prototype.mouseclick = function(event) {
  var mouse = apo.getMousePos(event);
  if( mouse.x > this.x &&
      mouse.y > this.y &&
      mouse.x-this.width < this.x &&
      mouse.y-this.height < this.y) {
    this.drag = !this.drag;
    this.offset.x = mouse.x - this.x;
    this.offset.y = mouse.y - this.y;
  }
};

DiagramObject.prototype.setPos = function(x, y) {
  this.x = x;
  this.y = y;
};

DiagramObject.prototype.draw = function() {
  apo.ctx.fillStyle = "rgb(180,150,100)";
  apo.ctx.fillRect(this.x, this.y, this.width, this.height);
  apo.ctx.fillStyle = "Black";
  apo.ctx.strokeRect(this.x, this.y, this.width, this.height);

  apo.ctx.font = "20px Times New Roman";
  apo.ctx.fillStyle = "Black";
  apo.ctx.shadowOffsetX = 1;
  apo.ctx.shadowOffsetY = 1;
  apo.ctx.shadowBlur = 2;
  apo.ctx.shadowColor = "rgba(0,0,0,0.5)";
  apo.ctx.fillText(this.name, this.x+5, this.y+20);

  //Spacing after name, 5+height(20)+5
  apo.ctx.beginPath();
  apo.ctx.moveTo(this.x, this.y+30);
  apo.ctx.lineTo(this.x+this.width, this.y+30);
  apo.ctx.stroke();

  //Objects
  apo.ctx.font = "15px Times New Roman";
  apo.ctx.shadowBlur = 0;
  apo.ctx.shadowOffsetX = 0;
  apo.ctx.shadowOffsetY = 0;
  apo.ctx.shadowColor = "rgba(0,0,0,1)";
  for(var i=0; i < this.properties.length; i++) {
    this.properties[i].draw(this.x+5, this.y+35+15+20*i);
  }

};

DiagramObject.prototype.reloadLines = function() {
  for(var i=0; i < this.lines.length; i++) {
      this.lines[i].recalculateLine();
    }
}

DiagramObject.prototype.addProperty = function(obj) {
  this.height += 15;
  var objWidth = obj.getWidth();
  if(objWidth > this.width) {
    this.width = objWidth;
    this.reloadLines();
  }
  this.properties.push(obj);
};

/// ---- Properties end ---- ///
var visibility = {
  public: 0,
  private: 1,
  protected: 2
};

function Property() {
  this.name = "Property";
  this.visibility = visibility.public;
  this.type = null;
};

function Property(name, type) {
  this.name = name;
  this.visibility = visibility.public;
  this.type = type;
};

Property.prototype.getWidth = function() {
  return 15;
}

Property.prototype.draw = function(x, y) {
  switch(this.visibility) {
    case visibility.public:
      apo.ctx.fillText("+", x, y);
      break;
    case visibility.private:
      apo.ctx.fillText("-", x, y);
      break;
    case visibility.protected:
      apo.ctx.fillText("_", x, y);
      break;
  }
};

Variable.prototype = new Property();
Variable.prototype.constructor=Variable;

function Variable(name, type) {
  Property.call(this);
  if(typeof name != 'undefined')
    this.name = name;
  if(typeof type != 'undefined')
    this.type = type;
};

Variable.prototype.getWidth = function() {
  apo.ctx.font = "15px Times New Roman";
  var len = Property.prototype.getWidth.call(this);
  len += apo.ctx.measureText(this.type+"  : "+this.name).width;
  return len;
}

Variable.prototype.draw = function(x, y) {
  Property.prototype.draw.call(this, x, y);

  var len = apo.ctx.measureText(this.type+" : ");
  apo.ctx.fillText(this.type+" : ", x+10, y);
  apo.ctx.fillText(this.name, x+10+len.width, y);
};

Method.prototype = new Property();
Method.prototype.constructor=Method;

function Method(name, type) {
  Property.call(this);
  if(typeof name != 'undefined')
    this.name = name;
  if(typeof type != 'undefined')
    this.type = type;

  this.parameters = []
};

// Should use the following example format
// int methodCall(int : variableName, int : variable2)
Method.prototype.getWidth = function() {
  apo.ctx.font = "15px Times New Roman";
  var len = Property.prototype.getWidth.call(this);
  len += apo.ctx.measureText(this.type+" : "+this.name+"(").width;

  for(var i=0; i < this.parameters.length; i++) {
    len += apo.ctx.measureText(this.parameters[i].type +" : "+this.parameters[i].name).width;
    if(i != this.parameters.length-1){
      len += apo.ctx.measureText(", ").width;
    }
  }
  len += apo.ctx.measureText(") ").width;
  return len;
}

Method.prototype.draw = function(x, y) {
  Property.prototype.draw.call(this, x, y);

  var len = apo.ctx.measureText(this.type+" : ");
  apo.ctx.fillText(this.type+" : ", x+10, y);
  var text = this.name + "(";
  for(var i=0; i < this.parameters.length; i++) {
    text += this.parameters[i].type + " : " + this.parameters[i].name;
    if(i != this.parameters.length-1) {
      text += ", ";
    }
  }
  text += ")";
  apo.ctx.fillText(text, x+10+len.width, y);
};

/***** End Classes *****/