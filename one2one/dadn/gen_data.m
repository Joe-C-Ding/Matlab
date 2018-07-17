start_tic = tic;
% close all but one figure, or creat one if none is there.
h = get(groot, 'Children');
if length(h) > 1
    i = ([h.Number] == 1);
    close(h(~i)); h = h(i);
end
clf(h);

%%
dadn_orig = cell(9,1);

dadn_orig{1} = [
2.20	49.96	9.14e-7	
4.83	37.83	1.19e-7	
7.23	33.07	9.78e-8	
7.58	27.19	1.11e-8	
8.05	21.13	1.24e-8	
8.62	17.66	1.36e-8	
9.35	15.55	2.13e-8	
10.11	9.89	2.39e-8
10.50	8.50	2.04e-9
10.60	7.71	1.62e-10
11.22	36.00	1.24e-7
11.50	36.81	8.19e-8
11.77	37.63	6.81e-8
12.03	38.44	5.81e-8
];

dadn_orig{2} = [
0.98	22.48	1.03e-8
1.41	26.57	7.82e-9
1.88	30.17	6.24e-9
2.24	32.54	4.98e-9
2.59	34.64	5.15e-9
2.99	36.83	3.94e-7
5.12	46.64	9.63e-8
7.20	27.70	1.53e-9
8.41	30.40	1.32e-8
10.60	25.67	1.07e-8
12.12	23.20	1.84e-8
12.74	20.36	6.42e-9
13.21	16.95	1.90e-9
13.56	17.47	5.67e-9
13.74	15.53	1.81e-9
13.88	14.61	1.50e-9
14.42	14.17	9.62e-10
];

dadn_orig{3} = [
1.00	19.46	6.45e-9
1.49	23.32	3.44e-9
1.92	26.08	1.37e-9
2.48	32.33	7.47e-9
5.02	44.02	4.55e-8
7.75	34.43	8.95e-8
8.84	29.97	1.58e-8
10.17	24.90	1.45e-7
9.54	15.81	3.80e-8
13.88	18.11	3.63e-8
14.46	16.72	2.77e-8
];

dadn_orig{4} = [
1.02	29.96	1.78e-7	
1.58	33.27	1.04e-7	
4.79	37.72	2.20e-7	
5.95	35.80	9.14e-8	
6.36	30.85	4.98e-8	
6.83	25.63	1.67e-8	
7.16	19.73	1.84e-9	
7.47	20.20	3.84e-8	
7.67	16.41	1.85e-10	
7.72	16.47	4.61e-9	
8.17	14.20	7.93e-10	
8.59	11.73	3.75e-12	
8.72	11.84	4.96e-10	
8.92	12.02	7.33e-10	
9.08	12.17	9.22e-10	
9.22	12.29	1.19e-9
9.37	12.43	1.30e-9
9.56	15.78	6.94e-9
9.74	15.99	6.42e-9
9.96	16.26	5.74e-9
10.17	16.53	5.28e-9
10.35	16.76	5.84e-9
10.55	17.01	5.99e-9
10.73	17.26	5.81e-9
10.92	17.51	6.33e-9
11.13	17.80	7.09e-9
11.33	18.09	8.03e-9
11.56	18.42	8.88e-9
11.83	18.83	1.01e-8
12.25	29.22	8.63e-8
12.87	30.76	9.63e-8
];

dadn_orig{5} = [
0.84	15.47	4.30e-11	
0.85	15.57	1.93e-10	
0.88	15.80	7.10e-11	
0.90	16.48	1.71e-10	
0.91	16.58	5.03e-10	
0.92	16.68	1.68e-10	
0.93	16.77	1.49e-10	
0.95	16.88	1.18e-10	
0.97	17.02	2.23e-11	
0.98	17.15	1.04e-11	
1.00	17.80	3.43e-10	
1.01	17.95	4.20e-10	
1.04	18.16	3.10e-10
1.25	19.78	3.98e-10
1.47	21.87	6.62e-11
1.51	22.15	9.98e-11
1.59	22.66	2.22e-10
1.64	22.99	1.32e-11
1.72	24.85	2.83e-9
1.93	26.12	2.32e-9
2.13	27.27	1.53e-9
2.37	28.51	1.25e-9
2.64	31.54	1.33e-9
2.85	32.61	1.35e-9
3.11	33.85	1.31e-9
];

dadn_orig{6} = [
1.24	35.82	2.98e-7	
1.85	42.70	3.94e-7	
2.57	49.28	6.49e-7	
3.28	54.73	1.29e-6	
3.81	34.04	1.83e-8	
4.27	35.79	9.89e-8	
4.61	31.74	1.43e-8	
4.81	32.38	4.09e-8	
5.11	27.74	2.23e-8	
5.45	22.88	9.23e-9	
5.70	17.53	6.68e-10	
5.88	17.80	1.88e-8	
6.18	14.60	1.46e-9	
6.54	15.03	7.82e-9	
6.81	15.36	1.04e-9	
6.94	15.52	1.82e-10	
7.01	15.34	6.62e-10	
7.06	15.01	1.17e-9
7.11	14.42	1.85e-9
7.23	13.89	3.42e-9
7.34	12.00	5.90e-10
7.36	9.35	4.95e-12
7.49	8.77	1.56e-9
7.67	8.21	1.93e-9
7.84	7.63	1.75e-9
8.04	7.47	1.64e-9
8.38	21.68	2.88e-7
8.89	22.55	7.09e-8
9.41	23.46	4.88e-8
9.91	24.38	4.43e-8
10.41	25.34	4.52e-8
10.89	26.33	4.60e-8
11.33	27.28	5.13e-8
11.77	28.27	5.71e-8
12.22	29.34	5.91e-8
];

dadn_orig{7} = [
0.68	20.82	1.38e-8	
1.13	26.33	1.75e-8	
1.61	30.85	2.21e-8	
2.10	34.62	2.25e-8	
2.57	37.79	2.01e-8	
3.01	40.44	1.88e-8	
5.61	44.08	5.56e-8	
8.21	52.75	9.00e-7	
8.68	50.23	4.40e-7	
11.00	42.40	6.03e-8
13.48	26.03	4.36e-9
13.95	27.14	6.36e-10
14.37	28.19	6.28e-9
14.92	24.73	4.70e-9
15.37	20.65	3.33e-9
14.59	15.58	1.92e-7
16.41	17.19	1.40e-8
16.59	14.61	1.00e-14
];

dadn_orig{8} = [
0.55	10.24	4.89e-11	
0.62	15.18	5.15e-10	
0.83	17.32	1.22e-9	
0.99	18.88	4.59e-10
1.04	19.25	1.86e-10
1.54	26.28	1.15e-9
2.04	29.75	3.48e-11
];

dadn_orig{9} = [
0.71	16.65	2.53e-9	
0.85	18.08	1.54e-9	
1.01	19.59	9.83e-10	
1.15	20.73	4.64e-10	
1.30	21.96	9.07e-10	
1.53	23.63	9.85e-10	
1.73	24.91	3.90e-10	
1.83	25.53	7.04e-11	
1.93	26.87	3.37e-10	
2.02	27.42	3.53e-11
2.14	28.84	6.94e-10
2.27	29.63	5.79e-11
2.34	30.78	2.77e-10
2.58	32.90	1.04e-9
2.98	35.05	1.16e-9
3.37	36.94	1.55e-9
3.71	38.50	2.01e-9
4.09	40.14	2.83e-9
4.49	41.88	3.70e-9
];

%%
mm = 1e-3;
b = 31 * mm;

f = @(x) (1.99-x.*(1-x).*(2.15-3.93*x+2.7*x.^2))./(1+2*x).*(1-x).^1.5;
ka2s = @(k,a) k./sqrt(a)./f(a/b);
sa2k = @(s,a) s.*sqrt(a).*f(a/b);
sa2k_simple = @(s,a) s.*sqrt(pi*a);

dadn_trans = cell(size(dadn_orig));
for i = 1:length(dadn_orig)
    data = dadn_orig{i};
    data(:,1) = data(:,1) * mm;
    dadn_orig{i} = data;
    
    s = ka2s(data(:,2), data(:,1));
    data(:,2) = sa2k_simple(s, data(:,1));
    dadn_trans{i} = data;
end

s
[dadn_orig{1} dadn_trans{1}]

save('data', 'dadn_orig', 'dadn_trans', 'mm', 'b', 'f', 'ka2s', 'sa2k', 'sa2k_simple');

fprintf('%s elapsed: %f s\n', mfilename, toc(start_tic));