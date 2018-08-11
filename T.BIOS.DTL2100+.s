*********************************
*                               *
* 'BIOS' POUR DIGITELEC 2100+   *
*                               *
*********************************
*
* ADRESSES DU DIGITELEC 2100
*
SLOTDTL   = 2
*
PTA       = SLOTDTL*16+$C088
PTB       = SLOTDTL*16+$C089
PTC       = SLOTDTL*16+$C08C
PTD       = SLOTDTL*16+$C08D
*
* INITIALISATION MODEM
*
INITMDM   LDA #0
          STA PTB
          LDA #252
          STA PTA
          LDA #4
          STA PTB
          LDA #3
          STA PTC
          LDA #9
          STA PTC
          LDA #4
          STA PTA
          RTS
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
          DO EXPO
          JMP CESC2
          FIN
CLOOP     LDA PTA
          AND #2
          BNE CESC
          LDA PTC
          LDA PTD
          LDA PTC
          AND #12
          BNE CESC
          RTS
CESC      LDY $C000
          BIT $C010
          CPY #$9B
          BNE CLOOP
CESC2     LDY #'I'
          JSR READY1
          LDY #'M'
          JSR READY1
          LDY #'R'
          JSR READY1
          LDY #$0D
          JSR READY1
          JMP CLOOP
*
* ENVOI D'UN CARACTERE
*
ENVOICAR  TAY
          LDA PTA
          AND #%00000010
          BNE FINENVOI
READY1    LDA PTC
          AND #2
          BEQ READY1
          STY PTD
FINENVOI  RTS
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
PORTEUSE  LDA PTA
          AND #%00000010
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
RACCROCH  LDA #164
          STA PTA
          LDA #160
          STA PTA
          RTS
*
* EFFACE LE BUFFER DE RECEPTION DU MODEM
*
CLEARCV   LDA PTD
          RTS
********************************
* FIN DU BIOS DTL 2100         *
********************************

