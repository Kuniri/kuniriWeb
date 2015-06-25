
id = document.getElementById("class_diagram").getAttribute("userID")
project_name = document.getElementById("class_diagram").getAttribute("projectName")
apo.reloadCanvas("class_diagram")
import_class("class_data.xml")
apo.draw()

//public/id_user/projectName/class_data.xml
