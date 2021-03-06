% Author: Zachary Chiang, Buenrostro Lab, Harvard University
% Apply an offset in x, y, and z calculated using simple_offset_xyz.m

function[stackCr] = simple_offset_xyz_applied(stackC,offsets)
   
    % pre-set output

    stackCr = uint16(zeros(size(stackC)));

    % get offsets
    
    xoffset = offsets(1);
    yoffset = offsets(2);
    zoffset = offsets(3);
    
    % calculate offset bounds
    
    xbegin_A = max(1+xoffset, 1);
    xend_A   = min(size(stackC,2), size(stackC,2)+xoffset);
    xbegin_B = max(1-xoffset, 1);
    xend_B   = min(size(stackC,2), size(stackC,2)-xoffset);
    
    ybegin_A = max(1+yoffset, 1);
    yend_A   = min(size(stackC,2), size(stackC,2)+yoffset);
    ybegin_B = max(1-yoffset, 1);
    yend_B   = min(size(stackC,2), size(stackC,2)-yoffset);
    
    zbegin_A = max(1+zoffset, 1);
    zend_A   = min(size(stackC,3), size(stackC,3)+zoffset);
    zbegin_B = max(1-zoffset, 1);
    zend_B   = min(size(stackC,3), size(stackC,3)-zoffset);
           
    % apply offset bounds
    
    stackCr(ybegin_A:yend_A,xbegin_A:xend_A,zbegin_A:zend_A,:) = stackC(ybegin_B:yend_B,xbegin_B:xend_B,zbegin_B:zend_B,:);
    stackCr(stackCr == 0) = median(stackC(:));
    
end