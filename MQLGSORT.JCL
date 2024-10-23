//*                                                                   
//*------------------------------------------------------------------*
//* Author: Dirceu Ivo (contato@bimonti.com.br)                      |
//*   Date: 23-Oct-2024                                              |
//*  Descr: DFSORT job to list the Messages from the MQ Logs.        |
//EXPORT   EXPORT SYMLIST=*                                          |
//*SV         SET CSV=' '                                            |
//CSV         SET CSV=';'                                            |
//*                                                                  |
//*   Inst: Set the CSV variable above if you would like to export   |
//*         the report later. Otherwise, leave a blank space.        |
//*------------------------------------------------------------------*
//*                                                                   
//*------------------------------------------------------------------*
//* MQLGSORT | Sort and report on MQ messages.             | RC:0000 |
//*------------------------------------------------------------------*
//MQLGSORT EXEC PGM=SORT                                              
//SORTIN   DD DISP=SHR,DSN=&SYSUID..CSQCMT                            
//SYSOUT   DD SYSOUT=*                                         
//SORTDIAG DD DUMMY                                            
//REPORT   DD SYSOUT=*                                         
//SYMNAMES DD *                                                
rdw,1,4,BI                Record descriptor word
csrecorddate,*,21,CH      Log write time                       
cstimedelta,*,7,CH        Time delta from URID start           
dtodout,*,8,BI            STCK log was created                 
  logcredate,=,8,DC1      STCK to ISO Date YYYY/MM/DD          
  logcretime,=,8,TC4      STCK to ISO Time HH:MM:SS.TT         
csurid,*,8,CH             URID                                 
cscorrelator,*,12,CH      Thread correlation id                
csauth,*,8,CH             Authorization ID                     
dtime,*,8,BI              Time UoW started                     
  uowstadate,=,8,DC1      STCK to ISO Date YYYY/MM/DD          
  uowstatime,=,8,TC4      STCK to ISO Time HH:MM:SS.TT         
csresource,*,8,CH         Resource Name                         
cscnty,*,8,CH             Connection Type                       
cscnid,*,8,CH             Connection ID                         
csstatus,*,3,CH           Connection Type - BUR or CP           
ldatalen,*,4,BI           Data length                           
csqmgrname,*,4,CH         Queue Manager name                    
csqueuename,*,48,CH       Queue name                            
cssqdmcp,*,12,CH          Shared Queue message key              
csdmcp,*,8,CH             Non-shared queue message key          
csverb,*,8,CH             Activity verb                         
cscmitstatus,*,1,CH       UoW status - C, B or I                
csshunt,*,1,CH            Shunted status - Y or N               
cslogrba,*,8,CH           RBA of log record                     
csshuntrba,*,8,CH         RBA of shunted log record             
csuowscope,*,1,CH         Uow scope - Local or Shared           
lsegment,*,4,BI           Segment number                        
csbora,*,1,CH             Before or After copy of object        
csvardata,*,384,CH         Remainder of record                  
/*                                                            
//SYSIN    DD *,SYMBOLS=JCLONLY                               
*                                                             
* Handle long and short VB records                            
 OPTION VLSHRT,VLLONG    
*                                     
* Include only records that match queue name
 INCLUDE COND=(csqueuename,SS,EQ,C'QUEUE1',OR,                  
               csqueuename,SS,EQ,C'QUEUE2')                     
*                                                             
* Sort by Data and Time of log write                          
 SORT FIELDS=(csrecorddate,A)                                 
*                                                             
* Build the header and columns for reporting                  
 OUTFIL FNAMES=REPORT,REMOVECC,VLFILL=X'40',                  
   OUTREC=(1:rdw,csrecorddate,                                
   C'&CSV',cstimedelta,                                       
   C'&CSV',dtodout,HEX,                                       
   C'&CSV',logcredate,EDIT=(TTTT/TT/TT),                      
   C'&CSV',logcretime,EDIT=(TT:TT:TT.TT),                   
   C'&CSV',csurid,HEX,                                      
   C'&CSV',cscorrelator,                                    
   C'&CSV',csauth,                                          
   C'&CSV',dtime,HEX,                                       
   C'&CSV',uowstadate,EDIT=(TTTT/TT/TT),                    
   C'&CSV',uowstatime,EDIT=(TT:TT:TT.TT),                   
   C'&CSV',csresource,                                      
   C'&CSV',cscnty,                                          
   C'&CSV',cscnid,                                          
   C'&CSV',csstatus,                                        
   C'&CSV',ldatalen,EDIT=(IIIIIIIT),                        
   C'&CSV',csqmgrname,                                      
   C'&CSV',csqueuename,                                     
   C'&CSV',cssqdmcp,                                        
   C'&CSV',csdmcp,                                          
   C'&CSV',csverb,                                          
   C'&CSV',cscmitstatus,CHANGE=(8,                          
           C'C',C'Commit',                         
           C'B',C'Backout',                        
           C'I',C'Inflight'),                      
   C'&CSV',csshunt,CHANGE=(3,                      
           C'Y',C'Yes',                            
           C'N',C'No'),                            
   C'&CSV',cslogrba,HEX,                           
   C'&CSV',csshuntrba,HEX,                         
   C'&CSV',csuowscope,                             
   C'&CSV',lsegment,EDIT=(IIIIIIIT),               
   C'&CSV',csbora,                                 
   C'&CSV',csvardata)                              
/*                                                 

