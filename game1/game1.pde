import java.net.*;
import java.io.*;
import processing.data.JSONObject;
import processing.data.JSONArray;
boolean fkey = false;
int basekey = 0;


PFont font;
int max = 1026;
int pokeNum = int(random(1, max)); // ランダムで1匹だけ取得
boolean fetched = false;
boolean next = true;

int turn = 0;

class Pokemon {
    int no;
    String name;
    String[] types;
    PImage img;
    
    Pokemon(int no, String name, String[] types, PImage img) {
        this.no = no;
        this.name = name;
        this.types = types;
        this.img = img;
    }
}
ArrayList<Pokemon> pokemons = new ArrayList<Pokemon>();
boolean loading = true;

void setup() {
    size(500, 500);
    font = createFont("MS Gothic", 32, true); // 日本語対応フォント（Windows例）
    textFont(font);
    textSize(16);
    textAlign(LEFT, TOP);
    frameRate(1); // 1秒に1匹取得（API負荷軽減）
    
    
    background(255);
    // while(basekey ==  0) {
    //     text("1を押してください", 10, height - 30);
// }
    fill(0);
    text("1を押してください", width / 2 ,height / 2);    
}

void draw() {
    
}
