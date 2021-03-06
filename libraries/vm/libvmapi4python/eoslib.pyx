# cython: c_string_type=str, c_string_encoding=ascii
from libcpp.vector cimport vector
from libcpp.string cimport string
from libcpp cimport bool

import db
import struct

cdef extern from "exception_converter.hpp":
    pass


cdef extern from "<stdint.h>":
    ctypedef unsigned int       unsigned_int
    ctypedef unsigned short     uint16_t
    ctypedef unsigned long long uint64_t
    ctypedef unsigned int       uint32_t
    ctypedef int                int32_t
    ctypedef long long          int64_t
    ctypedef unsigned char      uint8_t

    #WRONG define, just to pass cython compiler
    ctypedef long long int128_t "__int128_t"
    ctypedef unsigned long long uint128_t "__uint128_t"

cdef extern from "<stdlib.h>":
    void memcpy(char* dst, char* src, size_t len)
    char * malloc(size_t size)
    void free(char* ptr)

cdef extern from "<fc/crypto/xxhash.h>":
    uint64_t XXH64(const char *data, size_t length, uint64_t seed);

cdef extern from "<eosiolib/transaction.hpp>":
    cdef cppclass permission_level:
          uint64_t    actor;
          uint64_t permission;

    cdef cppclass action:
        action()
        uint64_t                    account
        uint64_t                    name
        vector[permission_level]    authorization
        vector[char]                data

    cdef cppclass transaction:
        uint32_t        expiration;
        unsigned_int    net_usage_words
        int32_t         max_ram_usage
        unsigned_int    delay_sec
        uint32_t        ref_block_prefix
        uint16_t        ref_block_num
        uint8_t         max_cpu_usage_ms

        vector[action]  actions;


cdef extern from "eoslib_.hpp": # namespace "eosio::chain":
    ctypedef unsigned long long uint128_t #fake define should be ctypedef __uint128_t uint128_t

    cdef cppclass permission_level:
        permission_level()
        uint64_t    actor
        uint64_t permission
    

    void pack_bytes_(string& _in, string& out);
    void unpack_bytes_(string& _in, string& out);

    int call_set_args_(string& args);
    int call_get_args_(string& args);

    uint64_t call_(uint64_t account, uint64_t func);
    int send_inline_(action& act)  except +
    int send_deferred_(uint128_t* id, uint64_t payer, vector[action] actions, int expiration, int delay_sec, int max_ram_usage, bool replace_existing)  except +


    cdef cppclass checksum256:
       uint8_t hash[32]

    cdef cppclass checksum160:
       uint8_t hash[20];
    
    cdef cppclass checksum512:
       uint8_t hash[64];

    cdef cppclass vm_api:
#action.h
        uint32_t (*read_action_data)( void* msg, uint32_t len ) except +;
        uint32_t (*action_data_size)()  except +
        void (*require_recipient)( uint64_t name )  except +
        void (*require_auth)( uint64_t name )  except +
        bool (*has_auth)( uint64_t name )  except +
        void (*require_auth2)( uint64_t name, uint64_t permission )  except +
        bool (*is_account)( uint64_t name )  except +
        void (*send_inline)(char *serialized_action, size_t size)  except +
        void (*send_context_free_inline)(const char *serialized_action, size_t size)  except +
        uint64_t  (*publication_time)()  except +
        uint64_t (*current_receiver)()  except +
#chain.h
        uint32_t (*get_active_producers)( uint64_t* producers, uint32_t datalen )  except +


        void (*assert_sha256)( const char* data, uint32_t length, const checksum256* hash )  except +
        void (*assert_sha1)( const char* data, uint32_t length, const checksum160* hash )  except +
        void (*assert_sha512)( const char* data, uint32_t length, const checksum512* hash )  except +
        void (*assert_ripemd160)( const char* data, uint32_t length, const checksum160* hash )  except +
        void (*sha256)( const char* data, uint32_t length, checksum256* hash )  except +
        void (*sha1)( const char* data, uint32_t length, checksum160* hash )  except +
        void (*sha512)( const char* data, uint32_t length, checksum512* hash )  except +
        void (*ripemd160)( const char* data, uint32_t length, checksum160* hash )  except +
        int (*recover_key)( const checksum256* digest, const char* sig, size_t siglen, char* pub, size_t publen )  except +
        void (*assert_recover_key)( const checksum256* digest, const char* sig, size_t siglen, const char* pub, size_t publen )  except +


        void (*send_deferred)(const uint128_t* sender_id, uint64_t payer, const char *serialized_transaction, size_t size, uint32_t replace_existing)  except +
        int (*cancel_deferred)(const uint128_t* sender_id)  except +

        bool (*is_code_activated)( uint64_t name )  except +
        uint32_t (*get_active_producers)( uint64_t* producers, uint32_t datalen )  except +

        int (*get_balance)(uint64_t _account, uint64_t _symbol, int64_t* amount) except +
        int (*transfer_inline)(uint64_t to, uint64_t _account, uint64_t _symbol) except +

        int64_t (*get_permission_last_used)( uint64_t account, uint64_t permission )  except +
        int64_t (*get_account_creation_time)( uint64_t account )  except +

        void (*set_resource_limits)( uint64_t account, int64_t ram_bytes, int64_t net_weight, int64_t cpu_weight )  except +
        void (*get_resource_limits)( uint64_t account, int64_t* ram_bytes, int64_t* net_weight, int64_t* cpu_weight )  except +
        int64_t (*set_proposed_producers)( char *producer_data, uint32_t producer_data_size )  except +
        bool (*is_privileged)( uint64_t account )  except +
        void (*set_privileged)( uint64_t account, bool is_priv )  except +
        void (*set_blockchain_parameters_packed)(char* data, uint32_t datalen) except +
        uint32_t (*get_blockchain_parameters_packed)(char* data, uint32_t datalen) except +
        void (*activate_feature)( int64_t f ) except +

        uint64_t (*string_to_uint64)(const char* str) except +
        int32_t (*uint64_to_string)(uint64_t n, char* out, int size) except +

        void (*eosio_abort)() except +
        void (*eosio_assert)( uint32_t test, const char* msg ) except +
        void (*eosio_assert_message)( uint32_t test, const char* msg, uint32_t msg_len ) except +
        void (*eosio_assert_code)( uint32_t test, uint64_t code ) except +
        void (*eosio_exit)( int32_t code ) except +
        uint64_t  (*current_time)() except +
        uint32_t  (*now)() except +

        int (*set_code_ext)(uint64_t account, int vm_type, uint64_t code_name, const char* src_code, size_t code_size) except +


    vm_api& api()

cdef extern from "eoslib_.hpp" namespace "eosio::chain":
    uint64_t wasm_call2_(uint64_t receiver, string& file_name, string& func, vector[uint64_t]& args, vector[char]& result);

'''
int db_idx128_find_secondary( uint64_t code, uint64_t scope, uint64_t table, const uint128_t& secondary, uint64_t& primary )
int db_idx128_find_primary( uint64_t code, uint64_t scope, uint64_t table, uint128_t& secondary, uint64_t primary )
int db_idx128_lowerbound( uint64_t code, uint64_t scope, uint64_t table,  uint128_t& secondary, uint64_t& primary )
int db_idx128_upperbound( uint64_t code, uint64_t scope, uint64_t table,  uint128_t& secondary, uint64_t& primary )
int db_idx128_end( uint64_t code, uint64_t scope, uint64_t table )
int db_idx128_next( int iterator, uint64_t& primary  )
int db_idx128_previous( int iterator, uint64_t& primary )

int db_idx256_find_secondary( uint64_t code, uint64_t scope, uint64_t table, array_ptr<const idx256> data, size_t data_len, uint64_t& primary )
int db_idx256_find_primary( uint64_t code, uint64_t scope, uint64_t table, array_ptr<idx256> data, size_t data_len, uint64_t primary )
int db_idx256_lowerbound( uint64_t code, uint64_t scope, uint64_t table, array_ptr<idx256> data, size_t data_len, uint64_t& primary )
int db_idx256_upperbound( uint64_t code, uint64_t scope, uint64_t table, array_ptr<idx256> data, size_t data_len, uint64_t& primary )
int db_idx256_end( uint64_t code, uint64_t scope, uint64_t table )
int db_idx256_next( int iterator, uint64_t& primary  )
int db_idx256_previous( int iterator, uint64_t& primary )
'''

def is_code_activated(uint64_t account):
    return api().is_code_activated(account)

def N(const char* _str):
    return api().string_to_uint64(_str);

def s2n(const char* _str):
    return api().string_to_uint64(_str);

def n2s(uint64_t n):
    cdef int size;
    size = api().uint64_to_string(n, NULL, 0)

    name = bytes(size)
    api().uint64_to_string(n, name, size)
    return name.decode('utf8')

def eosio_assert(cond, msg=''):
    if not cond:
        raise AssertionError(msg)

def now():
    return api().now()

#action.h
def read_action():
    cdef int size
    size = api().action_data_size()
    buf = bytes(size)
    api().read_action_data(<char*>buf, size);
    return buf

def require_recipient(uint64_t account):
    return api().require_recipient(account)

def require_auth(uint64_t account):
    return api().require_auth(account)

def has_auth(uint64_t name):
   return api().has_auth( name )

def require_auth2(uint64_t name, uint64_t permission):
   api().require_auth2( name, permission );

def is_account( uint64_t name ):
   return api().is_account( name );

def send_inline(contract, act, args: bytes, permissions):
    cdef action _act
    cdef permission_level per

    if isinstance(contract, str):
        contract = s2n(contract)

    if isinstance(act, str):
        act = s2n(act)

    _act.account = contract
    _act.name = act
    _act.data.resize(len(args))

    memcpy(_act.data.data(), args, len(args))
    for key in permissions:
        per.actor = s2n(key)
        per.permission = s2n(permissions[key])
        _act.authorization.push_back(per)

    return send_inline_(_act)

def transfer_inline(_to, _amount, symbol=0):
    if isinstance(_to, str):
        _to = s2n(_to)

    if not symbol:
        symbol=bytearray(8)
        symbol[0] = 4
        symbol[1] = ord('E')
        symbol[2] = ord('O')
        symbol[3] = ord('S')
        symbol, = struct.unpack('Q', symbol)
    return api().transfer_inline(_to, _amount, symbol)

def send_context_free_inline(data):
   api().send_context_free_inline(data, len(data))

def publication_time():
    return api().publication_time()

def current_receiver():
   return api().current_receiver()


def get_active_producers():
    cdef uint32_t size
    cdef vector[uint64_t] producers
    size = api().get_active_producers(NULL, 0)
    producers.resize(size/(sizeof(uint64_t)))
    api().get_active_producers(producers.data(), size)
    _producers = []
    for p in producers:
        _producers.append(n2s(p))
    return _producers

#crypto.h
def assert_sha256(data, hash):
    cdef const char* _hash
    api().eosio_assert(len(hash) == sizeof(checksum256), 'length mismatch')
    _hash = hash
    api().assert_sha256(data, len(data), <const checksum256*>_hash)

def assert_sha1(data, hash):
    cdef const char* _hash
    api().eosio_assert(len(hash) == sizeof(checksum160), 'length mismatch')
    _hash = hash
    api().assert_sha1(data, len(data), <const checksum160*>_hash)

def assert_sha512(data, hash):
    cdef const char* _hash
    api().eosio_assert(len(hash) == sizeof(checksum512), 'length mismatch')
    _hash = hash
    api().assert_sha512(data, len(data), <const checksum512*>_hash)

def assert_ripemd160(data, hash):
    cdef const char* _hash
    api().eosio_assert(len(hash) == sizeof(checksum160), 'length mismatch')
    _hash = hash
    api().assert_ripemd160(data, len(data), <const checksum160*>_hash)

def sha256(data):
    cdef const char* _hash
    hash = bytes(sizeof(checksum256))
    _hash = hash
    api().sha256(data, len(data), <checksum256*>_hash)
    return hash

def sha1(data):
    cdef char* _hash
    hash = bytes(sizeof(checksum160))
    _hash = hash
    api().sha1(data, len(data), <checksum160*>_hash)
    return hash

def sha512(data):
    cdef char* _hash
    hash = bytes(sizeof(checksum512))
    _hash = hash
    api().sha512(data, len(data), <checksum512*>_hash)
    return hash

def ripemd160(data):
    cdef char* _hash
    hash = bytes(sizeof(checksum160))
    _hash = hash
    api().ripemd160(data, len(data), <checksum160*>_hash)
    return hash

def send_deferred(id, uint64_t payer, actions, expiration, delay_sec, max_ram_usage, replace_existing=False):
    cdef uint128_t          _id
    cdef action             _act
    cdef vector[action]     _acts
    cdef permission_level   per

    if len(actions) > 100:
        raise Exception('action size too large!')

    for a in actions:
        _act = action()
        _act.account = s2n(a[0])
        _act.name = s2n(a[1])
        _act.data.resize(len(a[2]))
        memcpy(_act.data.data(), a[2], len(a[2]))

        pers = a[3]
        for key in pers:
            per.actor = s2n(key)
            per.permission = s2n(pers[key])
            _act.authorization.push_back(per)
        _acts.push_back(_act)

    _id = id
    return send_deferred_(&_id, payer, _acts, expiration, delay_sec, max_ram_usage, replace_existing)

def cancel_deferred(id):
    cdef uint128_t _id
    _id = id
    api().cancel_deferred(&_id);

def wasm_call2(uint64_t receiver, string& file_name, string& func, vector[uint64_t]& args):
    cdef vector[char] result
    return None #wasm_call2_(receiver, file_name, func, args, result);

def hash64(data, uint64_t seed = 0):
    '''64 bit hash using xxhash

    Args:
        data (str|bytes): data to be hashed
        seed (int): hash seed

    Returns:
        int: hash code in uint64_t
    '''

    return XXH64(data, len(data), seed)


def pack_bytes(string& _in):
    cdef string out
    pack_bytes_(_in, out)
    return <bytes>out

def unpack_bytes(string& _in):
    cdef string out
    unpack_bytes_(_in, out)
    return <bytes>out

def call_set_args(string& args):
    return call_set_args_(args)

def call_get_args():
    cdef string args
    call_get_args_(args)
    return <bytes>args

def call(uint64_t account, uint64_t func):
    return call_(account, func)

#    return send_inline('eosio.token', 'transfer', args, {_from:'active'})

def get_balance(account, symbol=None):
    cdef int64_t amount = 0

    if isinstance(account, str):
        account = s2n(account)
    if not symbol:
        symbol=bytearray(8)
        symbol[0] = 4
        symbol[1] = ord('E')
        symbol[2] = ord('O')
        symbol[3] = ord('S')
        symbol, = struct.unpack('Q', symbol)
    else:
        symbol, = struct.unpack('Q', symbol)
    api().get_balance(account, symbol, &amount)
    return amount

def set_code_ext(uint64_t account, int vm_type, uint64_t code_name, src_code):
    return api().set_code_ext(account, vm_type, code_name, src_code, len(src_code));

