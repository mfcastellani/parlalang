#include <stdio.h>
#include "main.h"
#include "y.tab.h"

int ex(nodeType *p) {
    int i = 0;

    if (!p) return 0;
    switch(p->type) {
        case typeCon:       return p->con.value;
        case typeId:        return sym[p->id.i];
        case typeOpr:
            switch(p->opr.oper) {
                case WHILE:     while(ex(p->opr.op[0])) ex(p->opr.op[1]); 
                                return 0;
                                break;  
                case IF:        if (ex(p->opr.op[0]))
                                    ex(p->opr.op[1]);
                                else if (p->opr.nops > 2)
                                    ex(p->opr.op[2]);
                                return 0;
                                break;  
                case PRINT:     printf("%d\n", ex(p->opr.op[0])); 
                                return 0;
                                break;  
                case FPRINT:    printf("Formated print %d:%d", ex(p->opr.op[0]), ex(p->opr.op[1]));
                                switch(ex(p->opr.op[0])) {
                                    case 1: printf("%.4f\n", (double)ex(p->opr.op[1])); 
                                    case 2: printf("%d\n", ex(p->opr.op[1])); 
                                }
                                return 0;
                                break;  
                case INSPECT:   printf("Inspect ---->\n");
                                printf("   opr.oper  = %d\n", p->opr.oper); 
                                printf("   opr.nops  = %d\n", p->opr.nops); 
                                for(i = 0; i < p->opr.nops; i++)
                                    printf("   opr.op[%d] = %d\n", i, ex(p->opr.op[i]));     
                                printf("   id.i      = %d\n", p->id.i); 
                                printf("   con.value = %d\n", p->con.value); 
                                return 0;                            
                                break;  
                case ';':       ex(p->opr.op[0]); 
                                return ex(p->opr.op[1]);
                                break;  
                case '=':       return sym[p->opr.op[0]->id.i] = ex(p->opr.op[1]);
                                break;  
                case UMINUS:    return -ex(p->opr.op[0]);
                                break;  
                case '+':       return ex(p->opr.op[0]) + ex(p->opr.op[1]);
                                break;  
                case '-':       return ex(p->opr.op[0]) - ex(p->opr.op[1]);
                                break;  
                case '*':       return ex(p->opr.op[0]) * ex(p->opr.op[1]);
                                break;  
                case '/':       return ex(p->opr.op[0]) / ex(p->opr.op[1]);
                                break;  
                case '<':       return ex(p->opr.op[0]) < ex(p->opr.op[1]);
                                break;  
                case '>':       return ex(p->opr.op[0]) > ex(p->opr.op[1]);
                                break;  
                case GE:        return ex(p->opr.op[0]) >= ex(p->opr.op[1]);
                                break;  
                case LE:        return ex(p->opr.op[0]) <= ex(p->opr.op[1]);
                                break;  
                case NE:        return ex(p->opr.op[0]) != ex(p->opr.op[1]);
                                break;  
                case EQ:        return ex(p->opr.op[0]) == ex(p->opr.op[1]);
                                break;  
            }
        }
    return 0;
}