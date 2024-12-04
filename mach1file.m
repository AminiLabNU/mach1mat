function df = mach1file(fpath)
    
    arguments
        fpath (1,1) string %location of file to load
    end

    df = struct;
    df.info = dictionary;

    % Load data from file
    lines = readlines(fpath);

    %check if mach-1 file
    if isempty(find(lines == "<Mach-1 File>",1))
        error("Mach-1 file header missing")
    end

    % check for info block
    info_idx_start = find(lines == "<INFO>");

    info_idx_end = find(lines == "<END INFO>");

    if isempty(info_idx_start)
        warning("No info block found")
    elseif isempty(info_idx_end)
        error("INFO block not terminated with <END INFO>")
    elseif info_idx_end < info_idx_start
        error("<END INFO> located before <INFO> header")
    else
        %load info into dictionary
        for i=info_idx_start+1:info_idx_end-1
            
            info_line = lines(i);
    
            keyvalue = split(info_line, ":");
            keyvalue(2) = strip(keyvalue(2),"left",char(9));
    
            df.info(keyvalue(1))=keyvalue(2);
        end
        % load action
        action = lines(info_idx_end+1);
        action = strip(action,"left","<");
        action = strip(action,"right",">");
    
        df.info("Action") = action;
    
        data_idx_start = find(lines == "<DATA>");
    
        
        for i=info_idx_end+2:data_idx_start-1
            
            info_line = lines(i);
    
            keyvalue = split(info_line, ":");
            keyvalue(2) = strip(keyvalue(2),"left",char(9));
    
            df.info(keyvalue(1))=keyvalue(2);
        end
    end

    % load data

    data_idx_end = find(lines == "<END DATA>");

    tabledata = lines(data_idx_start+2:data_idx_end-1);

    header = lines(data_idx_start+1);
    header = split(header,char(9));

    ncol = length(header);
    nrow = height(tabledata);

    dtypes = repmat({'double'}, 1, ncol);

    df.data = table('Size',[nrow,ncol],'VariableTypes',dtypes,'VariableNames',header);

    for i=data_idx_start+2:data_idx_end-1

        line = lines(i);
        linedata = transpose(split(line,char(9)));

        new_row = str2double(linedata);
        new_row = array2table(new_row,'VariableNames',header);

        df.data(i-data_idx_start - 1,:) = new_row;

    end

end