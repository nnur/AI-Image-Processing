%%%%% teddy %%%%%
teddyL = double(imread('teddy-left.pgm'));

teddyR = double(imread('teddy-right.pgm'));

windowSize = 5;
maxDisp = 50;

bestDisp_teddy = stereoCorrespondence(teddyL, teddyR, windowSize, maxDisp);
imagesc(stretch(bestDisp_teddy))
imwrite(uint8(stretch(bestDisp_teddy)), 'teddyDisp.png');

%%%%% tsukuba %%%%%
tsukubaL = double(imread('tsukuba-left.pgm'));
tsukubaR = double(imread('tsukuba-right.pgm'));

maxDisp = 14;

bestDisp_tsukuba = stereoCorrespondence(tsukubaL, tsukubaR, windowSize, maxDisp);
imagesc(stretch(bestDisp_tsukuba))
imwrite(uint8(stretch(bestDisp_tsukuba)), 'tsukubaDisp.png');

%%%%% venus %%%%%
venusL = double(imread('venus-left.pgm'));
venusR = double(imread('venus-right.pgm'));

maxDisp = 20;

bestDisp_venus = stereoCorrespondence(venusL, venusR, windowSize, maxDisp);
imagesc(stretch(bestDisp_venus))
imwrite(uint8(stretch(bestDisp_venus)), 'venusDisp.png');