import numpy as np
import random

class Dataset:
    def __init__(self, data, parameters=[]):
        self.parameters = parameters
        self.data = data
        self.size = np.size(data)
    
    def set_parameters(self, parameters):
        self.parameters = parameters
        
    def get_random_path(self, path_length):
        s = self.size
        i = random.randrage(path_length, s - path_length)
        return self.data[i:i+length]
    
    
