%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Performs foreground/background segmentation based on a graph cut
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% INPUT: 
%        im: input image  in double format 
%        scribbleMask: 
%               scribbleMask(i,j) = 2 means pixel(i,j) is a foreground seed
%               scribbleMask(i,j) = 1 means pixel(i,j) is a background seed
%               scribbleMask(i,j) = 0 means pixel(i,j) is not a seed
%        lambda: parameter for graph cuts
%        numClusters: parameter for kmeans
%        inftCost: parameter for infinity cost constraints
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% OUTPUT:   segm is the segmentation mask of the  same size as input image im
%           segm(i,j) = 1 means pixel (i,j) is the foreground
%           segm(i,j) = 0 means pixel (i,j) is the background
%
%           eng_finish: the energy of the computed segmentation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [segm,eng_finish]  = segmentGC(im,scribbleMask,lambda,numClusters,inftyCost)
    [row,col,d] = size(im);
    D_bg = zeros(row, col);
    D_fg = D_bg;
    
    if (exist('numClusters','var') == 0)
        numClusters = 0;
    end   
    if (exist('lambda','var') == 0)
        lambda = 1;
    end  
    if (exist('inftyCost','var') == 0)
       inftyCost = 1000;
    end 
    
    if (numClusters > 0)
        flatIm = reshape(im, [], d);
        
        clusters = kmeans(flatIm, numClusters, 'MaxIter', 150);
        clusters = reshape(clusters, row, col);
        
        fg_indices = find(scribbleMask == 2);
        bg_indices = find(scribbleMask == 1);
        binRange = 1:numClusters;
        fg_count = hist(clusters(fg_indices), binRange)+1;
        bg_count = hist(clusters(bg_indices), binRange)+1;
        
        total_fg = sum(fg_count);
        total_bg = sum(bg_count);
        
        norm_fg_count = fg_count/total_fg;
        norm_bg_count = bg_count/total_bg;
        
        fg_cost = -1*log(norm_fg_count);
        bg_cost = -1*log(norm_bg_count);
        
        D_bg = bg_cost(clusters);
        D_fg = fg_cost(clusters);
            
    else
        D_bg((scribbleMask == 2)) = inftyCost;
        D_fg((scribbleMask == 1)) = inftyCost;
    end
    
    D_bg = reshape(D_bg, 1, []);
    D_fg = reshape(D_fg, 1, []);
    
    imG = (im(:,:,1) + im(:,:,2) + im(:,:,3))/3 ;
    
    indices = 1:(row*col);
    % matrix of pixel names
    indices = reshape(indices,row,col);
    
    % start pixel of each vertical edge
    vert_edges0 = reshape(indices(1:end-1,:),[],1);
    % end pixel of each vertical edge
    vert_edges1 = vert_edges0 + 1;
    
    % start pixel of each horizontal edge
    horz_edges0 = reshape(indices(:,1:end-1),[],1);
    % end pixel of each horizontal edge
    horz_edges1 = horz_edges0 + row;
    
    % put together to create edge pairs
    horz_edges = [horz_edges0, horz_edges1];
    vert_edges = [vert_edges0, vert_edges1];
    horz_edges_flipped = [horz_edges1, horz_edges0];
    vert_edges_flipped = [vert_edges1, vert_edges0];
    
    % create list of all edges
    W = [horz_edges; vert_edges];
    % get sigma
    sigma = sum(( imG(W(:,1)) - imG(W(:,2)) ).^2)/(size(W,1))
    
    
    % get weights
    weights = lambda*exp(-1*(( imG(W(:,1)) - imG(W(:,2)) ).^2)/(2*sigma));
    % include edges going in the other direction
    W = [horz_edges; vert_edges; horz_edges_flipped; vert_edges_flipped];
    weights = [weights; weights];
    W_ = [W, weights];
    
    [labels,~,eng_finish] = solveMinCut(D_bg, D_fg, W_);
    
    segm = reshape(labels, row, col);

        