       >>SOURCE FORMAT FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Hello.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 DUMMY-CHAR PIC X.

       PROCEDURE DIVISION.
           DISPLAY "✅ Hello from COBOL in WSL!".
           DISPLAY "Press Enter to exit".
           ACCEPT DUMMY-CHAR.
           STOP RUN.
