extends Node

class_name BinarySearch


# searches a sorted array of integers for the integer x
# using a recursive implementation of binary search
#
# returns: the index of x or -1 if x is not found
#
# sortedArray: the array where x needs to be found in
# x: the number to search for
# left: the left index of the array
# right: the right index of the array
func search_recursive(sortedArray: Array, x: int, left: int, right: int):
    if left > right || len(sortedArray) <= right || left < 0:
        return -1 # early abort for invalid input
        
    # to avoid integer overflows, we can't just use (left + right) / 2
    var mid: int = left + ((right - left) / 2)
    
    if sortedArray[mid] == x:
        # index of x found
        return mid
    if x < sortedArray[mid]:
        # continue search in left part of the array
        return search_recursive(sortedArray, x, left, mid - 1)
    else:
        # continue search in right part of the array
        return search_recursive(sortedArray, x, mid + 1, right)


# searches a sorted array of integers for the integer x
# using an iterative implementation of binary search
#
# returns: the index of x or -1 if x is not found
#
# sortedArray: the array where x needs to be found in
# x: the number to search for
func search_iterative(sortedArray: Array, x: int):
    var left: int = 0
    var right: int = len(sortedArray)
    
    while left <= right:
        # to avoid integer overflows, we can't just use (left + right) / 2
        var mid: int = left + ((right - left) / 2)
        
        if sortedArray[mid] == x:
            # index of x found
            return mid
        if x < sortedArray[mid]:
            # continue search in left part of the array
            right = mid - 1
        else:
            # continue search in right part of the array
            left = mid + 1
    
    # if the index was not found, return -1
    return -1


# searches a sorted array of integers for the integer x
# one step at a time for the animation
#
# returns: an array of size 3
#    arr[0]: the left search index
#    arr[1]: the right search index
#    arr[3]: the index of x or -1 if not found
#
# sortedArray: the array where x needs to be found in
# x: the number to search for
# left: the left index of the array
# right: the right index of the array
func search_iterative_single_step(sortedArray: Array, x: int, left: int, right: int):
    # to avoid integer overflows, we can't just use (left + right) / 2
    var mid: int = left + ((right - left) / 2)
    
    if sortedArray[mid] == x:
        # index of x found
        return [mid, mid, mid]
    
    # index not found, update search space
    if x < sortedArray[mid]:
        # continue search in left part of the array
        right = mid - 1
    else:
        # continue search in right part of the array
        left = mid + 1
        
    return [left, right, -1]
