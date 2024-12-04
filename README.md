# Mach1mat

Matlab file parser for biomomentum Mach-1 data files

## Overview

Mach1mat is a file parser for data files generated using the Mach-1 Motion software for controlling Biomomentum Mach-1 mechanical testers.  File information is read into a dictionary and file data is read into a table.

## Installation

Download the mach1file.m function file.  Either place in active code directory, or use ```addpath(genpath(<path to your directory>))``` to add the mach1file.m folder to your active code directory.

## Example script

``` matlab
addpath(genpath("/path/to/dir"));

df = mach1file("/path/to/input/file.txt")

%print header info
disp(df.info)

disp(df.info("Date"))
disp(df.info("Load Cell Calibration Date"))

%print data
disp(df.data)

%save data to csv file
writetable(df.data, "/path/to/output.csv")

```

## Mach1file object

**Arguments**
|      Name      |      Data Type      |     Description     |
|------|-----------|-------------|
|file_path | string | Location of Mach-1 text file to load | 

**Structure Attributes**

|      Name      |      Data Type      |     Description     |
|------|-----------|-------------|
| info | Dictionary | Dictionary of name/value pairs with all data in the info and function information blocks. |
| data | Table | Numerical data from Data file section |# mach1mat
