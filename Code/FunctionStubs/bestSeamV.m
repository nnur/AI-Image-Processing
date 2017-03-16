function [seam,c] = bestSeamV(M,P)
     [c,I] = min(M(end, :));
     
     num_rows = size(M,1);
     seam = zeros(num_rows,1);
     seam(end) = I;
     
     for i = 1:num_rows-1
        I = P(num_rows-i+1, I); 
        seam(num_rows-i) = I;
     end
     
     
end

