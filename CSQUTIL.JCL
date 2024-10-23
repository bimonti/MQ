//*                                                                   
//*------------------------------------------------------------------*
//* Author: Dirceu Ivo (contato@bimonti.com.br)                      |
//*   Date: 23-Oct-2024                                              |
//*  Descr: Execute MQ Commands in Batch mode.                       |
//*   Inst: N/A                                                      |
//*------------------------------------------------------------------*
//*                                                                   
//*------------------------------------------------------------------*
//* CSQUTIL1 | MQ Command processor in batch.              | RC:0000 |
//*------------------------------------------------------------------*
//CSQUTIL1 EXEC PGM=CSQUTIL,PARM='MQ01'                               
//STEPLIB  DD DISP=SHR,DSN=MQSERIES.SCSQAUTH                     
//         DD DISP=SHR,DSN=MQSERIES.SCSQANLE                     
//OUTPUT   DD SYSOUT=*                                                
//SYSPRINT DD SYSOUT=*                                                
//SYSIN    DD *                                                       
COMMAND DDNAME(CMDINP) MAKEDEF(OUTPUT)                               
/*                                              
//CMDINP   DD *                                 
DISPLAY STGCLASS(*) ALL QSGDISP(QMGR)           
DISPLAY STGCLASS(*) ALL QSGDISP(GROUP)          
DISPLAY CFSTRUCT(*) ALL                         
DISPLAY QUEUE(*) ALL QSGDISP(QMGR)              
DISPLAY QUEUE(*) ALL QSGDISP(GROUP)             
DISPLAY QUEUE(*) ALL QSGDISP(SHARED)            
DISPLAY PROCESS(*) ALL QSGDISP(QMGR)            
DISPLAY PROCESS(*) ALL QSGDISP(GROUP)           
/*                                             