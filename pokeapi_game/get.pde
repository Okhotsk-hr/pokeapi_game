// URLからJSONを取得
JSONObject getJSON(String url) {
  try {
    URL u = new URL(url);
    HttpURLConnection conn = (HttpURLConnection) u.openConnection();
    conn.setRequestProperty("User-Agent", "Mozilla/5.0");
    conn.connect();
    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = br.readLine()) != null) {
      sb.append(line);
    }
    br.close();
    return JSONObject.parse(sb.toString());
  } catch (Exception e) {
    e.printStackTrace();
    return null;
  }
}

// ポケモンデータを取得
Pokemon fetchPokemon(int no) {
  String url = "https://pokeapi.co/api/v2/pokemon/" + no;
  JSONObject data = getJSON(url);
  if (data == null) {
    println("ポケモンデータの取得に失敗しました: " + url);
    return null;
  }

  // 画像
  String imgUrl = data.getJSONObject("sprites")
                      .getJSONObject("other")
                      .getJSONObject("official-artwork")
                      .getString("front_default");
  PImage img = null;
  if (imgUrl != null) {
    img = loadImage(imgUrl);
  }

  // 日本語名
  String speciesUrl = data.getJSONObject("species").getString("url");
  JSONObject speciesData = getJSON(speciesUrl);
  if (speciesData == null) {
    println("種族データの取得に失敗しました: " + speciesUrl);
    return null;
  }
  JSONArray names = speciesData.getJSONArray("names");
  String name = "";
  for (int i = 0; i < names.size(); i++) {
    JSONObject obj = names.getJSONObject(i);
    if (obj.getJSONObject("language").getString("name").equals("ja")) {
      name = obj.getString("name");
      break;
    }
  }

  // 日本語タイプ
  JSONArray typeArray = data.getJSONArray("types");
  String[] types = new String[typeArray.size()];
  for (int i = 0; i < typeArray.size(); i++) {
    String typeUrl = typeArray.getJSONObject(i).getJSONObject("type").getString("url");
    JSONObject typeData = getJSON(typeUrl);
    JSONArray typeNames = typeData.getJSONArray("names");
    for (int j = 0; j < typeNames.size(); j++) {
      JSONObject obj = typeNames.getJSONObject(j);
      if (obj.getJSONObject("language").getString("name").equals("ja")) {
        types[i] = obj.getString("name");
        break;
      }
    }
  }

  return new Pokemon(no, name, types, img);
}
