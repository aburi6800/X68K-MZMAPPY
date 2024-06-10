/*
/* MZ-MAPPY PRO68K
/*
/* Programmed 2024 by ABURI6800 (Hitoshi Iwai)
/* 
/* MIT License.
/*
screen 0, 2, 1, 1   /* �\����ʃT�C�Y 256x256,�O���t�B�b�N��� 512x512 256�F,���𑜓x
sp_init()           /* �X�v���C�g��ʏ�����
sp_clr()            /* �S�X�v���C�g�p�^�[���N���A
sp_disp(1)          /* �X�v���C�g��ʕ\��
sp_on()             /* �S�v���[���̃X�v���C�g�\��
sprite_pallet()     /* �X�v���C�g�p���b�g��`
sprite_pattern()    /* �X�v���C�g�p�^�[����`
bg_pattern()        /* BG�p�^�[����`
/* �萔
int C_BG_WIDTH = 54
int C_DISP_WIDTH = 32
int C_GAME_STATUS_INIT = 0
int C_GAME_STATUS_TITLE = 1
int C_GAME_STATUS_OPENING = 2
int C_GAME_STATUS_ROUNDINIT = 3
int C_GAME_STATUS_START = 4
int C_GAME_STATUS_MAIN = 5
int C_GAME_STATUS_CLEAR = 6
int C_GAME_STATUS_MISS = 7
int C_GAME_STATUS_OVER = 8
int C_GAME_STATUS_QUIT = -1
dim char title_chr(32 * 6)
/* �^�C�g���̃L�����N�^�[�f�[�^
/*             0                                       1                                       2                                       3
/*             0   1   2   3   4   5   6   7   8   9   0   1   2   3   4   5   6   7   8   9   0   1   2   3   4   5   6   7   8   9   0   1
title_chr = {  0, 67, 67, 77, 78, 67, 67,   0,  0, 78, 67, 67, 77,  0,   0, 67, 67, 67, 67, 77,   0, 67, 67, 67, 67, 77,   0, 67, 67,  0, 67, 67
            ,114,112, 66, 86,112,115, 67,   0,118,112,112, 66, 67, 77, 114,112,112,112, 66, 67, 114,112,112,112, 66, 67, 114,115, 67,114,115, 67
            ,113,  0,  0,  0,  0, 61, 67, 118,  0, 59,123,  0, 66, 67, 113,  0, 67,  0, 61, 67, 113,  0, 67,  0, 61, 67, 113, 61, 67,113, 61, 67
            ,113,  0,  0,  0,  0, 61, 67, 113,  0, 59,123,  0, 61, 67, 113,  0, 67,  0, 61, 86, 113,  0, 67,  0, 61, 86, 113,  0,  0,  0, 61, 67
            ,113, 61, 77,118,113, 61, 67, 113,  0,  0,  0,  0, 61, 67, 113,  0,  0,  0,118,  0, 113,  0,  0,  0,118,  0, 113,  0,  0,  0, 61, 67
            , 50, 51,  0,  0, 50, 51,  0,  50, 51,112,112, 50, 51,  0,  50, 51,112,112,  0,  0,  50, 51,112,112,  0,  0, 112,112,112, 50, 51,  0
          }
/* �h�A�̃L�����N�^�[�f�[�^
dim char dr_chr(5, 11) 
dr_chr = {114,115,  0,  0  /* (0, 0�`11) �I�[�v���E��
         , 55, 61,  0,  0
         , 50, 51,  0,  0
         ,  0,  0,114,115  /* (1, 0�`11) �I�[�v���E�E
         ,  0,  0,113, 63
         ,  0,  0, 50, 51
         ,  0, 53,121,  0  /* (2, 0�`11) �ʏ�h�A�N���[�Y�E��
         ,  0,123,121,  0
         ,  0, 53,121,  0
         ,  0, 53,121,  0  /* (3, 0�`11) �ʏ�h�A�N���[�Y�E�E
         ,  0, 53, 59,  0
         ,  0, 53,121,  0
         ,  0, 30, 94,  0  /* (4, 0�`11) �p���[�h�A�N���[�Y�E��
         ,  0, 82, 94,  0
         ,  0, 30, 94,  0
         ,  0, 30, 94,  0  /* (5, 0�`11) �p���[�h�A�N���[�Y�E�E
         ,  0, 30, 84,  0
         ,  0, 30, 94,  0
}
/* �ϐ�
int i, j
int tick
int trg
int stk
dim char offscr(54*29)  /* �I�t�X�N���[��
int game_status = 0     /* �Q�[�����
int round = 0           /* ���E���h��
int score = 0           /* �X�R�A
int hiscore = 20000     /* �n�C�X�R�A
int mp_left = 0         /* �c�@��
int st = 0              /* �X�e�B�b�N���͒l
int tr_f = 0            /* �g���K���̓t���O(1=���͂���A0=�Ȃ�)
int bg_x = 0            /* BG�ʂ̕\���ʒu
/* �}�b�s�[
int mp_x = 48           /* �}�b�s�[X���W
int mp_y = 28           /* �}�b�s�[Y���W
int mp_vx = 0           /* �}�b�s�[X�ړ���
int mp_vy = 0           /* �}�b�s�[Y�ړ���
int mp_cd = 0           /* �}�b�s�[�̌���(0=���A1=�E)
int np_anim = 0         /* �}�b�s�[�̃A�j���p�^�[��(0, 1)
int mp_cond = 0         /* �}�b�s�[�̏��
int mp_tpix = 255       /* �}�b�s�[���Ō�ɏ�����g�����|�����̃C���f�b�N�X
/* �G
int en_type(8)          /* �G�̎��(1=�~���[�L�[�Y,2=�j���[���R,3=����c�l)
int en_x(8)             /* �GX���W
int en_y(8)             /* �GY���W
int en_cp(8)            /* �G�L�����N�^�[�p�^�[���ԍ�
int en_anim(8)          /* �G�L�����N�^�[�A�j���p�^�[��(0, 1)
int en_cond(8)          /* �G�̏��
/* �g�����|����
int tp_x(8)             /* �g�����|����X���W
int tp_y(8)             /* �g�����|����Y���W
int tp_cond(8)          /* �g�����|�����̏��(0=�j�ꂽ�A1=����1��A2�`4=�ʏ�)
/* �h�A
int dr_x(10)            /* �h�AX���W
int dr_y(10)            /* �h�AY���W
int dr_dir(10)          /* �h�A�̎��(0=���m�u�A1=�E�m�u)
int dr_cond(10)         /* �h�A�̏��(0=�I�[�v���A1=�ʏ�h�A�N���[�Y�A2=�p���[�h�A�N���[�Y)
int dr_n                /* ����Ώۃh�A
/* ���i
int it_x(9)             /* ���i��X���W
int it_y(9)             /* ���i��Y���W
int it_cond(9)          /* ���i�̏��(0=�擾�ρA1=�ʏ�A2=2�{)
int it_type(9)          /* ���i�̎��(1=�J�Z�b�g�A2=�e���r�A3���}�C�R���A4=���i���T�A5=�L���R�D)
/*
/* ���C�����[�`��
/*
while game_status <> C_GAME_STATUS_QUIT
  switch game_status
    case 0 : game_init()      : break
    case 1 : game_title()     : break
    case 2 : game_opening()   : break
    case 3 : game_roundinit() : break
    case 4 : game_start()     : break
    case 5 : game_main()      : break
/*    case 6 : game_clear()     : break
/*    case 7 : game_miss()      : break
/*    case 8 : game_over()      : break
    default : break
  endswitch
endwhile
/* �I������
m_stop()
erase_all()
screen 2,0,1,0
end
/*
/* �������
/*
func get_control()
  str ky
  ky = inkey$(0)
/*  if (ky >= "0" and ky <= "9") then {
/*    stk = val(ky)
/*  } else {
    stk = stick(1)
/*  }
  trg = strig(1)
/*  if (ky = " ") then {
/*    trg = 1
/*  }
  /* �I���`�F�b�N
/*  if (ky = chr$(27) and game_status = C_GAME_STATUS_TITLE) then {
  if (ky = chr$(27)) then {
      game_status = C_GAME_STATUS_QUIT
  }
endfunc
/*
/* �Q�[��������
/*
func game_init()
  /* �ݒ菉����
  round = 1
  score = 0
  mp_left = 2
  /* �T�E���h������
  m_init()
  /* �g���b�N�V�[�P���X�������m��
  m_alloc(1, 100)
  m_alloc(2, 200)
  m_alloc(3, 1000)
  m_alloc(4, 100)
  m_alloc(5, 100)
  m_alloc(6, 100)
  /* trk1 : ���C�����[�v�E�F�C�g�p
  m_trk(1, "@1t180@l2o1v0rrrrrr")
  /* trk2 : �I�[�v�j���O
  m_trk(2, "@31t160l16o3v13f#8ga8f# g8ab8g a8b<c8>a b8<cd8>b <c8de8c d8ef#8a b8.a8ba8ba8br2")
  /* trk3 : ���C��BGM
  m_trk(3, "@31t180l8o4v13")
  m_trk(3, "|:c#ag#aa#4a4gagdg4.r")
  m_trk(3, "gf#ga4g4fgfdc4.r")
  m_trk(3, ">a<edc>a<edcr")
  m_trk(3, "agcfe16r16d16r16c16r16:|")
  m_trk(3, "|:5>a<ce:||:5>gb<d:|")
  m_trk(3, "l16>a.<cd8>b.<de8c.ef#8d.f#g8e.ga8f#.ab8")
  m_trk(3, "<c.>b<c>b<c>b<c>l8")
  m_trk(3, "|:c#ag#aa#4a4gagdg4.r")
  m_trk(3, "gf#ga4g4fgfdc4.r")
  m_trk(3, ">a<edc>a<edcr")
  m_trk(3, "agcfe16r16d16r16c16r16:|")
  m_trk(3, "agaa#agac<edc>g4.r gf#gagabr<c>bgara#r")
  m_trk(3, "agaa#agarf#g<ce16.d16e16.dd16c16d16r16")
  m_trk(3, "f#.d16.c16.d16.>b16.f#16.g16.a16.g16.agf#edg16.rg16.r")
  /* trk4 : �G�N�X�e���h
  m_trk(4, "@31t180l8o5v13dc16>af#16<c#.d#.f2.")
  /* trk5 : ���E���h�N���A
  m_trk(5, "@31t180l8o4v13ga16bg16er16dr.f#r16gr")
  /* trk6 : �~�X
  m_trk(6, "@31t180l8o4v13e<c16>a#g16<c#c16>a#g16d#4&d#16dr2")
  /* �Q�[����Ԃ�ύX
  game_status = C_GAME_STATUS_TITLE /* �^�C�g��
endfunc
/*
/* �^�C�g��
/*
func game_title()
  int i, j
  str s
  /* ��ʏ���
  erase_all()
  bg_set(0, 0, 0)
  bg_set(1, 1, 0)
  for i = 0 to 5
    for j = 0 to 31
      bg_put(1, j, 2 + i, pat_dat(0, 0, 1, title_chr(i * 32 + j)))
    next
  next
  s = "PUSH TRIGGER TO START !!"
  bg_print( 4, 12, s)
  s = "1ST EXTEND 20000PT"
  bg_print( 7, 15, s)
  s = "2ND EXTEND 70000PT"
  bg_print( 7, 18, s)
  s = "(C)NAMCO"
  bg_print(12, 22, s)
  s = "PROGRAM ARRANGED BY DEMPA"
  bg_print( 0, 26, s)
  s = "AND GAME ROMAN"
  bg_print(18, 27, s)
  s = "REPROGRAMMED BY ABURI GAMES 2024"
  bg_print( 0, 29, s)
  bg_set(0, 0, 1)
  bg_set(1, 1, 1)
  while trg = 0
    get_control()
    if (game_status = C_GAME_STATUS_QUIT) then {
      return()
    }
  endwhile
  /* �Q�[����Ԃ�ύX
  game_status = C_GAME_STATUS_OPENING /* �Q�[���I�[�v�j���O
endfunc
/*
/* �Q�[���I�[�v�j���O
/*
func game_opening()
  str s
  erase_all()
  bg_set(0, 0, 0)
  bg_set(1, 1, 0)
  for i =0 to 31
    bg_put(1, i, 30, pat_dat(0, 0, 1, &H4A))
    bg_put(1, i, 31, pat_dat(0, 0, 1, &H4A))
  next
  s = "NOW ON GO TO THE STORY!"
  bg_print(4, 9, s)
  bg_set(0, 0, 1)
  bg_set(1, 1, 1)
  sp_move(1, spr_x(6),  spr_y(28), 78) /* �j���[���R��
  sp_move(2, spr_x(10), spr_y(28), 70) /* �~���[�L�[�Y��
  sp_move(3, spr_x(13), spr_y(28), 70) /* �~���[�L�[�Y��
  sp_move(4, spr_x(16), spr_y(28), 70) /* �~���[�L�[�Y��
  sp_move(5, spr_x(24), spr_y(28), 64) /* �}�b�s�[
  /* �I�[�v�j���O��
  m_assign(1, 2) /* ch1 : trk2(�I�[�v�j���O)
  m_play(1)
  while m_stat(1) = 1
  endwhile
  /* �Q�[����Ԃ�ύX
  game_status = C_GAME_STATUS_ROUNDINIT /* ���E���h������
endfunc
/*
/* ���E���h������
/*
func game_roundinit()
  /* ���E���h�f�[�^�ݒ�
  switch round
    case 1 : game_roundinit_1() : break
    default : break
  endswitch
  /* �Q�[����Ԃ�ύX
  game_status = C_GAME_STATUS_START /* ���E���h�X�^�[�g
endfunc
/*
/* ���E���h1
/*
func game_roundinit_1()
  /*          0                                       1                                       2                                       3                                       4                                       5
  /*          0   1   2   3   4   5   6   7   8   9   0   1   2   3   4   5   6   7   8   9   0   1   2   3   4   5   6   7   8   9   0   1   2   3   4   5   6   7   8   9   0   1   2   3   4   5   6   7   8   9   0   1   2   3
  offscr = {  0,  0,  0, 78, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 77,  0,  0,  0
           ,  0,  0, 78, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 77,  0,  0
           ,  0, 78, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 77,  0
           , 78, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 67, 77
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64,239,239,239,239,239,239,239,239,239,239,239,239,239,239, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 64, 64, 67,  0
           ,  0, 67, 52, 52, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 52, 52, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 52, 52, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 52, 52, 67,  0
           ,  0, 67, 64, 64, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 64, 64, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 64, 64, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 74, 64, 64, 67,  0
  }
  /* �g�����|����
  tp_x(0) = 2
  tp_y(0) = 30
  tp_cond(0) = 4
  tp_x(1) = 18
  tp_y(1) = 30
  tp_cond(1) = 4
  tp_x(2) = 34
  tp_y(2) = 30
  tp_cond(2) = 4
  tp_x(3) = 50
  tp_y(3) = 30
  tp_cond(3) = 4
  /* �h�A
  dr_x(0) = 10
  dr_y(0) = 7
  dr_dir(0) = 1   /* �E
  dr_cond(0) = 1  /* �ʏ�h�A�N���[�Y
  dr_x(1) = 42
  dr_y(1) = 7
  dr_dir(1) = 0   /* ��
  dr_cond(1) = 2  /* �p���[�h�A�N���[�Y
  /*
  dr_x(2) = 10
  dr_y(2) = 11
  dr_dir(2) = 1   /* �E
  dr_cond(2) = 2  /* �p���[�h�A�N���[�Y
  dr_x(3) = 26
  dr_y(3) = 11
  dr_dir(3) = 1   /* �E
  dr_cond(3) = 1  /* �ʏ�h�A�N���[�Y
  /*
  dr_x(4) = 42
  dr_y(4) = 15
  dr_dir(4) = 0   /* ��
  dr_cond(4) = 1  /* �ʏ�h�A�N���[�Y
  /*
  dr_x(5) = 10
  dr_y(5) = 19
  dr_dir(5) = 1   /* �E
  dr_cond(5) = 1  /* �ʏ�h�A�N���[�Y
  dr_x(6) = 26
  dr_y(6) = 19
  dr_dir(6) = 0   /* ��
  dr_cond(6) = 0  /* �I�[�v��
  /*
  dr_x(7) = 42
  dr_y(7) = 23
  dr_dir(7) = 0   /* ��
  dr_cond(7) = 2  /* �p���[�h�A�N���[�Y
  /*
  dr_x(8) = 10
  dr_y(8) = 27
  dr_dir(8) = 1   /* �E
  dr_cond(8) = 2  /* �p���[�h�A�N���[�Y
  dr_x(9) = 26
  dr_y(9) = 27
  dr_dir(9) = 0   /* ��
  dr_cond(9) = 1  /* �ʏ�h�A�N���[�Y
  /* ���i
  it_type(0) = 1  /* �J�Z�b�g
  it_cond(0) = 1  /* �ʏ�
  it_x(0) = 45
  it_y(0) = 8
  it_type(1) = 1  /* �J�Z�b�g
  it_cond(1) = 1  /* �ʏ�
  it_x(1) = 22
  it_y(1) = 20
  it_type(2) = 2  /* �e���r
  it_cond(2) = 1  /* �ʏ�
  it_x(2) = 28
  it_y(2) = 16
  it_type(3) = 2  /* �e���r
  it_cond(3) = 1  /* �ʏ�
  it_x(3) = 39
  it_y(3) = 28
  it_type(4) = 3  /* �}�C�R��
  it_cond(4) = 1  /* �ʏ�
  it_x(4) = 8
  it_y(4) = 8
  it_type(5) = 3  /* �}�C�R��
  it_cond(5) = 1  /* �ʏ�
  it_x(5) = 30
  it_y(5) = 28
  it_type(6) = 4  /* ���i���T
  it_cond(6) = 1  /* �ʏ�
  it_x(6) = 21
  it_y(6) = 12
  it_type(7) = 4  /* ���i���T
  it_cond(7) = 1  /* �ʏ�
  it_x(7) = 6
  it_y(7) = 28
  it_type(8) = 5  /* �L���R�D
  it_cond(8) = 1  /* �ʏ�
  it_x(8) = 6
  it_y(8) = 16
  it_type(9) = 5  /* �L���R�D
  it_cond(9) = 1  /* �ʏ�
  it_x(9) = 46
  it_y(9) = 16
endfunc
/*
/* ���E���h�X�^�[�g
/*
func game_start()
  str s
  /* �}�b�s�[
  mp_x = 48       /* �}�b�s�[X���W
  mp_y = 28       /* �}�b�s�[Y���W
  mp_vx = 0       /* �}�b�s�[X�ړ���
  mp_vy = 0       /* �}�b�s�[Y�ړ���
  mp_cd = 1       /* �}�b�s�[�L�����N�^�[�p�^�[���ԍ�
  mp_anim = 0     /* �}�b�s�[�̃A�j���p�^�[��
  mp_cond = 0     /* �}�b�s�[�̏��
  mp_tpox = 255   /* �}�b�s�[���Ō�ɏ�����g�����|�����̃C���f�b�N�X 
  /* �G�z�u
  en_type(0) = 2  /* �j���[���R
  en_x(0) = 37
  en_y(0) = 12
  en_cp(0) = 0    /* ��
  en_anim(0) = 0
  en_cond(0) = 0
  /*
  en_type(1) = 1  /* �~���[�L�[�Y
  en_x(1) = 10
  en_y(1) = 16
  en_cp(1) = 1    /* �E
  en_anim(1) = 0
  en_cond(1) = 0
  /* ��ʏ���
  erase_all()
  /* ��ʕ`��
  bg_set(0, 0, 0)
  bg_set(1, 1, 0)
  /*   BG#1�ɉ��~�`��
  for i = 0 to 28
    for j = 0 to 53
      bg_put(1, j, i+3, pat_dat(0, 0, 1, offscr(i*54 + j)))
    next
  next
  /*   BG#1�Ƀg�����|�����`��
  for i = 0 to 8
    if (tp_cond(i) > 0) then {
      bg_put(1, tp_x(i)    , tp_y(i), pat_dat(0, 0, 1, &H34))
      bg_put(1, tp_x(i) + 1, tp_y(i), pat_dat(0, 0, 1, &H34))
    }
  next
  /*   BG#1�Ƀh�A�`��
  for i = 0 to 10
    if (dr_x(i) > 0) then {
      draw_door(i)
    }
  next
  /*   BG#0�ɃX�R�A�Ȃǂ�`��
  s = "1UP"
  bg_print(5, 0, s)
  s = "HI-SCORE"
  bg_print(11, 0, s)
  s = "MP"
  bg_print(22, 0, s)
  s = "R"
  bg_print(27, 0, s)
  s = "0"
  bg_print(9, 1, s)
  s = "20000"
  bg_print(14, 1, s)
  s = "1"
  bg_print(23, 1, s)
  s = "1"
  bg_print(27, 1, s)
  /* BG�����ʒu�Z�b�g
  bg_x = 22
  bg_scroll(1, bg_x * 8, 0)
  bg_set(0, 0, 1)
  bg_set(1, 1, 1)
  /* �T�E���h�ݒ�
  m_stop()
  m_assign(8, 1) /* ch8 : trk1(���C�����[�v�E�F�C�g�p)
  m_assign(1, 3) /* ch1 : trk3(���C��BGM)
  /* �o�ߎ��ԃ��Z�b�g
  tick = 0
  /* �Q�[����Ԃ�ύX
  game_status = C_GAME_STATUS_MAIN /* ���E���h�X�^�[�g
endfunc
/*
/* ���C�����[�`��
/*
func game_main()
  if (m_stat(1) = 0) then {
    m_play(1) /* ���C��BGM���t
  }
  m_play(8)  /* �E�F�C�g�p�̉�����炷
  get_control()
  draw_trampoline()
  move_mappy()
  move_enemy()
  draw_item()
  /* BG#1�X�N���[��
  if mp_x - bg_x < C_DISP_WIDTH / 2 and bg_x > 0 then {
    bg_x = bg_x - 1
  }
  if mp_x - bg_x > C_DISP_WIDTH / 2 and bg_x < (C_BG_WIDTH - C_DISP_WIDTH) then {
    bg_x = bg_x + 1
  }
  bg_scroll(1, bg_x * 8, 0)
  /* �E�F�C�g
  while m_stat(8) = 1
  endwhile
  /* �o�ߎ��ԉ��Z
  tick = tick + 1
endfunc
/*
/* �g�����|�����`��
/*
func draw_trampoline()
  int i
  char v
/*
  for i = 0 to 8
    if (tp_cond(i) > 1) then {
      v = &H34
    } else if (tp_cond(i) = 1) then {
      v = &H2A
    } else {
      v = &H00
    }
    bg_put(1, tp_x(i)    , tp_y(i), pat_dat(0, 0, 1, v))
    bg_put(1, tp_x(i) + 1, tp_y(i), pat_dat(0, 0, 1, v))
  next
endfunc
/*
/* �}�b�s�[�ړ�
/*
func move_mappy()
  switch mp_cond
    case 0 : move_mappy_floor() : break
    case 1 : move_mappy_toupdown() : break
    case 2 : move_mappy_updown() : break
    case 3 : move_mappy_tofloor() : break
    default : break
  endswitch
  /* ���W�ύX
  mp_x = mp_x + mp_vx
  mp_y = mp_y + mp_vy
  if (mp_x < 0) then mp_x = 0
  if (mp_x > C_BG_WIDTH - 2) then mp_x = C_BG_WIDTH - 2
  if (mp_y > 30) then {
    mp_y = 30
  }
  /* �L�����N�^�\��
  sp_move(0, spr_x(mp_x), spr_y(mp_y), (mp_cd * 2) + 64 + mp_anim)
  /* �A�j���p�^�[���ύX
  mp_anim = mp_anim xor 1
endfunc
/*
/* �}�b�s�[���ړ�
/*
func move_mappy_floor()
  int vdata
/*
  mp_vy = 0
  mp_vx = 0
  if (stk = 4) then {
    /* ������
    mp_cd = 0
    mp_vx = - 1
    /* BG����
    vdata = vpeek(mp_x - 1, mp_y + 1)
    if (vdata = 64) then {
      mp_vy = - 1
      mp_cond = 1 /* �g�����|�����ɏ��
    } else if (vdata <> 0) then {
      mp_vx = 0
    }
  } else if (stk = 6) then {
    /* �E����
    mp_cd = 1
    mp_vx = 1
    /* BG����
    vdata = vpeek(mp_x + 2, mp_y + 1)
    if (vdata = 64) then {
      mp_vy = - 1
      mp_cond = 1 /* �g�����|�����ɏ��
    } else if (vdata <> 0) then {
      mp_vx = 0
    }
  }
  if (trg > 0) then {
    if (tr_f = 0) then {
      tr_f = 1
      /* ����Ώۃh�A����
      dr_n = search_door(mp_x, mp_y, mp_cd)
      if dr_n <> 255 then {
        if (dr_cond(dr_n) = 0) then {
          /* �h�A�N���[�Y
          dr_cond(dr_n) = 1
          /* �}�b�s�[���h�A�ɂ������Ă��邩
          if (dr_dir(dr_n) <> mp_cd) then {
            if (iabs((dr_x(dr_n) + 1) - mp_x) < 3) then {
              mp_vx = 0
              if (mp_cd = 0) then {
                mp_x = mp_x - 4
              } else {
                mp_x = mp_x + 4
              }
            }
          } else {
            if (iabs((dr_x(dr_n) + 1) - (mp_x + 2 - (mp_cd * 4))) < 4) then {
              mp_vx = 0
              if (mp_cd = 0) then {
                mp_x = mp_x + 4
              } else {
                mp_x = mp_x - 4
              }
            }
          }
        } else {
          /* �h�A�I�[�v��
          if (dr_cond(dr_n) = 1) then {
            /* �ʏ�h�A�I�[�v��
            dr_cond(dr_n) = 0
          } else {
            /* �p���[�h�A�I�[�v��
            dr_cond(dr_n) = 0
            /* �}�C�N���E�F�[�u����
          }
          /* �}�b�s�[���h�A�ɂ������Ă��邩
          if (iabs((dr_x(dr_n) + 1) - mp_x) < 3) and (dr_dir(dr_n) <> mp_cd) then {
            mp_vx = 0
            if (mp_cd = 0) then {
              mp_x = mp_x + 4
            } else {
              mp_x = mp_x - 4
            }
          }
        }
        draw_door(dr_n)
      }
    }
  } else {
    tr_f = 0
  }
endfunc
/*
/* �}�b�s�[�㉺�ړ��ڍs
/*
func move_mappy_toupdown()
  mp_vy = 1
  mp_cd = 2
  mp_cond = 2
endfunc
/*
/* �}�b�s�[�㉺�ړ�
/*
func move_mappy_updown()
  int i
/*
  mp_vx = 0
  /* �ړ���`�F�b�N�i���j
  if (mp_vy = 1) then {
    /* �ړ���Ƀg�����|���������邩
    for i = 0 to 8
      if (mp_x = tp_x(i)) and (mp_y + 1 = tp_y(i)) and (tp_cond(i) > 0) then {
        mp_tpix = i
        tp_cond(i) = tp_cond(i) - 1
        if (tp_cond(i) > 0) then {
          bg_put(1, tp_x(i)    , tp_y(i), pat_dat(0, 0, 1, 119))
          bg_put(1, tp_x(i) + 1, tp_y(i), pat_dat(0, 0, 1, 118))
          mp_vy = -1
        } else {
          bg_put(1, tp_x(i)    , tp_y(i), pat_dat(0, 0, 1, 0))
          bg_put(1, tp_x(i) + 1, tp_y(i), pat_dat(0, 0, 1, 0))
        }
      }
    next
  }
  /* �ړ���`�F�b�N�i��j
  if vpeek(mp_x, mp_y + mp_vy) <> 64 then {
    mp_vy = 1
  }
  /* ���̓`�F�b�N
  if (mp_vy = -1) and ((mp_y - 8) mod 4 = 0) then {
    if (stk = 4) then {
      /* ������
      if vpeek(mp_x - 1, mp_y + 1) = 0 then {
        mp_cond = 3
        mp_cd = 0
        mp_vx = -1
        mp_vy = - 1
      } else {
        mp_vy = 1
      }
    } else if (stk = 6) then {
      /* �E����
      if vpeek(mp_x + 2, mp_y + 1) = 0 then {
        mp_cond = 3
        mp_cd = 1
        mp_vx = 1
        mp_vy = - 1
      } else {
        mp_vy = 1
      }
    }
  }
endfunc
/*
/* �}�b�s�[���ړ��ڍs
/*
func move_mappy_tofloor()
  mp_vy = 1
  mp_cond = 0
  /* �g�����|������Ԑݒ�
  if (mp_tpix <> 255) then {
    tp_cond(mp_tpix) = 4
    mp_tpix = 255
  }
endfunc
/*
/* �G�ړ�
/*
func move_enemy()
  for i = 0 to 7
    if en_type(i) = 1 then {
      move_nyamco(i)
    }
    if en_type(i) = 2 then {
      move_myukies(i)
    }
  next
endfunc
/*
/* �j���[���R�ړ�
/*
func move_nyamco(num;int)
  /* �Œ�Œu���Ă���
  sp_move(10 + num, spr_x(en_x(num)), spr_y(en_y(num)), 78 + en_anim(num) + (en_cp(num) * 2))
endfunc
/*
/* �~���[�L�[�Y�ړ�
/*
func move_myukies(num;int)
  /* �Œ�Œu���Ă���
  sp_move(10 + num, spr_x(en_x(num)), spr_y(en_y(num)), 70 + en_anim(num) + (en_cp(num) * 2))
endfunc
/*
/* �A�C�e���\��
/*
func draw_item()
  int i, j
  for i = 0 to 9
    /* �擾�`�F�b�N
    if (it_cond(i) > 0) then {
      if (it_x(i) = mp_x and it_y(i) = mp_y) then {
        /* �X�R�A���Z
        score = score + (it_type(i) * 100 * it_cond(i))
        /* ������A�C�e���͎擾�ςɂ���
        it_cond(i) = 0
        /* ��U���ׂĂ�2�{��Ԃ��L�����Z������
        for j = 0 to 9
          if (it_cond(j) > 0) then {
            it_cond(j) = 1
          }
        next
        /* ������A�C�e���Ɠ������̂��܂��c���Ă���ꍇ�́A2�{��Ԃɂ���
        if (i > 0) then {
          if (it_type(i - 1) = it_type(i) and it_cond(i - 1) > 0) then {
            it_cond(i - 1) = 2
          }
        }
        if (i < 9) then {
          if (it_type(i + 1) = it_type(i) and it_cond(i + 1) > 0) then {
            it_cond(i + 1) = 2
          }
        }
      }
      /* �\��
      if (it_cond(i) = 1) then {
        sp_move(30 + i, spr_x(it_x(i)), spr_y(it_y(i)), 90 + it_type(i) - 1)
      } else if (it_cond(i) = 2) then {
        if (tick mod 2 = 0) then {
          sp_move(30 + i, spr_x(it_x(i)), spr_y(it_y(i)), 90 + it_type(i) - 1)
        } else {
          sp_move(30 + i, spr_x(it_x(i)), spr_y(it_y(i)), 95)
        }
      }
    } else {
      sp_move(30 + i, -16, -16, 90 + it_type(i) - 1)
    }
  next
endfunc
/*
/* ����Ώۃh�A����
/* in:
/*    int   x         �L�����N�^�[X���W
/*    int   y         �L�����N�^�[Y���W
/*    int   d         �L�����N�^�[�̌���(0=���A1=�E)
/* out:
/*   int   ����Ώۃh�A�̔z��ԍ�(���݂��Ȃ�����255)
/*
func int search_door(x;int, y;int, d;int)
  int i
  int door_n = 255
  int dist = 255
  int w_dist
  for i = 0 to 10 /* ���ׂẴh�A�ɂ��Ĕ�r����
    if dr_y(i) = y - 1 then {
      w_dist = 255
      if (d = 0 and dr_dir(i) = 0 and dr_x(i) < x + 1) then w_dist = x + 1 - dr_x(i)
      if (d = 1 and dr_dir(i) = 0 and dr_x(i) > x - 1) then w_dist = dr_x(i) - x - 1
      if (d = 0 and dr_dir(i) = 1 and dr_x(i) < x - 1) then w_dist = x - 1 - dr_x(i)
      if (d = 1 and dr_dir(i) = 1 and dr_x(i) > x - 3) then w_dist = dr_x(i) - x - 3
      if (dist > w_dist) then {
        dist = abs(dr_x(i) - x)
        door_n = i
      }
    }
  next
  return(door_n)
endfunc
/*
/* �h�A�`��
/* in:
/*    int   dr_n      �h�A�̗v�f�ԍ�
/*
func draw_door(dr_n;int)
  int ix, iy, i, j
  /* �p�^�[���ݒ�
  ix = (dr_cond(dr_n) * 2) + dr_dir(dr_n)
  /* �`��
  iy = 0
  for i = 0 to 2
    for j = 0 to 3 
      bg_put(1, dr_x(dr_n) + j, dr_y(dr_n) + i, pat_dat(0, 0, 1, dr_chr(ix, iy)))
      iy = iy + 1
    next 
  next
  /* ���z��ʂւ̏��X�V
  if (dr_cond(dr_n) = 0) then {
    /* dr_cond = 0 �̎��͊J���h�A�Ȃ̂ŉ��z��ʂɃ[����ݒ�
    vpoke(dr_x(dr_n) + 1, dr_y(dr_n) + 2, 0)
    vpoke(dr_x(dr_n) + 2, dr_y(dr_n) + 2, 0)
  } else {
    /* dr_cond = 1, 2 �̎��͕��h�A�Ȃ̂ŉ��z��ʂɕǂƓ�������ݒ�
    vpoke(dr_x(dr_n) + 1, dr_y(dr_n) + 2, 67)
    vpoke(dr_x(dr_n) + 2, dr_y(dr_n) + 2, 67)
  }
endfunc
/*
/* ���z���X���W����X�v���C�g�\��X���W���擾
/* in:
/*    int   txt_x     ���z���X���W(�e�L�X�g)
/* out:
/*    int   �X�v���C�g�\��X���W(�\���͈͊O�̂Ƃ���-16)
/*
func int spr_x(txt_x;int)
  int spr_x
  spr_x = (txt_x - bg_x) * 8
  if (spr_x < -16) or (spr_x > 255) then {
    spr_x = -16
  } 
  return(spr_x)
endfunc
/*
/* �e�L�X�gY���W����X�v���C�g�\��Y���W���擾
/* in:
/*    int   txt_y     ���z���Y���W(�e�L�X�g)
/* out:
/*    int   �X�v���C�g�\��Y���W(�\���͈͊O�̂Ƃ���-16)
/*
func int spr_y(txt_y;int)
  int spr_y
  spr_y = (txt_y) * 8
  if (spr_y < -16) or (spr_y > 255) then {
    spr_y = -16
  }
  return(spr_y)
endfunc
/*
/* BG�ʁE�X�v���C�g����
/* in:
/*    �Ȃ�
/* out:
/*    �Ȃ�
/*
func erase_all()
  bg_fill(0, pat_dat(0, 0, 1, &H0))
  bg_fill(1, pat_dat(0, 0, 1, &H0))
  for i=0 to 127
    sp_set(i, 0, 0, pat_dat(0, 0, 1, 0))
  next
endfunc
/*
/* ���z��ʂ̎w����W�̃f�[�^���擾����
/* in:
/*    int   x         ���z���X���W
/*    int   y         ���z���Y���W
/* out:
/*    char  �w����W�̉��z��ʃf�[�^
/*
func char vpeek(x;int, y;int)
  char data
  data = offscr(((y - 3) * C_BG_WIDTH) + x)
  return(data)
endfunc
/*
/* ���z��ʂ̎w����W�Ƀf�[�^��ݒ肷��
/* in:
/*    int   x         ���z���X���W
/*    int   y         ���z���Y���W
/*    int   data      �������ރf�[�^
/* out:
/*    �Ȃ�
/*
func char vpoke(x;int, y;int, data;int)
  offscr(((y - 3) * C_BG_WIDTH) + x) = data
endfunc
/* ��Βl�Z�o(int�^)
/* in:
/*    int   v         �l
/* out:
/*    int   �l�̐�Βl
func int iabs(v;int)
  if (v < 0) then {
    v = v * -1
  }
  return(v)
endfunc
/*
/* �p�����\��
/* in:
/*    char  x         BG�ʂ�X���W(0�`63)
/*    char  y         BG�ʂ�Y���W(0�`63)
/*    str   value     �\�����镶����
/* out:
/*    �Ȃ�
/*
func bg_print(x;char, y;char, value;str)
  int p = 0
  char data
  char v
  while asc(mid$(value, p+1, 1)) <> 0
    data = 0
    v = asc(mid$(value, p+1, 1))
    /* ���l
    if (v >= '0' and v <= '9') then {
      data = v - 16
    }
    /* �p��
    if (v >= 'A' and v <= 'Z') then {
      data = v - 64
    }
    /* ���ꕶ��
    if v = '-' then {
      data = 42
    }
    if v = '.' then {
      data = 46
    }
    if v = '!' then {
      data = 97
    }
    if v = '(' then {
      data = 104
    }
    if v = ')' then {
      data = 105
    }
    bg_put(0, x + p, y, pat_dat(0, 0, 1, data))
    p = p + 1
  endwhile
endfunc
/*
/* �p�^�[���f�[�^�擾
/* in:
/*    char  vr        �������](0:�ʏ�A1:�������])
/*    char  hr        �������](0:�ʏ�A1:�������])
/*    char  pb        �p���b�g�u���b�N(1�`15)
/*    char  cd        �p�^�[���R�[�h(0�`255)
/* out:
/*    int   �p�^�[���f�[�^
/*
func int pat_dat(vr;char, hr;char, pb;char, cd;char)
  return(vr*32768 + hr*16384 + pb*256 + cd)
endfunc
/*
/* �X�v���C�g��`(16x16)
/* No64�`�Œ�`
/*
func sprite_pattern()
  dim char c(255)
  /*
  /* �}�b�s�[��(1)
  c={&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(64, c)
  /*
  /* �}�b�s�[��(2)
  c={&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(65, c)
  /*
  /* �}�b�s�[�E(1)
  c={&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(66, c)
  /*
  /* �}�b�s�[�E(2)
  c={&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(67, c)
  /* �}�b�s�[����(1)
  c={&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF
    ,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF
    ,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(68, c)
  /* �}�b�s�[����(2)
  c={&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF
    ,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF
    ,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&HF,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(69, c)
  /*
  /* �~���[�L�[�Y��(1)
  c={&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(70, c)
  /*
  /* �~���[�L�[�Y��(2)
  c={&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(71, c)
  /*
  /* �~���[�L�[�Y�E(1)
  c={&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(72, c)
  /*
  /* �~���[�L�[�Y�E(2)
  c={&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(73, c)
  /*
  /* �j���[���R��(1)
  c={&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1
    ,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1
    ,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1
    ,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(78, c)
  /*
  /* �j���[���R��(2)
  c={&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF
    ,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF
    ,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1
    ,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1
    ,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1
    ,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(79, c)
  /*
  /* �j���[���R�E(1)
  c={&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1
    ,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1
    ,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1
    ,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(80, c)
  /*
  /* �j���[���R�E(2)
  c={&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H1
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1
    ,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1
    ,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1,&H1,&H1,&HF,&HF,&HF,&HF,&HF,&H1
    ,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1,&H1,&H1,&H1,&HF,&HF,&HF,&H1,&H1
    ,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1,&H1,&H1,&HF,&H1,&HF,&H1,&HF,&H1
    ,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&HF,&H1,&H1,&H1
    ,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1,&H1
  }
  sp_def(81, c)
  /*
  /* �J�Z�b�g
  c={&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&HF,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&HF,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(90, c)
  /*
  /* �e���r
  c={&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(91, c)
  /*
  /* �}�C�R��
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(92, c)
  /*
  /* ���i���T
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(93, c)
  /*
  /* �L���R�D
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(94, c)
  /*
  /* �H�H�H�H
  c={&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    }
  sp_def(95, c)
endfunc
/*
/* �o�b�N�O���E���h�̐ݒ�
/* No0�`255�ŃL�����N�^�[�R�[�h�ɑΉ�����ԍ��Œ�`
/*
func bg_pattern()
  dim char c(63)
  /* ��
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(0, c, 0)
  /* A
  c={&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(1, c, 0)
  /* B
  c={&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(2, c, 0)
  /* C
  c={&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(3, c, 0)
  /* D
  c={&H0,&HF,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(4, c, 0)
  /* E
  c={&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(5, c, 0)
  /* F
  c={&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(6, c, 0)
  /* G
  c={&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&HF,&HF,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(7, c, 0)
  /* H
  c={&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(8, c, 0)
  /* I
  c={&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(9, c, 0)
  /* J
  c={&H0,&H0,&H0,&H0,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(10, c, 0)
  /* K
  c={&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(11, c, 0)
  /* L
  c={&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(12, c, 0)
  /* M
  c={&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&HF,&H0,&H0,&HF,&HF,&H0
    ,&H0,&HF,&H0,&HF,&HF,&H0,&HF,&H0
    ,&H0,&HF,&H0,&HF,&HF,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(13, c, 0)
  /* N
  c={&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&HF,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&HF,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&HF,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(14, c, 0)
  /* O
  c={&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(15, c, 0)
  /* P
  c={&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(16, c, 0)
  /* Q
  c={&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&HF,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(17, c, 0)
  /* R
  c={&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(18, c, 0)
  /* S
  c={&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(19, c, 0)
  /* T
  c={&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(20, c, 0)
  /* U
  c={&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(21, c, 0)
  /* V
  c={&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(22, c, 0)
  /* W
  c={&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&HF,&HF,&H0,&HF,&H0
    ,&H0,&HF,&H0,&HF,&HF,&H0,&HF,&H0
    ,&H0,&HF,&HF,&H0,&H0,&HF,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(23, c, 0)
  /* X
  c={&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(24, c, 0)
  /* Y
  c={&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(25, c, 0)
  /* Z
  c={&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(26, c, 0)
  /* (�p���[�h�A���p�[�c)
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
  }
  sp_def(30, c, 0)
  /* 0
  c={&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&HF,&HF,&H0
    ,&H0,&HF,&H0,&HF,&HF,&H0,&HF,&H0
    ,&H0,&HF,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(32, c, 0)
  /* 1
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(33, c, 0)
  /* 2
  c={&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(34, c, 0)
  /* 3
  c={&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(35, c, 0)
  /* 4
  c={&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(36, c, 0)
  /* 5
  c={&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(37, c, 0)
  /* 6
  c={&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(38, c, 0)
  /* 7
  c={&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(39, c, 0)
  /* 8
  c={&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(40, c, 0)
  /* 9
  c={&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(41, c, 0)
  /* -
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(42, c, 0)
  /* .
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(46, c, 0)
  /* (���Ɖ��̐�)
  c={&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
  }
  sp_def(50, c, 0)
  /* (�E�Ɖ��̐�)
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
  }
  sp_def(51, c, 0)
  /* -(�O���t�B�b�N����)
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(52, c, 0)
  /* (���h�A���̏c��)
  c={&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
  }
  sp_def(53, c, 0)
  /* (��2�h�b�g�h��Ԃ�)
  c={&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(55, c, 0)
  /* (�E�����h��Ԃ�)
  c={&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
  }
  sp_def(59, c, 0)
  /* (���̐�)
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
  }
  sp_def(60, c, 0)
  /* (�E�̐�)
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
  }
  sp_def(61, c, 0)
  /* (�E2�h�b�g�h��Ԃ�)
  c={&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
  }
  sp_def(63, c, 0)
  /* ��
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(64, c, 0)
  /* ?
  c={&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H0,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&HF,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
  }
  sp_def(66, c, 0)
  /* ��
  c={&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
  }
  sp_def(67, c, 0)
  /* ��(���])
  c={&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&H0,&H0,&H0,&H0,&HF,&HF
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&HF,&HF,&H0,&H0,&H0,&H0,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
  }
  sp_def(74, c, 0)
  /* ?
  c={&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
  }
  sp_def(77, c, 0)
  /* ?
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&HF,&HF,&HF,&HF,&HF
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H0,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
  }
  sp_def(78, c, 0)
  /* [
  c={&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(82, c, 0)
  /* ]
  c={&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(84, c, 0)
  /* ?
  c={&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&H0
    ,&HF,&HF,&HF,&HF,&HF,&HF,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(86, c, 0)
  /* (�p���[�h�A�E�p�[�c)
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
  }
  sp_def(94, c, 0)
  /* !
  c={&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(97, c, 0)
  /* (
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(104, c, 0)
  /* )
  c={&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(105, c, 0)
  /* (��̐�)
  c={&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(112, c, 0)
  /* (���̐�)
  c={&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(113, c, 0)
  /* (���Ə�̐�)
  c={&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(114, c, 0)
  /* (�E�Ə�̐�)
  c={&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
  }
  sp_def(115, c, 0)
  /* �^
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(118, c, 0)
  /* �_
  c={&HF,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&HF
  }
  sp_def(119, c, 0)
  /* (���h�A�E�̏c��)
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
  }
  sp_def(121, c, 0)
  /* (�������h��Ԃ�)
  c={&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&H0,&H0,&H0,&H0
  }
  sp_def(123, c, 0)
  /* �R
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(130, c, 0)
  /* �V
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&HF,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(132, c, 0)
  /* �C
  c={&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(133, c, 0)
  /* �L
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(135, c, 0)
  /* �}
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(138, c, 0)
  /* ��
  c={&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(140, c, 0)
  /* ��
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(141, c, 0)
  /* ��
  c={&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(143, c, 0)
  /* �Z
  c={&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(144, c, 0)
  /* �g
  c={&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(147, c, 0)
  /* �J
  c={&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(148, c, 0)
  /* �i
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(149, c, 0)
  /* �q
  c={&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(150, c, 0)
  /* �e
  c={&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(151, c, 0)
  /* �T
  c={&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(152, c, 0)
  /* ��
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(153, c, 0)
  /* ��
  c={&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(171, c, 0)
  /* �J
  c={&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(178, c, 0)
  /* �b
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&HF,&H0,&HF,&H0
    ,&H0,&H0,&HF,&H0,&HF,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_def(187, c, 0)
  /* �Ԋ|��
  c={&HF,&H0,&HF,&H0,&HF,&H0,&HF,&H0
    ,&H0,&HF,&H0,&HF,&H0,&HF,&H0,&HF
    ,&HF,&H0,&HF,&H0,&HF,&H0,&HF,&H0
    ,&H0,&HF,&H0,&HF,&H0,&HF,&H0,&HF
    ,&HF,&H0,&HF,&H0,&HF,&H0,&HF,&H0
    ,&H0,&HF,&H0,&HF,&H0,&HF,&H0,&HF
    ,&HF,&H0,&HF,&H0,&HF,&H0,&HF,&H0
    ,&H0,&HF,&H0,&HF,&H0,&HF,&H0,&HF
  }
  sp_def(239, c, 0)
endfunc
/*
/* �p���b�g�̐ݒ�
/* �Ƃ肠�����p���b�g�u���b�N1������`
/*
func sprite_pallet()
  sp_color(0,0,1)
  sp_color(1,1,1)
  sp_color(2,32,1)
  sp_color(3,62,1)
  sp_color(4,1024,1)
  sp_color(5,1984,1)
  sp_color(6,1056,1)
  sp_color(7,2046,1)
  sp_color(8,32768,1)
  sp_color(9,63488,1)
  sp_color(10,32800,1)
  sp_color(11,63550,1)
  sp_color(12,33792,1)
  sp_color(13,65472,1)
  sp_color(14,44394,1)
  sp_color(15,65534,1)
endfunc
