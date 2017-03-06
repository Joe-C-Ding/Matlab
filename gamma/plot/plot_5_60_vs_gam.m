start_test = tic;
figure(1);
clf; ax = gca;

hold(ax, 'on');
ax.Box = 'on';

bN = 1.0e+07 * [
                   0   0.000000500000000
   0.037060900000000   0.000000510898014
   0.074060900000000   0.000000522625628
   0.111060900000000   0.000000535278369
   0.148060900000000   0.000000548857545
   0.185072200000000   0.000000563485567
   0.222111000000000   0.000000579221736
   0.259111000000000   0.000000596305858
   0.296111000000000   0.000000614774567
   0.333122500000000   0.000000634878686
   0.370172300000000   0.000000656753938
   0.407172300000000   0.000000680902459
   0.444172300000000   0.000000707811864
   0.481172300000000   0.000000738050709
   0.518200000000000   0.000000771979988
   0.555200000000000   0.000000810271142
   0.592260900000000   0.000000853807021
   0.629260900000000   0.000000903360212
   0.666260900000000   0.000000960089682
   0.703260900000000   0.000001025457914
   0.740260900000000   0.000001100991018
   0.777272200000000   0.000001188953556
   0.814311000000000   0.000001291701450
   0.851311000000000   0.000001413983822
   0.888311000000000   0.000001561055900
   0.925322500000000   0.000001739359971
   0.962372300000000   0.000001957593882
   0.999372300000000   0.000002227271499
   1.036372300000000   0.000002562839995
   1.073372300000000   0.000002983696581
   1.110400000000000   0.000003519781904
   1.147400000000000   0.000004209246796
   1.184460900000000   0.000005108663240
   1.213260900000000   0.000006000571917
];

aN(:,:,1) = 1.0e+07 * [
                   0   0.000000500000000
   0.011000000000000   0.000000500000000
   0.022000000000000   0.000000500000000
   0.033000000000000   0.000000500000000
   0.044000000000000   0.000000500000000
   0.055000000000000   0.000000500000000
   0.066000000000000   0.000000500000000
   0.077000000000000   0.000000500000000
   0.088000000000000   0.000000500000000
   0.099000000000000   0.000000500000000
   0.109000000000000   0.000000500000000
   0.120000000000000   0.000000500000036
   0.131000000000000   0.000000500000036
   0.142000000000000   0.000000500000036
   0.153000000000000   0.000000522662418
   0.164000000000000   0.000000522662418
   0.175000000000000   0.000000522662418
   0.186000000000000   0.000000522662418
   0.197000000000000   0.000000522662418
   0.208000000000000   0.000000522662418
   0.219000000000000   0.000000522662418
   0.230000000000000   0.000000522663626
   0.241000000000000   0.000000581300848
   0.252000000000000   0.000000581300848
   0.263000000000000   0.000000581300848
   0.274000000000000   0.000000581398284
   0.285000000000000   0.000000581398400
   0.296000000000000   0.000000581398400
   0.307000000000000   0.000000581705940
   0.318000000000000   0.000000581705963
   0.328000000000000   0.000000581705968
   0.339000000000000   0.000000622654904
   0.350000000000000   0.000000622671281
   0.361000000000000   0.000000622671283
   0.372000000000000   0.000000622694548
   0.383000000000000   0.000000622695203
   0.394000000000000   0.000000623558853
   0.405000000000000   0.000000623563401
   0.416000000000000   0.000000623565564
   0.427000000000000   0.000000623565573
   0.438000000000000   0.000000647230861
   0.449000000000000   0.000000647230865
   0.460000000000000   0.000000649717829
   0.471000000000000   0.000000737234142
   0.482000000000000   0.000000737238429
   0.493000000000000   0.000000737238998
   0.504000000000000   0.000000737534766
   0.515000000000000   0.000000756285416
   0.526000000000000   0.000000756391048
   0.537000000000000   0.000000756815725
   0.547000000000000   0.000000766638899
   0.558000000000000   0.000000769155847
   0.569000000000000   0.000000769193993
   0.580000000000000   0.000000807998975
   0.591000000000000   0.000000869095237
   0.602000000000000   0.000000869424807
   0.613000000000000   0.000000873275090
   0.624000000000000   0.000000873275115
   0.635000000000000   0.000000902700573
   0.646000000000000   0.000000902700686
   0.657000000000000   0.000000926430701
   0.668000000000000   0.000000933364211
   0.679000000000000   0.000000933834898
   0.690000000000000   0.000000937079016
   0.701000000000000   0.000000937236130
   0.712000000000000   0.000000937355714
   0.723000000000000   0.000000937377947
   0.734000000000000   0.000001036828691
   0.745000000000000   0.000001037569823
   0.756000000000000   0.000001051420106
   0.766000000000000   0.000001054951166
   0.777000000000000   0.000001166094206
   0.788000000000000   0.000001167213925
   0.799000000000000   0.000001214940702
   0.810000000000000   0.000001218740447
   0.821000000000000   0.000001622015024
   0.832000000000000   0.000001622190139
   0.843000000000000   0.000001647681919
   0.854000000000000   0.000001844896447
   0.865000000000000   0.000002062322612
   0.876000000000000   0.000002291392824
   0.887000000000000   0.000002299269679
   0.898000000000000   0.000002332398943
   0.909000000000000   0.000002901086714
   0.920000000000000   0.000002901112400
   0.931000000000000   0.000003027638647
   0.942000000000000   0.000003471281476
   0.953000000000000   0.000003505684606
   0.964000000000000   0.000003577838184
   0.975000000000000   0.000003631006787
   0.985000000000000   0.000003726567464
   0.996000000000000   0.000004237956424
   1.007000000000000   0.000004244897259
   1.018000000000000   0.000004698872104
   1.029000000000000   0.000005005697550
   1.040000000000000   0.000005175957691
   1.051000000000000   0.000005361276640
   1.062000000000000   0.000005385690121
   1.073000000000000   0.000005386553507
   1.084000000000000   0.000006037440633
];

aN(:,:,2) = 1.0e+07 * [
                   0   0.000000500000000
   0.012596031825000   0.000000500000000
   0.025192063650000   0.000000500000000
   0.037788095475000   0.000000500000000
   0.050384127300001   0.000000500000000
   0.062980159125000   0.000000500000000
   0.075576190950000   0.000000500000000
   0.088172222775000   0.000000500000000
   0.100768254599999   0.000000500000000
   0.113364286424999   0.000000500000000
   0.125960318249999   0.000000506790924
   0.138556350074998   0.000000506790924
   0.151152381899998   0.000000506790924
   0.163748413724998   0.000000506790924
   0.176344445549997   0.000000506790924
   0.188940477374997   0.000000506790924
   0.201536509199997   0.000000513216592
   0.214132541024996   0.000000513216592
   0.226728572849996   0.000000513216592
   0.239324604674996   0.000000513216592
   0.251920636499996   0.000000513216592
   0.264516668324995   0.000000513216592
   0.277112700149995   0.000000513217801
   0.289708731974995   0.000000513218029
   0.302304763799994   0.000000513218029
   0.314900795624994   0.000000557035064
   0.327496827449994   0.000000557035065
   0.340092859274993   0.000000557091874
   0.352688891099993   0.000000557091875
   0.365284922924993   0.000000557091875
   0.377880954749992   0.000000557091880
   0.390476986574992   0.000000568011858
   0.403073018399992   0.000000568020909
   0.415669050224991   0.000000574912170
   0.428265082049991   0.000000574912171
   0.440861113874991   0.000000583517518
   0.453457145699990   0.000000583529569
   0.466053177524990   0.000000583529570
   0.478649209349990   0.000000583530199
   0.491245241174989   0.000000607297254
   0.503841272999989   0.000000607300239
   0.516437304824989   0.000000607351594
   0.529033336649988   0.000000659033149
   0.541629368474988   0.000000683474166
   0.554225400299988   0.000000683549035
   0.566821432124987   0.000000689191859
   0.579417463949987   0.000000704694288
   0.592013495774987   0.000000718392974
   0.604609527599986   0.000000728632785
   0.617205559424986   0.000000736590916
   0.629917151174986   0.000000800215396
   0.642513182999986   0.000000805111747
   0.655109214824985   0.000000805113090
   0.667705246649985   0.000000805132298
   0.680301278474984   0.000000806573095
   0.692897310299984   0.000000806762387
   0.705493342124984   0.000000881422099
   0.718089373949984   0.000000928069485
   0.730685405774983   0.000000929922649
   0.743281437599983   0.000000973462979
   0.755877469424983   0.000000978866661
   0.768473501249982   0.000000995669231
   0.781069533074982   0.000001109857886
   0.793665564899982   0.000001125089735
   0.806261596724981   0.000001136432774
   0.818857628549981   0.000001141547168
   0.831453660374981   0.000001283293136
   0.844049692199980   0.000001286281628
   0.856645724024980   0.000001349812000
   0.869241755849980   0.000001474216470
   0.881837787674979   0.000001474640930
   0.894433819499979   0.000001474765199
   0.907029851324979   0.000001577995054
   0.919625883149978   0.000001625854291
   0.932221914974978   0.000001671534866
   0.944817946799978   0.000001856600831
   0.957413978624977   0.000001877330587
   0.970010010449977   0.000002092006434
   0.982606042274977   0.000002381045585
   0.995202074099976   0.000002382332010
   1.007798105924976   0.000002507452460
   1.020394137749976   0.000002666740705
   1.032990169574976   0.000002800066231
   1.045586201399975   0.000002863810775
   1.058182233224975   0.000002979333618
   1.070778265049974   0.000003064246089
   1.083374296874974   0.000003558223572
   1.095970328699974   0.000003640443160
   1.108566360524973   0.000003669357250
   1.121162392349973   0.000003709661541
   1.133758424174973   0.000003845294259
   1.146354455999973   0.000004251123347
   1.158950487824972   0.000004308528067
   1.171546519649972   0.000004409255309
   1.184142551474972   0.000004976252797
   1.196738583299971   0.000005029067747
   1.209334615124971   0.000005134589474
   1.221930646949970   0.000005371882115
   1.234526678774970   0.000005703057690
   1.247122710599970   0.000006119259759
];

aN(:,:,3) = 1.0e+07 * [
                   0   0.000000500000000
   0.013000000000000   0.000000500000000
   0.027000000000000   0.000000500000000
   0.040000000000000   0.000000500000000
   0.054000000000000   0.000000500306360
   0.067000000000000   0.000000500306360
   0.080000000000000   0.000000500306360
   0.094000000000000   0.000000500306360
   0.107000000000000   0.000000500306360
   0.121000000000000   0.000000500306360
   0.134000000000000   0.000000500306360
   0.147000000000000   0.000000500306360
   0.161000000000000   0.000000500306360
   0.174000000000000   0.000000500306360
   0.188000000000000   0.000000500306360
   0.201000000000000   0.000000500391070
   0.214000000000000   0.000000506814605
   0.228000000000000   0.000000506814605
   0.241000000000000   0.000000506814605
   0.254000000000000   0.000000511141129
   0.268000000000000   0.000000511141129
   0.281000000000000   0.000000517524619
   0.295000000000000   0.000000517952796
   0.308000000000000   0.000000550794678
   0.321000000000000   0.000000551552168
   0.335000000000000   0.000000586057018
   0.348000000000000   0.000000592348869
   0.362000000000000   0.000000592352790
   0.375000000000000   0.000000592352790
   0.388000000000000   0.000000592352791
   0.402000000000000   0.000000593263545
   0.415000000000000   0.000000723846295
   0.429000000000000   0.000000723855166
   0.442000000000000   0.000000723865316
   0.455000000000000   0.000000727810162
   0.469000000000000   0.000000730793428
   0.482000000000000   0.000000782712523
   0.496000000000000   0.000000783582077
   0.509000000000000   0.000000860035039
   0.522000000000000   0.000000907228066
   0.536000000000000   0.000000953334670
   0.549000000000000   0.000001036199502
   0.563000000000000   0.000001042469198
   0.576000000000000   0.000001042496852
   0.589000000000000   0.000001044091044
   0.603000000000000   0.000001044461535
   0.616000000000000   0.000001049383018
   0.630000000000000   0.000001050218172
   0.643000000000000   0.000001087218531
   0.656000000000000   0.000001087292025
   0.670000000000000   0.000001097005532
   0.683000000000000   0.000001097368919
   0.696000000000000   0.000001097376512
   0.710000000000000   0.000001169085349
   0.723000000000000   0.000001201976443
   0.737000000000000   0.000001380021486
   0.750000000000000   0.000001408350419
   0.763000000000000   0.000001409667019
   0.777000000000000   0.000001464876694
   0.790000000000000   0.000001468033975
   0.804000000000000   0.000001470639002
   0.817000000000000   0.000001534128552
   0.830000000000000   0.000001543579214
   0.844000000000000   0.000001588409804
   0.857000000000000   0.000001859642341
   0.871000000000000   0.000002077036500
   0.884000000000000   0.000002144939591
   0.897000000000000   0.000002165259263
   0.911000000000000   0.000002178979477
   0.924000000000000   0.000002278284728
   0.938000000000000   0.000002346316967
   0.951000000000000   0.000002408809575
   0.964000000000000   0.000002531385728
   0.978000000000000   0.000002668544588
   0.991000000000000   0.000002693396218
   1.005000000000000   0.000002704967421
   1.018000000000000   0.000002908394597
   1.031000000000000   0.000002922442508
   1.045000000000000   0.000002983733220
   1.058000000000000   0.000002993447667
   1.072000000000000   0.000003053112332
   1.085000000000000   0.000003253479022
   1.098000000000000   0.000003452184855
   1.112000000000000   0.000003495907100
   1.125000000000000   0.000003792302300
   1.138000000000000   0.000003875183929
   1.152000000000000   0.000003896794077
   1.165000000000000   0.000004259501487
   1.179000000000000   0.000004328622505
   1.192000000000000   0.000004446086552
   1.205000000000000   0.000004568605435
   1.219000000000000   0.000004612471459
   1.232000000000000   0.000004722297160
   1.246000000000000   0.000004743353430
   1.259000000000000   0.000004790538164
   1.272000000000000   0.000004851035298
   1.286000000000000   0.000005179579914
   1.299000000000000   0.000005329608334
   1.313000000000000   0.000005479549121
   1.326000000000000   0.000006157178092
];

h_line = zeros(4,1);
h_line(1) = plot(ax, bN(:,1), bN(:,2), 'k');
lt = {'k--', 'k:', 'k-.'};
for i = 1:3
    h_line(i+1) = plot(ax, aN(:,1,i), aN(:,2,i), lt{i});
end

ax.XLim = [5e5 2e7];
ax.XScale = 'log';
ax.YLim = [5 60];
ax.YTick = [5 10:10:60];

h_leg = legend({'Berretta$^{[3]}$', 'Gamma1', 'Gamma2', 'Gamma3'});
h_leg.Location = 'northwest';
h_leg.FontSize = 12;
h_leg.Interpreter = 'latex';

set(h_line, 'LineWidth', 2);
ax.FontSize = 12;
ax.TickLabelInterpreter = 'latex';

h_lab(1) = xlabel('number of cycles');
h_lab(2) = ylabel('depth of crack ($mm$)');
set(h_lab, 'Interpreter', 'latex');

toc(start_test);