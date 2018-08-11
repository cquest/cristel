********************************
*                              *
* 'BIOS' POUR MINITEL RETOURNE *
*                              *
********************************
*
* ADRESSES DE LA SUPER-SERIE
*
SLOTSSC   = 2
*
*
REG       = SLOTSSC*16+$C088
STATUS    = SLOTSSC*16+$C089
COMMAND   = SLOTSSC*16+$C08A
CONTROL   = SLOTSSC*16+$C08B
*
* INITIALISATION MODEM
*
INITMDM   LDA #107
          STA COMMAND
          LDA #56
          STA CONTROL
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
BELL1     LDA STATUS
          AND #64
          BNE BELL2
          LDY $C000
          CPY #$9B
          BNE BELL1
          BEQ BEND
BELL2     INC TEMPOL
          BNE BELL3
          BIT $C010
          INC TEMPOH
          BNE BELL3
          BEQ BEND
B2        LDA #$FF
          JSR WAITROM
          DEY
          BPL B2
          RTS
BELL3     LDA STATUS
          AND #64
          BNE BELL2
          JMP BIGBELL
BEND      BIT $C010
ENDRING   LDA STATUS
          AND #$60
          BNE ENDRING
          JSR CMDSEND
          HEX 1B396F1B396800
WAITPORT  LDA #0
          STA TEMPOL
          STA TEMPOH
          LDA #-10
          STA LEN
PORT1     JSR CARECU
          BNE PORT2
          INC TEMPOL
          BNE PORT1
          INC TEMPOH
          BNE PORT1
          INC LEN
          BNE PORT1
          BEQ CONNECT
PORT2     JSR RECOICAR
          CMP #'S'
          BNE PORT1
          JSR CMDSEND
          HEX 1B
          ASC '          ;aXS'
          HEX 1B
          ASC '          ;`ZR'
          HEX 00
          RTS
*
* ENVOI D'UN CARACTERE
*
ENVOICAR  TAY
READY1    LDA STATUS
          AND #%00010000
          BEQ READY1
          STY REG
          RTS
*
*
*
SENDCLEA  LDA STATUS
          AND #%00010000
          RTS
*
* ENVOI D'UNE COMMANDE
*
CMDSEND   PLA
          STA CMD3+1
          PLA
          STA CMD3+2
CMD1      INC CMD3+1
          BNE CMD3
          INC CMD3+2
CMD3      LDA CMD3
          BEQ CMD4
          JSR ENVOICAR
          JMP CMD1
CMD4      LDA CMD3+2
          PHA
          LDA CMD3+1
          PHA
          RTS
*
* TEST PORTEUSE PRESENTE
* IMPOSSIBLE SUR MINITEL RETOURNE
*
PORTEUSE  RTS
*
* TEST SI CARACTERE RECU...
* NE SI CARACTERE RECU
*
CARECU    LDA STATUS
          AND #%00001000
          RTS
*
* RECOIT UN CARACTERE DANS L'ACCUM.
*
RECOICAR  LDA REG
          AND #$7F
          RTS
*
* RACCROCHE
*
RACCROCH  JSR CMDSEND
          HEX 1B396700
          RTS
*
* EFFACE LE BUFFER DE RECEPTION DU MODEM
*
CLEARCV   LDA REG
          RTS
********************************
* FIN DU BIOS MINITEL/IMS      *
********************************
