using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ImDrop : MonoBehaviour
{
    public int posX;
    public int posY;
    public float timeCnt;
    public float timeDelta;
    public int myType;
    public AudioClip dropSound1;
    public AudioClip dropSound2;
    // Start is called before the first frame update
    void playSound(AudioClip sound,double beginTime,double durTime,float vol) {
        //double cntTime = 0; //播放时间未实装
        GetComponent<AudioSource>().volume = vol;
        GetComponent<AudioSource>().clip = sound;
        GetComponent<AudioSource>().PlayScheduled(beginTime);
        
    }
    void Start()
    {
        timeCnt = 0;
        timeDelta = 0.1f;
        dropSound1=GameControl.dropSoundS1;
        dropSound2=GameControl.dropSoundS2;
    }

    // Update is called once per frame
    void Update()
    {
        myType = GameControl.dropsLevel[posX][posY];
        if (GameControl.dropsLevel[posX][posY] < GameControl.dropType)
        {
            FlushSelf(GameControl.sp[GameControl.dropsLevel[posX][posY]]);
        }
        if (GameControl.dropsLevel[posX][posY] >= GameControl.dropType)
        {
            timeCnt += Time.deltaTime;
            if (timeCnt >= timeDelta)
            {
                timeCnt -= timeDelta;
                if (GetComponent<SpriteRenderer>().sprite != GameControl.sp[GameControl.dropType])
                {
                    //Debug.Log("1");
                    Debug.Log(GameControl.dropType);
                    FlushSelf(GameControl.sp[GameControl.dropType]);
;                }
                else
                {
                    Boom(posX, posY);
                    Debug.Log("2");
                }
            }
        }
    }
    void FlushSelf(Sprite newSp)
    {
        GetComponent<SpriteRenderer>().sprite = newSp;
    }

    bool valid(int x, int y)
    {
        if (x >= 0 && x < GameControl.height && y >= 0 && y < GameControl.width) return true;
        else return false;
    }

    void Boom(int x, int y)
    {
        playSound(dropSound2, 0.5, 1, 0.5f);
        GameControl.score++;
        //GameControl.dropsLevel[posX][posY] -= GameControl.dropType;
        GameControl.dropsLevel[posX][posY] = 0;
        for (int i = x - 1; i <= x + 1; i++)
        {
            for (int j = y - 1; j <= y + 1; j++)
            {
                if (valid(i, j) && !(i == x && j == y))
                {
                    GameControl.dropsLevel[i][j]++;
                }
            }
        }
    }

    private void OnMouseUp()
    {
        Debug.Log("clicked");
        playSound(dropSound1, 0.5, 1, 1.0f);
        if (GameControl.dropsLevel[posX][posY] < GameControl.dropType)
        {
            GameControl.dropsLevel[posX][posY]++;
        }
    }

}