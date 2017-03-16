rng(0);  % set  random number generator to the same starting point

A = [ 1 0 3; 2 1 2; 1 3 3 ];
imSmall = cat(3,A,A,A);
scribbleSmall = [1 0 0; 1 0 0; 0 2 2];

lambda = 1;
numClusters = 0;
inftyCost = 1000;

%[segm,e2]  = segmentGC(imSmall,scribbleSmall,lambda,numClusters,inftyCost)

%sigma =   2.0833   % the value of sigma computed on the input image
                    % I display it here for your debugging purposes
                    % but you are not required to have it as output

% segm =
% 
%      0     0     0
%      0     0     0
%      0     1     1
% 
% 
% e2 =
% 
%     1.5524

disp('____________________________cluster =3__________________')


numClusters = 3;

%[segm,e2]  = segmentGC(imSmall,scribbleSmall,lambda,numClusters,inftyCost);

%  reshape(clusters,3,3)  % you don't have to display clustering that you
                          %  get with kmeans, but I'm displaying it for
                          %  debuggin purposes
% 
% ans =
% 
%      3     3     2
%      1     3     1
%      3     2     2
%
%
% segm =
% 
%     0     0     1
%     0     0     1
%     0     1     1
% 
% 
% e2 =
% 
%     9.3911

% Clusters I get with kmeans clustering
% clustersOut =
% 
%      3     3     2
%      1     3     1
%      3     2     2

% disp('____________________________cluster =50__________________')
% load q5; % loads a larger example from file 
% 
% im = imread('square.png');
% im = double(im);
% 
% lambda = 50;
% numClusters = 50;
% inftyCost = 1000;
% [segm,e2]  = segmentGC(im,scribblesSquare,lambda,numClusters,inftyCost);
% e2
% % 
% segm(segm == 1) = 255;
% % 
% imwrite(uint8(stretch(segm)), 'sqOut.png');
% img = double(imread('squareOut.png'));
% imagesc(img)

% sigma = 165.1678  % the value of sigma computed on the input image
% e2 = 4.0668e+04
% I also saved the segmentation you should get in file "squareOut.png"
% where 0 corresponds to the background and 255 to the object

%%%%%%%% Face %%%%%%

% im = imread('face.jpg');
% im = double(im);
% 
% lambda = 50;
% numClusters = 50;
% inftyCost = 1000;
% [segm,e2]  = segmentGC(im,scribblesFace,lambda,numClusters,inftyCost);
% e2
%  
% imwrite(uint8(stretch(segm)), 'faceL.png');
% img = double(imread('faceL.png'));
% imagesc(img)


%%%%%%%% Lift %%%%%%

im = imread('lift.jpg');
im = double(im);

lambda = 50;
numClusters = 50;
inftyCost = 1000;
[segm,e2]  = segmentGC(im,scribblesLift,lambda,numClusters,inftyCost);
segm = segm*255; 
imwrite(uint8(stretch(segm)), 'liftL.png');
img = double(imread('liftL.png'));
imagesc(img)


