using System.Collections;
using System.Collections.Generic;
using UnityEngine;
public class GameControl : MonoBehaviour
{
    public static int dropType = 7;
    public static int life;
    public static int score;
    public static int height = 8;
    public static int width = 5;
    public static int[][] dropsLevel;
    public static Sprite[] sp = new Sprite[8];
    public GameObject[] preDrops = new GameObject[8];
    public GameObject[] instDrops = new GameObject[height * width];
    public float cnt;
    public AudioClip dropSound1;
    public static AudioClip dropSoundS1;
    public AudioClip dropSound2;
    public static AudioClip dropSoundS2;
    public void InitGame()
    {
        Random.InitState((int)Time.time);
        score = 0;
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
        for (int i = 0; i < 8; i++)
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
                PlaceOne(preDrops[dropsLevel[i][j]], i, j);
            }
        }
    }
    void PlaceOne(GameObject sDrop, int x, int y)
    {
        float x1 = x - 4;
        float y1 = y - 2;
        Vector3 vec3 = new Vector3(y1, x1, -2);
        instDrops[x * width + y] = Instantiate(sDrop, vec3, Quaternion.identity);
        instDrops[x * width + y].GetComponent<ImDrop>().posX = x;
        instDrops[x * width + y].GetComponent<ImDrop>().posY = y;
        instDrops[x * width + y].AddComponent<BoxCollider2D>();
        instDrops[x * width + y].AddComponent<AudioSource>();
    }
    // Start is called before the first frame update
    void Start()
    {
        dropType = 7;
        dropSoundS1 = dropSound1;
        dropSoundS2 = dropSound2;
        InitGame();
        Paint();
    }
    // Update is called once per frame
    void Update()
    {
    }
}
