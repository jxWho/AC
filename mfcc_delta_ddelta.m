function [cDDd] = mfcc_delta_ddelta(samples, sr)
    addpath('./rastamat');
    c = melfcc(samples, sr);
    d = deltas(c);
    dd = deltas(d);
    c = c';
    d = d';
    dd = dd';
    cDDd = [c d dd];
end