% Author: Zachary Chiang, Buenrostro Lab, Harvard University
% Uses cross correlation to register one stack to another in x and y

function[stackBr] = simple_offset(stackA, stackB)
    
    stackBr = stackB;
    
    % calculate correlation prior to registration
    
    max_corr = corr(stackA(:),stackB(:));
    pre_corr = max_corr;

    % take maximum intensity projections
    
    imgA = max(stackA,[],3);
    imgB = max(stackB,[],3);

    % perform cross correlation
    
    c = normxcorr2(imgB, imgA);
    [max_c, imax] = max(abs(c(:)));
    [ypeak, xpeak] = ind2sub(size(c),imax(1));
    corr_offset = [(xpeak-size(imgB,2)) (ypeak-size(imgB,1))];
    xoffset = corr_offset(1);
    yoffset = corr_offset(2);
    
    % calculate offset bounds
    
    xbegin_A = max(1+xoffset, 1);
    xend_A   = min(size(stackA,2), size(stackA,2)+xoffset);
    xbegin_B = max(1-xoffset, 1);
    xend_B   = min(size(stackA,2), size(stackA,2)-xoffset);
    
    ybegin_A = max(1+yoffset, 1);
    yend_A   = min(size(stackA,1), size(stackA,1)+yoffset);
    ybegin_B = max(1-yoffset, 1);
    yend_B   = min(size(stackA,1), size(stackA,1)-yoffset);
           
    % apply offsets
    
    stackBr(ybegin_A:yend_A,xbegin_A:xend_A,:) = stackB(ybegin_B:yend_B,xbegin_B:xend_B,:);
    stackBc(stackBr == 0) = mode(stackB(:));
    
end