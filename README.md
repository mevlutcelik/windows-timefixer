# Windows Timefixer

Bu depo, Windows PowerShell kullanarak bir klasörün ve içerisindeki tüm alt klasör ve dosyaların “oluşturma” ve “değiştirilme” tarihlerini güncellemek için iki farklı script içerir:

1. **`random_date.ps1`**  
   Belirlenen tarih aralığında, iş saatleri (09:00–17:59) içinde rastgele tarih atar.
2. **`change_date.ps1`**  
   Kullanıcının girdiği tek bir tarihe göre tüm öğelerin oluşturma ve değiştirme tarihlerini ayarlar.

---

## İçindekiler

- [Önkoşullar](#önkoşullar)  
- [Dosya Açıklamaları](#dosya-açıklamaları)  
  - [1. `random_date.ps1`](#1-random_dateps1)  
  - [2. `change_date.ps1`](#2-change_dateps1)  
- [Kurulum ve Çalıştırma](#kurulum-ve-çalıştırma)  
  - [1. Depoyu Klonlamak](#1-depoyu-klonlamak)  
  - [2. PowerShell Ayarları](#2-powershell-ayarları)  
  - [3. `random_date.ps1` Kullanımı](#3-random_dateps1-kullanımı)  
  - [4. `change_date.ps1` Kullanımı](#4-change_dateps1-kullanımı)  
- [Örnek Kullanım](#örnek-kullanım)  
- [Dikkat Edilmesi Gerekenler](#dikkat-edilmesi-gerekenler)  
- [Lisans](#lisans)

---

## Önkoşullar

- Windows 10 veya daha yeni bir işletim sistemi  
- PowerShell (v5 veya üzeri tercih edilir)  
- Yönetici (Administrator) yetkisiyle PowerShell açma izni  
- Depoya erişim (örn. Git ile clonelama yetkisi)

---

## Dosya Açıklamaları

### 1. `random_date.ps1`

Bu script, kullanıcıdan bir klasör yolu alır ve:

- **Oluşturma tarihi** için:  
  - 30 Nisan 2025 00:00:00 – 15 Mayıs 2025 23:59:59 aralığında  
  - Saat, iş saati (09:00–17:59) içinde rastgele seçilir  
- **Değiştirilme tarihi** için:  
  - 30 Nisan 2025 00:00:00 – 28 Mayıs 2025 23:59:59 aralığında  
  - Saat, iş saati (09:00–17:59) içinde rastgele seçilir  

Klasörün kendisi ile içindeki tüm alt klasör ve dosyaların (iç içe tüm yapılar dâhil) hem “CreationTime” hem de “LastWriteTime”/“LastAccessTime” değerleri bu rastgele seçilen tarih ve saatlere göre güncellenir.

> **Önemli**: Tarih aralıkları ve iş saati (09–17) dilimleri, script’in içinde kolayca düzenlenebilir.

---

### 2. `change_date.ps1`

Bu script, kullanıcıdan:

- Bir klasör yolu  
- Yeni tarih bilgisi (`gg.aa.yyyy SS:dd:ss` formatında, örn. `01.01.2024 10:00:00`)  

alır ve:

- Girilen tarih değerini “CreationTime”, “LastWriteTime” ve “LastAccessTime” olarak  
  - Klasörün kendisine  
  - Klasör içindeki tüm dosyalara  

uygular. Alt klasörler de `Get-ChildItem -File` ile işleme dâhil edilir (klasörler dışındaki tüm dosyalar).

---

## Kurulum ve Çalıştırma

Aşağıdaki adımları takip ederek script’leri kendi bilgisayarınızda çalıştırabilirsiniz.

### 1. Depoyu Klonlamak

```bash
git clone https://github.com/KULLANICI_ADINIZ/folder-timestamp-changer.git
cd folder-timestamp-changer
```

> **Not:** `KULLANICI_ADINIZ` yerine kendi GitHub kullanıcı adınızı ve repo adınızı yazın.

### 2. PowerShell Ayarları

Windows PowerShell’i **Yönetici (Administrator)** olarak açın. Aşağıdaki komutla çalıştırma ilkelerini (execution policy) geçici olarak devre dışı bırakabilirsiniz:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
```

Bu ayar yalnızca açık oturum boyunca geçerli olur ve bilgisayarınızın genel güvenlik ayarlarına kalıcı bir değişiklik getirmenize gerek kalmaz.

---

### 3. `random_date.ps1` Kullanımı

1. PowerShell penceresinde repo klasörüne gidin:

   ```powershell
   cd "C:\Yol\folder-timestamp-changer"
   ```

2. Aşağıdaki komutu çalıştırın:

   ```powershell
   .\random_date.ps1
   ```

3. Ekranda görünecek “Enter PATH” satırına, tarihlerini rastgele ayarlamak istediğiniz klasörün tam yolunu yazın. Örneğin:

   ```
   Enter PATH: C:\Users\mevlutcelik\Desktop\deneme_klasoru
   ```

4. Script, klasör ve içerisindeki her bir alt klasör/dosya için oluşturma ve değiştirme tarihlerini rastgele atayacak ve başarılı olunca “Tüm klasör ve dosyalar için rastgele tarih atamaları tamamlandı.” mesajını verecektir.

---

### 4. `change_date.ps1` Kullanımı

1. PowerShell penceresinde repo klasörüne gidin:

   ```powershell
   cd "C:\Yol\folder-timestamp-changer"
   ```

2. Aşağıdaki komutu çalıştırın:

   ```powershell
   .\change_date.ps1
   ```

3. İlk satırda, “Enter PATH” ile klasör yolunu girin:

   ```
   Enter PATH: C:\Users\mevlutcelik\Desktop\deneme_klasoru
   ```

4. İkinci soruda, yeni tarihi `gg.aa.yyyy SS:dd:ss` formatında girin. Örneğin:

   ```
   Enter the new date (example: 01.01.2024 10:00:00): 05.05.2025 14:30:00
   ```

5. Script, klasör ve içindeki tüm dosyalar için belirtilen tarihi hem “CreationTime” hem de “LastWriteTime”/“LastAccessTime” olarak ayarlayacak ve ardından “The folder and all contained files have been successfully updated.” mesajını gösterecektir.

---

## Örnek Kullanım

**1. `random_date.ps1` Örneği**  
- Klasör: `C:\Users\mevlutcelik\Desktop\deneme_klasoru`  

```powershell
PS C:\Users\mevlutcelik\Desktop\folder-timestamp-changer> .\random_date.ps1
Enter PATH: C:\Users\mevlutcelik\Desktop\deneme_klasoru
Tüm klasör ve dosyalar için rastgele tarih atamaları tamamlandı.
```

Script, örneğin şu şekilde rastgele değerler atayabilir:
- `deneme_klasoru` klasörünün CreationTime: 03.05.2025 11:17:42  
- `deneme_klasoru\alt_klasor\file.txt` dosyasının CreationTime: 08.05.2025 09:03:58, LastWriteTime: 27.05.2025 15:45:22  
  vb.

---

**2. `change_date.ps1` Örneği**  
- Klasör: `C:\Users\mevlutcelik\Desktop\deneme_klasoru`  
- Yeni Tarih: `05.05.2025 14:30:00`  

```powershell
PS C:\Users\mevlutcelik\Desktop\folder-timestamp-changer> .\change_date.ps1
Enter PATH: C:\Users\mevlutcelik\Desktop\deneme_klasoru
Enter the new date (example: 01.01.2024 10:00:00): 05.05.2025 14:30:00
The folder and all contained files have been successfully updated.
```

Bu çalıştırma sonunda:
- `deneme_klasoru` klasörünün hem CreationTime hem de LastWriteTime = 05.05.2025 14:30:00  
- İçerisindeki tüm dosyaların CreationTime/LastWriteTime/LastAccessTime = 05.05.2025 14:30:00  

şeklinde güncellenir.

---

## Dikkat Edilmesi Gerekenler

- **Yönetici İzni**: Bu script’ler klasör ve dosya zaman bilgilerini değiştirdiğinden, PowerShell’in yönetici (Administrator) olarak çalıştırılması gerekebilir.  
- **Tarihler**: Tarih formatlarının doğru girilmesi önemlidir. Yanlış format girildiğinde hata mesajı alırsınız.  
- **Performans**: Çok büyük klasör yapılarında (`-Recurse`) çalıştırmak bir süre alabilir. O esnada PowerShell penceresini kapatmayın.  
- **Tarih Aralıkları**: `random_date.ps1` içindeki tarih aralıklarını ve iş saati dilimlerini (09–17) dilediğiniz gibi ayarlayabilirsiniz.  
- **Execution Policy**: Her PowerShell oturumunda `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force` komutunu unutmamanız gerekir; aksi takdirde script çalışmayabilir.

---

## Lisans

Bu projedeki kodlar **MIT Lisansı** ile lisanslanmıştır. Dilediğiniz gibi kullanabilir, değiştirebilir ve dağıtabilirsiniz.
