/*
/* �h�A�̔���e�X�g
/*
dim int dx(6,3)
dx(5,0) = 10
dx(5,1) = 20
dx(5,2) = 30
int mp_x = 35, mp_dir = 0
/*
int i
cls:for i = 0 to 2
  locate dx(5, i),  8:print i;
  locate dx(5, i),  9:print "||";
  locate dx(5, i), 10:print "||";
  locate dx(5, i), 11:print "||";
next
if mp_dir = 0 then {
  locate mp_x, 10:print ">>";
  locate mp_x, 11:print ">>";
} else {
  locate mp_x, 10:print "<<";
  locate mp_x, 11:print "<<";
}
int door_n
door_n = search_door(mp_x, 0, mp_dir)
locate 0, 13:print door_n
end
/*
/* �`�F�b�N����
/* in:
/*   int   x  �L�����N�^�[X���W
/*   int   y  �L�����N�^�[Y���W
/*   int   d  �L�����N�^�[�̌���(0=�E�A1=��)
/* out:
/*   int   �Ώۂ̃h�A�̔z��ԍ�(���݂��Ȃ�����255)
/*
func int search_door(x;int, y;int, d;int)
  int i
  int door_n = 255
  int dist = 255, w_dist
  int floor
  floor = 5 /* ������Y���W����Ώۂ̊K�������߂邱��
  for i = 0 to 2 /* ���ׂẴh�A�ɂ��Ĕ�r����
    w_dist = 255
    if d=0 and dx(floor, i) > x then w_dist = dx(floor, i) - x
    if d=1 and dx(floor, i) < x then w_dist = x - dx(floor, i)
    if dist > w_dist then {
      dist = abs(dx(floor, i) - x)
      door_n = i
    }
  next
  return(door_n)
endfunc
