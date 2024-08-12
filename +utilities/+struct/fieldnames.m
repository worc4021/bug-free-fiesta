function fields = fieldnames(str,parent)
arguments
    str (1,1) struct
    parent (1,1) string = ""
end

fields = strings(1,0);

for field = fieldnames(str)'
    if isstruct(str.(field{1}))
        if isscalar(str.(field{1}))
            tmp = utilities.struct.fieldnames(str.(field{1})(1),field{1});
            fields = cat(2,fields,tmp);
        else
            for i = 1:numel(str.(field{1}))
                tmp = utilities.struct.fieldnames(str.(field{1})(i),sprintf('%s(%d)',field{1},i));
                fields = cat(2,fields,tmp);
            end
        end
    else
        if parent == ""
            fields(end+1) = string(field{1});
        else
            fields(end+1) = parent + "." + field{1};
        end
    end
end

end

