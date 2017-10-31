%-------- Print eps plots -----

set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');

switch changed
    case 1
        str1 = strcat('$\gamma=',num2str(gamma_1),'$');
        str2 = strcat('$\gamma=',num2str(gamma_2),'$');
        file_name = strcat('gamma',num2str(gamma_1),'gamma',num2str(gamma_2));
        
    case 2
        str1 = '$r(t)=';
        str2 = '$r(t)=';
        if dc_1~=0
            str1 = strcat(str1,num2str(dc_1),'+');
        end
        if dc_2~=0
            str2 = strcat(str2,num2str(dc_2),'+');
        end
        plus_str1 = '';
        plus_str2 = '';
        for i=1:length(A)
            if A_1(i)~=0
                str1 = strcat(str1,plus_str1,num2str(A_1(i)),'sin(',num2str(W_1(i)),'t)');
                plus_str1 = '+';
            end
            if A_2(i)~=0
                str2 = strcat(str2,plus_str2,num2str(A_2(i)),'sin(',num2str(W_2(i)),'t)');
                plus_str2 = '+';
            end
        end
        str1 = strcat(str1,'$');
        str2 = strcat(str2,'$');
        file_name = 'r1r2';
        
    case 3
        theta_str_1 = '[\,';
        for i=1:length(theta0_1)
            if i ~= length(theta0_1)
                theta_str_1 = strcat(theta_str_1,num2str(theta0_1(i)),'\,\,');
            else
                theta_str_1 = strcat(theta_str_1,num2str(theta0_1(i)),'\,]');
            end
        end
        theta_str_2 = '[\,';
        for i=1:length(theta0)
            if i ~= length(theta0)
                theta_str_2 = strcat(theta_str_2,num2str(theta0(i)),'\,\,');
            else
                theta_str_2 = strcat(theta_str_2,num2str(theta0(i)),'\,]');
            end
        end
        str1 = strcat('$\theta(0)=',theta_str_1,'$');
        str2 = strcat('$\theta(0)=',theta_str_2,'$');
        file_name = 'theta01theta02';
end

path_tiltheta = strcat('./tiltheta/',sim_str,file_name,'.eps');
path_modtheta = strcat('./modtheta/',sim_str,file_name,'.eps');
path_epsilon = strcat('./epsilon/',sim_str,file_name,'.eps');

%--------------- Fig1: til_theta -------------
figure(1);clf;

subplot(211);
plot(T_1,tiltheta_1);grid on;
title(strcat('$\tilde{\theta}$ com~ ', str1));

subplot(212);
plot(T_2,tiltheta_2);grid on;
title(strcat('$\tilde{\theta}$ com~ ', str2));

switch(N)
    case 1
        subplot(211);
        legend('$\tilde{\theta}_1$','$\tilde{\theta}_2$','Location','SouthEast');
        subplot(212);
        legend('$\tilde{\theta}_1$','$\tilde{\theta}_2$','Location','SouthEast');
    case 2
        subplot(211);
        legend('$\tilde{\theta}_1$','$\tilde{\theta}_2$','$\tilde{\theta}_3$','$\tilde{\theta}_4$','Location','SouthEast')
        subplot(212);
        legend('$\tilde{\theta}_1$','$\tilde{\theta}_2$','$\tilde{\theta}_3$','$\tilde{\theta}_4$','Location','SouthEast')
    case 3
        subplot(211);
        legend('$\tilde{\theta}_1$','$\tilde{\theta}_2$','$\tilde{\theta}_3$','$\tilde{\theta}_4$','$\tilde{\theta}_5$','$\tilde{\theta}_6$','Location','SouthEast')
        subplot(212);
        legend('$\tilde{\theta}_1$','$\tilde{\theta}_2$','$\tilde{\theta}_3$','$\tilde{\theta}_4$','$\tilde{\theta}_5$','$\tilde{\theta}_6$','Location','SouthEast')
end

if PRINT
    print(path_tiltheta,'-depsc2')
end

%--------------- Fig2: mod theta -------------
figure(2);clf;

plot(T_1,modtt_1);grid on;hold on;
plot(T_2,modtt_2);
plot(T_1,norm(thetas)*ones(1,length(T_1)));hold off;

title('$||\theta||$');
legend(str1,str2,'$||\theta^*||$','Location','SouthEast');

if PRINT
    print(path_modtheta,'-depsc2')
end

%--------------- Fig3: epsilon -------------
figure(3);clf;

plot(T_1,epsilon_1);grid;hold on;
plot(T_2,epsilon_2);hold off;

title('$\epsilon$');
legend(str1,str2,'Location','SouthEast');

if PRINT
    print(path_epsilon,'-depsc2')
end

