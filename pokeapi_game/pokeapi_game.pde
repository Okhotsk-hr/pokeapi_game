import java.net.*;
import java.io.*;
import processing.data.JSONObject;
import processing.data.JSONArray;

int max = 1026;
int pokeNum = int(random(1, max)); // ランダムで1匹だけ取得
boolean fetched = false;

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
    textSize(16);
    textAlign(LEFT, TOP);
    frameRate(1); // 1秒に1匹取得（API負荷軽減）
}

int turn = 0;
void draw() {
    background(255);
    turn += 1;
    if (turn % 5 == 0) { // 5秒ごと
        pokeNum = int(random(1, max));
        fetched = false;
        pokemons.clear();
    }
    
    //データ取得（1回だけ）
    if (!fetched) {
        Pokemon p = fetchPokemon(pokeNum);
        if (p != null) {
            pokemons.add(p);
        }
        fetched = true;
    }
    
    // 表示
    float y = 10;
    for (Pokemon p : pokemons) {
        text("No." + p.no, 10, y);
        if (p.img != null) {
            image(p.img, 10, y + 20, 100, 100);
        }
        text("タイプ: " + join(p.types, ", "), 120, y + 20);
        text("名前: " + p.name, 120, y + 50);
        y += 130;
        line(0, y, width, y);
    }
    
    if (loading) {
        text("読み込み中...", 10, height - 30);
    }
}

