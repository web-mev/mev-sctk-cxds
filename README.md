# mev-sctk-cxds

This repository contains a WDL-format Cromwell-compatible workflow for executing the CXDS doublet detection algorithem (part of scds: https://academic.oup.com/bioinformatics/article/36/4/1150/5566507) for single-cell RNA-seq data as provided through the Single-Cell Toolkit (https://github.com/compbiomed/singleCellTK).

Outputs include a file containing the barcodes of likely doublets/multiplets *and* a count matrix subset where those cell barcodes have been removed.

To use, simply fill in the the `inputs.json` with the path to the single-cell counts file and submit to a Cromwell job runner.

Alternatively (if you do not want to use Cromwell), you can pull the docker image (https://github.com/web-mev/mev-sctk-cxds/pkgs/container/mev-sctk-cxds), start the container, and run: 

```
Rscript /opt/software/cxds_qc.R \
    -f <path to raw counts tab-delimited file> \
    -o <prefix (string) for the subsetted count matrix filename> \
    -d <prefix (string) for the multiplet barcodes filename>
```