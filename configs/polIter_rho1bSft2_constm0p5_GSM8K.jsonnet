(import 'polIter_rho1bSft2_vineppo_GSM8K.jsonnet') + {
  episode_generator+: {
    constant_advantage_value: -0.5,
  },
}
+ (import 'trainers/refKl0.0.jsonnet') 