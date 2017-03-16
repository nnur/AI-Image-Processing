function eng = computeEngGrad(im,F)
    imG = (im(:,:,1) + im(:,:,2) + im(:,:,3))/3 ;
    
    horz_grad = applyFilter(imG, F);   
    vert_grad = applyFilter(imG, F');
     
    eng = (horz_grad.^2 + vert_grad.^2).^0.5 ;
    
end
