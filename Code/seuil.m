function [ graph ] = seuil( type )
%Applique un seuillage adaptatif gaussien, et calcule la valeur de
%l'interfrange pour toutes les mesures (�cart de 25nm pour la calibration, 100nm pour les mesures)puis affiche la
%courbe i=f(z);
% type : type de valeurs sur lesquelles on effectue les calculs :
%0->calibration, 1->mesures
if (type == 0)
    for i = 0: 25: 1375
        img1 = bin2mat(name_Z('..\..\Projet 2A\Calibration\STACK=0001_IM=00001_Z=',i));
        im = zeros(120, 120);
        im = masque_rephase(img1);
        %figure;
        %imshow2(im);
        % On remplace le pixel central par la moyenne des pixels
        % l'entourant
        moyenne = 0;
        for i=-1:1
            for j=-1:1
                moyenne = moyenne + img1(61+i,61+j);
            end
        end
        moyenne = (moyenne-img1(61,61))/8;
        img1(61,61) = moyenne;
        p = fit_gauss2D(img1);
        im_seuil = zeros(120, 120);
        comparaison = hgaussp(size(img1), [p(3), p(4)], p(2), p(5), p(1), 1);
        for i=1:120
            for j=1:120
                if im(i,j)>comparaison(i,j)-75
                    im_seuil(i,j) = 1;
                else
                    im_seuil(i,j) = 0;
                end
            end
        end
        
        im_seuil = bwmorph(im_seuil, 'remove', Inf);
        %figure;
        %imshow(im_seuil,'InitialMagnification','fit');
        %title('seuillage adap fit-gauss2D');
        
        %Bw = edge(im_seuil, 'canny', [0.1 0.5],3);
        %figure;
        %imagesc(Bw);
        [L,num] = bwlabel(im_seuil,8);
        
        barycentre = zeros(2,num);
        for ii=1:num
            
            im_seuil=(L==ii);
            [y,x] = find(im_seuil);
            barycentre(1,ii) = mean(x);
            barycentre(2,ii) = mean(y);
        end
        %figure(1);
        %line(barycentre(1,:), barycentre(2,:), 'LineStyle', 'none', 'Marker', '+', 'color', [1 0 0]);
        
       % d(i) = pdist([barycentre(1,2),barycentre(2,2);barycentre(1,3), barycentre(2,3)], 'euclidean');
    end
    figure;
    graph = plot( 0 : 25 : 1375, d);
else
    for i = 0 : 100 : 1400
        img1 = bin2mat(name_Z('..\..\Projet 2A\Mesures\STACK=0000_IM=00001_Z=',i));
        im = zeros(120, 120);
        im = masque_rephase(img1);
        %figure;
        %imshow2(im);
        p = fit_gauss2D(img1);
        im_seuil = zeros(120, 120);
        comparaison = hgaussp(size(img1), [p(3), p(4)], p(2), p(5), p(1), 1);
        for i=1:120
            for j=1:120
                if im(i,j)>comparaison(i,j)-75
                    im_seuil(i,j) = 1;
                else
                    im_seuil(i,j) = 0;
                end
            end
        end
        
        im_seuil = bwmorph(im_seuil, 'remove', Inf);
        %figure;
        %imshow(im_seuil,'InitialMagnification','fit');
        %title('seuillage adap fit-gauss2D');
        
        %Bw = edge(im_seuil, 'canny', [0.1 0.5],3);
        %figure;
        %imagesc(Bw);
        [L,num] = bwlabel(im_seuil,8);
        
        %barycentre = zeros(2,num);
%         for ii=1:num
%             
%             im_seuil=(L==ii);
%             [y,x] = find(im_seuil);
%             barycentre(1,ii) = mean(x);
%             barycentre(2,ii) = mean(y);
%         end
%         %figure(1);
%         %line(barycentre(1,:), barycentre(2,:), 'LineStyle', 'none', 'Marker', '+', 'color', [1 0 0]);
%         
%         d(i) = pdist([barycentre(1,2),barycentre(2,2);barycentre(1,3), barycentre(2,3)], 'euclidean');
%     end
%     figure;
%     graph = plot(0 : 100 : 1400, d);
    
end
end

