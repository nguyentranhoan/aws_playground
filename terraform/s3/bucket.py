import os
import boto3
import uuid


class S3Bucket:
    # Low-level service access
    s3_client = boto3.client('s3')
    # High-level interface
    s3_resource = boto3.resource('s3')

    @staticmethod
    def create_bucket_name(bucket_prefix):
        return ''.join([bucket_prefix, str(uuid.uuid4())])

    @classmethod
    def create_bucket(cls, bucket_prefix, region):
        bucket_name = cls.create_bucket_name(bucket_prefix)
        cls.s3_resource.create_bucket(Bucket=bucket_name,
                                      CreateBucketConfiguration={
                                          'LocationConstraint': region,
                                      })
        return bucket_name

    # A better way to get the region programmatically
    @classmethod
    def create_bucket_using_session(cls, bucket_prefix):
        session = boto3.session.Session()
        current_region = session.region_name
        bucket_name = cls.create_bucket_name(bucket_prefix)
        # Using the resource
        s3_connection = cls.s3_resource
        # Using the client
        # s3_connection = cls.s3_resource.meta.client
        bucket_response = s3_connection.create_bucket(
            Bucket=bucket_name,
            CreateBucketConfiguration={
                'LocationConstraint': current_region,
            })
        print(bucket_name, bucket_response)
        return bucket_name, bucket_response


class S3BucketFile:
    @staticmethod
    def create_temp_file(size, file_name, file_content):
        random_file_name = ''.join([str(uuid.uuid4().hex[:6]), file_name])
        with open(random_file_name, 'w') as f:
            f.write(str(file_content) * size)
        return random_file_name

    @classmethod
    def upload_a_file_using_object(cls, bucket_name, file_path):
        basename = os.path.basename(file_path)
        # Object instance version
        object_instance = S3Bucket.s3_resource.Object(bucket_name, basename)
        object_instance.upload_file(file_path)

    @classmethod
    def upload_a_file_using_bucket(cls, bucket_name, file_path):
        basename = os.path.basename(file_path)
        # Bucket instance version
        bucket_instance = S3Bucket.s3_resource.Bucket(bucket_name)
        bucket_instance.upload_file(FileName=file_path, Key=basename)

    @classmethod
    def upload_a_file_using_client(cls, bucket_name, file_path):
        basename = os.path.basename(file_path)
        # Client version
        S3Bucket.s3_resource.meta.client(FileNane=file_path, Bucket=bucket_name, Key=basename)

    @classmethod
    def download_a_file_using_object(cls, bucket_name, file_path):
        basename = os.path.basename(file_path)
        # Object instance version
        object_instance = S3Bucket.s3_resource.Object(bucket_name, basename)
        object_instance.upload_file(file_path)

    @classmethod
    def download_a_file_using_bucket(cls, bucket_name, file_path):
        basename = os.path.basename(file_path)
        # Bucket instance version
        bucket_instance = S3Bucket.s3_resource.Bucket(bucket_name)
        bucket_instance.download_file(FileName=file_path, Key=basename)

    @classmethod
    def download_a_file_using_client(cls, bucket_name, file_path):
        basename = os.path.basename(file_path)
        # Client version
        S3Bucket.s3_resource.meta.client(FileNane=file_path,
                                         Bucket=bucket_name,
                                         Key=basename)

    @classmethod
    def copy_a_file_using_object(cls, bucket_source_name, bucket_destination_name, file_name):
        copy_source = {
            'Bucket': bucket_source_name,
            'Key': file_name
        }
        # Object instance version
        to_bucket = S3Bucket.s3_resource.Bucket(bucket_destination_name)
        object_instance = to_bucket.Object(file_name)
        object_instance.copy(CopySource=copy_source)

    @classmethod
    def copy_a_file_using_bucket(cls, bucket_source_name, bucket_destination_name, file_name):
        # Bucket instance version
        copy_source = {
            'Bucket': bucket_source_name,
            'Key': file_name
        }
        to_bucket = S3Bucket.s3_resource.Bucket(bucket_destination_name)
        to_bucket.copy(CopySource=copy_source, key=file_name)

    @classmethod
    def copy_a_file_using_client(cls, bucket_source_name, bucket_destination_name, file_name):
        # Client version
        copy_source = {
            'Bucket': bucket_source_name,
            'Key': file_name
        }
        S3Bucket.s3_resource.meta.client(CopySource=copy_source,
                                         Bucket=bucket_destination_name,
                                         Key=file_name)


# if __name__ == '__main__':
#     bucket_source, _ = S3Bucket.create_bucket_using_session('hoan-test-source')
#     bucket_destination, _ = S3Bucket.create_bucket_using_session('hoan-test-destination')
#     # Upload file to source bucket(s)
#     S3BucketFile.upload_a_file_using_bucket(bucket_source, 'static/hoan.txt')
#     S3BucketFile.upload_a_file_using_bucket(bucket_source, 'static/athena.txt.txt')
#     # copy file file from source bucket(s) to des bucket(s)
#     S3BucketFile.copy_a_file_using_bucket(bucket_source, bucket_destination, 'static/hoan.txt')
#     S3BucketFile.copy_a_file_using_bucket(bucket_source, bucket_destination, 'static/athena.txt.txt')
