#!/bin/bash

homedir="$HOME/multitask_vnn"

gene2idfile="${homedir}/sample/gene2ind.txt"
cell2idfile="${homedir}/sample/cell2ind.txt"
mutationfile="${homedir}/sample/cell2mutation.txt" #Renamed actual calling from genotype to mutation
testdatafile="${homedir}/sample/test_data.txt"

#Added
cn_deletionfile="${homedir}/sample/cell2cndeletion.txt"
cn_amplificationfile="${homedir}/sample/cell2cnamplification.txt"

modeldir="${homedir}/my_m_vnn_model"
modelfile="${modeldir}/model_final.pt"

resultfile="${modeldir}/my_predict"

hiddendir="${modeldir}/hidden"
if [ -d $hiddendir ]
then
	rm -rf $hiddendir
fi
mkdir -p $hiddendir

cudaid=0

pyScript="${homedir}/src/test_vnn.py"

source activate cuda11_env

python -u $pyScript -gene2id $gene2idfile -cell2id $cell2idfile \
	-mutations $mutationfile -cn_deletions $cn_deletionfile -cn_amplifications $cn_amplificationfile -hidden $hiddendir -result $resultfile \
	-batchsize 2000 -predict $testdatafile -load $modelfile -cuda $cudaid > "${modeldir}/my_test.log"
