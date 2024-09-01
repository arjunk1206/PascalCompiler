import nltk
from nltk.tree import Tree
import matplotlib.pyplot as plt

# open text file in read mode
text_file = open("tree.txt", "r")

# read whole file to a string
data = text_file.read()

# close file
text_file.close()

print(data)
tree=Tree.fromstring(data)

with open("AST.txt", "w") as file:
    # Print the tree's structure to the file
    tree.pretty_print(stream=file)

print("Tree structure saved to AST.txt")

# import nltk
# from nltk.tree import Tree

# # Read the tree from the file
# with open("tree.txt", "r") as file:
#     tree_str = file.read()

# # Parse the tree string
# tree = Tree.fromstring(tree_str)

# # Visualize the tree graphically
# tree.draw()

# from nltk.tree import *

# # assign your output (generalied list of the syntax tree) to varaible text
# f = open('tree.txt', 'r')

# text = f.readlines()[0]
# f.close()




# # text = text.replace("(", "ob")    #in the syntax tree, 'ob' will display in place of '('
# # text = text.replace(")", "cb")    #in the syntax tree, 'cb' will display in place of ')'
# # text = text.replace("[", "(")
# # text = text.replace("]", ")")


# tree = Tree.fromstring(text)
# tree.pretty_print(unicodelines=True, nodedist=10)   