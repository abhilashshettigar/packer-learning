NOW=$(date +"%Y-%m-%d")
NOW_TIME=$(date +"%Y-%m-%d %T %p")
NOW_MONTH=$(date +"%Y-%m")

# MYSQL_HOST="localhost"
# MYSQL_PORT="3306"

# MYSQL_DATABASE="wordpress"
# MYSQL_USER="user"
# MYSQL_PASSWORD="password"

BACKUP_DIR="/home/ubuntu/backup-db/$NOW_MONTH"
BACKUP_FULL_PATH="$BACKUP_DIR/strapi-$NOW.sql"

AMAZON_S3_BUCKET="s3://newmanreview-backup/qa/$NOW_MONTH/"
# AMAZON_S3_BIN="/home/mkyong/.local/bin/aws"

#################################################################

mkdir -p ${BACKUP_DIR}

backup_mysql(){
#        mysqldump -h ${MYSQL_HOST} \
#          -P ${MYSQL_PORT} \
#          -u ${MYSQL_USER} \
#          -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} | gzip > ${BACKUP_FULL_PATH}
    docker exec strapiDB /usr/bin/mysqldump -u root --password=strapi strapi > ${BACKUP_FULL_PATH}
}

upload_s3(){
    #   ${AMAZON_S3_BIN} s3 cp ${BACKUP_FULL_PATH} ${AMAZON_S3_BUCKET}
    aws s3 cp ${BACKUP_FULL_PATH} ${AMAZON_S3_BUCKET}
}

backup_mysql
upload_s3