function [M,P] = seamV_DP(E)
    M = zeros(size(E));
    P = M;
    M(1, :) = E(1, :);
    P(1, :) = -1*ones(1, size(E,2));
    
    num_rows = size(M,1);
    num_cols = size(M,2);
    
    for r = 2:num_rows
        for c = 1:num_cols
            % initialize smallest with the left-most possible value
            if (c ~= 1)
                smallest = M(r-1,c-1);
                P(r,c) = c-1;
            else
                smallest = M(r-1,c);
                P(r,c) = c;
            end

            % Compare smallest with the two values to the right of it
            if (smallest > M(r-1,c))
                smallest = M(r-1,c);
                P(r,c) = c;
            end
            if (c ~= num_cols && smallest > M(r-1,c+1))
                smallest = M(r-1,c+1);
                P(r,c) = c+1;
            end
           
            M(r,c)= E(r,c) + smallest;
          
        end
    end
    
   
end
