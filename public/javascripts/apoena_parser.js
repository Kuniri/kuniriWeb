// Require apoena.js to be imported before this

var apo_parser = {
  dx: 0,
  dy: 0,
  inheritanceData: [],
  diagramData: [],
  processClass: function(data) {
    diagram = new DiagramObject(data.getAttribute('name'));
    diagram.x = this.dx;
    diagram.y = this.dy;
    this.dx += 200;
    if(this.dx > 2500) {
      this.dx = 0;
      this.dy += 200;
    }
    for(var i=0; i < data.children.length; i++) {
      console.log(data.children[i]);
      var name = data.children[i].tagName;
      if(name == "method") {
          this.processMethod(data.children[i], diagram);
      } else
      if(name == "variable") {
          this.processVariable(data.children[i], diagram);
      }
      if(name == "inheritance") {
          this.inheritanceData.push([data.children[i].getAttribute('name'), diagram.name])
      }
    }
    this.diagramData.push(diagram);
  },
  processMethod: function(data, diagram) {
    method = new Method(data.getAttribute('name'));

    for(var i=0; i < data.children.length; i++) {
      console.log(data.children[i]);
      var name = data.children[i].tagName;
      if(name == "parameter") {
          this.processParameter(data.children[i], method);
      }
    }
    diagram.addProperty(method);
  },
  processParameter: function(data, method) {
    prop = new Property(data.getAttribute('name'), "float");
    console.log(prop);
    method.parameters.push(prop);
    for(var i=0; i < data.children.length; i++) {
      console.log(data.children[i]);
      var name = data.children[i].tagName;
    }
  },
  processVariable: function(data, diagram) {
  },
  xml: null
};

function get_diagram_by_name(dname) {
  for(var i=0; i < apo_parser.diagramData.length; i++) {
    if(apo_parser.diagramData[i].name == dname){
      return apo_parser.diagramData[i]
    }
  }
  return null;
}

function import_class(xml_path) {
  xmlhttp = new XMLHttpRequest();
  xmlhttp.open("GET", xml_path, false);
  xmlhttp.send();

  apo_parser.xml = xmlhttp.responseXML;
  // Remove the kuniri node
  apo_parser.xml = apo_parser.xml.children[0]

  for(var i=0; i < apo_parser.xml.children.length; i++) {
    console.log(apo_parser.xml.children[i]);
    var name = apo_parser.xml.children[i].tagName;
    if(name == "class_data") {
      apo_parser.processClass(apo_parser.xml.children[i]);
    }
  }

  for(var i=0; i < apo_parser.inheritanceData.length; i++) {
    l = new InheritanceLine();
    d1 = get_diagram_by_name(apo_parser.inheritanceData[i][0])
    d2 = get_diagram_by_name(apo_parser.inheritanceData[i][1])
    if(!d1 || !d2) {
      continue;
    }
    l.calculateLine(d1, d2);
  }
};