/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class NativeInterface */

#ifndef _Included_NativeInterface
#define _Included_NativeInterface
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     NativeInterface
 * Method:    sayHello
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_NativeInterface_sayHello
  (JNIEnv *, jclass);

/*
 * Class:     NativeInterface
 * Method:    check_time
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_NativeInterface_check_1time
  (JNIEnv *, jclass);

/*
 * Class:     NativeInterface
 * Method:    get_code
 * Signature: (J)[B
 */
JNIEXPORT jbyteArray JNICALL Java_NativeInterface_get_1code
  (JNIEnv *, jclass, jlong);

/*
 * Class:     NativeInterface
 * Method:    eosio_assert
 * Signature: (ZLjava/lang/String;)V
 */
JNIEXPORT void JNICALL Java_NativeInterface_eosio_1assert
  (JNIEnv *, jclass, jboolean, jstring);

/*
 * Class:     NativeInterface
 * Method:    is_account
 * Signature: (J)Z
 */
JNIEXPORT jboolean JNICALL Java_NativeInterface_is_1account
  (JNIEnv *, jclass, jlong);

/*
 * Class:     NativeInterface
 * Method:    s2n
 * Signature: (Ljava/lang/String;)J
 */
JNIEXPORT jlong JNICALL Java_NativeInterface_s2n
  (JNIEnv *, jclass, jstring);

/*
 * Class:     NativeInterface
 * Method:    n2s
 * Signature: (J)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_NativeInterface_n2s
  (JNIEnv *, jclass, jlong);

/*
 * Class:     NativeInterface
 * Method:    action_data_size
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_NativeInterface_action_1data_1size
  (JNIEnv *, jclass);

/*
 * Class:     NativeInterface
 * Method:    read_action_data
 * Signature: ()[B
 */
JNIEXPORT jbyteArray JNICALL Java_NativeInterface_read_1action_1data
  (JNIEnv *, jclass);

/*
 * Class:     NativeInterface
 * Method:    require_recipient
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_NativeInterface_require_1recipient
  (JNIEnv *, jclass, jlong);

/*
 * Class:     NativeInterface
 * Method:    require_auth
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_NativeInterface_require_1auth
  (JNIEnv *, jclass, jlong);

/*
 * Class:     NativeInterface
 * Method:    db_store_i64
 * Signature: (JJJJ[B)I
 */
JNIEXPORT jint JNICALL Java_NativeInterface_db_1store_1i64
  (JNIEnv *, jclass, jlong, jlong, jlong, jlong, jbyteArray);

/*
 * Class:     NativeInterface
 * Method:    db_update_i64
 * Signature: (IJ[B)V
 */
JNIEXPORT void JNICALL Java_NativeInterface_db_1update_1i64
  (JNIEnv *, jclass, jint, jlong, jbyteArray);

/*
 * Class:     NativeInterface
 * Method:    db_remove_i64
 * Signature: (I)V
 */
JNIEXPORT void JNICALL Java_NativeInterface_db_1remove_1i64
  (JNIEnv *, jclass, jint);

/*
 * Class:     NativeInterface
 * Method:    db_get_i64
 * Signature: (I)[B
 */
JNIEXPORT jbyteArray JNICALL Java_NativeInterface_db_1get_1i64
  (JNIEnv *, jclass, jint);

/*
 * Class:     NativeInterface
 * Method:    db_next_i64
 * Signature: (I)J
 */
JNIEXPORT jlong JNICALL Java_NativeInterface_db_1next_1i64
  (JNIEnv *, jclass, jint);

/*
 * Class:     NativeInterface
 * Method:    db_previous_i64
 * Signature: (I)J
 */
JNIEXPORT jlong JNICALL Java_NativeInterface_db_1previous_1i64
  (JNIEnv *, jclass, jint);

/*
 * Class:     NativeInterface
 * Method:    db_find_i64
 * Signature: (JJJJ)I
 */
JNIEXPORT jint JNICALL Java_NativeInterface_db_1find_1i64
  (JNIEnv *, jclass, jlong, jlong, jlong, jlong);

/*
 * Class:     NativeInterface
 * Method:    db_lowerbound_i64
 * Signature: (JJJJ)I
 */
JNIEXPORT jint JNICALL Java_NativeInterface_db_1lowerbound_1i64
  (JNIEnv *, jclass, jlong, jlong, jlong, jlong);

/*
 * Class:     NativeInterface
 * Method:    db_upperbound_i64
 * Signature: (JJJJ)I
 */
JNIEXPORT jint JNICALL Java_NativeInterface_db_1upperbound_1i64
  (JNIEnv *, jclass, jlong, jlong, jlong, jlong);

/*
 * Class:     NativeInterface
 * Method:    db_end_i64
 * Signature: (JJJ)I
 */
JNIEXPORT jint JNICALL Java_NativeInterface_db_1end_1i64
  (JNIEnv *, jclass, jlong, jlong, jlong);

#ifdef __cplusplus
}
#endif
#endif
