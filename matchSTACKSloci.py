import pandas as pd
import argparse
import numpy as np

def main():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
        description='Add chromosome location to loc files. Be sure to delete the individuals section at the bottom of the loc file including the individual names')

    parser.add_argument(
        '-l', required=True,
        help='Joinmap loc file.')

    parser.add_argument(
        '-s', required=True,
        help='STACKS populations sumstats file usually NAME.p.sumstats.tsv')

    parser.add_argument(
        '-o', required=True,
        help='Name of the excel output file')

    args = parser.parse_args()
    
    if not (args.l and args.s):
        print('include both a --loc and --sumstats file',
              file=sys.stderr)
        sys.exit(1)


    #read both files
    locFile = pd.read_csv(args.l, sep='\t', skiprows=7, header=None, prefix = 'column', index_col=0)
    sumFile = pd.read_csv(args.s, sep='\t', skiprows=3, header=None, prefix = 'column', index_col=0)

    #Drop duplicated lines in sumstats file
    sumFile = sumFile.drop_duplicates(subset='column2', keep='first', ignore_index=False)

    #add missing data to index and fill empty lines with "-" to be cleaned at a later step. 
    sumFile = sumFile.reindex(np.arange(sumFile.index.min(), sumFile.index.max() + 1), fill_value='-')
    sumFile.reset_index(inplace=True)

    locFile = locFile.reindex(np.arange(locFile.index.min(), locFile.index.max() + 1), fill_value='-')
    locFile.reset_index(inplace=True)

    #Strip what we want out of the sumstats file and add the columns to the loc file.
    ChrNum = pd.Series(sumFile['column1'])
    ChrLoc = pd.Series(sumFile['column2'])
    locFile.insert(1, 'Chr', ChrNum)
    locFile.insert(2, 'Pos', ChrLoc)

    #rename columns to something more useful
    locFile.rename(columns = {'column0':'ID', 'column1':'genotypes'}, inplace = True)
    #remove all lines containing -
    #locFile = locFile[~locFile.eq("-").any(1)]

    locFile.to_csv(args.o, index=False, header=True)


if __name__ == "__main__":
    main()
