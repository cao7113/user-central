Rails.application.config.middleware.use OmniAuth::Builder do  
  #provider :tsina, '54634137', '119d98772f06eddc36707e76157c7542'
  provider :tsina, '3365702251', 'dedd8e597ff8705ad63142240333f88f'#知识管理app
  provider :tqq, '0631078bfa9f4657b9d473a9b4cdafaf', '6d3025d32092e329e47c367ebb68f704'
end
