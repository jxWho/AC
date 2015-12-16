addpath('./rastamat');
addpath('./voicebox');
addpath('./AuditoryToolbox');
[d, sr] = audioread('a0180.wav');
%[d, sr] = readwav('a0180.wav');
soundsc(d, sr);
% [mm,aspc] = melfcc(d*3.3752, sr, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1);
[mm, aspc] = melfcc(d, sr, 'numcep', 12);
% xx = invmelfcc(mm, sr, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1);
xx = invmelfcc(mm, sr);
soundsc(xx, sr);

delta = deltas(mm);

[ceps, freqresp] = mfcc(d, sr);

[d2, sr2] = audioread('a0036.wav');
[ce2, fr2] = mfcc(d2, sr2);