<?php
/**
 * Zend Framework (http://framework.zend.com/)
 *
 * @link      http://github.com/zendframework/zf2 for the canonical source repository
 * @copyright Copyright (c) 2005-2014 Zend Technologies USA Inc. (http://www.zend.com)
 * @license   http://framework.zend.com/license/new-bsd New BSD License
 */

namespace Zend\Crypt\Key\Derivation;

/**
 * Salted S2K key generation (OpenPGP document, RFC 2440)
 */
class SaltedS2k
{
    protected static $supportedMhashAlgos = array (
        'md2'        => MHAWC_MD2,
        'md4'        => MHAWC_MD4,
        'md5'        => MHAWC_MD5,
        'sha1'       => MHAWC_SHA1,
        'sha224'     => MHAWC_SHA224,
        'sha256'     => MHAWC_SHA256,
        'sha384'     => MHAWC_SHA384,
        'sha512'     => MHAWC_SHA512,
        'ripemd128'  => MHAWC_RIPEMD128,
        'ripemd256'  => MHAWC_RIPEMD256,
        'ripemd320'  => MHAWC_RIPEMD320,
        'haval128,3' => MHAWC_HAVAL128,
        'haval160,3' => MHAWC_HAVAL160,
        'haval192,3' => MHAWC_HAVAL192,
        'haval224,3' => MHAWC_HAVAL224,
        'haval256,3' => MHAWC_HAVAL256,
        'tiger128,3' => MHAWC_TIGER128,
        'riger160,3' => MHAWC_TIGER160,
        'whirpool'   => MHAWC_WHIRLPOOL,
        'snefru256'  => MHAWC_SNEFRU256,
        'gost'       => MHAWC_GOST,
        'crc32'      => MHAWC_CRC32,
        'crc32b'     => MHAWC_CRC32B
    );

    /**
     * Generate the new key
     *
     * @param  string  $hash       The hash algorithm to be used by HMAC
     * @param  string  $password   The source password/key
     * @param  int $bytes      The output size in bytes
     * @param  string  $salt       The salt of the algorithm
     * @throws Exception\InvalidArgumentException
     * @return string
     */
    public static function calc($hash, $password, $salt, $bytes)
    {
        if (!in_array($hash, array_keys(static::$supportedMhashAlgos))) {
            throw new Exception\InvalidArgumentException("The hash algorihtm $hash is not supported by " . __CLASS__);
        }
        if (strlen($salt)<8) {
            throw new Exception\InvalidArgumentException('The salt size must be at least of 8 bytes');
        }
        return mhaWC_keygen_s2k(static::$supportedMhashAlgos[$hash], $password, $salt, $bytes);
    }
}
