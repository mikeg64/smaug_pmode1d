
directory='/fastdata/cs1mkg/smaug1d/spic_30_1d/';
extension='.out';


ndirectory='/fastdata/cs1mkg/smaug1d/spic_30_1d/images_3d_vsecs';
nextension='.jpg';
nt=1799;
nsz=128;

wvz=zeros(nt,nsz);
eflux=zeros(nt,nsz);
for i=1:1:nt
%for i=1519:2632
%for i=2631:2632

    

id=int2str(5000*i);
filename=[directory,'zerospic1__',id,extension];
timetext=['time=',int2str(i),'s'];
imfile=[ndirectory,'im1_',id,nextension];
disp([id filename]);
   fid=fopen(trim(filename));
   %fseek(fid,pictsize(ifile)*(npict(ifile)-1),'bof');
   headline=trim(setstr(fread(fid,79,'char')'));
   it=fread(fid,1,'integer*4'); time=fread(fid,1,'float64');
 
   ndim=fread(fid,1,'integer*4');
   neqpar=fread(fid,1,'integer*4'); 
   nw=fread(fid,1,'integer*4');
   nx=fread(fid,2,'integer*4');
   
   nxs=nx(1)*nx(2);
   varbuf=fread(fid,7,'float64');
   
   gamma=varbuf(1);
   eta=varbuf(2);
   g(1)=varbuf(3);
   g(2)=varbuf(4);
   %g(3)=varbuf(5);
   
   
   varnames=trim(setstr(fread(fid,79,'char')'));
   nw=nw-1;
   for idim=1:ndim
      X(:,idim)=fread(fid,nxs,'float64');
   end
   
   for iw=1:nw
      %fread(fid,4);
      w(:,iw)=fread(fid,nxs,'float64');
      %fread(fid,4);
   end
   
   nx1=nx(1);
   nx2=nx(2);
   %nx3=nx(3);
   
   xx=reshape(X(:,1),nx1,nx2);
   yy=reshape(X(:,2),nx1,nx2);
   %zz=reshape(X(:,3),nx1,nx2,nx3);
   
   
 
  % extract variables from w into variables named after the strings in wnames
wd=zeros(nw,nx1-4);
for iw=1:nw
  
     tmp=reshape(w(:,iw),nx1,nx2);
     wd(iw,:)=tmp(3:nx1-2,3);
end


%w=tmp(iw);
  

clear tmp; 
   
   
   fclose(fid);



   	R=8.3e+003;
	mu=1.257E-6;
	mu_gas=0.6;
	gamma=1.66667;


   
   nrange=1:128;
   

 

% TP=wd(7,nrange);
% TP=(gamma-1.d0).*TP;
% 
% myval=mu_gas.*TP./R./val2;



  
   
    val1=wd(4,nrange)+wd(7,nrange);%total energy
    val2=wd(4,nrange);%energy perturbed
    val3=wd(7,nrange);%energy bg
    val4=wd(1,nrange)+wd(8,nrange);%density
    val5=wd(2,nrange);
   
   myval=(gamma-1).*(val2-(val5./2)).*(val5./val4); %eflux

    eflux(i,:)=myval;



   val1=wd(2,nrange);
   val2=wd(1,nrange)+wd(8,nrange);


   myval=(val1./val2);
  %myval=wd(1,nrange);

   wvz(i,:)=myval;

    

  
end 
  
save('p30_eflux_vz_1d.mat','wvz','eflux');

ef1Mm=sum(eflux(:,20))/nt;
ef2Mm=sum(eflux(:,42))/nt;
ef2p9Mm=sum(eflux(:,64))/nt;
ef4Mm=sum(eflux(:,90))/nt;
ef5p5Mm=sum(eflux(:,117))/nt;

