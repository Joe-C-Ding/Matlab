start_tic = tic;
format shortG;
format compact;

total_sample = 140;

alpha = 0.05;

observation = [
    468750
    487500
    487500
    487500
    487500
    506250
    506250
    506250
    506250
    506250
    543750
    675000
    675000
    825000
    843750
    862500
    862500
    881250
    881250
    881250
    881250
    900000
    900000
    918750
    937500
    1200000
    1256250
    1293750
    1368750
    1368750
    1368750
];
valid_count = length(observation);
trucate_dist = mean(observation);

data = [
    observation;
    trucate_dist * ones(total_sample-valid_count, 1)
];
censoring = [
    zeros(valid_count, 1);
    ones(total_sample-valid_count, 1)
];

[p, pc] = wblfit(data, alpha, censoring)

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));