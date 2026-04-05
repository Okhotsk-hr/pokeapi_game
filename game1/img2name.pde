String[] datanames = {"","","",""};
String[] shownames = {"","","",""};
String ansname = "";
boolean quiz = true;
int inkey = 0;

void img2name() {
    
    if (next) {
        pokeNum = int(random(1, max));
        fetched = false;
        pokemons.clear();
    }
    
    // if (turn % 5 == 0) { // 5秒ごと
    //     pokeNum = int(random(1, max));
    //     fetched = false;
    //     pokemons.clear();
// }
    
    //データ取得（1回だけ）
    if (!fetched) {
        // 本物のポケモン取得
        Pokemon p = fetchPokemon(pokeNum);
        if (p != null) {
            pokemons.add(p);
        }
        // ダミー名3つをprint
        for (int i = 0; i < 3; i++) {
            int dummyNum = int(random(1, max));
            Pokemon dummy = fetchPokemon(dummyNum);
            if (dummy != null) {
                // println("ダミー: " + dummy.name);
                datanames[i + 1] = dummy.name;
            }
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
        // 画像の下に名前を表示
        text(p.name, width / 2, height / 2);
        if (next) {
            // println(p.name);
            datanames[0] = p.name;
            ansname = p.name;
        }
        text("タイプ: " + join(p.types, ", "), 120, y + 20);
        // 右側の名前表示は削除
        y += 130;
    }
    
    if (loading) {
        text("読み込み中...", 10, height - 30);
    }
    
    
    if (next) {
        shownames = datanames;
        println(datanames);
        // 配列の順番をランダムにシャッフル
        for (int i = shownames.length - 1; i > 0; i--) {
            int j = int(random(i + 1));
            String tmp = shownames[i];
            shownames[i] = shownames[j];
            shownames[j] = tmp;
        }
        //なぜか両方シャッフルになってる
        // print("元データ: ");
        // println(datanames);
        // print("シャッフル後: ");
        // println(shownames);
        next = false;
    }
    
    if (quiz) {
        //選択肢表示
        int btny = height / 2;
        int btnh = height / 8;
        for (int i = 0;i < 4;i++) {
            fill(180); // グレーに設定
            rect(0, height / 2 + (btnh * i), width, btnh); 
            fill(0);
            text(str(i + 1) + "：" + shownames[i], 10, height / 2 + (btnh * i) + 20);
        }
        
        
    }
    
}

void keyPressed() {
    background(220);
    fill(0);
    if (!fkey) {
        println("1を取得");
        basekey = keyCode;
        fkey = true;
        fill(0); // 文字色を黒に設定
        
        img2name();
        
    } else{
        inkey = keyCode - basekey + 1;
        println(inkey);
    }
    
    if (inkey != 0) {
        if (shownames[inkey - 1].equals(ansname)) {
            background(255);
            println("正解!");
            text("正解！", width / 2, height / 2);
            delay(1000);
            println("次の問題へ");
        } else {
            background(255);
            println("不正解...");
            text("不正解", width / 2, height / 2);
            delay(1000);
            println("次の問題へ");
        }
        // 次の問題の準備
        fetched = false;
        quiz = true;
        inkey = 0;
        next = true;
        img2name();
    }
}
