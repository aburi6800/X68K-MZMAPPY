/*
/* BG�f�[�^�W�F�l���[�^
/* (MZ80�o�[�W����)
/*
/* Programmed 2024 by ABURI6800 (Hitoshi Iwai)
/* 
/* MIT License.
/* 
int f
str fname
str ans
dim char c(63)
/*
fname = "bg.dat"
/*
cls
print "�J�����g�f�B���N�g����" ; fname ; "���쐬���܂��B"
print "���ɂ���t�@�C���͏㏑������܂��B"
input "��낵���ł��� (y/n)";ans
if (strlwr(ans) <> "y") then {
    print "�����𒆎~���܂��B"
    end
}
/*
f = fopen(fname, "c")
bg_pattern()
fputc(255, f)
fclose(f)
print "�I�����܂����B"
end
/*
func sp_write(n;char)
    fputc(n, f)
    fwrite(c, 64, f)
endfunc
/*
/* �ȍ~��sprdeftool.bas�̃G�N�X�|�[�g�\�[�X����荞�݁A
/* �擪�� char c[63] �̒�`���폜�Asp_def �� sp_write �ɕϊ�����B
/*
func bg_pattern()
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
  sp_write(0)
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
  sp_write(1)
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
  sp_write(2)
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
  sp_write(3)
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
  sp_write(4)
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
  sp_write(5)
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
  sp_write(6)
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
  sp_write(7)
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
  sp_write(8)
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
  sp_write(9)
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
  sp_write(10)
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
  sp_write(11)
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
  sp_write(12)
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
  sp_write(13)
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
  sp_write(14)
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
  sp_write(15)
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
  sp_write(16)
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
  sp_write(17)
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
  sp_write(18)
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
  sp_write(19)
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
  sp_write(20)
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
  sp_write(21)
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
  sp_write(22)
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
  sp_write(23)
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
  sp_write(24)
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
  sp_write(25)
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
  sp_write(26)
  /* ��
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
  }
  sp_write(27)
  /* ��(�p���[�h�A���p�[�c)
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
  }
  sp_write(30)
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
  sp_write(32)
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
  sp_write(33)
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
  sp_write(34)
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
  sp_write(35)
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
  sp_write(36)
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
  sp_write(37)
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
  sp_write(38)
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
  sp_write(39)
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
  sp_write(40)
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
  sp_write(41)
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
  sp_write(42)
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
  sp_write(46)
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
  sp_write(50)
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
  sp_write(51)
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
  sp_write(52)
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
  sp_write(53)
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
  sp_write(55)
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
  sp_write(59)
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
  sp_write(60)
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
  sp_write(61)
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
  sp_write(63)
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
  sp_write(64)
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
  sp_write(66)
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
  sp_write(67)
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
  sp_write(74)
  /* ��(�~)
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&HF
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
  }
  sp_write(75)
  /* ��(�~)
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
  }
  sp_write(76)
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
  sp_write(77)
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
  sp_write(78)
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
  sp_write(82)
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
  sp_write(84)
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
  sp_write(86)
  /* ��(�p���[�h�A�E�p�[�c)
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
  }
  sp_write(94)
  /* ��
  c={&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
    ,&HF,&HF,&HF,&HF,&HF,&HF,&HF,&HF
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
  }
  sp_write(95)
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
  sp_write(97)
  /* &
  c={&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&HF,&H0,&H0,&H0,&H0
    ,&H0,&HF,&H0,&H0,&HF,&H0,&HF,&H0
    ,&H0,&HF,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_write(102)
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
  sp_write(104)
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
  sp_write(105)
  /* *
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&HF,&H0,&HF,&H0
    ,&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&HF,&HF,&HF,&HF,&HF,&H0
    ,&H0,&H0,&H0,&HF,&HF,&HF,&H0,&H0
    ,&H0,&H0,&HF,&H0,&HF,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&H0,&H0
  }
  sp_write(107)
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
  sp_write(112)
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
  sp_write(113)
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
  sp_write(114)
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
  sp_write(115)
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
  sp_write(118)
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
  sp_write(119)
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
  sp_write(121)
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
  sp_write(123)
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
  sp_write(130)
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
  sp_write(132)
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
  sp_write(133)
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
  sp_write(135)
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
  sp_write(138)
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
  sp_write(140)
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
  sp_write(141)
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
  sp_write(143)
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
  sp_write(144)
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
  sp_write(147)
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
  sp_write(148)
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
  sp_write(149)
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
  sp_write(150)
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
  sp_write(151)
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
  sp_write(152)
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
  sp_write(153)
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
  sp_write(171)
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
  sp_write(178)
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
  sp_write(187)
  /* �c�̃M�U�M�U
  c={&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&HF,&H0,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&HF,&H0,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&HF,&H0,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
    ,&H0,&H0,&H0,&H0,&H0,&H0,&HF,&H0
    ,&H0,&H0,&H0,&H0,&H0,&HF,&H0,&H0
  }
  sp_write(238)
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
  sp_write(239)
endfunc
