********************************
*                              *
* 'BIOS' POUR DIGITELEC 2000+  *
*                              *
********************************
*
* ADRESSES DU DIGITELEC 2000+
*
SLOTDTL   = 2
*
PTA       = SLOTDTL*16+$C088
PTB       = SLOTDTL*16+$C089
PTC       = SLOTDTL*16+$C08C
PTD       = SLOTDTL*16+$C08D
*
* LECTURE DU REGISTRE PTC...
*
READPTC   LDA PTC
          PHA
          LDA PTD
          PLA
          RTS
*
* INITIALISATION MODEM
*
INITMDM   LDA #0
          STA PTB
          LDA #254
          STA PTA
          LDA #4
          STA PTB
          LDA #3
          STA PTC
          RTS
*
* CONNEXION AVEC LE MINITEL
*
CONNECT   JSR RACCROCH
          LDY #10
WL        LDA #$FF
          JSR WAITROM
          DEY
          BPL WL
BIGBELL   LDA #0
          STA TEMPOL
          LDA #-80
          STA TEMPOH
BELL1     LDA PTA
          AND #1
          BEQ BELL2
          LDY $C000
          CPY #$9B
          BNE BELL1
          BEQ BEND
BELL2     INC TEMPOL
          BNE BELL3
          BIT $C010
          INC TEMPOH
          BNE BELL3
          LDY #10
B2        LDA #$FF
          JSR WAITROM
          DEY
          BPL B2
          RTS
BELL3     LDA PTA
          AND #1
          BEQ BELL2
          JMP BIGBELL
BEND      BIT $C010
          LDA #186
          STA PTA
          LDA #9
          STA PTC
WAITPORT  LDA #0
          STA TEMPOL
          STA TEMPOH
          LDA #-10
          STA LEN
PORT1     JSR READPTC
          AND #4
          BEQ PORT2
          INC TEMPOL
          BNE PORT1
          INC TEMPOH
          BNE PORT1
          INC LEN
          BEQ CONNECT
          BNE PORT1
PORT2     LDA #0
          STA TEMP
          LDA #-15
          STA TEMP2
PORT3     LDA #5
          JSR WAITROM
          JSR READPTC
          AND #4
          BNE PORT1
          INC TEMP
          BNE PORT3
          INC TEMP2
          BNE PORT3
          RTS
*
* ENVOI D'UN CARACTERE
*
ENVOICAR  TAY
READY1    LDA PTC
          AND #2
          BEQ READY1
          STY PTD
          RTS
*
*
*
SENDCLEA  LDA PTC
          AND #2
          RTS
*
* TEST PORTEUSE PRESENTE
* SI ABSENTE -> LOST
*
PORTEUSE  JSR READPTC
          AND #%00000100
          BNE LOSTBIS
          RTS
LOSTBIS   JMP LOST
*
* TEST SI CARACTERE RECU...
* NE SI CARACTERE RECU
*
CARECU    LDA PTC
          AND #1
          RTS
*
* RECOIT UN CARACTERE DANS L'ACCUM.
*
RECOICAR  LDA PTD
          AND #$7F
          RTS
*
* RACCROCHE
*
RACCROCH  LDA #73
          STA PTC
          LDA #190
          STA PTA
          RTS
*
* EFFACE LE BUFFER DE RECEPTION DU MODEM
*
CLEARCV   LDA PTD
          RTS
********************************
* FIN DU BIOS DTL 2000 +       *
********************************

