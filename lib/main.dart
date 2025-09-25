import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_counter/providers/counter.dart';

void main() {
  //main sınıf dışında olmalı
  runApp(
    ChangeNotifierProvider(
      create: (_) => Counter(),

      child: MaterialApp(
        home: ProviderCounter(),
        debugShowCheckedModeBanner: false,
      ),
    ), //ProviderCOunter sınıfını ChangeNotifierProvider widget'ı çocuğu olarak yazıyoruz ki counter'a o da erişebilsin değişikliği dinlesin ui'ı değiştirsin
  );
}
//ChangeNotifierProvider provider paketinde tanımlı bir widget. Flutter’daki Scaffold, Column, Text gibi nasıl bir widget’sa onlar gibi
//Counter sınıfını dinleyen bir provider oluşturduk

class IncrementButton extends StatelessWidget {
  //özel bir buton oluşturduk
  final VoidCallback //voidCallback demek parametre almayan ve geriye değer döndürmeyen fonksiyon demek
  onPressed; //butona basılınca ne olacağını belirten bir değişken onPressed. tipi VoidCallback. onPressed sınıfa ait değşken
  //onPressef butona basılınca çalışacak fonksiyonu tutar. Yani fonksiyonu tutan bir değişken. biz de burada onun tipini yazdk
  //VoidCallback kullandık çünkü Flutter butonlarının onPressed parametresi parametresiz ve değer döndürmeyen fonksiyon istiyor, bu yüzden tip olarak bunu verdik ve buton esnek bir şekilde kullanılabilir hâle geldi.
  const IncrementButton({required this.onPressed, super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text('Increment'));
    ;
  }
}

class ProviderCounter extends StatelessWidget {
  const ProviderCounter({super.key});

  @override
  Widget build(BuildContext context) {
    //builde ui'da nasıl görüneceğini yazıyoruz

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Artış: '),
            Consumer<Counter>(
              builder: (context, counter, child) {
                //builder bir fonksiyon. context, dinlediği provider'ın instance'ı(counter) ve child parametreleri var
                //builder fonksiyonu her dinlediği provider'da bir değişiklik olduğunda tetiklenir ve UI'ı yeniden oluşturur
                //her widgetın kendi context'i var. context widget'ın nerede olduğunu, hangi widget'ın çocuğu olduğunu, o anki tema gibi bilgileri tutar
                //counter kullanmamızın nedeni counter provider'ını dinliyor olmamız

                return Text(
                  '${counter.count}', //counter provider'ının count değişkenine eriştik
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            SizedBox(height: 20),
            IncrementButton(
              //bizim oluşturduğumuz buton widgetı
              onPressed: () {
                //butona basıldığında çalışacak fonksiyon
                Provider.of<Counter>(
                  //verilen tipteki provider'ı bulur. Burada Counter tipinde provider'ı bulur
                  context,
                  listen: false,
                ).increment(); //buton basıldığında increment(artış) fonksiyonnu çağrılır. Ve sayı artar
              },
            ),
            //buton sayıyı değiştiriyor provider.of ile provider'a erişyiyoruz. Sonrasında cunsomer widget'o da değişikliği dinlediği için yeni sayıyı ekrana yansıtıyor.
          ],
        ),
      ),
    );
  }
}
