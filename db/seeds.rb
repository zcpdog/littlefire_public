# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([{ name: '数码家电' }, { name: '食品保障' },{name: "家居生活"}, {name: "图书音像"}, 
  {name: "服饰鞋包"},{name: "母婴玩具"}, {name: "钟表首饰"}, {name: "运动户外"}, {name: "个护化妆"},{name: "杂七杂八"},
  {name: "国内优惠"}, {name: "海淘咨询"},{name: "手机平板"},{name: "笔记本", parent_id: 1},{name: "相机影像", parent_id: 1},
  {name: "PC&DIY", parent_id: 1}, {name: "大家电", parent_id: 1},{name: "小家电", parent_id: 1},
  {name: "影音娱乐", parent_id: 1},{name: "数码配件", parent_id: 1}, {name: "网络设备", parent_id: 1},
  {name: "新奇数码", parent_id: 1},{name: "美国海淘", parent_id: 12},{name: "日本海淘", parent_id: 12}])

Merchant.create([{name: "京东", link: "http://www.jingdong.com", domain: "jingdong.com"},
  {name: "苏宁易购", link: "http://www.suning.com/", domain: "suning.com"},
  {name: "易迅", link: "http://51buy.com/", domain: "51buy.com"},
  {name: "亚马逊中国", link: "http://www.amazon.cn/", domain: "amazon.cn"},
  {name: "天猫", link: "http://www.tmall.com/", domain: "tmall.com"},
  {name: "1号店", link: "http://www.yihaodian.com", domain: "yihaodian.com"},
  {name: "美国亚马逊", link: "http://www.amazon.com/", domain: "amazon.com"},
  {name: "日本亚马逊", link: "http://www.amazon.co.jp/", domain: "amazon.co.jp"},
  {name: "当当", link: "http://www.dangdang.com/", domain: "dangdang.com"},
  {name: "国美在线", link: "http://www.gome.com.cn/" , domain: "gome.com.cn"},
  {name: "库巴", link: "http://www.coo8.com/", domain: "coo8.com"},
  {name: "淘宝", link: "http://www.taobao.com/", domain: "taobao.com"}])
