void setup() {
    size(400, 200);
    textSize(32);
    println("キーを押してください");
}

void draw() {
    background(220);
    fill(0);
}

void keyPressed() {
    background(220);
    fill(0);
    println("押されたキー: " + key);
    println("キーコード: " + keyCode);
}
