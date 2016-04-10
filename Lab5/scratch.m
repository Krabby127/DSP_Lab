close all;
h=figure;
ha=tight_subplot(1,3,[.01 .03],[.1 .01],[.01 .01]);
imshow(luminance,'border','tight');
title('Original Image');
axes(ha(1));
% set(ha(1:3),'title');

% tight_subplot(1,3,[.01 .03],[.1 .01],[.01 .01]) 
imshow(luminance,'border','tight');
title('Reconstructed image');
axes(ha(2));

k=255-imabsdiff(luminance,luminance2);
% tight_subplot(1,3,[.01 .03],[.1 .01],[.01 .01]) 
imshow(k,'border','tight');
title('Difference');
axes(ha(2));
h.Position=[h.Position(1), h.Position(2), 560,240];
saveas(h,'test.jpg');