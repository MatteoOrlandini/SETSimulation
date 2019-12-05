clear all; close all;

y = [];
n = 5;
N1 = -n:n;
N2 = -n:n;
for k = 1:6
    for i = 1:(2*n+1)
        for j = 1:(2*n+1)
            F(i,j,k)=f_tunnel_2dot(k,i-n,j-n,1,0);
        end
    end
end

figure; surf(N1,N2,F(:,:,1),'FaceAlpha',0.5);
hold on; surf(N1,N2,F(:,:,2),'FaceAlpha',0.5);
hold on; surf(N1,N2,F(:,:,3),'FaceAlpha',0.5);
hold on; surf(N1,N2,F(:,:,4),'FaceAlpha',0.5);
hold on; surf(N1,N2,F(:,:,5),'FaceAlpha',0.5);
hold on; surf(N1,N2,F(:,:,6),'FaceAlpha',0.5);


% for i = -n : n
%     y = [y; f_tunnel_2dot(1,i,5,1,0)];
% end
% %%% plot dei 4 tipi di gamma(n) per n che va da -10 a 10
% figure ('Name','plot dei 4 tipi di gamma(n) per n che va da -10 a 10','NumberTitle','off');
% plot(N, y(:,1), N, y(:,2), N, y(:,3), N, y(:,4), N, y(:,5), N, y(:,6));
% xlabel ('Numero di cariche nel dot (n)');
% ylabel ('Rate di tunneling (\Gamma_n)');
% legend ('\Gamma_{source->dot1}', '\Gamma_{dot1->source}', '\Gamma_{dot1->dot2}', '\Gamma_{dot2->dot1}', '\Gamma_{dot2->drain}', '\Gamma_{drain->dot2}')
