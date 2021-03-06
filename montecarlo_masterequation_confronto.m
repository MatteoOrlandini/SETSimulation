
% Per visualizzare i risultati: copiare e incollare nella linea di comando
% Matlab le linee di codice per ciascuno dei test riportati sotto

clc
%clear all
close all

%%% test 1
%%%%%%%%
y = [];
n = 10;
for i = -n : n 
    y = [y; f_tunnel0(1,i,1,0)];
end;
%%% plot dei 4 tipi di gamma(n) per n che va da -10 a 10
figure ('Name', 'plot dei 4 tipi di gamma(n) per n che va da -10 a 10', 'NumberTitle', 'off');
plot(-n:n, y(:,1), -n:n, y(:,2), -n:n, y(:,3), -n:n, y(:,4));
xlabel ('Number of charge stored into the dot (n)', 'Interpreter', 'latex');
ylabel ('Tunneling rate $\Gamma_n$', 'Interpreter', 'latex');
legend ('\Gamma_{source \rightarrow dot}', '\Gamma_{dot \rightarrow source}', '\Gamma_{dot \rightarrow drain}', '\Gamma_{drain \rightarrow dot}')

%%% test 2
%%%%%%%%%
%%% plot del termine [p(n)*(\Gamma_dot->R)(N) - (\Gamma_R->dot)(N)] al variare di V
figure('Name','plot del termine [p(n)*(\Gamma_{dot->R})(N) - (\Gamma_{R->dot})(N)] al variare di V','NumberTitle','off');
for i = 1:50
    corrente(i) = master_equation0(exp(0.04*i)-1, 0.5, 10); 
end; 
xlabel ('Drain voltage ($V_d$)', 'Interpreter', 'latex');
ylabel ('$p(n) \cdot [\Gamma_{dot \rightarrow R}(N) - \Gamma_{R \rightarrow dot}(N)]$', 'Interpreter', 'latex');
%legend (num2str(exp(0.04*[1:50])));
hold off; 

%plot del termine [p(n)*(\Gamma_dot->R)(N) - (\Gamma_R->dot)(N)] al variare di Vg
figure('Name','plot del termine [p(n)*(\Gamma_{dot \rightarrow R})(N) - (\Gamma_{R \rightarrow dot})(N)] al variare di Vg','NumberTitle','off');
for i=1:50 
    corrente(i)=master_equation0(0.1, exp(0.04*i)-1, 10); 
end; 
xlabel ('Gate voltate ($V_g$)', 'Interpreter', 'latex');
ylabel ('$p(n) \cdot [\Gamma_{dot \rightarrow R}(N) - \Gamma_{R \rightarrow dot}(N)]$', 'Interpreter', 'latex');
hold off; 

%%% test 3
%%%%%%%%%
clear corrente; 
for i = 1:50 
    corrente(i) = master_equation(exp(0.04*i)-1,0.5,10); 
end;
N=10000;
clear t; 
clear curd; 
clear curs; 
clear car; 
for i = 1:50 
    [tempo,q,s,d] = arrivi(N,exp(0.04*i)-1,0.5); 
    curd(:,i) = d(:,1); 
    curs(:,i) = s(:,1); 
    t(:,i) = tempo(:,1); 
    car(:,i) = q(:,1);
end;
%%%% plot della corrente di drain (curd) al variare di V, avendo fissato Vg=0.5, confronto col risultato master equation
figure ('Name','plot della corrente di drain (curd) al variare di V, avendo fissato Vg=0.5, confronto col risultato master equation','NumberTitle','off');
plot(exp(0.04*[1:50])-1, (curd(length(curd),:))./sum(t(:,:)), exp(0.04*[1:50])-1, corrente);
xlabel ('Drain voltage ($V_d$)', 'Interpreter', 'latex');
ylabel ('Drain current ($I_d$)', 'Interpreter', 'latex');
legend ('Monte Carlo', 'Master Equations');
clear  corr_parz; 
for i = 1:N 
    corr_parz(i) = curd(i,10)/sum(t(1:i,10));
end; 
%%%% plot della corrente di drain (curd), al variare del tempo, avendo fissato V=exp(0.04*10) e Vg=0.5
figure ('Name','plot della corrente di drain (curd), al variare del tempo, avendo fissato V=exp(0.04*10) e Vg=0.5','NumberTitle','off');
plot(corr_parz);
xlabel ('Time');
ylabel ('Drain current ($I_d$)', 'Interpreter', 'latex');
%%% numero di cariche arrivate al drain al variare del tempo, avendo fissato V=exp(0.04*10) e Vg=0.5
figure ('Name','numero di cariche arrivate al drain al variare del tempo, avendo fissato V=exp(0.04*10) e Vg=0.5','NumberTitle','off');
plot(curd(:,10));
xlabel ('Time');
ylabel ('Charges arrived at the drain');
%%% numero di cariche uscite dal source al variare del tempo, avendo fissato V=exp(0.04*10) e Vg=0.5
figure ('Name','numero di cariche uscite dal source al variare del tempo, avendo fissato V=exp(0.04*10) e Vg=0.5','NumberTitle','off');
plot(curs(:,10))
xlabel ('Time');
ylabel ('Charges that left the drain');
%%% somma algebrica del numero di cariche di cui ai due punti precedenti
figure ('Name','somma algebrica del numero di cariche arrivate al drain e uscite dal source','NumberTitle','off');
plot(curs(:,10)+curd(:,10))
xlabel ('Time');
ylabel ('Charges that left the source');
%%% media temporale della somma algebrica di cui al punto precedente
mean(curd(:,10)+curs(:,10))
%%% media temporale della carica nel dot, sempre avendo fissato V=exp(0.04*10) e Vg=0.5
mean(car(:,10))
%%%%% da notare l'uguaglianza delle due medie di cui ai due punti precedenti (segno a parte, essendo un bilancio di cariche)

%%% test 4
%%%%%%%%%
clear corrente; 
for i = 1:50 
    corrente(i) = master_equation(0.4,exp(0.04*i)-1,10); 
end;
N=10000;
clear t; 
clear curd; 
clear curs; 
clear car; 
for i = 1:50 
    [tempo,q,s,d] = arrivi(N,0.4,exp(0.04*i)-1); 
    curd(:,i) = d(:); 
    curs(:,i) = s(:,1); 
    t(:,i) = tempo(:,1); 
    car(:,i) = q(:,1); 
end;
%%%% plot della corrente di drain (curd) al variare di Vg, avendo fissato V=0.4, confronto col risultato master equation
figure ('Name','plot della corrente di drain (curd) al variare di Vg, avendo fissato V=0.4, confronto col risultato master equation','NumberTitle','off');
plot(exp(0.04*[1:50])-1, (curd(length(curd),:))./sum(t(:,:)), exp(0.04*[1:50])-1, corrente);
xlabel ('Gate voltage ($V_g$)', 'Interpreter', 'latex');
ylabel ('Drain current ($I_d$)', 'Interpreter', 'latex');
legend ('Monte Carlo', 'Master Equations');
for i = 1:N 
    corr_parz(i) = curd(i,10)/sum(t(1:i,10));
end; 
%figure (4); 
% %%%% plot della corrente di drain (curd), al variare del tempo, avendo fissato Vg=exp(0.04*10) e V=0.4
figure ('Name','plot della corrente di drain (curd), al variare del tempo, avendo fissato Vg=exp(0.04*10) e V=0.4','NumberTitle','off');
plot(corr_parz)  
xlabel ('Time');
ylabel ('Drain current ($I_d$)', 'Interpreter', 'latex');

%%% test 5
%%%%%%%%%
clear corrente; 
for i = 1:50 
    for j = 1:20 
        corrente(i,j) = master_equation(exp(0.04*j)-1,exp(0.04*i)-1,10); 
    end;
end;
N=10000;
clear t; 
clear curd; 
clear curs; 
clear car; 
for i = 1:50 
    for j = 1:20 
        [tempo,q,s,d] = arrivi(N,exp(0.04*j)-1,exp(0.04*i)-1); 
        curd(i,j) = d(length(d))/sum(tempo);
        curs(i,j) = s(length(s))/sum(tempo); 
        car(i,j) = mean(q);
    end;
end;
figure('Name','confronto risultati Montecarlo e Master equations','NumberTitle','off');
hold off; 
surf(exp(0.04*[1:20])-1, exp(0.04*[1:50])-1, corrente);
hold on; 
%%% confronto risultati Montecarlo e Master equations 
surf(exp(0.04*[1:20])-1, exp(0.04*[1:50])-1, curd); 
hold off; 
figure('Name','carica immagazzinata nel Dot, al variare di V e Vg','NumberTitle','off');
%carica immagazzinata nel Dot, al variar di V e Vg
surf(exp(0.04*[1:20])-1, exp(0.04*[1:50])-1, car);