%save('p30_vz_1d.mat');
%ntm=size(eflux);
ntm=size(wvz);
nt=ntm(1);
%pdat=eflux;
pdat=wvz;

  max1=max(pdat);
  max2=max(max1);
  maxval=max2;
  
  min1=min(pdat);
  minval=min(min1);
  


surf(pdat','LineStyle','none');

hold on
hc=colorbar();
%caxis(5e3*[0 1]);
%set(hc,'Zlim',5e3*[0 1]);




  cmap=colormap(jet(256));
  caxis([minval maxval]);
  
%   divmap=diverging_map(linspace(0,1,256),[0.23 0.299 0.754],[0.706 0.016 0.15]);
%   colormap(divmap);
 
  
  ef1Mm=sum(eflux(:,20))/nt;
ef2Mm=sum(eflux(:,42))/nt;
ef2p9Mm=sum(eflux(:,64))/nt;
ef4Mm=sum(eflux(:,90))/nt;
ef5p5Mm=sum(eflux(:,117))/nt;