real cmax[NDIM];
real courantmax;
int nt;

int ngi=2;
int ngj=2;
int ngk=2;



//Domain definition
// Define the x domain
#ifdef USE_SAC
int ni;
ni=128; //BW tests
ni=ni+2*ngi;
//ni=512;

real xmax=5955555.6e0;
real xmin=133333.33;
real dx = (xmax-xmin)/(ni);

#endif



// Define the y domain
#ifdef USE_SAC
int nj=2;  //BW test
nj=nj+2*ngj;


real ymax = 189453.1e0;
real ymin=1953.10;
//real dy = (ymax-ymin)/(nj); 
real dy = (ymax-ymin)/(128);
    
//nj=41;
#endif

               

real *x=(real *)calloc(ni,sizeof(real));
for(i=0;i<ni;i++)
		x[i]=i*dx;

real *y=(real *)calloc(nj,sizeof(real));
for(i=0;i<nj;i++)
		y[i]=i*dy;



int step=0;
real tmax = 0.2;
int steeringenabled=1;
int finishsteering=0;
char configfile[300];
//char *cfgfile="zero1.ini";
char *cfgfile="configs/1D_iso_128_spic_asc.ini";
//char *cfgfile="zero1_BW_bin.ini";
char *cfgout="/fastdata/cs1mkg/smaug1d_iso_nograv/spic_300_1d/zerospic1_";
//char *cfgout="/fastdata/cs1mkg/smaug1d/spic_30_1d/zerospic1_";


struct params *d_p;
struct params *p=(struct params *)malloc(sizeof(struct params));

struct state *d_state;
struct state *state=(struct state *)malloc(sizeof(struct state));



//dt=0.15;
//dt=0.000000493;  //BW tests
dt=0.0002;
nt=6000000;

real *t=(real *)calloc(nt,sizeof(real));
for(i=0;i<nt;i++)
		t[i]=i*dt;



p->n[0]=ni;
p->n[1]=nj;
p->ng[0]=ngi;
p->ng[1]=ngj;
p->npgp[0]=1;
p->npgp[1]=1;
p->dt=dt;
p->dx[0]=dx;
p->dx[1]=dy;
p->gamma=1.66666667;  //OZ test
p->mu=1.0;
p->eta=0.0;
//p->g[0]=-274.0;
p->g[0]=0.0;
p->g[1]=0.0;
p->g[2]=0.0;
p->cmax=0.02;
p->rkon=0.0;
p->sodifon=1.0;
p->moddton=0.0;
p->divbon=0.0;
p->divbfix=0.0;
p->hyperdifmom=1.0;
p->readini=1.0;
p->cfgsavefrequency=5000;

p->xmax[0]=xmax;
p->xmax[1]=ymax;
p->xmin[0]=xmin;
p->xmin[1]=ymin;
p->nt=nt;
p->tmax=tmax;





p->steeringenabled=steeringenabled;
p->finishsteering=finishsteering;
p->maxviscoef=0;
p->chyp3=0.00000;


for(i=0;i<NVAR;i++)
  p->chyp[i]=0.0;

p->chyp[rho]=0.02;
p->chyp[energy]=0.02;
p->chyp[b1]=0.02;
p->chyp[b2]=0.02;
p->chyp[mom1]=0.4;
p->chyp[mom2]=0.4;




iome elist;
meta meta;


for(int ii=0; ii<NVAR; ii++)
for(int idir=0; idir<NDIM; idir++)
for(int ibound=0; ibound<2; ibound++)
{
   (p->boundtype[ii][idir][ibound])=4;  //period=0 mpi=1 mpiperiod=2  cont=3 contcd4=4 fixed=5 symm=6 asymm=7
}



elist.server=(char *)calloc(500,sizeof(char));
meta.directory=(char *)calloc(500,sizeof(char));
meta.author=(char *)calloc(500,sizeof(char));
meta.sdate=(char *)calloc(500,sizeof(char));
meta.platform=(char *)calloc(500,sizeof(char));
meta.desc=(char *)calloc(500,sizeof(char));
meta.name=(char *)calloc(500,sizeof(char));
meta.ini_file=(char *)calloc(500,sizeof(char));
meta.log_file=(char *)calloc(500,sizeof(char));
meta.out_file=(char *)calloc(500,sizeof(char));

strcpy(meta.directory,"out");
strcpy(meta.author,"MikeG");
strcpy(meta.sdate,"Nov 2009");
strcpy(meta.platform,"swat");
strcpy(meta.desc,"A simple test of SAAS");
strcpy(meta.name,"test1");
strcpy(meta.ini_file,"test1.ini");
strcpy(meta.log_file,"test1.log");
strcpy(meta.out_file,"test1.out");


strcpy(elist.server,"localhost1");
elist.port=80801;
elist.id=0;


