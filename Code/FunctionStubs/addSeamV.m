function imOut = addSeamV(im4,seam)
    r = size(im4, 1);
    c = size(im4, 2);
    imOut = zeros(r, c+1, size(im4, 3));
    

    for i = 1:r
        for j = 1:c
            if (j == 1)
                k = 1;
            end
            imOut(i, k, :) = im4(i, j, :);
            k = k + 1;
            if (j == seam(i))
                imOut(i, k, :) = im4(i, j, :);
                k = k + 1;
            end
          
        end
    end
end

