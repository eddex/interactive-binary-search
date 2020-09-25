extends "res://addons/gut/test.gd"


func test_recursive_search_with_match_returns_expected_index():
    
    var binarySearch: BinarySearch = BinarySearch.new()
    var sortedArray: Array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    var x: int = 3
    
    var index: int = binarySearch.search_recursive(sortedArray, x, 0, len(sortedArray) - 1)
    
    self.assert_eq(2, index)
    
    binarySearch.free()


func test_recursive_search_without_match_returns_negative_one():
    
    var binarySearch: BinarySearch = BinarySearch.new()
    var sortedArray: Array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    var x: int = 11
    
    var index: int = binarySearch.search_recursive(sortedArray, x, 0, len(sortedArray) - 1)
    
    self.assert_eq(-1, index)
    
    binarySearch.free()
    

func test_recursive_search_with_left_below_zero_returns_negative_one():
    
    var binarySearch: BinarySearch = BinarySearch.new()
    var sortedArray: Array = [1, 2]
    var x: int = 1
    
    var index: int = binarySearch.search_recursive(sortedArray, x, -1, len(sortedArray) - 1)
    
    self.assert_eq(-1, index)
    
    binarySearch.free()


func test_recursive_search_with_right_bigger_than_max_index_returns_negative_one():
    
    var binarySearch: BinarySearch = BinarySearch.new()
    var sortedArray: Array = [1, 2]
    var x: int = 1
    
    var index: int = binarySearch.search_recursive(sortedArray, x, -1, 2)
    
    self.assert_eq(-1, index)
    
    binarySearch.free()
    
    
func test_iterative_search_with_match_returns_expected_index():
    
    var binarySearch: BinarySearch = BinarySearch.new()
    var sortedArray: Array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    var x: int = 9
    
    var index: int = binarySearch.search_recursive(sortedArray, x, 0, len(sortedArray) - 1)
    
    self.assert_eq(8, index)
    
    binarySearch.free()


func test_iterative_search_without_match_returns_negative_one():
    
    var binarySearch: BinarySearch = BinarySearch.new()
    var sortedArray: Array = [8, 88, 888, 8888]
    var x: int = 17
    
    var index: int = binarySearch.search_recursive(sortedArray, x, 0, len(sortedArray) - 1)
    
    self.assert_eq(-1, index)
    
    binarySearch.free()
    

func test_iterative_search_with_left_below_zero_returns_negative_one():
    
    var binarySearch: BinarySearch = BinarySearch.new()
    var sortedArray: Array = [42, 69]
    var x: int = 42
    
    var index: int = binarySearch.search_recursive(sortedArray, x, -1, len(sortedArray) - 1)
    
    self.assert_eq(-1, index)
    
    binarySearch.free()


func test_iterative_search_with_right_bigger_than_max_index_returns_negative_one():
    
    var binarySearch: BinarySearch = BinarySearch.new()
    var sortedArray: Array = [5, 7, 10]
    var x: int = 10
    
    var index: int = binarySearch.search_recursive(sortedArray, x, -1, 3)
    
    self.assert_eq(-1, index)
    
    binarySearch.free()
