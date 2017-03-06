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

ichv  = 1;                                              % [km/h] velocità di avanzamento vel
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
ichA1 = 20;                                             % [V]  Canale fusello sezione A ruota 1 0°-180°
ichA2 = 21;                                             % [V]  Canale fusello sezione A ruota 1 90°-270°
ichB1 = 22;                                             % [V]  Canale collare sezione B ruota 1 0°-180°
ichB2 = 23;                                             % [V]  Canale collare sezione B ruota 1 90°-270°
ichC1 = 24;                                             % [V]  Canale sezione C raccordo interno ruota 1 0°-180°
ichC2 = 25;                                             % [V]  Canale sezione C raccordo interno  ruota 1 90°-270°
ichD1 = 26;                                             % [V]  Canale centrale sezione D 0°-180°
ichD2 = 27;                                             % [V]  Canale centrale sezione D 90°-270°
ichE1 = 28;                                             % [V]  Canale sezione E raccordo interno ruota 2 0°-180°
ichE2 = 29;                                             % [V]  Canale sezione E raccordo interno ruota 2 90°-270°
ichF1 = 30;                                             % [V]  Canale collare sezione F ruota 2 0°-180°
ichF2 = 31;                                             % [V]  Canale collare sezione F ruota 2 90°-270°
ichG1 = 32;                                             % [V]  Canale fusello sezione G ruota 2 0°-180°
ichG2 = 33;                                             % [V]  Canale fusello sezione G ruota 2 90°-270°
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

%- Coefficienti di conversione da unità elettrica ad unità ingegneristica ------------------------------------
 
kpf = 0.2;                                  % [mm/V] Coefficiente di conversione per i proximitor fungo 
kpb = -0.25;                                % [mm/V] Coefficiente di conversione per i proximitor boccola 
 
% NOTA: il kpb è stato inserito con segno negativo in modo da uniformare la convenzione per entrambi i proximity. 
% I proximity tipo nuovo, infatti, (montati in prossimità del fungo delle rotaie) generano un segnale decrescente al 
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
      
% ********************************************************************************************************
% Caricamento file dati
% ********************************************************************************************************

[fname, pname] = uigetfile('*.dat','Seleziona file');
dati = load(fname);
[nrdati ncdati] = size(dati);                           % Dimensione matrice Dati
dot = find(fname == '.');
fid = fopen([pname fname(1:dot(length(dot))) 'doc'],'rt');
for i = 1:6
    tmp = fgetl(fid);
end
fsamp = str2num(fgetl(fid));
fclose(fid);
facq = fsamp;
time = [0:1/facq:(nrdati-1)/facq]';                      % [s] Vettore tempo

v = dati(:,ichv);                                       % [km/h] vettore velocità
phi = dati(:,ichPh);                                    % [mrad] serpeggio assoluto trave Phi
FQ1 = dati(:,ichFQ1);                                   % [kN] carico attuatore verticale sx FQ1
FQ2 = dati(:,ichFQ2);                                   % [kN] carico attuatore verticale dx FQ2
FY = dati(:,ichFY);                                     % [kN] carico attuatore laterale FY
sQ1 = dati(:,ichsQ1);                                   % [mm] spostamento verticale sq1
sQ2 = dati(:,ichsQ2);                                   % [mm] spostamento verticale sq2
sY = dati(:,ichsY);                                     % [mm] spostamento laterale trave sY (da LVDT dell'attuatore FY)
Ys = -1*dati(:,ichYs);                                  % [mm] spostamento laterale sala Ysala (LASER), segno -1 per renderlo conforme alla convenzione di
                                                        % segno dell'sY

alfa = (atan((sY-sYzero)/dcern));                       % angolo di inclinazione attuatori verticali FQ1&FQ2
DY = (FQ1+FQ2).*sin(alfa);                              % delta Y dovuto all'inclinazione degli attuatori verticali FQ1&FQ2

A1 = kA*dati(:,ichA1);                                  % [microepsilon] Canale fusello sezione A ruota 1 0°-180°
A2 = kA*dati(:,ichA2);                                  % [microepsilon] Canale fusello sezione A ruota 1 90°-270°
B1 = kB*dati(:,ichB1);                                  % [microepsilon] Canale collare sezione B ruota 1 0°-180°
B2 = kB*dati(:,ichB2);                                  % [microepsilon] Canale collare sezione B ruota 1 90°-270°
C1 = kC*dati(:,ichC1);                                  % [microepsilon] Canale sezione C raccordo interno ruota 1 0°-180°
C2 = kC*dati(:,ichC2);                                  % [microepsilon] Canale sezione C raccordo interno  ruota 1 90°-270°
D1 = kD*dati(:,ichD1);                                  % [microepsilon] Canale centrale sezione D 0°-180°
D2 = kD*dati(:,ichD2);                                  % [microepsilon] Canale centrale sezione D 90°-270°
E1 = kE*dati(:,ichE1);                                  % [microepsilon] Canale sezione E raccordo interno ruota 2 0°-180°
E2 = kE*dati(:,ichE2);                                  % [microepsilon] Canale sezione E raccordo interno ruota 2 90°-270°
F1 = kF*dati(:,ichF1);                                  % [microepsilon] Canale collare sezione F ruota 2 0°-180°
F2 = kF*dati(:,ichF2);                                  % [microepsilon] Canale collare sezione F ruota 2 90°-270°
G1 = kG*dati(:,ichG1);                                  % [microepsilon] Canale fusello sezione G ruota 2 0°-180°
G2 = kG*dati(:,ichG2);                                  % [microepsilon] Canale fusello sezione G ruota 2 90°-270°
H = kH*dati(:,ichH);                                    % [V]  Canale torsionale presso ruota 1
I = kI*dati(:,ichI);                                    % [V]  Canale torsionale presso ruota 2
P = dati(:,ichP);                                       % [V]  Canale mozzo ruota 1
Q = dati(:,ichQ);                                       % [V]  Canale piede ruota 1
R = dati(:,ichR);                                       % [V]  Canale mozzo ruota 2
S = dati(:,ichS);                                       % [V]  Canale piede ruota 2 

%- Calcolo forze di contatto verticali

Q1 = [];						% vertical contact force Q1
Q2 = [];						% vertical contact force Q2

for j = 1:nrdati
    q2 = (1/(2*s)*(-FQ1(j)*(sb-s)*cos(alfa(j))+FQ2(j)*(sb+s)*cos(alfa(j))-(FY(j)+DY(j))*r+Peso*(d+s)));         % forza di contatto verticale dx
    q1 = (FQ1(j)+FQ2(j))*cos(alfa(j))+Peso-q2;                                                                  % forza di contatto verticale sx
    Q2 = [Q2; q2];
    Q1 = [Q1; q1];        
end

%--- Grafici
figure
plot(time,Q1,'k',time,Q2,'b','LineWidth',2),grid
xlabel('Time [s]'),ylabel('Force kN]'),title(fname)
legend('Q1 - vertical contact force left wheel','Q2 - vertical contact force right wheel')

figure
subplot(3,1,1)
plot(time,A1,'k',time,A2,'c',time,B1,'r',time,B2,'b'),hold on
grid,legend('A1','A2','B1','B2'),title(fname),xlabel('[s]'),ylabel('\mu m/m')
subplot(3,1,2)
plot(time,C1,'k',time,C2,'c',time,D1,'r',time,D2,'b',time,E1,'g',time,E2,'y'),hold on
grid,legend('C1','C2','D1','D2','E1','E2'),xlabel('[s]'),ylabel('\mu m/m')
subplot(3,1,3)
plot(time,F1,'k',time,F2,'c',time,G1,'r',time,G2,'b'),hold on
grid,legend('F1','F2','G1','G2'),xlabel('[s]'),ylabel('\mu m/m')