function [] =plot3Images(luminance,luminance2,filename,lossFactor)
% close all;
h=figure;

[~,name,~]=fileparts(filename);
a=suptitle([name, ': Loss Factor = ', num2str(lossFactor)]);
a.Position(2)=-0.1;

subplot(1,3,1);
imshow(luminance,'border','tight');
title('Original Image');

subplot(1,3,3);
imshow(luminance2,'border','tight');
title('Reconstructed image');

k=255-imabsdiff(luminance,luminance2);
subplot(1,3,2);
imshow(k,'border','tight');
title('Difference');

h.Position=[h.Position(1), h.Position(2), 560,260];
saveas(h,[name,'L',num2str(lossFactor),'_dct.jpg']);
close(h);
end