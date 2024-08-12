function value = getfield(str,fieldname)
arguments
    str (1,1) struct
    fieldname (1,1) string
end

fieldparts = strsplit(char(fieldname),'.');
if numel(fieldparts) > 1
    m = regexp(fieldparts{1},'(?<field>[^\(]+)\((?<index>\d+)\)','names');
    if isempty(m)
        substruct = str.(fieldparts{1});
    else
        substruct = str.(m.field)(str2double(m.index));
    end
    value = utilities.struct.getfield(substruct,strjoin(fieldparts(2:end),'.'));
else
    value = str.(fieldparts{1});
end

end

