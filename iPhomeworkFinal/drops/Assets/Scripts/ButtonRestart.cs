using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class ButtonRestart : MonoBehaviour
{
    public GameObject God;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
    }


    private void OnMouseUp()
    {
        Debug.Log("restart");
        GameControl.dropType = 7; 
        God.GetComponent<GameControl>().InitGame();
        //GameControl.InitGame();
    }

}
