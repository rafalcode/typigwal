# this file needs to be "source"'d in .bashrc or something like that.
# or just sourced ont he comand line too.
# underlying naming logic for these shell functions

# pl19 stands for hte v1.9 of plink i.e. not version 1.0.4, 1.0.7 nor 2.0
# Basically it's the version that supports VCF.
# afert pl19 first letter is b, v, t, or p, meaning the input is:
# b, the binary bim/bed/fam triple fileset
# p, the text ped/map double fileset
# t, the transposed tped/tfam double fileset
# v, the text VCF single file
# the second letter is the same but specifies the output
# Note in VCF's there is a certain amount of unresolved doubt about which allele VCF will put first.
# In fact the VCF standard has no requirement to be consistent, though plink does try and make it be
# via --keep-allele-order.

# convert file format type commands ... first, to same prefix name i.e. the "0" versions
# i.e. --out prefix is the same as input prefix
pl19tv0() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --tfile $1 --recode vcf-iid --out $1; }
#
# convert tped/tfam to binary
pl19bt() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --bfile $1 --recode transpose --out $1; }
pl19bp() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --bfile $1 --recode --out $1; }
pl19bp() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --bfile $1 --recode --out $1; }
pl19tp() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --tfile $1 --recode --out $1; }
pl19pt() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --file $1 --recode transpose --out $1; }
pl19pb() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --file $1 --make-bed --out $1; }
pl19tb() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --tfile $1 --make-bed --out $1; }
pl19bv0() { if [ $# -ne 2 ]; then echo "two args required!"; return; fi; plink1.9 --silent --bfile $1 --recode vcf-iid --out $2; }
pl19bv() { if [ $# -ne 2 ]; then echo "two args required!"; return; fi; plink1.9 --silent --bfile $1 --recode vcf-iid --keep-allele-order --out $2; }
# is this really the magic command (I've spent ages) which will retain allele order?
# ref. https://groups.google.com/forum/#!msg/plink2-users/FTir9SbtHPA/vuJYV8CdBgAJ
pl19bv2() { if [ $# -ne 1 ]; then echo "one arg required!"; return; fi; plink1.9 --silent --bfile $1 --recode vcf-iid --keep-allele-order --a1-allele 4 3 '#' --out $1; }
# nah that doesn't work
pl19bv1() { if [ $# -ne 1 ]; then echo "1 arg: dset rootname required!"; return; fi; plink1.9 --silent --bfile $1 --recode vcf-iid --keep-allele-order --out $1; }
#
# pl19tv1() { if [ $# -ne 2 ]; then echo "two args required!"; return; fi; plink1.9 --silent --tfile $1 --recode vcf-iid --keep-allele-order --out $2; }
pl19tv() { if [ $# -ne 2 ]; then echo "two args required!"; return; fi; plink1.9 --silent --tfile $1 --recode vcf-iid --out $2; }
pl19tv1() { if [ $# -ne 1 ]; then echo "1 arg required!"; return; fi; plink1.9 --silent --tfile $1 --recode vcf-iid --keep-allele-order --out $1; }
pl19tv2() { if [ $# -ne 2 ]; then echo "two args required!"; return; fi; plink1.9 --silent --tfile $1 --recode vcf-iid --real-ref-alleles --out $2; }
pl19tv3() { if [ $# -ne 2 ]; then echo "two args required!"; return; fi; plink1.9 --silent --tfile $1 --recode vcf-iid --reference-allele --out $2; }
# pl19tvb() { if [ $# -ne 2 ]; then echo "two args required!"; return; fi; plink1.9 --silent --tfile $1 --recode vcf-iid bgz --keep-allele-order --out $2; }
pl19tvb() { if [ $# -ne 2 ]; then echo "two args required!"; return; fi; plink1.9 --silent --tfile $1 --recode vcf-iid bgz --keep-allele-order --out $2; }
#
# next convert a tped pair to ped and map.
pl19tf() { if [ $# -ne 2 ]; then echo "two args required!"; return; fi; plink1.9 --silent --tfile $1 --recode --out $2; }
pl19v0() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --file $1 --recode vcf-iid --out $1; }
pl19t0() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --file $1 --recode transpose --out $1; }
#
# converting VCF to TPED/TFAM. Trouble with A1/A2 flipping
pl19vt() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --double-id --vcf $1 --recode transpose --keep-allele-order --out ${1%%.*}; }
# pl19vt() { if [ $# -ne 1 ]; then echo "Just the 1 arg pls!"; return; fi; plink1.9 --silent --double-id --vcf $1 --recode transpose --real-ref-alleles --out ${1%%.*}; }
# pl19vt3() { if [ $# -ne 2 ]; then echo "1 args, 1st a vcf, 2nd a bim!"; return; fi; plink1.9 --silent --double-id --a2-allele S1 4 3 '#'--recode transpose --out ${1%%.*}; }
pl19vt3() { if [ $# -ne 1 ]; then echo "1 arg, please, an uncompressed vcf!"; return; fi; plink1.9 --silent --double-id --vcf $1 --a1-allele $1 4 3 '#' --recode transpose --out ${1%%.*}; }
# for the clean, no "0" versions
pl19bum() { if [ $# -ne 3 ]; then echo "3 args pls!"; return; fi; plink1.9 --silent --bfile $1 --update-map $2 --make-bed --out $3; }
pl19v() { if [ $# -ne 2 ]; then echo "2 args pls!"; return; fi; plink1.9 --silent --file $1 --recode vcf-iid --out $2; }
pl19t() { if [ $# -ne 2 ]; then echo "2 args pls!"; return; fi; plink1.9 --silent --file $1 --recode transpose --out $2; }
# plink extratc a chromosome and change to vcf .. three args required!
pl19vc() { if [ $# -ne 3 ]; then echo "3 args pls!"; return; fi; plink1.9 --silent --file $1 --chr $2 --recode vcf-iid --out $3; }
