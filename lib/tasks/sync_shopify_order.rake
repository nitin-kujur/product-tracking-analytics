# namespace :order do
#   desc 'Shopify sync missing orders'
#   task sync_shopify_order: :environment do
#     CYCLE = 0.5     # You can average 2 calls per second
#     Shop.all.each do |shop|
      
#       shopify_orders_count = 1200
#       nb_pages      = (shopify_orders_count / 250.0).ceil
#       start_time = Time.now
      
#       1.upto(nb_pages) do |page|
#         unless page == 1
#           stop_time = Time.now
#           puts "Last batch processing started at #{start_time.strftime('%I:%M%p')}"
#           puts "The time is now #{stop_time.strftime('%I:%M%p')}"
#           processing_duration = stop_time - start_time
#           puts "The processing lasted #{processing_duration.to_i} seconds."
#           wait_time = (CYCLE - processing_duration).ceil
#           puts "We have to wait #{wait_time} seconds then we will resume."
#           sleep wait_time if wait_time > 0
#           start_time = Time.now
#         end
#         puts "Doing page #{page}/#{nb_pages}..."
#         Shop.set_session(shop)
#         shopify_orders_count = ShopifyAPI::Order.count
#         shopify_page = 1
#         shopify_order = ShopifyAPI::Order.find(:all, params: {status: :any, limit: 250, page: shopify_page})
#         max_result_count = shopify_order.nil? ? 0 : shopify_order.count
#         while max_result_count == 250
#           shopify_page = shopify_page + 1
#           temp_shop_orders = ShopifyAPI::Order.find(:all, params: {limit: 250, page: shopify_page})
#           shopify_order = shopify_order + temp_shop_orders
#           max_result_count = temp_shop_orders.count
#         end
#         shopify_order
#         shopify_order.each do |order|
#           puts "=============================================="
#           puts order.name
#           puts shop.shopify_domain
#           puts "=============================================="
#           Order.save_shopify_order(shop, order)
#         end
#       end
#     end
#   end
# end

namespace :order do
  desc 'Shopify sync missing orders'
  task sync_shopify_order: :environment do
    Shop.all.each do |shop|
      Shop.set_session(shop)
      order_count = ShopifyAPI::Order.count
      pages = order_count / 250 + (order_count % 250 == 0 ? 0 : 1)
      orders = []
      # (1..pages).each { |page| orders << ShopifyAPI::Order.find(:all, params: { page: page, status: 'any', limit: 250}) }
      # orders.flatten!
      ["PNFL1425", "PNFL1424", "PNFL1423", "PNFL1422", "PNFL1421", "PNFL1420", "PNFL1419", "PNFL1417", "PNFL1416", "PNFL1415", "PNFL1413", "PNFL1412", "PNFL1411", "PNFL1410", "PNFL1409", "PNFL1408", "PNFL1407", "PNFL1406", "PNFL1405", "PNFL1404", "PNFL1403", "PNFL1402", "PNFL1401", "PNFL1400", "PNFL1399", "PNFL1398", "PNFL1397", "PNFL1396", "PNFL1395", "PNFL1394", "PNFL1393", "PNFL1392", "PNFL1391", "PNFL1390", "PNFL1389", "PNFL1388", "PNFL1387", "PNFL1386", "PNFL1385", "PNFL1384", "PNFL1383", "PNFL1382", "PNFL1381", "PNFL1341", "PNFL1340", "PNFL1339", "PNFL1338", "PNFL1337", "PNFL1336", "PNFL1335", "PNFL1334", "PNFL1333", "PNFL1332", "PNFL1331", "PNFL1330", "PNFL1329", "PNFL1328", "PNFL1327", "PNFL1326", "PNFL1325", "PNFL1324", "PNFL1323", "PNFL1322", "PNFL1321", "PNFL1320", "PNFL1319", "PNFL1318", "PNFL1317", "PNFL1316", "PNFL1315", "PNFL1314", "PNFL1313", "PNFL1312", "PNFL1311", "PNFL1310", "PNFL1309", "PNFL1308", "PNFL1307", "PNFL1306", "PNFL1305", "PNFL1304", "PNFL1303", "PNFL1302", "PNFL1301", "PNFL1300", "PNFL1299", "PNFL1298", "PNFL1297", "PNFL1296", "PNFL1295", "PNFL1294", "PNFL1293", "PNFL1292", "PNFL1291", "PNFL1290", "PNFL1289", "PNFL1288", "PNFL1287", "PNFL1284", "PNFL1283", "PNFL1282", "PNFL1281", "PNFL1280", "PNFL1279", "PNFL1278", "PNFL1277", "PNFL1276", "PNFL1272", "PNFL1271", "PNFL1270", "PNFL1269", "PNFL1268", "PNFL1267", "PNFL1266", "PNFL1265", "PNFL1264", "PNFL1263", "PNFL1262", "PNFL1261", "PNFL1259", "PNFL1258", "PNFL1257", "PNFL1256", "PNFL1255", "PNFL1254", "PNFL1253", "PNFL1252", "PNFL1251", "PNFL1250", "PNFL1249", "PNFL1248", "PNFL1247", "PNFL1246", "PNFL1195", "PNFL1194", "PNFL1193", "PNFL1192", "PNFL1191", "PNFL1190", "PNFL1189", "PNFL1188", "PNFL1187", "PNFL1186", "PNFL1185", "PNFL1184", "PNFL1183", "PNFL1182", "PNFL1181", "PNFL1180", "PNFL1179", "PNFL1178", "PNFL1177", "PNFL1176", "PNFL1175", "PNFL1174", "PNFL1173", "PNFL1172", "PNFL1171", "PNFL1170", "PNFL1169", "PNFL1168", "PNFL1167", "PNFL1166", "PNFL1165", "PNFL1164", "PNFL1163", "PNFL1162", "PNFL1161", "PNFL1160", "PNFL1418", "PNFL1380", "PNFL1379", "PNFL1378", "PNFL1377", "PNFL1376", "PNFL1375", "PNFL1374", "PNFL1373", "PNFL1372", "PNFL1371", "PNFL1370", "PNFL1369", "PNFL1368", "PNFL1367", "PNFL1366", "PNFL1365", "PNFL1364", "PNFL1363", "PNFL1362", "PNFL1361", "PNFL1360", "PNFL1359", "PNFL1358", "PNFL1357", "PNFL1356", "PNFL1355", "PNFL1354", "PNFL1353", "PNFL1352", "PNFL1351", "PNFL1350", "PNFL1349", "PNFL1348", "PNFL1347", "PNFL1346", "PNFL1345", "PNFL1344", "PNFL1343", "PNFL1342", "PNFL1286", "PNFL1285", "PNFL1275", "PNFL1274", "PNFL1273", "PNFL1260", "PNFL1245"].each do |name|
        l_order = ShopifyAPI::Order.where(:name => name)
        Order.save_shopify_order(shop, l_order)
      end  
      # puts "+++++++++++++++++++++++++++"
      # puts orders.count
      # puts "+++++++++++++++++++++++++++"
      # orders.each do |order|
      #   local_order = Order.where(:order_number => order.name).first
      #   if local_order.nil?
      #     Order.save_shopify_order(shop, order)
      #   end
      # end
    end
  end
end