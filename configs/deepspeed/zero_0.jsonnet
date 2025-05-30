// (import 'base.jsonnet') + {
//     zero_optimization: {
//         stage: 0,
//         allgather_partitions: true,
//         allgather_bucket_size: 5e8,
//         overlap_comm: false,
//         reduce_scatter: true,
//         reduce_bucket_size: 'auto',
//         contiguous_gradients: true,
//     },
// }
(import 'base.jsonnet') + {
  zero_optimization: {
    stage: 1,
    offload_optimizer: {
      device: "cpu",
      pin_memory: true,
    },
    allgather_partitions: true,
    allgather_bucket_size: 5e8,
    overlap_comm: false,
    reduce_scatter: true,
    reduce_bucket_size: 'auto',
    contiguous_gradients: true,
  },
}