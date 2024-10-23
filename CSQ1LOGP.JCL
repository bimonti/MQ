//*                                                                   
//*------------------------------------------------------------------*
//* Author: Dirceu Ivo (contato@bimonti.com.br)                      |
//*   Date: 23-Oct-2024                                              |
//*  Descr: MQ Log Print Utility to extract commited messages.       |
//*   Inst: See MQ for z/OS User Guide.                              |
//*------------------------------------------------------------------*
//PRTLOG EXEC PGM=CSQ1LOGP                                            
//STEPLIB  DD DISP=SHR,DSN=MQSERIES.SCSQLOAD                     
//         DD DISP=SHR,DSN=MQSERIES.SCSQANLE                     
//ACTIVE1  DD DISP=SHR,DSN=MQSERIES.LOGCOPY1.DS01           
//ACTIVE2  DD DISP=SHR,DSN=MQSERIES.LOGCOPY1.DS02           
//ACTIVE3  DD DISP=SHR,DSN=MQSERIES.LOGCOPY1.DS03           
//ACTIVE4  DD DISP=SHR,DSN=MQSERIES.LOGCOPY1.DS04           
//ACTIVE5  DD DISP=SHR,DSN=MQSERIES.LOGCOPY1.DS05   
//ACTIVE6  DD DISP=SHR,DSN=MQSERIES.LOGCOPY1.DS06   
//ACTIVE7  DD DISP=SHR,DSN=MQSERIES.LOGCOPY1.DS07   
//ACTIVE8  DD DISP=SHR,DSN=MQSERIES.LOGCOPY1.DS08   
//*SDS     DD DISP=SHR,DSN=MQSERIES.BSDS01                        
//CSQCMT   DD DISP=(NEW,CATLG),DSN=&SYSUID..CSQCMT,           
//         SPACE=(CYL,(50,50),RLSE)                           
//SYSPRINT DD DUMMY                                           
//SYSSUMRY DD SYSOUT=*                                        
//CSQ1DUMP DD SYSOUT=*                                        
//SYSIN    DD *                                               
PAGESET(2)                                                    
SUMMARY(NO)                                                   
EXTRACT(YES)                                                  
/*