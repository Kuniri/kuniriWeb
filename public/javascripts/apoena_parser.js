// Require apoena.js to be imported before this

var apo_parser = {
  processClass: function(data) {
    diagram = new DiagramObject(data.getAttribute('name'));
    for(var i=0; i < data.children.length; i++) {
      console.log(data.children[i]);
      var name = data.children[i].tagName;
      if(name == "method") {
          this.processMethod(data.children[i], diagram);
      } else
      if(name == "variable") {
          this.processVariable(data.children[i], diagram);
      }
    }
  },
  processMethod: function(data, diagram) {
     method = new Method(data.getAttribute('name'));

    for(var i=0; i < data.children.length; i++) {
      console.log(data.children[i]);
      var name = data.children[i].tagName;
      if(name == "parameter") {
          this.processParameter(data.children[i], diagram, method);
      }
    }
  },
  processParameter: function(data, diagram, method) {
    prop = new Property(data.children[0].innerHTML, "float");
    console.log(prop);
    diagram.addProperty(method);
    for(var i=0; i < data.children.length; i++) {
      console.log(data.children[i]);
      var name = data.children[i].tagName;
    }
  },
  processVariable: function(data, diagram) {
  },
  xml: null
};

function import_class(xml_path) {
  xmlhttp = new XMLHttpRequest();
  xmlhttp.open("GET", xml_path, false);
  xmlhttp.send();

  apo_parser.xml = xmlhttp.responseXML;

  for(var i=0; i < apo_parser.xml.children.length; i++) {
    console.log(apo_parser.xml.children[i]);
    var name = apo_parser.xml.children[i].tagName;
    if(name == "class_data") {
      apo_parser.processClass(apo_parser.xml.children[i]);
    }
  }
};