function outIm = applyFilter(im,F)

    [num_rows, num_columns] = size(im);
    
    outIm = zeros(num_rows, num_columns);
    
    [r,c] = size(F);
    row_padding = floor(r/2);
    column_padding = floor(c/2);

    im = padarray(im, [row_padding,column_padding]);
   
    
    for x = 1:num_rows
        for y = 1:num_columns
            matrix = F .* im(x:r+x-1, y:c+y-1);
            outIm(x,y) = sum(matrix(:));
        end
    end
end
