            gamma_WT = single_WT_AUC(:,30:40); gamma_WT = mean(gamma_WT');
            gamma_L = single_LRRK_AUC(:,30:40); gamma_L = mean(gamma_L');
            gamma_WT_m = mean(gamma_WT);
            gamma_L_m = mean(gamma_L);
            gamma_WT_sem = sem(gamma_WT);
            gamma_L_sem = sem(gamma_L);
            
            x_all = [.8 1.2; 2.8 3.2; 4.8 5.2; 6.8 7.2; 8.8 9.2; 10.8 11.2];
            f_bands = [1 3 5 7 9 11];
            % x_WT = [1 4 7 10 13 16];
            %x_L = [2 5 8 11 14 17];
            
            bp = [delta_WT_m delta_L_m; theta_WT_m theta_L_m; alpha_WT_m alpha_L_m; sigma_WT_m sigma_L_m; beta_WT_m beta_L_m; gamma_WT_m gamma_L_m];
            % b = bar(bp);
            figure;
            b = bar(x_all, bp,4);
            set(gca,'XTick',f_bands); set(gca,'XTickLabel',[{'delta'} {'theta'} {'alpha'}  {'sigma'} {'beta'} {'gamma'}]);
            b(1).FaceColor = 'k';
            b(2).FaceColor = 'b';
            
            eb = [delta_WT_sem delta_L_sem; theta_WT_sem theta_L_sem; alpha_WT_sem alpha_L_sem; sigma_WT_sem sigma_L_sem; beta_WT_sem beta_L_sem; gamma_WT_sem gamma_L_sem];
            hold on;
            e = errorbar(x_all,bp,eb,'o');
            e(1).Color = 'r';
            e(2).Color = 'c';