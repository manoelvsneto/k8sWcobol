       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       
       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-CURRENT-DATE-DATA.
          05 WS-CURRENT-DATE.
             10 WS-CURRENT-YEAR         PIC 9(4).
             10 WS-CURRENT-MONTH        PIC 9(2).
             10 WS-CURRENT-DAY          PIC 9(2).
          05 WS-CURRENT-TIME.
             10 WS-CURRENT-HOUR         PIC 9(2).
             10 WS-CURRENT-MINUTE       PIC 9(2).
             10 WS-CURRENT-SECOND       PIC 9(2).
             10 WS-CURRENT-CENTISECOND  PIC 9(2).
       
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "COBOL Application Running on Kubernetes ARM64".
           MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE-DATA.
           DISPLAY "Data atual: " WS-CURRENT-DAY "/" WS-CURRENT-MONTH "/" 
                   WS-CURRENT-YEAR.
           DISPLAY "Hora atual: " WS-CURRENT-HOUR ":" WS-CURRENT-MINUTE ":" 
                   WS-CURRENT-SECOND.
           
           PERFORM VARYING WS-CURRENT-SECOND FROM 1 BY 1 UNTIL WS-CURRENT-SECOND > 10
               DISPLAY "Contador: " WS-CURRENT-SECOND
           END-PERFORM.
           
           DISPLAY "Processamento concluído com sucesso."
           STOP RUN.