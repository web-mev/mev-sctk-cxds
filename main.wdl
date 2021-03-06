workflow SctkCxds {
    
    # An integer matrix of counts
    File raw_counts

    call runCxds {
        input:
            raw_counts = raw_counts
    }

    output {
        File doublet_removed_counts = runCxds.output_counts
        File doublet_ids = runCxds.output_ids
    }
}

task runCxds {
    File raw_counts

    String output_name_prefix = "sctk_cxds_reduced_counts"
    String doublet_file_prefix = "sctk_cxds_ids"

    Int disk_size = 20

    command {
        Rscript /opt/software/cxds_qc.R \
        -f ${raw_counts} \
        -o ${output_name_prefix} \
        -d ${doublet_file_prefix}
    }

    output {
        File output_counts = glob("${output_name_prefix}*")[0]
        File output_ids = glob("${doublet_file_prefix}*")[0]
    }

    runtime {
        docker: "hsphqbrc/mev-sctk-cxds"
        cpu: 2
        memory: "16 G"
        disks: "local-disk " + disk_size + " HDD"
        preemptible: 0
    }
}
