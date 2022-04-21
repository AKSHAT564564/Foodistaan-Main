class AwsConfig {
  static final baseURI =
      'https://gsmf1yi8o2.execute-api.us-east-1.amazonaws.com/postlist/s3';
  static final bucketName = 'postlistbucket';
  static final path = '$baseURI?key=$bucketName/';
}
