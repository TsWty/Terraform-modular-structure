
Terraform Sürümü ve Provider Versiyonları

Repo’da .terraform.lock.hcl dosyası varsa aynı provider sürümleri otomatik kilitlenir. Yoksa, indiren kişinin en az Terraform 1.11.4 ve AWS provider’ı kullanması; aksi hâlde init aşamasında uyumsuzluk uyarısı alabilir.

AWS Kimlik Doğrulaması

Kodda credential tanımı bulunmuyor; indiren kişinin kendi AWS CLI profili veya ortam değişkenleri (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY) ile kimlik bilgilerini sağlaması gerekir.

Yanlış veya eksik kimlik bilgisi durumunda terraform plan/apply aşamasında “Unauthorized” hatası alır.

Backend vs. Local State

Eğer uzak backend (S3/DynamoDB) konfigürasyonu kodda yoksa, çalıştıran kişi default olarak yerel terraform.tfstate yaratır. Bu da herkesin kendi local state dosyasını yönetmesi demek; ekip çalışması yerine bireysel test için uygun.

Uzak backend ayarları eksikse, “Backend configuration not found” uyarısı gelebilir.

Eksik Değişkenler ve Dosya Düzeni

variables.tf ve örnek terraform.tfvars.example dosyaları yoksa, indiren kişi hangi değişkenleri sağlaması gerektiğini koddan çıkarmak zorunda kalabilir. Bu da başlangıçta kafa karışıklığı yaratabilir.

Öneri: Bir terraform.tfvars.example dosyası ekleyip içinde AWS bölgesi (region), AMI filtre kriteri gibi zorunlu değişkenleri örnekleyebilirsiniz.

Network Kaynaklarına Bağımlılıklar

VPC/subnet/security-group oluşturuluyor; başka bir altyapıyla çakışma riski yok. Ancak kullanıcı aynı AWS hesabında halihazırda aynı isimde kaynaklar kullandıysa (ör. VPC adı “my-vpc”), isim çakışması veya hizmet kısıtlama hatası gelebilir.

----------------------------------------------------------------------------------------------------------------------------------------

Modüler ve Tekrar Kullanılabilir Mimari

VPC, Security Group ve EC2 kaynaklarını ayrı modüllerde tanımlayarak altyapıyı temiz, okunabilir ve yeniden kullanılabilir hale getirdiniz.

Özellikle “module.vpc”, “module.sg” gibi isimlendirmeler, hangi bileşenin ne iş yaptığını doğrudan gösteriyor.

Güvenlik Odaklı Yaklaşım

IMDSv2’yi zorunlu kılan http_tokens = "required" ayarıyla modern güvenlik standartlarına uyum sağladınız.

Erişim anahtarları (Access Key/Secret) doğrudan Terraform kodlarına gömülmemiş, dışarıdan sağlanacak şekilde bırakılmış — bu, “secrets as code” yerine “secrets out of code” pratiğini gösterir.

Performans ve Maliyet Dengesi

gp3 root volume’a yüksek IOPS atayarak performans ihtiyaçlarını karşılamayı hedeflemişsiniz; işvereninize “yüksek performans gerektiren senaryolara hazırlıklı” olduğunuzu gösterir.

Aynı repo’da kolayca değiştirilebilecek parametreler (volume tipi, IOPS, AMI veri kaynağı) mevcut.

DRY ve Otomatize Edilebilir

Terraform’un terraform fmt ve terraform validate komutları ile CI/CD entegrasyonuna hazır bir yapı görünümü söz konusu.

State’i uzak backende (ör. S3 + DynamoDB) taşıma notlarınız, ekip çalışmasına ve ölçeklendirilebilirliğe odaklandığınızı vurgular.
