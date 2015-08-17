%save('p30_vz_1d.mat');

pdat=eflux;
%pdat=wvz;

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
 
  
  