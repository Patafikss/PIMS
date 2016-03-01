function [ pos ] = img_maxfourier2( img,alpha )
%retourne le max des franges qui nous int�resse
%supposant qu'img a �t� trait�e
[f1, posi1]=frange_detect(img,alpha);
[f2, posi2]=frange_detect(transpose(img),-alpha);
posi1=posi1-120;
posi2=posi2-120;
%%
%s�pare en deux la repr�sentation de fourier et prend le max de part et
%d'autre

f12=f1(length(f1)/2:length(f1));%freq positives
f11=f1(1:length(f1)/2);%freq 'n�gatives'

    f22=f2(length(f2)/2:length(f2));
    f21=f2(1:length(f2)/2);

    pos(1)=smooth_max(flipud(f11));
    pos(2)=smooth_max(f12);
    pos(3)=smooth_max(flipud(f21));
    pos(4)=smooth_max(f22);
    
    %% POUR POS(1)
    ka=ceil(length(f1)/2-pos(1));% round(L/2-pos)
    k1=ka-(length(f1)/2-pos(1));%juste le 0.X
    p1=posi1(ka,:)*(1-k1)+posi1(ka+1,:)*(k1);%renvoie x,y correspondant
    pos(1)=sqrt((p1(1)-61)^2+(p1(2)-61)^2);
   
    %% POUR POS(2)
%     kb=ceil(length(f1)/2-pos(2));% round(L/2-pos)
%     k1=kb-(length(f1)/2-pos(2));%juste le 0.X
%     p2=posi1(kb,:)*(1-k1)+posi1(kb+1,:)*(k1);%renvoie x,y correspondant
%     pos(2)=sqrt((p2(1)-61)^2+(p2(2)-61)^2);

end