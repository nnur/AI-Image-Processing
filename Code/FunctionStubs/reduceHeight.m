function [seam,im,c] = reduceHeight(im4,E)
    im4 = permute(im4,[2 1 3]);
   [seam, im, c] = reduceWidth(im4, E');
   im = permute(im,[2 1 3]);
end
