process run_cxds {

    tag "Run SCTK CXDS tool"
    publishDir "${params.output_dir}/SctkCxds.doublet_removed_counts", mode:"copy", pattern:"${output_name_prefix}*"
    publishDir "${params.output_dir}/SctkCxds.doublet_ids", mode:"copy", pattern:"${doublet_file_prefix}*"
    container "ghcr.io/web-mev/mev-sctk-cxds"
    cpus 2
    memory '16 GB'

    input:
        path raw_counts

    output:
        path "${output_name_prefix}*"
        path "${doublet_file_prefix}*"

    script:
        output_name_prefix = "sctk_cxds_reduced_counts"
        doublet_file_prefix = "sctk_cxds_ids"
        """
        Rscript /opt/software/cxds_qc.R \
            -f ${raw_counts} \
            -o ${output_name_prefix} \
            -d ${doublet_file_prefix}
        """
}

workflow {
    run_cxds(params.raw_counts)
}