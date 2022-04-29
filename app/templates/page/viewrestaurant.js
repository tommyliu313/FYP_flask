const posts=[
       {"title": "watchOS 5.1.1 更新",
        "abstract": "隨著 iOS 12.1 一同登場的 watchOS 5.1，在推送後就陸續收到部分用戶回報他們的 Apple Watch 遭遇了變磚的問題，為預防情勢進一步擴大， Apple 隨即便將其緊急撤下。然而幾天過去，Apple 似乎已解決了相關問題，並於稍早正式推出 watchOS 5.1.1 供用戶更新。",
        "category": "科技"},
            {"title": "Samsung 展示折疊螢幕手機",
             "abstract": "Samsung 即將在本週於舊金山舉行的開發者大會中，帶來折疊螢幕手機的最新消息。行動通訊部門副總裁李景泰於電話中向記者說明，到時他們會展示一些使用者介面的相關功能，解釋折疊螢幕將能如何提升多工的效率，以及該產品如何在折疊時能當作手機，展開時能變身為平板電腦。",
             "category": "科技"},
            {"title": "你用大腿跑步還是小腿？",
             "abstract": "慢跑是提升「心肺功能」最簡單、肌群參與最少、技術性最低的有氧運動。但跑步前如果核心、臀部、大小腿肌群不夠強壯，跑步時發力點、腳掌著地位置不對，都可能讓你跑不久、跑不遠，甚至容易受傷。跑步要怎麼跑才不會變成「傷膝中年」？跑步應該是前腳掌、還是腳後跟先落地？跑步時該跨大步還是跨小步？",
             "category": "運動"
            },
            {"title": "「三杯咖啡」養生",
             "abstract": "「三十年前，我讀博士班時，常常做實驗做到晚上七、八點，有時和同學一起去喝杯咖啡，別人喝都沒事，我一喝就肚子痛，所以後來我就不喝了。直到多年後，有一次我搭高鐵，喝了一杯高鐵咖啡，結果完全不一樣了，我想說怎麼會這樣啊，就開始研究……」台大乳癌名醫張金堅說起咖啡，眉開眼笑話匣子全開。",
             "category": "食品"
            },
            {
                "title": "鍛練背部肌力、紓緩下背痛",
                "abstract": "坐了一整天，下背隱隱作痛。別擔心，只要一個動作拯救痠痛不求人。習慣久坐、姿勢又不良的現代人，大多有下背痛的困擾，透過瑜伽鱷魚式的動作練習，可以紓緩下背肌肉緊繃痠疼，也可微調脊椎回正。工作一整天後，找個時間做完簡單的伸展暖身，在鱷魚式這個動作中停留幾個呼吸，為背部紓壓解痛。",
                "category": "運動"
            },
            {
                "title": "Motorola One 將於美國發售",
                "abstract": "Motorola 再戰智能電話市場，而第一部電話 Motorola One 很快於於美國正式發售了。這部早於 8 月份發佈，並同之前推出過的 Moto X4 一樣加入 Google 的 Android One 計劃的產品。好處是採用 Android 原生系統，其次便是得到 2 次 Android 版本的更新。至於規格方面為中階產品。","category": "科技"},
            {"title": "Intel 48 核 Xeon 處理器明年登場","abstract": "Intel 發表了產品線中最高階產品，足足有 48 個核心的 Cascade Lake-AP 處理器。和早前的 28 核心 Xeon W-3175 不同的是在一個封裝內包進兩個 24 核的晶片，本質上可以看做是一個迷你的雙 Xeon 處理器系統，當把兩顆這個放進真正的雙處理器主機板的話，就變成一共 96 個核心了。","category": "科技"}]

const SECTIONS_TW="食品,運動,科技"

new Vue({
  el: '#app',
  data:{
    posts,
    results:[],
    sections: SECTIONS_TW.split(','),
    section: '科技'
  },
    delimiters: ["[[","]]"],
  created(){
    this.getPostsByCategory(this.section)
},
  methods:{
    getPostsByCategory(section){
    let posts = this.posts
      .slice()
      .filter(post => post.category === this.section)
      let i,j,chuckedArray=[],chunk=4;
      for(i=0,j=0;i<posts.length;i+=chunk,j++){
        chuckedArray[j]=posts.slice(i,i+chunk);
      }
      this.results = chuckedArray;
    }
  },
  mounted(){
    axios.get('./db.json').then((response)=>{
      this.posts = response.data;
      this.results(this.section)
    }).catch(error => { console.log(error);});
  }
})