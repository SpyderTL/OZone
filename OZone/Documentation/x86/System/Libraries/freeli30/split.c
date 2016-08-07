#include <stdio.h>
#include <string.h>

char s[160], ibuf[16384], fbuf[16384];

main(int argc, char *argv[])
{
    int i, ctr = 0;
    FILE *in, *fp = NULL;

    if(argc < 2) return 0;
    if((in = fopen(argv[1], "rb")) == NULL) return 0;
    setvbuf(in, ibuf, 16384, _IOFBF);
    while(!feof(in)) {
        fgets(s, 160, in);
        while(1) {
            i = strlen(s) - 1;
            if(s[i] != 0x0D && s[i] != 0x0A) break;
            s[i] = 0;
        }
        if(s[0] == '~' && s[1] == '~' && s[2] == '~') {
            if(fp) {
                printf(" ");
                if((ctr = (ctr + 1) % 6) == 0) printf("&\n");
                fclose(fp);
            }
            printf("+%s", s + 3);
            strcat(s, ".ASM");
            fp = fopen(s + 3, "wb");
            setvbuf(fp, fbuf, 16384, _IOFBF);
        } else {
            if(fp) fprintf(fp, "%s\n", s);
        }
    }
    if(argc > 2) printf(" &");
    printf("\n");
    return 0;
}
