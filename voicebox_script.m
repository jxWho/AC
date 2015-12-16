addpath('./voicebox');
addpath('./mfcc2sdc');
[Y, FS] = readwav('a0180.wav');
[Y2, FS2] = readwav('a0036.wav');
c1 = melcepst(Y, FS, '0dD');
c2 = melcepst(Y2, FS2);
% d = disteusq(c1, c2, 's');

%[Y3, FS3] = readwav('/Users/god/Dropbox/Fun Speech Recognition/project/voxforge/female/aileen-20080831-dfq/wav/a0395.wav');

pc1 = pca(c1);
pc2 = pca(c2);

sdc_coeff = mfcc2sdc(c2, 12, 3, 3, 7);