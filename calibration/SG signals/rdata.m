function [ Time WQ WA ] = rdata( fname )
%RDATA [ Time WQ WA ] = rdata( fname )
%   Detailed explanation goes here

need_filter = false;

%% *************************************************************************
% Definizioni delle costanti
% *************************************************************************

%- Costanti geometriche --------------------------------------------------------------------------------------

s = 1.493/2;                                % [m] semi-scartmento del piano medio delle ruote
sb = 2.015/2;                               % [m] semi-scartamento delle boccole
r = 0.860/2;                                % [m] raggio nominale delle ruote
d = 0.072;                                  % [m] distanza baricentro trave-piano medio della sala (calcolata per far tornare 
                                            % l'equilibrio al rollio con sala centrata e la sola ruota sx a contatto)
% c = 1.100;                                  % [m] distanza baricentro trave-piano del ferro (calcolata in  maniera approssimata
% Raggio = 1.991/2;                           % [m] raggio anelli rotaia
dcern = 880;                                % [mm] distanza cerniere superiore ed inferiore attuatori verticali
sYzero = -1.5; %10;                         % [mm] posizione sala centrata

%- Masse -----------------------------------------------------------------------------------------------------
Peso = 44.1;	                            % [kN] peso sala portante + trave

%- Indice canali (vedi files "....dat" ) -%

ichv  = 1;                                              % [km/h] velocit?di avanzamento vel
% ichTY = 2;                                              % [kNm] coppia di serpeggio TqYaw
% ichPh = 3;                                              % [mrad] serpeggio assoluto trave Phi
%Ch.	4                                                 aaa volts CANALE FUORI USO
ichFQ1 = 5;                                             % [kN] carico attuatore verticale sx FQ1
ichFQ2 = 6;                                             % [kN] carico attuatore verticale dx FQ2
ichFY  = 7;                                             % [kN] carico attuatore laterale FY
% ichefsx = 8;                                            % [mm] spostamento fungo sinistro efsx
% ichefdx = 9;                                            % [mm] spostamento fungo destro efdx
% ichebsx = 10;                                           % [mm] spostamento boccola sinistra ebsx
% ichebdx = 11;                                           % [mm] spostamento boccola destra ebdx
% ichFZ1 = 12;                                            % [kN] carico attuatore Z1
% ichFZ2 = 13;                                            % [kN] carico attuatore Z2
% ichFZ3 = 14;                                            % [kN] carico attuatore Z3
% ichFZ4 = 15;                                            % [kN] carico attuatore Z4
% ichsQ1 = 16;                                            % [mm] spostamento verticale trave sY (da LVDT dell'attuatore Q1)
% ichsQ2 = 17;                                            % [mm] spostamento verticale trave sY (da LVDT dell'attuatore Q2)
ichsY = 18;                                             % [mm] spostamento laterale trave sY (da LVDT dell'attuatore FY)
% ichYs = 19;                                             % [mm] spostamento laterale sala Ysala (LASER)
ichA1 = 20;                                             % [V]  Canale fusello sezione A ruota 1 0?180?
ichA2 = 21;                                             % [V]  Canale fusello sezione A ruota 1 90?270?
ichB1 = 22;                                             % [V]  Canale collare sezione B ruota 1 0?180?
ichB2 = 23;                                             % [V]  Canale collare sezione B ruota 1 90?270?
ichC1 = 24;                                             % [V]  Canale sezione C raccordo interno ruota 1 0?180?
ichC2 = 25;                                             % [V]  Canale sezione C raccordo interno  ruota 1 90?270?
ichD1 = 26;                                             % [V]  Canale centrale sezione D 0?180?
ichD2 = 27;                                             % [V]  Canale centrale sezione D 90?270?
ichE1 = 28;                                             % [V]  Canale sezione E raccordo interno ruota 2 0?180?
ichE2 = 29;                                             % [V]  Canale sezione E raccordo interno ruota 2 90?270?
ichF1 = 30;                                             % [V]  Canale collare sezione F ruota 2 0?180?
ichF2 = 31;                                             % [V]  Canale collare sezione F ruota 2 90?270?
ichG1 = 32;                                             % [V]  Canale fusello sezione G ruota 2 0?180?
ichG2 = 33;                                             % [V]  Canale fusello sezione G ruota 2 90?270?
% ichH = 34;                                              % [V]  Canale torsionale presso ruota 1
% ichI = 35;                                              % [V]  Canale torsionale presso ruota 2
% ichP = 36;                                              % [V]  Canale mozzo ruota 1
% ichQ = 37;                                              % [V]  Canale piede ruota 1
% ichR = 38;                                              % [V]  Canale mozzo ruota 2
% ichS = 39;                                              % [V]  Canale piede ruota 2

%- offeset canali attuatori -%
dfq1 = 0;                                               % differenza tra valore letto al BU300 e valore acquisito
dfq2 = -0.1;                                            % differenza tra valore letto al BU300 e valore acquisito
dfy = 0.65;                                             % differenza tra valore letto al BU300 e valore acquisito

%- Coefficienti di conversione da unit?elettrica ad unit?ingegneristica ------------------------------------
 
% kpf = 0.2;                                  % [mm/V] Coefficiente di conversione per i proximitor fungo 
% kpb = -0.25;                                % [mm/V] Coefficiente di conversione per i proximitor boccola 
 
% NOTA: il kpb ?stato inserito con segno negativo in modo da uniformare la convenzione per entrambi i proximity. 
% I proximity tipo nuovo, infatti, (montati in prossimit?del fungo delle rotaie) generano un segnale decrescente al 
% diminuire della distanza mentre quelli tipo vecchio (posti presso le boccole delle rotaie) generano un segnale crescente

kA = 60;                                   	% [microepsilon/V] Coefficiente di conversione per SG sezione A
kB = 60;                                   	% [microepsilon/V] Coefficiente di conversione per SG sezione B 
kC = 140;                                  	% [microepsilon/V] Coefficiente di conversione per SG sezione C
kD = 112;                                 	% [microepsilon/V] Coefficiente di conversione per SG sezione D
kE = 140;                                  	% [microepsilon/V] Coefficiente di conversione per SG sezione E
kF = 60;                                   	% [microepsilon/V] Coefficiente di conversione per SG sezione F
kG = 60;                                   	% [microepsilon/V] Coefficiente di conversione per SG sezione G
kH = 60;                                    % [microepsilon/V] Coefficiente di conversione per SG sezione H (Torsionali)
kI = 60;                                    % [microepsilon/V] Coefficiente di conversione per SG sezione I (Torsionali)
      
%% ********************************************************************************************************
% Caricamento file dati
% ********************************************************************************************************

dati = load(fname);
[nrdati ncdati] = size(dati);                           % Dimensione matrice Dati
dot = find(fname == '.');
fid = fopen([fname(1:dot(length(dot))) 'doc'],'rt');
for i = 1:6
    fgetl(fid);
end
fsamp = str2num(fgetl(fid));
fclose(fid);
% facq = fsamp;

v = dati(:,ichv);                                       % [km/h] vettore velocit?
% phi = dati(:,ichPh);                                    % [mrad] serpeggio assoluto trave Phi
FQ1 = dati(:,ichFQ1)+dfq1;                                   % [kN] carico attuatore verticale sx FQ1
FQ2 = dati(:,ichFQ2)+dfq2;                                   % [kN] carico attuatore verticale dx FQ2
FY = dati(:,ichFY)+dfy;                                     % [kN] carico attuatore laterale FY
% sQ1 = dati(:,ichsQ1);                                   % [mm] spostamento verticale sq1
% sQ2 = dati(:,ichsQ2);                                   % [mm] spostamento verticale sq2
sY = dati(:,ichsY);                                     % [mm] spostamento laterale trave sY (da LVDT dell'attuatore FY)
% Ys = -1*dati(:,ichYs);                                  % [mm] spostamento laterale sala Ysala (LASER), segno -1 per renderlo conforme alla convenzione di
                                                        % segno dell'sY
A1 = kA*dati(:,ichA1);                                  % [microepsilon] Canale fusello sezione A ruota 1 0?180?
A2 = kA*dati(:,ichA2);                                  % [microepsilon] Canale fusello sezione A ruota 1 90?270?
B1 = kB*dati(:,ichB1);                                  % [microepsilon] Canale collare sezione B ruota 1 0?180?
B2 = kB*dati(:,ichB2);                                  % [microepsilon] Canale collare sezione B ruota 1 90?270?
C1 = kC*dati(:,ichC1);                                  % [microepsilon] Canale sezione C raccordo interno ruota 1 0?180?
C2 = kC*dati(:,ichC2);                                  % [microepsilon] Canale sezione C raccordo interno  ruota 1 90?270?
D1 = kD*dati(:,ichD1);                                  % [microepsilon] Canale centrale sezione D 0?180?
D2 = kD*dati(:,ichD2);                                  % [microepsilon] Canale centrale sezione D 90?270?
E1 = kE*dati(:,ichE1);                                  % [microepsilon] Canale sezione E raccordo interno ruota 2 0?180?
E2 = kE*dati(:,ichE2);                                  % [microepsilon] Canale sezione E raccordo interno ruota 2 90?270?
F1 = kF*dati(:,ichF1);                                  % [microepsilon] Canale collare sezione F ruota 2 0?180?
F2 = kF*dati(:,ichF2);                                  % [microepsilon] Canale collare sezione F ruota 2 90?270?
G1 = kG*dati(:,ichG1);                                  % [microepsilon] Canale fusello sezione G ruota 2 0?180?
G2 = kG*dati(:,ichG2);                                  % [microepsilon] Canale fusello sezione G ruota 2 90?270?
% H = kH*dati(:,ichH);                                    % [V]  Canale torsionale presso ruota 1
% I = kI*dati(:,ichI);                                    % [V]  Canale torsionale presso ruota 2
% P = dati(:,ichP);                                       % [V]  Canale mozzo ruota 1
% Q = dati(:,ichQ);                                       % [V]  Canale piede ruota 1
% R = dati(:,ichR);                                       % [V]  Canale mozzo ruota 2
% S = dati(:,ichS);                                       % [V]  Canale piede ruota 2 

%% ********************************************************************************************************
% Fitraggio canali 滤波（去零飘）
% ********************************************************************************************************

if need_filter == true
    
i1 = find(v >= 1);	% trovo gli indici per cui la velocit??>1km/h (in sostanza c'?almeno una ruota in appoggio)
vl1 = mean(v(i1));

if length(i1) == nrdati
	vl2 = vl1;
else
    vl2 = mean(v(v >= vl1));
end

vmedia = vl2;                                   % [km/h] Velocit?media
    
if vmedia > 5 && vmedia < 15                    % introdurre valori di filtraggio per prove a 2 km/h !!!!!!
%     fcutP = 0.15;                               % [Hz] frequenza di taglio del filtro per proximitor
    fcutF = 0.5;                                % [Hz] frequenza di taglio del filtro per forze
%     fordP = 3;                                  % [-] ordine del filtro di Butterworth per proximitor
    fordF = 2;                                  % [-] ordine del filtro di Butterworth per Forze
elseif vmedia >= 15 && vmedia < 25
%     fcutP = 0.3;                                % [Hz] frequenza di taglio del filtro per proximitor
    fcutF = 1;                                  % [Hz] frequenza di taglio del filtro per forze
%     fordP = 3;                                  % [-] ordine del filtro di Butterworth per proximitor
    fordF = 2;                                  % [-] ordine del filtro di Butterworth per Forze
elseif vmedia >= 25 && vmedia < 60
%     fcutP = 0.8;                                % [Hz] frequenza di taglio del filtro per proximitor
    fcutF = 1.2;                                % [Hz] frequenza di taglio del filtro per forze
%     fordP = 3;                                  % [-] ordine del filtro di Butterworth per proximitor
    fordF = 2;                                  % [-] ordine del filtro di Butterworth per Forze
else
%     fcutP = 0.3;                                % [Hz] frequenza di taglio del filtro per proximitor
    fcutF = 1;                                  % [Hz] frequenza di taglio del filtro per forze
%     fordP = 3;                                  % [-] ordine del filtro di Butterworth per proximitor
    fordF = 2;                                  % [-] ordine del filtro di Butterworth per Forze
end

WnF = fcutF/(fsamp/2);     
[bF,aF] = butter(fordF,WnF,'low');              % IIR filter design per Forze
FQ1 = filtfilt(bF,aF,FQ1);                     % zero-phase filtering
FQ2 = filtfilt(bF,aF,FQ2);                     % zero-phase filtering
FY = filtfilt(bF,aF,FY);                       % zero-phase filtering
% P = filtfilt(bF,aF,P);                         % zero-phase filtering
% Q = filtfilt(bF,aF,Q);                         % zero-phase filtering
% R = filtfilt(bF,aF,R);                         % zero-phase filtering
% S = filtfilt(bF,aF,S);                         % zero-phase filtering

% 去零飘
WnF = 0.2/(fsamp/2);     
[bF,aF] = butter(fordF,WnF,'high');              % IIR filter design per Forze
A1 = filtfilt(bF,aF,A1);                     % zero-phase filtering
A2 = filtfilt(bF,aF,A2);                     % zero-phase filtering
B1 = filtfilt(bF,aF,B1);                     % zero-phase filtering
B2 = filtfilt(bF,aF,B2);                     % zero-phase filtering
C1 = filtfilt(bF,aF,C1);                     % zero-phase filtering
C2 = filtfilt(bF,aF,C2);                     % zero-phase filtering
D1 = filtfilt(bF,aF,D1);                     % zero-phase filtering
D2 = filtfilt(bF,aF,D2);                     % zero-phase filtering
E1 = filtfilt(bF,aF,E1);                     % zero-phase filtering
E2 = filtfilt(bF,aF,E2);                     % zero-phase filtering
F1 = filtfilt(bF,aF,F1);                     % zero-phase filtering
F2 = filtfilt(bF,aF,F2);                     % zero-phase filtering
G1 = filtfilt(bF,aF,G1);                     % zero-phase filtering
G2 = filtfilt(bF,aF,G2);                     % zero-phase filtering

%% ********************************************************************************************************
% Taglio la time history di 1.0 s (dt = 0.5s all'inzio e dt = 0.5s alla fine) 
% in modo da ottimizzare l'inizio ed il termine del filtro

% 避免滤波失真，抛弃数据的开头结尾各 0.5s
% ********************************************************************************************************
        
nrFQ1f = length(FQ1);

dt = 1;					% delta di tempo per il "ritaglio" del file
                
FQ1 = FQ1(fsamp*dt:nrFQ1f-fsamp*dt);
FQ2 = FQ2(fsamp*dt:nrFQ1f-fsamp*dt);
FY = FY(fsamp*dt:nrFQ1f-fsamp*dt);
% Ph = Ph(fsamp*dt:nrFQ1f-fsamp*dt);
% v = v(fsamp*dt:nrFQ1f-fsamp*dt);
sY = sY(fsamp*dt:nrFQ1f-fsamp*dt);
% Ys = Ys(fsamp*dt:nrFQ1f-fsamp*dt);
% P = P(fsamp*dt:nrFQ1f-fsamp*dt);
% Q = Q(fsamp*dt:nrFQ1f-fsamp*dt);
% R = R(fsamp*dt:nrFQ1f-fsamp*dt);
% S = S(fsamp*dt:nrFQ1f-fsamp*dt);

A1 = A1(fsamp*dt:nrFQ1f-fsamp*dt);
A2 = A2(fsamp*dt:nrFQ1f-fsamp*dt);
B1 = B1(fsamp*dt:nrFQ1f-fsamp*dt);
B2 = B2(fsamp*dt:nrFQ1f-fsamp*dt);
C1 = C1(fsamp*dt:nrFQ1f-fsamp*dt);
C2 = C2(fsamp*dt:nrFQ1f-fsamp*dt);
D1 = D1(fsamp*dt:nrFQ1f-fsamp*dt);
D2 = D2(fsamp*dt:nrFQ1f-fsamp*dt);
E1 = E1(fsamp*dt:nrFQ1f-fsamp*dt);
E2 = E2(fsamp*dt:nrFQ1f-fsamp*dt);
F1 = F1(fsamp*dt:nrFQ1f-fsamp*dt);
F2 = F2(fsamp*dt:nrFQ1f-fsamp*dt);
G1 = G1(fsamp*dt:nrFQ1f-fsamp*dt);
G2 = G2(fsamp*dt:nrFQ1f-fsamp*dt);

end     % need_filter

alfa = (atan((sY-sYzero)/dcern));                       % angolo di inclinazione attuatori verticali FQ1&FQ2
DY = (FQ1+FQ2).*sin(alfa);                              % delta Y dovuto all'inclinazione degli attuatori verticali FQ1&FQ2

%%
Time = (0:1/fsamp:(length(FY)-1)/fsamp)';	% Vettore tempo

WQ = zeros(length(FQ1), 2);
WQ(:,2) = (cos(alfa) .* ((sb-s) * -FQ1 + (sb+s) * FQ2) - r*(FY + DY) + Peso*(d+s)) / 2/s;
WQ(:,1) = cos(alfa) .* (FQ1 + FQ2) + Peso - WQ(:,2);

A = sqrt(A1.^2+A2.^2);
B = sqrt(B1.^2+B2.^2);
C = sqrt(C1.^2+C2.^2);
D = sqrt(D1.^2+D2.^2);
E = sqrt(E1.^2+E2.^2);
F = sqrt(F1.^2+F2.^2);
G = sqrt(G1.^2+G2.^2);

WA = [A B C D E F G];

end

