function bSuccess = assignIfPossible(h,fieldname,value)
arguments
    h (1,1) handle
    fieldname (1,:) char
    value 
end

fieldparts = strsplit(fieldname,'.');
m = regexp(fieldparts{1},'(?<field>[^\(]+)\((?<index>\d+)\)','names');

if numel(fieldparts)>1
    if isempty(m)
        if isprop(h,fieldparts{1})
            hNext = h.(fieldparts{1});
        else
            return
        end
    else
        if isprop(h,m.field)
            hNext = h.(m.field)(str2double(m.index));
        else
            return
        end
    end
    bSuccess = utilities.struct.assignIfPossible(hNext,strjoin(fieldparts(2:end),'.'),value);
else
    if isempty(m)
        if isprop(h,fieldparts{1})
            h.(fieldparts{1}) = value;
            bSuccess = true;
        else
            bSuccess = false;
        end
    else
        if isprop(h,m.field)
            h.(m.field)(str2double(m.index)) = value;
            bSuccess = true;
        else
            bSuccess = false;
        end
    end
end

end

