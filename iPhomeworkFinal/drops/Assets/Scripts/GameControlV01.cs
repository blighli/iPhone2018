using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Threading;
public class GameControlV01 : MonoBehaviour
{
    public int dropType = 7;
    public int life = 10;
    public static int height = 8;
    public static int width = 5;
    public static int[][] dropsLevel;
    public Sprite[] sp = new Sprite[8];
    public GameObject[] preDrops = new GameObject[8];
    public GameObject[] instDrops=new GameObject[height*width];
    public float cnt;
    public float timeDelta = 0.5f;
    void InitGame()
    {
        Random.InitState((int)Time.time);

        Random rd;
        dropsLevel = new int[height][];
        for (int i = 0; i < height; i++)
        {
            dropsLevel[i] = new int[width];
            for (int j = 0; j < width; j++)
            {
                rd = new Random();
                dropsLevel[i][j] = (int)Random.Range(0, 1000) % dropType;
            }
        }
        for(int i = 0; i < 8; i++)
        {
            sp[i] = preDrops[i].GetComponent<SpriteRenderer>().sprite;
        }
    }
    void Paint()
    {
        for (int i = 0; i < height; i++)
        {
            for (int j = 0; j < width; j++)
            {
                PlaceOne(preDrops[dropsLevel[i][j]], i,j);
            }
        }
    }
    void PlaceOne(GameObject sDrop,int x,int y)
    {
        float x1 = x - 4;
        float y1 = y - 2;
        Vector3 vec3 = new Vector3(y1, x1, -2);
        instDrops[x*width+y]=Instantiate(sDrop, vec3,Quaternion.identity);
        instDrops[x * width + y].GetComponent<ImDrop>().posX = x;
        instDrops[x * width + y].GetComponent<ImDrop>().posY = y;
        instDrops[x * width + y].AddComponent<BoxCollider2D>();
    }
    void Flush()
    {
        for (int i = 0; i < height; i++)
        {
            for (int j = 0; j < width; j++)
            {
                if(dropsLevel[i][j]<dropType)
                    instDrops[i * width + j].GetComponent<SpriteRenderer>().sprite = preDrops[dropsLevel[i][j]].GetComponent<SpriteRenderer>().sprite;
            }
        }
    }
    bool valid(int x,int y)
    { 
        if (x >= 0 && x < height && y >= 0 && y < width) return true;
        else return false;
    }
    void DetectOne(int x, int y, int chain)
    {
        if (dropsLevel[x][y] >= dropType)
        {
            dropsLevel[x][y] -= dropType;
            Debug.Log("boom");
            if (chain >= 1) life++;
            for (int i = x - 1; i <= x + 1; i++)
            {
                for (int j = y - 1; j <= y + 1; j++)
                {
                    if (valid(i, j) && !(i == x && j == y))
                    //if(valid(i,j)&& (Mathf.Abs(i-x)+Mathf.Abs(j-y)==1))
                    {
                        Flush();
                        Debug.Log("ppp");
                        dropsLevel[i][j]++;
                    }
                }
            }
        }
    }
    void DetectAll()
    {
        for (int i = 0; i < height; i++)
        {
            for (int j = 0; j < width; j++)
            {
                DetectOne(i, j, 0);
            }
        }
    }
    // Start is called before the first frame update
    void Start()
    {
        InitGame();
        Paint();
        cnt = 0;
       
    }
    // Update is called once per frame
    void Update()
    {
        cnt += Time.deltaTime;
        if (cnt > timeDelta)
        {
            cnt -= timeDelta;
            Flush();
            DetectAll();
        }
    }
}
