df = mach1file("example_file.txt");

%print header info
disp(df.info)

disp(df.info("Date"))
disp(df.info("Load Cell Calibration Date"))

%print data
disp(df.data)

%save data to csv file
writetable(df.data, "example_output.txt")
