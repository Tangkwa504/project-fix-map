class shopmarkermodel {
final double lat; 
final double lng;
final String id;
final String title;
final String address;
final String pharmacyname;
final String timeopening;
final String timeclosing;
final String? url;
final String licensepharmacy;
shopmarkermodel({required this.lat,required this.lng,required this.address,required this.id,required this.pharmacyname,required this.timeclosing,required this.timeopening,required this.title,this.url,required this.licensepharmacy});
}