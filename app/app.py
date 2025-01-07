from flask import Flask, render_template
import boto3
from botocore.exceptions import NoCredentialsError

app = Flask(__name__)

# AWS S3 configuration
S3_BUCKET_NAME = 'your-bucket-name'  # Replace with your S3 bucket name
AWS_REGION = 'us-east-1'  # Replace with the appropriate region of your bucket

# Initialize S3 client
s3 = boto3.client('s3', region_name=AWS_REGION)

# Fetch list of image files from the S3 bucket
def get_s3_images():
    try:
        # Get the list of objects in the S3 bucket
        response = s3.list_objects_v2(Bucket=S3_BUCKET_NAME)
        if 'Contents' in response:
            images = [item['Key'] for item in response['Contents']]
            return images
        else:
            return []
    except NoCredentialsError:
        print("Credentials not available.")
        return []

# Home route to display images
@app.route('/')
def index():
    images = get_s3_images()
    # Generate URLs for the images
    image_urls = [s3.generate_presigned_url('get_object',
                                            Params={'Bucket': S3_BUCKET_NAME, 'Key': image},
                                            ExpiresIn=3600) for image in images]
    return render_template('index.html', image_urls=image_urls)

if __name__ == '__main__':
    app.run(debug=True)