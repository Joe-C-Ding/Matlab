close all
clear all
home

% *************************************************************************
% Definizioni delle costanti
% *************************************************************************

%- Costanti geometriche --------------------------------------------------------------------------------------

s = 1.493/2;                                % [m] semi-scartmento del piano medio delle ruote
sb = 2.015/2;                               % [m] semi-scartamento delle boccole
r = 0.860/2;                                % [m] raggio nominale delle ruote
d = 0.072;                                  % [m] distanza baricentro trave-piano medio della sala (calcolata per far tornare 
                                            % l'equilibrio al rollio con sala centrata e la sola ruota sx a contatto)
c = 1.100;                                  % [m] distanza baricentro trave-piano del ferro (calcolata in  maniera approssimata
Raggio = 1.991/2;                           % [m] raggio anelli rotaia
dcern = 880;                                % [mm] distanza cerniere superiore ed inferiore attuatori verticali
sYzero = -1.5; %10;                         % [mm] posizione sala centrata

%- Masse -----------------------------------------------------------------------------------------------------
Peso = 44.1;	                            % [kN] peso sala portante + trave

%- Indice canali (vedi files "....dat" ) -%

ichv  = 1;                                              % [km/h] velocit?di avanzamento vel
ichTY = 2;                                              % [kNm] coppia di serpeggio TqYaw
ichPh = 3;                                              % [mrad] serpeggio assoluto trave Phi
%Ch.	4                                                 aaa volts CANALE FUORI USO
ichFQ1 = 5;                                             % [kN] carico attuatore verticale sx FQ1
ichFQ2 = 6;                                             % [kN] carico attuatore verticale dx FQ2
ichFY  = 7;                                             % [kN] carico attuatore laterale FY
ichefsx = 8;                                            % [mm] spostamento fungo sinistro efsx
ichefdx = 9;                                            % [mm] spostamento fungo destro efdx
ichebsx = 10;                                           % [mm] spostamento boccola sinistra ebsx
ichebdx = 11;                                           % [mm] spostamento boccola destra ebdx
ichFZ1 = 12;                                            % [kN] carico attuatore Z1
ichFZ2 = 13;                                            % [kN] carico attuatore Z2
ichFZ3 = 14;                                            % [kN] carico attuatore Z3
ichFZ4 = 15;                                            % [kN] carico attuatore Z4
ichsQ1 = 16;                                            % [mm] spostamento verticale trave sY (da LVDT dell'attuatore Q1)
ichsQ2 = 17;                                            % [mm] spostamento verticale trave sY (da LVDT dell'attuatore Q2)
ichsY = 18;                                             % [mm] spostamento laterale trave sY (da LVDT dell'attuatore FY)
ichYs = 19;                                             % [mm] spostamento laterale sala Ysala (LASER)
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
ichH = 34;                                              % [V]  Canale torsionale presso ruota 1
ichI = 35;                                              % [V]  Canale torsionale presso ruota 2
ichP = 36;                                              % [V]  Canale mozzo ruota 1
ichQ = 37;                                              % [V]  Canale piede ruota 1
ichR = 38;                                              % [V]  Canale mozzo ruota 2
ichS = 39;                                              % [V]  Canale piede ruota 2

%- offeset canali attuatori -%
dfq1 = 0;                                               % differenza tra valore letto al BU300 e valore acquisito
dfq2 = -0.1;                                            % differenza tra valore letto al BU300 e valore acquisito
dfy = 0.65;                                             % differenza tra valore letto al BU300 e valore acquisito

% ********************************************************************************************************
% Caricamento matrice di taratura per forze laterali Y1 ed Y2
% ********************************************************************************************************

load matrix_A.txt -ascii                       		% Caricamento matrice di legame Y1&Y2 - SG ruota (2x4)
matA = matrix_A;
[nrmatA, ncmatA] = size(matA);

% ********************************************************************************************************
% Caricamento file acquisito
% ********************************************************************************************************
 
[fname, pname] = uigetfile('*.dat','Select file');
dati = load(fname);
[nrdati ncdati] = size(dati);                           % Dimensione matrice Dati
dot = find(fname == '.');
fid = fopen([pname fname(1:dot(length(dot))) 'doc'],'rt');
for i = 1:6
    tmp = fgetl(fid);
end
fsamp = str2num(fgetl(fid));
fclose(fid);
       
v = dati(:,ichv);                                       % [km/h] vettore velocit?
phi = dati(:,ichPh);                                    % [mrad] serpeggio assoluto trave Phi
FQ1 = (dati(:,ichFQ1)+dfq1);                            % [kN] carico attuatore verticale sx FQ1
FQ2 = (dati(:,ichFQ2)+dfq2);                            % [kN] carico attuatore verticale dx FQ2
FY = (dati(:,ichFY)+dfy);                               % [kN] carico attuatore laterale FY
sQ1 = dati(:,ichsQ1);                                   % [mm] spostamento verticale sq1
sQ2 = dati(:,ichsQ2);                                   % [mm] spostamento verticale sq2
sY = dati(:,ichsY);                                     % [mm] spostamento laterale trave sY (da LVDT dell'attuatore FY)
Ys = -1*dati(:,ichYs);                                  % [mm] spostamento laterale sala Ysala (LASER), segno -1 per renderlo conforme alla convenzione di
                                                        % segno dell'sY
Ph = dati(:,ichPh);					% [mrad] Serpeggio
P = dati(:,ichP);                                       % [V]  Canale mozzo ruota 1
Q = dati(:,ichQ);                                       % [V]  Canale piede ruota 1
R = dati(:,ichR);                                       % [V]  Canale mozzo ruota 2
S = dati(:,ichS);                                       % [V]  Canale piede ruota 2

% Valore di "zero" (presi da sala sollevata dunque con Y1=Y2=0).
        
if (str2num(fname(5:7))> 77)			
    zeroP = -0.262;             		% [V], zero canale P
    zeroQ = -0.559;              		% [V], zero canale Q
    zeroR = -0.201;             		% [V], zero canale R
    zeroS = -0.464;              		% [V], zero canale S
else 
    zeroP = -0.710;              		% [V], zero canale P
    zeroQ = -0.387;              		% [V], zero canale Q
    zeroR = -0.152;             		% [V], zero canale R
    zeroS = -0.535;              		% [V], zero canale S
end

P = P-zeroP;                                    % Eliminazione valore di zero
Q = Q-zeroQ;                                    % Eliminazione valore di zero
R = R-zeroR;                                    % Eliminazione valore di zero
S = S-zeroS;                                    % Eliminazione valore di zero
       
ds = questdlg('Which wheel is in contact?',fname,'Left','Right','Both','Both');

% ********************************************************************************************************
% Fitraggio canali
% ********************************************************************************************************

i1 = find(v >= 1);	% trovo gli indici per cui la velocit??>1km/h (in sostanza c'?almeno una ruota in appoggio)
vl1 = mean(v(i1));

if length(i1) == nrdati
	i2 = i1;
	vl2 = vl1;
else
        i2 = find(v >=vl1);
        vl2 = mean(v(i2));
end

vmedia = vl2;                                   % [km/h] Velocit?media
    
if vmedia > 5 && vmedia < 15                    % introdurre valori di filtraggio per prove a 2 km/h !!!!!!
    fcutP = 0.15;                               % [Hz] frequenza di taglio del filtro per proximitor
    fcutF = 0.5;                                % [Hz] frequenza di taglio del filtro per forze
    fordP = 3;                                  % [-] ordine del filtro di Butterworth per proximitor
    fordF = 2;                                  % [-] ordine del filtro di Butterworth per Forze
elseif vmedia >= 15 && vmedia < 25
    fcutP = 0.3;                                % [Hz] frequenza di taglio del filtro per proximitor
    fcutF = 1;                                  % [Hz] frequenza di taglio del filtro per forze
    fordP = 3;                                  % [-] ordine del filtro di Butterworth per proximitor
    fordF = 2;                                  % [-] ordine del filtro di Butterworth per Forze
elseif vmedia >= 25 && vmedia < 60
    fcutP = 0.8;                                % [Hz] frequenza di taglio del filtro per proximitor
    fcutF = 1.2;                                % [Hz] frequenza di taglio del filtro per forze
    fordP = 3;                                  % [-] ordine del filtro di Butterworth per proximitor
    fordF = 2;                                  % [-] ordine del filtro di Butterworth per Forze
else
    fcutP = 0.3;                                % [Hz] frequenza di taglio del filtro per proximitor
    fcutF = 1;                                  % [Hz] frequenza di taglio del filtro per forze
    fordP = 3;                                  % [-] ordine del filtro di Butterworth per proximitor
    fordF = 2;                                  % [-] ordine del filtro di Butterworth per Forze
end

WnF = fcutF/(fsamp/2);     
[bF,aF] = butter(fordF,WnF,'low');              % IIR filter design per Forze
FQ1f = filtfilt(bF,aF,FQ1);                     % zero-phase filtering
FQ2f = filtfilt(bF,aF,FQ2);                     % zero-phase filtering
FYf = filtfilt(bF,aF,FY);                       % zero-phase filtering
Pf = filtfilt(bF,aF,P);                         % zero-phase filtering
Qf = filtfilt(bF,aF,Q);                         % zero-phase filtering
Rf = filtfilt(bF,aF,R);                         % zero-phase filtering
Sf = filtfilt(bF,aF,S);                         % zero-phase filtering

% ********************************************************************************************************
% Taglio la time history di 1.0 s (dt = 0.5s all'inzio e dt = 0.5s alla fine) 
% in modo da ottimizzare l'inizio ed il termine del filtro
% ********************************************************************************************************
        
nrFQ1f = length(FQ1f);

dt = 0.5;					% delta di tempo per il "ritaglio" del file
                
FQ1 = FQ1(fsamp*dt:nrFQ1f-fsamp*dt);
FQ2 = FQ2(fsamp*dt:nrFQ1f-fsamp*dt);
FY = FY(fsamp*dt:nrFQ1f-fsamp*dt);
Ph = Ph(fsamp*dt:nrFQ1f-fsamp*dt);
v = v(fsamp*dt:nrFQ1f-fsamp*dt);
sY = sY(fsamp*dt:nrFQ1f-fsamp*dt);
Ys = Ys(fsamp*dt:nrFQ1f-fsamp*dt);
P = P(fsamp*dt:nrFQ1f-fsamp*dt);
Q = Q(fsamp*dt:nrFQ1f-fsamp*dt);
R = R(fsamp*dt:nrFQ1f-fsamp*dt);
S = S(fsamp*dt:nrFQ1f-fsamp*dt);

FQ1f = FQ1f(fsamp*dt:nrFQ1f-fsamp*dt);
FQ2f = FQ2f(fsamp*dt:nrFQ1f-fsamp*dt);
FYf = FYf(fsamp*dt:nrFQ1f-fsamp*dt);
Pf = Pf(fsamp*dt:nrFQ1f-fsamp*dt);
Qf = Qf(fsamp*dt:nrFQ1f-fsamp*dt);
Rf = Rf(fsamp*dt:nrFQ1f-fsamp*dt);
Sf = Sf(fsamp*dt:nrFQ1f-fsamp*dt);

Time = [0:1/fsamp:(length(FYf)-1)/fsamp]';	% Vettore tempo

alfa = (atan((sY-sYzero)/dcern));		% angolo di inclinazione attuatori verticali FQ1&FQ2
DY = (FQ1f + FQ2f).*sin(alfa);      		% delta Y dovuto all'inclinazione degli attuatori verticali FQ1&FQ2
            
%--- A contatto solo la ruota sinistra
if strcmp(ds,'Left') == 1
    Y1f = -(FYf + DY);                      	% forza di contatto laterale sx
    Y2f = zeros(length(FYf),1);          	% forza di contatto laterale dx
    Q1f = (FQ1f + FQ2f).*cos(alfa) + Peso;  	% forza di contatto verticale sx
    Q2f = zeros(length(FQ2f),1);           	% forza di contatto verticale dx
    R = R-R(1);
    S = S-S(1);
    Rf = Rf-Rf(1);
    Sf = Sf-Sf(1);
%--- A contatto solo la ruota destra
elseif strcmp(ds,'Right') == 1                                		
    Y1f = zeros(length(FYf),1);           	% forza di contatto laterale sx
    Y2f = -(FYf + DY);                      	% forza di contatto laterale dx
    Q1f = zeros(length(FQ1f),1);           	% forza di contatto verticale sx
    Q2f = (FQ1f + FQ2f).*cos(alfa) + Peso;  	% forza di contatto verticale dx
    P = P-P(1);
    Q = Q-Q(1);
    Pf = Pf-Pf(1);
    Qf = Qf-Qf(1);
else
fprintf('Error')
end

%--- Calcolo forze laterali da SG ruota
Y1_from_SG = matA(1,:)*[Pf'; Qf'; Rf'; Sf'];
Y2_from_SG = matA(2,:)*[Pf'; Qf'; Rf'; Sf'];

%--- Grafici

figure
subplot(2,1,1)
plot(Time,P,'b',Time,Pf,'r','LineWidth',2),grid,hold on
plot(Time,Q,'k',Time,Qf,'m','LineWidth',2)
xlabel('Time [s]'),ylabel('SG left wheel [V]'),legend('P','P filt','Q','Q filt')
subplot(2,1,2)
plot(Time,R,'m',Time,Rf,'k','LineWidth',2),grid,hold on
plot(Time,S,'b',Time,Sf,'r','LineWidth',2)
xlabel('Time [s]'),ylabel('SG rigth wheel [V]'),legend('R','R filt','S','S filt')

figure
plot(Time,Y1f,'k',Time,Y1_from_SG,'b--','LineWidth',2),grid
axis ([0 Time(length(Time)) min(Y1f)-5 max(Y1f)+5])
xlabel('Time [s]'),ylabel('[kN]'),legend('Y1 reference-from equation','Y1 cal-from SG on wheel')

figure
plot(Time,Y2f,'k',Time,Y2_from_SG,'r--','LineWidth',2),grid
axis ([0 Time(length(Time)) min(Y2f)-5 max(Y2f)+5])
xlabel('Time [s]'),ylabel('[kN]'),legend('Y2 reference-from equation','Y2 cal-from SG on wheel')

figure
plot(Time,Y1f+Y2f,'k',Time,Y1_from_SG+Y2_from_SG,'m--','LineWidth',2),grid
axis ([0 Time(length(Time)) min(Y1f+Y2f)-5 max(Y1f+Y2f)+5])
xlabel('Time [s]'),ylabel('[kN]'),legend('Y1+Y2 reference-from equation','Y1+Y2 cal-from SG on wheel')

figure
subplot(3,1,1)
plot(Time,Y1f,'k',Time,Y1_from_SG,'b--','LineWidth',2),grid
axis ([0 Time(length(Time)) min(Y1f)-5 max(Y1f)+5])
xlabel('Time [s]'),ylabel('[kN]'),legend('Y1 reference-from equation','Y1 cal-from SG on wheel')
subplot(3,1,2)
plot(Time,Y2f,'k',Time,Y2_from_SG,'r--','LineWidth',2),grid
axis ([0 Time(length(Time)) min(Y2f)-5 max(Y2f)+5])
xlabel('Time [s]'),ylabel('[kN]'),legend('Y2 reference-from equation','Y2 cal-from SG on wheel')
subplot(3,1,3)
plot(Time,Y1f+Y2f,'k',Time,Y1_from_SG+Y2_from_SG,'m--','LineWidth',2),grid
axis ([0 Time(length(Time)) min(Y1f+Y2f)-5 max(Y1f+Y2f)+5])
xlabel('Time [s]'),ylabel('[kN]'),legend('Y1+Y2 reference-from equation','Y1+Y2 cal-from SG on wheel')

'Matrix_A:'
matA