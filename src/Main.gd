extends Control


var binarySearch: BinarySearch
var colorSquareScene = preload("res://src/ColorSquare.tscn")
var sortedItems: Array
var left: int = 0
var right: int
var arrow: TextureRect
var searchTarget: ColorSquare
var searchedColor: int
var logTextBox: RichTextLabel
var random: RandomNumberGenerator = RandomNumberGenerator.new()

# colors represented as integers, sorted by integer value
var colors: Array = [
    379618815, # Greensea
    448568575, # Turquoise
    665739519, # Nephritis
    742281471, # Midnightblue
    877223679, # Wetasphalt
    882433023, # Peterriver
    2386865663, # Wisteria
    2606348031, # Amethyst
    3867026175, # Carrot
    3880533247, # Alizarin
    4056158207, # Sunflower
]


# signal handlers

func _ready():
    self.binarySearch = BinarySearch.new()
    self.arrow = self.get_node("CurrentPositionArrow")
    self.searchTarget = self.get_node("SearchTarget")
    self.logTextBox = self.get_node("LogTextbox")

    self.random.randomize()
    self.change_search_target(
        self.colors[random.randi_range(0, len(self.colors) - 1)])

    for i in range(len(self.colors)):
        yield(get_tree().create_timer(0.1), "timeout")
        self.spawn_color_square(25 + i*170, colors[i], i)

    self.get_node("AnimateOneStepButton").disabled = false
    self.get_node("ResetButton").disabled = false

    self.initialize_search_indices()

    self.update_arrow_position()
    self.arrow.visible = true


func _on_AnimateOneStepButton_pressed():
    var result: Array = self.binarySearch.search_iterative_single_step(
        self.colors,
        self.searchedColor,
        self.left,
        self.right)

    var compareMessage: String = str("Compare search target color (", int(self.searchedColor/1000), ") and color at search index (", int(self.colors[self.get_search_index()]/1000), ")\n")
    if self.left != result[0] && self.right == result[1]:
        self.logTextBox.text += str(
            compareMessage,
            "Search target color is bigger than color at search index.\n",
            "Continuing search on the right side of the search index.\n")
    elif self.left == result[0] && self.right != result[1] && result[2] == -1:
        self.logTextBox.text += str(
            compareMessage,
            "Search target color is smaller than color at search index.\n",
            "Continuing search on the left side of the search index.\n")

    self.left = result[0]
    self.right = result[1]

    self.update_color_square_alpha()

    if result[2] != -1:
        print(str("item found at index: ", result[2]))
        self.logTextBox.text += str(compareMessage, "Found color ", int(self.searchedColor/1000), " at index ", result[2], ".\n")
        return

    if self.left <= self.right:
        # target not found yet, move to next search position
        yield(get_tree().create_timer(0.5), "timeout")
        self.update_arrow_position()
    else:
        self.logTextBox.text += str("\nColor ", int(self.searchedColor/1000), " was not found in the search space.\n")


func _on_ResetButton_pressed():
    self.logTextBox.text = "Starting binary search in the middle of the search space\n"
    self.initialize_search_indices()
    for item in self.sortedItems:
        item.reset_alpha()
    self.update_arrow_position()


func _on_RandomExistingItemButton_pressed():
    self._on_ResetButton_pressed()
    self.random.randomize()
    self.change_search_target(
        self.colors[random.randi_range(0, len(self.colors) - 1)])


func _on_RandomMissingItemButton_pressed():
    self._on_ResetButton_pressed()
    self.random.randomize()
    self.change_search_target(random.randi_range(255, 5000000000))


# methods

func update_arrow_position():
    var mid: int = self.get_search_index()
    self.arrow.rect_position = Vector2(68 + mid*170, self.arrow.rect_position.y)
    self.logTextBox.text += str("New search index: ", mid, "\n\n")


func get_search_index():
    return self.left + ((self.right - self.left) / 2)


func spawn_color_square(x: int, color: int, index: int):
    var item: ColorSquare = self.colorSquareScene.instance()
    item.rect_position = Vector2(x, 0)
    item.anchor_top = 0.11
    item.set_color(color)
    item.set_index(index)
    self.sortedItems.append(item)
    self.add_child(item)


func update_color_square_alpha():
    for i in range(len(self.sortedItems)):
        if i < self.left || i > self.right:
            self.sortedItems[i].reduce_alpha()


func initialize_search_indices():
    self.left = 0
    self.right = len(self.sortedItems) - 1


func change_search_target(color: int):
    self.searchTarget.set_color(color)
    self.searchTarget.set_index("?")
    self.searchedColor = color
    self.logTextBox.text += str("Search target changed to color: ", int(color/10000), "\n")
