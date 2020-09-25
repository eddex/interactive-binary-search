extends Control

class_name ColorSquare


func set_color(color: int):
    var colorRect: ColorRect = self.get_node("ColorRect")
    colorRect.color = Color(color)
    
    var label: Label = colorRect.get_node("Label")
    label.text = str(int(color/10000))


func set_index(index):
    self.get_node("ColorRect/PositionLabel").text = str(index)


func reduce_alpha():
    var overlay: Panel = self.get_node("Overlay")
    overlay.visible = true
    
    
func reset_alpha():
    var overlay: Panel = self.get_node("Overlay")
    overlay.visible = false
