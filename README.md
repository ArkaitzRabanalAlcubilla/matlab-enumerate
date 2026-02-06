# matlab-enumerate

Run `for` loops in MATLAB with automatic index tracking, just like Python's `enumerate()`.

MATLAB does not have a built-in `enumerate` function. While you can maintain a separate counter variable or loop over indices (`1:length(vec)`), these solutions can be verbose or less readable (especially when you need the value primarily). This repository provides a simple, clean, and user-friendly `enumerate` class to fill this gap.

## Table of Contents
- [Description](#description)
- [Installation](#installation)
- [Usage](#usage)
    - [Basic Usage (Struct Output)](#basic-usage-struct-output)
    - [Array Output](#array-output)
- [Examples](#examples)
- [Dependencies](#dependencies)
- [License](#license)

## Description

In Python, you can write:
```python
for idx, val in enumerate(my_list):
    print(idx, val)
```

In standard MATLAB, you often have to do:
```matlab
count = 0;
for val = my_list
    count = count + 1;
    % use count and val
end
```
OR
```matlab
for i = 1:length(my_list)
    val = my_list(i);
    % use i and val
end
```

With `enumerate.m`, you can simply write:
```matlab
for item = enumerate(my_list)
    fprintf('Index: %d, Value: %s\n', item.idx, item.val);
end
```

It supports:
- **Vectors** (Row and Column iterate correctly)
- **Matrices** (Iterates over columns, like standard MATLAB)
- **Cell Arrays**
- **Struct Arrays**

## Installation

### Option 1: Quick Start (For Beginners)
If you just want to use this function in a specific project:
1. Download the `enumerate.m` file.
2. Place it in the **same folder** (Current Working Directory) as your script.
3. That's it! You can now use `enumerate()` in your code.

### Option 2: Add to Path (Recommended for Frequent Use)
If you want `enumerate` to be available everywhere in MATLAB:
1. Save `enumerate.m` in a permanent folder (e.g., `Documents/MATLAB/MyFunctions`).
2. Open MATLAB.
3. Go to the **Home** tab -> **Set Path**.
4. Click **Add Folder** and select the folder where you saved `enumerate.m`.
5. Click **Save** and then **Close**.

Now `enumerate` is available in any script you write!

## Usage

### Basic Usage (Struct Output)
By default, `enumerate` returns a structure with `idx` and `val` fields for each iteration.

```matlab
data = ["apple", "banana", "cherry"];

for item = enumerate(data)
    disp(['Index: ', num2str(item.idx), ', Value: ', item.val]);
end
```
**Output:**
```
Index: 1, Value: apple
Index: 2, Value: banana
Index: 3, Value: cherry
```

### Array Output
If you prefer working with arrays (e.g., for performance or personal preference) and your data is numeric, you can use the `"array"` flag. It returns a vector `[index, value]` instead of a struct.

```matlab
data = [10, 20, 30];

for item = enumerate(data, "array")
    idx = item(1);
    val = item(2);
    fprintf('Idx: %d, Val: %d\n', idx, val);
end
```

## Examples
Check the [examples/](examples/) folder for complete scripts demonstrating different use cases, including matrices and cell arrays.

- `examples/Ex01_numeric_vector.m`: A runnable script showing how to use `enumerate` with **numeric vectors**.
- `examples/Ex02_matrix.m`: A runnable script showing how to use `enumerate` with **matrices**.
- `examples/Ex03_string_vector.m`: A runnable script showing how to use `enumerate` with **string vectors**.
- `examples/Ex04_cell_array.m`: A runnable script showing how to use `enumerate` with **cell arrays**.
- `examples/Ex05_array_output.m`: A runnable script showing how to use `enumerate` where the **iteration variable is an array**.


## Dependencies
- **MATLAB R2016b or later**.
- No external toolboxes required.

## License
This project is licensed under the **MIT License**.

See the [LICENSE](LICENSE) file for more details.
