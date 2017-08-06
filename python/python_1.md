---
title: numpy
date: 2016-11-14 14:54:27
tags: [Python]
categories: [Python]
---

import numpy as np
# numpy.zeros(shape, dtype=float, order='C')

Parameters:
- shape : int or sequence of ints
        Shape of the new array, e.g., (2, 3) or 2.
- dtype : data-type, optional
The desired data-type for the array, e.g., numpy.int8. Default is numpy.float64.
- order : {‘C’, ‘F’}, optional
Whether to store multidimensional data in C- or Fortran-contiguous (row- or column-wise) order in memory.
Returns:
- out : ndarray
Array of zeros with the given shape, dtype, and order.

```
>>> np.zeros((2, 1))
array([[ 0.],
       [ 0.]])
```
# numpy.concatenate((a1, a2, ...), axis=0)
Join a sequence of arrays along an existing axis.

Parameters:
a1, a2, ... : sequence of array_like
The arrays must have the same shape, except in the dimension corresponding to axis (the first, by default).
axis : int, optional
The axis along which the arrays will be joined. Default is 0.
Returns:
res : ndarray
The concatenated array.

``` python
>>> a = np.array([[1, 2], [3, 4]])
>>> b = np.array([[5, 6]])
>>> np.concatenate((a, b), axis=0)
array([[1, 2],
       [3, 4],
       [5, 6]])
>>> np.concatenate((a, b.T), axis=1)
array([[1, 2, 5],
       [3, 4, 6]])
```
