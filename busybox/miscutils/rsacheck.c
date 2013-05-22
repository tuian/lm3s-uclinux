//usage:#define rsacheck_trivial_usage ""
//usage:#define rsacheck_full_usage ""

#define LTM_DESC

#include <libbb.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <tomcrypt.h>

#define SIG_SIZE 128
#define HASH_SIZE 20
#define MAX_PK_SIZE 512

static int get_hash(unsigned char *hash, const char *file);
static int load_key(rsa_key *key, const char *key_file);
static int load_sig(unsigned char *sig, const char *sig_file);
static int check_signature(unsigned char *hash, unsigned char *sig, rsa_key *key, int hash_index);

int rsacheck_main(int argc, char **argv) MAIN_EXTERNALLY_VISIBLE;
int rsacheck_main(int argc, char **argv)
{
	const char *file;
	const char *sig_file;
	const char *key_file;
	struct stat file_stat;
	unsigned char hash[HASH_SIZE];
	int sha1_index;
	rsa_key key;
	unsigned char sig[SIG_SIZE];
	
	/* there should be 3 arguments */
	if( argc < 4 )
		return 1;
	
	file = argv[1];
	sig_file = argv[2];
	key_file = argv[3];
	
	/* check if files exist */
	if( stat(file, &file_stat) != 0 || !S_ISREG(file_stat.st_mode) )
		return 2;
	if( stat(sig_file, &file_stat) != 0 || !S_ISREG(file_stat.st_mode) )
		return 2;
	if( stat(key_file, &file_stat) != 0 || !S_ISREG(file_stat.st_mode) )
		return 2;
	
	/* libtomcrypt initialization */
	ltc_mp = ltm_desc;
	sha1_index = register_hash(&sha1_desc);
	
	if( get_hash(hash, file) )
		return 3;
	
	if( load_sig(sig, sig_file) )
		return 4;
	
	if( load_key(&key, key_file) )
		return 5;
	
	if( check_signature(hash, sig, &key, sha1_index) )
		return 6;
	
	return 0;
}

static int get_hash(unsigned char *hash, const char* file)
{
	int fd;
	unsigned char buffer[512];
	int res;
	hash_state h;
	
	fd = open(file, O_RDONLY, 0);
	
	if( fd < 0 )
		return 1;
	
	sha1_init(&h);
	
	while(1)
	{
		res = read(fd, buffer, sizeof(buffer));
		if( res > 0 )
			sha1_process(&h, buffer, res);
		else if( res == 0 )
		{
			sha1_done(&h, hash);
			close(fd);
			return 0;
		}
		else
		{
			close(fd);
			return 2;
		}
	}
	
	close(fd);
	return 0;
}

static int load_key(rsa_key *key, const char *key_file)
{
	unsigned char buffer[MAX_PK_SIZE + 1];
	int fd;
	int res;
	
	fd = open(key_file, O_RDONLY, 0);
	
	if( fd < 0 )
		return 1;
	
	res = read(fd, buffer, sizeof(buffer));
	close(fd);
	
	if( res < 0 || res > MAX_PK_SIZE )
		return 1;
	
	res = rsa_import(buffer, res, key);
	if( res )
		return 2;
	
	return 0;
}

static int load_sig(unsigned char *sig, const char *sig_file)
{
	int fd;
	int res;
	
	fd = open(sig_file, O_RDONLY, 0);
	
	if( fd < 0 )
		return 1;
	
	res = read(fd, sig, SIG_SIZE);
	close(fd);
	
	if( res != SIG_SIZE )
		return 1;
	
	return 0;
}

static int check_signature(unsigned char *hash, unsigned char *sig, rsa_key *key, int hash_index)
{
	int ret;
	int result = 0;
	
	ret = rsa_verify_hash_ex(sig, SIG_SIZE, hash, HASH_SIZE,
	                         LTC_LTC_PKCS_1_V1_5, hash_index, 0, &result, key);
	if( ret )
		return 1;
	
	if( result )
		return 0;
	else
		return 2;
}