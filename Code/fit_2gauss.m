function [ p ] = fit_2gauss(x,y)
%: renvoie les coefficients correspondant � l'approximation de deux
%gaussiennes sur une image, avec offset
%de la forme y=A+Bexp((x-D)^2)/(2s*s)   + A'+B'exp((x-D')^2)/(2s'*s')
%Entrees:
%   x,y: donn�es � approximer
%Sortie:
%   p0: coefficients autours desquels on va chercher la bonne approximation
%       p0(1) -> offset selon y => A
%       p0(2) -> amplitude
%       p0(3) -> moyenne
%       p0(4) -> ecart type
%%
[x,y]=size(img);


%Calcul des coefficients probables
p0(1)=min(y);
[p0(2),i]=max(y);
p0(2)=p0(2)-min(y);
p0(3)=x(i);
%variance: on trouve le x correspondant a la moiti� du maximum
j=i;
while (y(j)>y(i)/2) && (j<length(y))
    j=j+1;
end 
p0(4)=sqrt(((x(j)-p0(3))^2)*log(2*p0(2)/(p0(2)-p0(1)))/2); 


p=lsqnonlin(@(p)(y-p(1)-p(2)*exp(-((x-p(3)).^2)./(2*p(4)*p(4)))),p0);

end