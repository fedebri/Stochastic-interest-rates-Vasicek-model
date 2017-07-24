% Vasicek schema di Eulero

function r = vasicekEul (a, b, sig, r0, T, N)
% a = speed of mean reversion
% b = long-run mean interest rate
% sig = volatility of interest rate
% r0 = current interest rate
% T = time to maturity espresso in anni
% N = numero di passi di discretizzazione (360 o 60)
% Inizializzione di vettori (e.g.: r) per migliorare efficacia computazionale

r = zeros (N+1, 1);
r(1) = r0;
dt = T/N;

for w = 1 : N
    r(w + 1) = r(w) + a*(b - r(w))*dt + (sig*randn*sqrt(dt));
    end    
end


% Vasicek schema Esplicito

function r = vasicekEsp (a, b, sig, r0, T, N)

r = zeros (N+1, 1);
r(1) = r0;
dt = T/N;

for w = 1 : N
    r (w + 1) = r(w)*exp(-a*dt) + b*(1-exp(-a*dt)) + randn*sig*((sqrt(1-? 
    ?exp(a*dt))/(2*a)));
    end
end
                                        

% Vasicek normal distribution

function r = vasicekNor (a, b, sig, r0, T, N)
r = zeros (N+1, 1);
r(1) = r0;
dt = T/N;
for w = 1:N
    mean = r(w)*exp(-a*dt) + b*(1-exp(-a*dt));
    var =(sig^2/(2*a)) * (1-exp(-2*a*dt));
    r(w+1)= normrnd(mean, var);
end

% ZCB calcolo del prezzo 

function P = zcb (a, b, sig, r, T, t)
% t = tempo attuale, espresso in frazione di anno, e.g. fine primo trimestre 
% t = 0.25, fine secondo trimestre t = 0.5
 
ttm = (T-t) / T;
B = (1-exp(-a*(ttm)))/a;
A = exp((B-ttm) * (a^2*b - sig^2/2)/(a^2)  - (sig^2*B^2)/4*a);
P = 1000*(A*(exp(-B*r)));
end

%Simulazione tasso + calcolo prezzo

function mc_zcb (M, a, b, sig, r0, T, N,t)
% M = numero di simulazioni
 
r_avg = zeros (N,1);
P = zeros (N,1);
 
 
for w = 1 : M
    r =  vasicekNor (a, b, sig, r0, T, N);
    for d = 1 : N
       r_avg(d,1)  = r_avg(d,1) + r(d,1);
    end
 
end
r_avg = r_avg / M;
 
for s = 1 : N
    ra = r_avg(s,1);
    P(s,1) = zcb (a, b, sig, ra, T, t);
 
end
 
P(N,1)
 
end
r_avg / M;
r_avg(d,1) + r(d,1);
b, sig, ra, T, t);
1 : N
P(s,1) = zcb (a,
end
P(N,1)
end
