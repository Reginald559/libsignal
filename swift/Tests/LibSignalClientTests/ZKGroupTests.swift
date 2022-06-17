//
// Copyright 2020-2022 Signal Messenger, LLC.
// SPDX-License-Identifier: AGPL-3.0-only
//

import XCTest
import LibSignalClient

class ZKGroupTests: TestCaseBase {

  let TEST_ARRAY_16: UUID         = UUID(uuid: (0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f))

  let TEST_ARRAY_16_1: UUID       = UUID(uuid: (0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73))

  let TEST_ARRAY_32: Randomness   = Randomness((0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
                                              0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
                                              0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
                                              0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f))

  let TEST_ARRAY_32_1: [UInt8]    = [0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73,
                                  0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, 0x80, 0x81, 0x82, 0x83]

  let TEST_ARRAY_32_2: Randomness = Randomness((0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
                                                0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
                                                0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
                                                0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7))

  let TEST_ARRAY_32_3: Randomness = Randomness((
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,
      28, 29, 30, 31, 32))

  let TEST_ARRAY_32_4: Randomness = Randomness((
    2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,
    28, 29, 30, 31, 32, 33))

  let TEST_ARRAY_32_5: Randomness = Randomness((0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a,
                                                0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12,
                                                0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a,
                                                0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x21, 0x22))

  let authPresentationResult: [UInt8] = [
    0x01, 0x32, 0x2f, 0x91, 0x00, 0xde, 0x07, 0x34, 0x55, 0x0a, 0x81, 0xdc, 0x81, 0x72, 0x4a, 0x81,
    0xdb, 0xd3, 0xb1, 0xb4, 0x3d, 0xbc, 0x1d, 0x55, 0x2d, 0x53, 0x45, 0x59, 0x11, 0xc2, 0x77, 0x2f,
    0x34, 0xa6, 0x35, 0x6c, 0xa1, 0x7c, 0x6d, 0x34, 0xd8, 0x58, 0x39, 0x14, 0x56, 0xaf, 0x55, 0xd0,
    0xef, 0x84, 0x1f, 0xbe, 0x1f, 0xa8, 0xc4, 0xee, 0x81, 0x0f, 0x21, 0xe0, 0xbb, 0x9f, 0x4a, 0xce,
    0x4c, 0x5c, 0x48, 0xc7, 0x2e, 0xbb, 0xeb, 0x2c, 0xcd, 0xa5, 0xf7, 0xaa, 0x49, 0xae, 0xe6, 0xbc,
    0x00, 0x51, 0xcd, 0xde, 0x16, 0x6e, 0x0f, 0x8c, 0x5f, 0x1f, 0xeb, 0xd5, 0x3a, 0x44, 0x37, 0xc5,
    0x70, 0xee, 0x1a, 0xa2, 0x23, 0xf5, 0xeb, 0x93, 0x7d, 0xb9, 0x8f, 0x34, 0xe3, 0x65, 0x3d, 0x85,
    0xec, 0x16, 0x3f, 0x39, 0x84, 0x72, 0x22, 0xa2, 0xde, 0xc4, 0x23, 0x5e, 0xa4, 0x1c, 0x47, 0xbb,
    0x62, 0x02, 0x8a, 0xae, 0x30, 0x94, 0x58, 0x57, 0xee, 0x77, 0x66, 0x30, 0x79, 0xbc, 0xc4, 0x92,
    0x3d, 0x14, 0xa4, 0x3a, 0xd4, 0xf6, 0xbc, 0x33, 0x71, 0x50, 0x46, 0xf7, 0xbd, 0xe5, 0x27, 0x15,
    0x37, 0x5c, 0xa9, 0xf8, 0x9b, 0xe0, 0xe6, 0x30, 0xd4, 0xbd, 0xaa, 0x21, 0x11, 0x56, 0xd0, 0x30,
    0x67, 0x23, 0xf5, 0x43, 0xb0, 0x6f, 0x5e, 0x99, 0x84, 0x47, 0xb9, 0x62, 0xc8, 0xe9, 0x72, 0x9b,
    0x4c, 0xc0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x74, 0xd0, 0xea, 0xe8, 0xe4, 0x31, 0x1a,
    0x6a, 0xe3, 0xd2, 0x97, 0x0e, 0xf1, 0x98, 0xc3, 0x98, 0x11, 0x04, 0x62, 0xbe, 0x47, 0xdd, 0x2f,
    0x26, 0xe6, 0x55, 0x92, 0x09, 0xef, 0x6c, 0xc2, 0x00, 0x01, 0xa0, 0x5a, 0x0b, 0x31, 0x9a, 0x17,
    0x2d, 0xbe, 0xb2, 0x29, 0x3c, 0xc1, 0xe0, 0xe1, 0x91, 0xce, 0xfb, 0x23, 0xe2, 0x4c, 0xf0, 0xd6,
    0xb4, 0xb5, 0x37, 0x3a, 0x30, 0x04, 0x4b, 0xe1, 0x0c, 0xb0, 0x33, 0x67, 0x4d, 0x63, 0x1e, 0x17,
    0xdf, 0xce, 0x09, 0x39, 0x8f, 0x23, 0x4e, 0x9d, 0x62, 0xe1, 0x18, 0xa6, 0x07, 0x7c, 0xae, 0xa0,
    0xef, 0x8b, 0xf6, 0x7d, 0x7d, 0x72, 0x3d, 0xb7, 0x0f, 0xec, 0xf2, 0x09, 0x8f, 0xa0, 0x41, 0x31,
    0x7b, 0x7b, 0xe9, 0xfd, 0xbb, 0x68, 0xb0, 0xf2, 0x5f, 0x5c, 0x47, 0x9d, 0x68, 0xbd, 0x91, 0x7f,
    0xc6, 0xf1, 0x87, 0xc5, 0xbf, 0x7a, 0x58, 0x91, 0x02, 0x31, 0x92, 0x1f, 0xc4, 0x35, 0x65, 0x23,
    0x24, 0x66, 0x32, 0x5c, 0x03, 0x92, 0x12, 0x36, 0x2b, 0x6d, 0x12, 0x03, 0xcc, 0xae, 0xdf, 0x83,
    0x1d, 0xc7, 0xf9, 0x06, 0x0d, 0xca, 0xaf, 0xfa, 0x02, 0x62, 0x40, 0x42, 0x17, 0x1f, 0x5f, 0x0e,
    0x78, 0x0b, 0x9f, 0x74, 0xcf, 0xa8, 0x8a, 0x14, 0x7f, 0x3f, 0x1c, 0x08, 0x2f, 0x9c, 0xa8, 0x63,
    0x8a, 0xf1, 0x78, 0x8e, 0x78, 0x99, 0xcb, 0xae, 0x0c, 0x76, 0x5d, 0xe9, 0xdf, 0x4c, 0xfa, 0x54,
    0x87, 0xf3, 0x60, 0xe2, 0x9e, 0x99, 0x34, 0x3e, 0x91, 0x81, 0x1b, 0xae, 0xc3, 0x31, 0xc4, 0x68,
    0x09, 0x85, 0xe6, 0x08, 0xca, 0x5d, 0x40, 0x8e, 0x21, 0x72, 0x5c, 0x6a, 0xa1, 0xb6, 0x1d, 0x5a,
    0x8b, 0x48, 0xd7, 0x5f, 0x4a, 0xaa, 0x9a, 0x3c, 0xbe, 0x88, 0xd3, 0xe0, 0xf1, 0xa5, 0x43, 0x19,
    0x08, 0x1f, 0x77, 0xc7, 0x2c, 0x8f, 0x52, 0x54, 0x74, 0x40, 0xe2, 0x01, 0x00]

  let profileKeyPresentationResult: [UInt8] = [
    0x01, 0xe0, 0xf4, 0x9c, 0xef, 0x4f, 0x25, 0xc3, 0x1d, 0x1b, 0xfd, 0xc4, 0xa3, 0x28, 0xfd, 0x50,
    0x8d, 0x22, 0x22, 0xb6, 0xde, 0xce, 0xe2, 0xa2, 0x53, 0xcf, 0x71, 0xe8, 0x82, 0x1e, 0x97, 0xcc,
    0x3f, 0x86, 0x82, 0x4f, 0x79, 0xb1, 0x88, 0x4b, 0x43, 0xc6, 0x7f, 0x85, 0x47, 0x17, 0xb1, 0xa4,
    0x7f, 0x56, 0xc8, 0xff, 0x50, 0xa1, 0xc0, 0x7f, 0xdd, 0xbf, 0x4f, 0x6e, 0x85, 0x70, 0x27, 0xd5,
    0x48, 0x58, 0x3b, 0x54, 0x07, 0x9d, 0xd6, 0x1d, 0x54, 0xcd, 0xd3, 0x9c, 0xd4, 0xac, 0xae, 0x5f,
    0x8b, 0x3b, 0xbf, 0xa2, 0xbb, 0x6b, 0x35, 0x02, 0xb6, 0x9b, 0x36, 0xda, 0x77, 0xad, 0xdd, 0xdc,
    0x14, 0x5e, 0xf2, 0x54, 0xa1, 0x6f, 0x2b, 0xae, 0xc1, 0xe3, 0xd7, 0xe8, 0xdc, 0x80, 0x73, 0x0b,
    0xc6, 0x08, 0xfc, 0xd0, 0xe4, 0xd8, 0xcf, 0xef, 0x33, 0x30, 0xa4, 0x96, 0x38, 0x0c, 0x7a, 0xc6,
    0x48, 0x68, 0x6b, 0x9c, 0x5b, 0x91, 0x4d, 0x0a, 0x77, 0xee, 0x84, 0x84, 0x8a, 0xa9, 0x70, 0xb2,
    0x40, 0x44, 0x50, 0x17, 0x9b, 0x40, 0x22, 0xee, 0xf0, 0x03, 0x38, 0x7f, 0x6b, 0xdb, 0xcb, 0xa3,
    0x03, 0x44, 0xca, 0xdf, 0xd5, 0xe3, 0xf1, 0x67, 0x7c, 0xaa, 0x2c, 0x78, 0x5f, 0x4f, 0xef, 0xe0,
    0x42, 0xa1, 0xb2, 0xad, 0xf4, 0xf4, 0xb8, 0xfa, 0x60, 0x23, 0xe4, 0x1d, 0x70, 0x4b, 0xda, 0x90,
    0x1d, 0x3a, 0x69, 0x79, 0x04, 0x77, 0x0a, 0xc4, 0x6e, 0x0e, 0x30, 0x4c, 0xf1, 0x9f, 0x91, 0xce,
    0x9a, 0xb0, 0xed, 0x1c, 0xca, 0xd8, 0xa6, 0xfe, 0xbd, 0x72, 0x31, 0x34, 0x55, 0xf1, 0x39, 0xb9,
    0x22, 0x2e, 0x9a, 0x30, 0xa2, 0x26, 0x5c, 0x6c, 0xd2, 0x2e, 0xe5, 0xb9, 0x07, 0xfc, 0x95, 0x96,
    0x74, 0x17, 0xa0, 0xd8, 0xca, 0x33, 0x8a, 0x5e, 0xe4, 0xd5, 0x1b, 0xba, 0x78, 0x03, 0x9c, 0x31,
    0x4e, 0x40, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x74, 0x9d, 0x54, 0x77, 0x2b, 0x81, 0x37,
    0xe5, 0x70, 0x15, 0x7c, 0x06, 0x8a, 0x5c, 0xfe, 0xbb, 0x46, 0x4b, 0x6c, 0x11, 0x33, 0xc7, 0x2d,
    0x9a, 0xbf, 0xda, 0x72, 0xdb, 0x42, 0x1c, 0xd0, 0x05, 0x61, 0xac, 0x4e, 0xec, 0xb9, 0x43, 0x13,
    0xc6, 0x91, 0x20, 0x13, 0xe3, 0x2c, 0x32, 0x2e, 0xa3, 0x67, 0x43, 0xb0, 0x18, 0x14, 0xfe, 0x91,
    0x9c, 0xa8, 0x4b, 0x9a, 0xea, 0x9c, 0x78, 0xb1, 0x0b, 0xa0, 0x21, 0x50, 0x6f, 0x7a, 0xd8, 0xc6,
    0x62, 0x5e, 0x87, 0xe0, 0x7c, 0xe3, 0x2b, 0x55, 0x90, 0x36, 0xaf, 0x6b, 0x67, 0xe2, 0xc0, 0x38,
    0x3a, 0x64, 0x3c, 0xb9, 0x3c, 0xdc, 0x2b, 0x98, 0x00, 0xe9, 0x05, 0x88, 0xa1, 0x8f, 0xcc, 0x44,
    0x9c, 0xd4, 0x66, 0xc2, 0x8c, 0x6d, 0xb7, 0x35, 0x07, 0xd8, 0x28, 0x2d, 0xd0, 0x08, 0x08, 0xb5,
    0x92, 0x7f, 0xee, 0x33, 0x36, 0xed, 0x0a, 0x22, 0x02, 0xdf, 0xb1, 0xe1, 0x76, 0xfe, 0xce, 0x6a,
    0x41, 0x04, 0xca, 0xa2, 0xa8, 0x66, 0xc4, 0x75, 0x20, 0x99, 0x67, 0x63, 0x8e, 0xa2, 0xf1, 0x46,
    0x68, 0x47, 0xda, 0x73, 0x01, 0xa7, 0x7b, 0x90, 0x07, 0xdf, 0xb3, 0x32, 0xa3, 0x0e, 0x9b, 0xbf,
    0xae, 0x8a, 0x83, 0x98, 0x16, 0x5e, 0xc9, 0xdd, 0x47, 0x78, 0x21, 0x4e, 0x0d, 0x6e, 0xd3, 0x5a,
    0x34, 0x07, 0x1b, 0xdf, 0x3b, 0x3b, 0x19, 0x51, 0x0f, 0xf2, 0xa6, 0x17, 0xbc, 0x53, 0xeb, 0x0e,
    0x6b, 0x0d, 0xdc, 0x50, 0x1d, 0xb0, 0x27, 0xbb, 0x47, 0xe4, 0xf4, 0x12, 0x7d, 0x7a, 0x01, 0x04,
    0x94, 0x5f, 0x3d, 0x3d, 0xc7, 0xec, 0x17, 0x41, 0x03, 0x8b, 0x9b, 0x80, 0xe2, 0xc7, 0xf1, 0x31,
    0xc5, 0x19, 0xee, 0x26, 0xff, 0xcb, 0x7c, 0xb9, 0xd3, 0x55, 0x6c, 0xd3, 0x5a, 0x12, 0xbe, 0xf1,
    0xd4, 0xb3, 0x76, 0xfc, 0x51, 0x31, 0x97, 0xba, 0x00, 0xce, 0x8f, 0x01, 0x2a, 0x0b, 0x37, 0x41,
    0x64, 0x22, 0x2b, 0xa7, 0x9a, 0x39, 0xe7, 0x4e, 0x15, 0x08, 0x13, 0x47, 0x4c, 0xa6, 0xf8, 0x7b,
    0xa7, 0x05, 0xc0, 0xf0, 0x6e, 0x7b, 0x70, 0x68, 0x03, 0x9c, 0x5e, 0xdd, 0x9d, 0xd1, 0xa5, 0xab,
    0x67, 0x93, 0xac, 0x21, 0x19, 0x89, 0x90, 0x76, 0x86, 0xb4, 0x56, 0x50, 0x22, 0x11, 0x87, 0xd4,
    0xd5, 0x9a, 0xe4, 0x92, 0x67, 0x9f, 0x3b, 0x43, 0x08, 0x76, 0x5d, 0xe9, 0xdf, 0x4c, 0xfa, 0x54,
    0x87, 0xf3, 0x60, 0xe2, 0x9e, 0x99, 0x34, 0x3e, 0x91, 0x81, 0x1b, 0xae, 0xc3, 0x31, 0xc4, 0x68,
    0x09, 0x85, 0xe6, 0x08, 0xca, 0x5d, 0x40, 0x8e, 0x21, 0x72, 0x5c, 0x6a, 0xa1, 0xb6, 0x1d, 0x5a,
    0x8b, 0x48, 0xd7, 0x5f, 0x4a, 0xaa, 0x9a, 0x3c, 0xbe, 0x88, 0xd3, 0xe0, 0xf1, 0xa5, 0x43, 0x19,
    0x08, 0x1f, 0x77, 0xc7, 0x2c, 0x8f, 0x52, 0x54, 0x74, 0x48, 0xc0, 0x3a, 0xb4, 0xaf, 0xbf, 0x6b,
    0x8f, 0xb0, 0xe1, 0x26, 0xc0, 0x37, 0xa0, 0xad, 0x40, 0x94, 0x60, 0x0d, 0xd0, 0xe0, 0x63, 0x4d,
    0x76, 0xf8, 0x8c, 0x21, 0x08, 0x7f, 0x3c, 0xfb, 0x48, 0x5a, 0x89, 0xbc, 0x1e, 0x3a, 0xbc, 0x4c,
    0x95, 0x04, 0x1d, 0x1d, 0x17, 0x0e, 0xcc, 0xf0, 0x29, 0x33, 0xec, 0x53, 0x93, 0xd4, 0xbe, 0x1d,
    0xc5, 0x73, 0xf8, 0x3c, 0x33, 0xd3, 0xb9, 0xa7, 0x46]

  let pniPresentationResult: [UInt8] = [
    0x01, 0xf8, 0x87, 0xf4, 0x03, 0xdb, 0x1a, 0x80, 0xfa, 0x04, 0x04, 0x34, 0x13, 0x23, 0x3f, 0x56,
    0xbf, 0x6c, 0x53, 0xbb, 0x07, 0x8c, 0x16, 0xd2, 0x4d, 0xf9, 0x3a, 0x21, 0x9d, 0x77, 0x85, 0x69,
    0x68, 0x56, 0xd8, 0xf1, 0x97, 0xa0, 0x1c, 0x6e, 0x22, 0x3d, 0x4a, 0xce, 0xed, 0x1d, 0x60, 0xb9,
    0x0b, 0x71, 0x3f, 0x45, 0x56, 0xab, 0x39, 0x40, 0x3b, 0x84, 0xc5, 0x1d, 0x72, 0x4c, 0xa9, 0xaa,
    0x44, 0x88, 0x6d, 0x73, 0xbe, 0x15, 0xfc, 0xeb, 0xc9, 0x33, 0xf8, 0x35, 0xfc, 0x0f, 0x32, 0x10,
    0xf8, 0xd7, 0xb8, 0xfa, 0x79, 0x40, 0xbf, 0x90, 0x69, 0xd5, 0x0d, 0xc4, 0xba, 0x83, 0xda, 0x8a,
    0x0e, 0xd8, 0x6d, 0x6c, 0x33, 0xcd, 0x99, 0xa2, 0x5f, 0xe4, 0x69, 0x06, 0xd6, 0x55, 0xa7, 0xfe,
    0xc5, 0xfe, 0xe5, 0x00, 0x52, 0x7a, 0x56, 0xea, 0x56, 0x89, 0xd1, 0x76, 0x53, 0x96, 0x90, 0x7b,
    0x15, 0x3a, 0x86, 0xe4, 0x0e, 0xb2, 0x7b, 0x81, 0x20, 0x66, 0x1d, 0xfe, 0x59, 0xbb, 0x17, 0xaf,
    0x10, 0x24, 0xeb, 0xd6, 0x97, 0xc2, 0xc3, 0x6c, 0x46, 0xf3, 0xa8, 0x5f, 0x8d, 0xc6, 0xf9, 0x27,
    0x61, 0xb2, 0x9c, 0x84, 0x25, 0x68, 0x47, 0xb5, 0xf4, 0x20, 0x38, 0x6a, 0xc4, 0x1d, 0x6d, 0x81,
    0xf8, 0xe6, 0x5a, 0x19, 0x5f, 0x2a, 0xb7, 0x00, 0x3c, 0x0f, 0xc2, 0x2f, 0xd9, 0x69, 0x87, 0x0e,
    0x2c, 0x5c, 0x4a, 0xd4, 0xa9, 0xde, 0x38, 0xa8, 0xbd, 0xe7, 0x35, 0x09, 0xc4, 0x1e, 0x85, 0xac,
    0xce, 0xf5, 0x9d, 0xb6, 0x99, 0x30, 0x97, 0x2b, 0x1c, 0x3f, 0xcb, 0x9c, 0x9a, 0xbd, 0x4c, 0x88,
    0x4a, 0x3e, 0x91, 0xb4, 0xc2, 0x5b, 0x8f, 0xde, 0x3b, 0x5c, 0xac, 0x7c, 0x55, 0x44, 0x2f, 0x99,
    0x6b, 0x3f, 0xd3, 0x71, 0x21, 0x10, 0xc7, 0xdd, 0x71, 0xc8, 0x47, 0xbe, 0x55, 0x21, 0x22, 0xb9,
    0x47, 0x40, 0x21, 0x36, 0xb1, 0xc1, 0x6f, 0xe1, 0x8a, 0xcb, 0xa2, 0xe6, 0xa2, 0x77, 0xdc, 0x57,
    0x17, 0x2a, 0xc7, 0x9d, 0x18, 0x92, 0x46, 0x06, 0x0d, 0x50, 0xdb, 0x1a, 0x7d, 0xc5, 0x31, 0xd0,
    0x75, 0xec, 0x94, 0x14, 0xf8, 0x6e, 0x31, 0xa1, 0xb0, 0x40, 0x6c, 0xe1, 0x73, 0xb0, 0x9c, 0x1e,
    0xab, 0xbe, 0xf2, 0xde, 0x11, 0x77, 0x49, 0xb3, 0xc5, 0x12, 0x49, 0x9d, 0x5f, 0x91, 0xe4, 0x69,
    0x4e, 0x40, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x76, 0x9c, 0x0c, 0x6c, 0x31, 0x0e, 0xd2,
    0xb8, 0xf4, 0xa1, 0xd1, 0xe6, 0xb8, 0x53, 0xd8, 0x3f, 0x5d, 0xa8, 0x13, 0x6e, 0x36, 0x60, 0x5f,
    0xd6, 0x31, 0x97, 0x9c, 0xc6, 0x18, 0xd0, 0xe1, 0x02, 0xcc, 0x82, 0xe9, 0x05, 0x6d, 0x20, 0x31,
    0x37, 0x9d, 0xe3, 0xe5, 0x7c, 0x04, 0x53, 0x0b, 0x20, 0x61, 0x7d, 0x0b, 0x24, 0x18, 0xb8, 0x95,
    0x0c, 0x8a, 0x23, 0x94, 0x35, 0x5c, 0x6d, 0x40, 0x0f, 0x0e, 0x4f, 0x69, 0xb7, 0x59, 0x42, 0x03,
    0x20, 0x67, 0x38, 0x2a, 0xe2, 0x44, 0x87, 0x0f, 0x58, 0x59, 0xa3, 0x57, 0x82, 0xcb, 0x81, 0xb1,
    0x10, 0x6c, 0x5a, 0xae, 0x58, 0xdf, 0x1f, 0x11, 0x0d, 0xbf, 0x76, 0x1c, 0x3a, 0x52, 0xad, 0x5e,
    0x3a, 0x87, 0x2f, 0x38, 0x5c, 0x30, 0x56, 0xbf, 0x2b, 0xe3, 0xd6, 0x78, 0x26, 0xcf, 0x33, 0xbc,
    0x74, 0x3c, 0x1c, 0x25, 0xee, 0xd0, 0xed, 0xa2, 0x0f, 0x21, 0xde, 0x77, 0x39, 0x06, 0x65, 0x7b,
    0x26, 0xe0, 0x9c, 0xf3, 0x88, 0xda, 0x23, 0x33, 0xdb, 0x60, 0xf7, 0x68, 0x86, 0x5e, 0x24, 0x05,
    0xf4, 0xdf, 0x4f, 0x48, 0xb6, 0x40, 0x29, 0x5e, 0x02, 0x76, 0x25, 0x67, 0x8a, 0x81, 0x0d, 0xbf,
    0x81, 0x11, 0x91, 0x8f, 0x7b, 0x12, 0x7f, 0xd9, 0xfb, 0x0b, 0x33, 0x25, 0x31, 0xec, 0x52, 0x06,
    0x9b, 0x98, 0xab, 0xf9, 0x5b, 0xb4, 0xae, 0x73, 0x07, 0xd9, 0x6b, 0x9d, 0x50, 0xb6, 0xe7, 0x34,
    0xff, 0x8a, 0xf9, 0x2d, 0x2c, 0x84, 0x17, 0x91, 0x97, 0x95, 0xa4, 0x6b, 0x97, 0xdf, 0x7a, 0x69,
    0x2d, 0xf4, 0xea, 0x9b, 0x63, 0x81, 0x0e, 0xf7, 0x0d, 0xca, 0x68, 0x69, 0x3b, 0xbe, 0xc7, 0xe1,
    0xf5, 0x24, 0x09, 0x43, 0x0d, 0xa6, 0x1c, 0xac, 0x92, 0x49, 0xca, 0x02, 0x21, 0x6a, 0x77, 0xb1,
    0xf0, 0x8e, 0x59, 0x51, 0xa5, 0x07, 0x83, 0xca, 0x08, 0x8f, 0xa5, 0x99, 0x2b, 0x5e, 0xca, 0xf1,
    0x41, 0x3d, 0xfe, 0x45, 0xf9, 0xef, 0x23, 0xb3, 0xc1, 0x20, 0x99, 0x41, 0x18, 0xb3, 0x25, 0x76,
    0x3d, 0x66, 0xe6, 0x0c, 0x96, 0x47, 0xcc, 0x38, 0x02, 0x48, 0xa9, 0xda, 0x79, 0xe4, 0x6c, 0x17,
    0xb6, 0xbb, 0x03, 0xa2, 0x3c, 0x39, 0x87, 0xce, 0xa8, 0x6a, 0xc1, 0x58, 0xd4, 0x5b, 0x78, 0xf1,
    0xf9, 0xb9, 0x23, 0x47, 0x25, 0x21, 0xec, 0xb3, 0x0e, 0x76, 0x5d, 0xe9, 0xdf, 0x4c, 0xfa, 0x54,
    0x87, 0xf3, 0x60, 0xe2, 0x9e, 0x99, 0x34, 0x3e, 0x91, 0x81, 0x1b, 0xae, 0xc3, 0x31, 0xc4, 0x68,
    0x09, 0x85, 0xe6, 0x08, 0xca, 0x5d, 0x40, 0x8e, 0x21, 0x72, 0x5c, 0x6a, 0xa1, 0xb6, 0x1d, 0x5a,
    0x8b, 0x48, 0xd7, 0x5f, 0x4a, 0xaa, 0x9a, 0x3c, 0xbe, 0x88, 0xd3, 0xe0, 0xf1, 0xa5, 0x43, 0x19,
    0x08, 0x1f, 0x77, 0xc7, 0x2c, 0x8f, 0x52, 0x54, 0x74, 0xfe, 0x74, 0x40, 0x90, 0x60, 0x61, 0x56,
    0x79, 0xfc, 0x11, 0x54, 0x73, 0x68, 0x3d, 0x63, 0xab, 0xd9, 0xce, 0xd4, 0x6c, 0x7f, 0x2a, 0xd7,
    0x36, 0x04, 0x6d, 0xe5, 0xa2, 0xc7, 0xd2, 0x52, 0x2f, 0x12, 0x28, 0x95, 0x59, 0x70, 0x49, 0xcf,
    0xd7, 0xcc, 0x5b, 0xeb, 0x6d, 0xc7, 0x2a, 0xa9, 0x90, 0xae, 0x9a, 0x62, 0xec, 0x8e, 0x25, 0x6a,
    0x1c, 0xbf, 0x5f, 0x3f, 0x28, 0x42, 0x33, 0xbb, 0x07, 0x48, 0xc0, 0x3a, 0xb4, 0xaf, 0xbf, 0x6b,
    0x8f, 0xb0, 0xe1, 0x26, 0xc0, 0x37, 0xa0, 0xad, 0x40, 0x94, 0x60, 0x0d, 0xd0, 0xe0, 0x63, 0x4d,
    0x76, 0xf8, 0x8c, 0x21, 0x08, 0x7f, 0x3c, 0xfb, 0x48, 0x5a, 0x89, 0xbc, 0x1e, 0x3a, 0xbc, 0x4c,
    0x95, 0x04, 0x1d, 0x1d, 0x17, 0x0e, 0xcc, 0xf0, 0x29, 0x33, 0xec, 0x53, 0x93, 0xd4, 0xbe, 0x1d,
    0xc5, 0x73, 0xf8, 0x3c, 0x33, 0xd3, 0xb9, 0xa7, 0x46]

  let serverSignatureResult: [UInt8] = [ 0x87, 0xd3, 0x54, 0x56, 0x4d, 0x35,
  0xef, 0x91, 0xed, 0xba, 0x85, 0x1e, 0x08, 0x15, 0x61, 0x2e, 0x86, 0x4c, 0x22,
  0x7a, 0x04, 0x71, 0xd5, 0x0c, 0x27, 0x06, 0x98, 0x60, 0x44, 0x06, 0xd0, 0x03,
  0xa5, 0x54, 0x73, 0xf5, 0x76, 0xcf, 0x24, 0x1f, 0xc6, 0xb4, 0x1c, 0x6b, 0x16,
  0xe5, 0xe6, 0x3b, 0x33, 0x3c, 0x02, 0xfe, 0x4a, 0x33, 0x85, 0x80, 0x22, 0xfd,
  0xd7, 0xa4, 0xab, 0x36, 0x7b, 0x06]

  func testAuthIntegration() throws {
    let uuid: UUID             = TEST_ARRAY_16
    let redemptionTime: UInt32 = 123456

    // Generate keys (client's are per-group, server's are not)
    // ---

    // SERVER
    let serverSecretParams = try ServerSecretParams.generate(randomness: TEST_ARRAY_32)
    let serverPublicParams = try serverSecretParams.getPublicParams()
    let serverZkAuth       = ServerZkAuthOperations(serverSecretParams: serverSecretParams)

    // CLIENT
    let masterKey         = try GroupMasterKey(contents: TEST_ARRAY_32_1)
    let groupSecretParams = try GroupSecretParams.deriveFromMasterKey(groupMasterKey: masterKey)

    XCTAssertEqual((try groupSecretParams.getMasterKey()).serialize(), masterKey.serialize())

    let groupPublicParams = try groupSecretParams.getPublicParams()

    // SERVER
    // Issue credential
    let authCredentialResponse = try serverZkAuth.issueAuthCredential(randomness: TEST_ARRAY_32_2, uuid: uuid, redemptionTime: redemptionTime)

    // CLIENT
    // Receive credential
    let clientZkAuthCipher  = ClientZkAuthOperations(serverPublicParams: serverPublicParams)
    let clientZkGroupCipher = ClientZkGroupCipher(groupSecretParams: groupSecretParams )
    let authCredential      = try clientZkAuthCipher.receiveAuthCredential(uuid: uuid, redemptionTime: redemptionTime, authCredentialResponse: authCredentialResponse)

    // Create and decrypt user entry
    let uuidCiphertext = try clientZkGroupCipher.encryptUuid(uuid: uuid)
    let plaintext      = try clientZkGroupCipher.decryptUuid(uuidCiphertext: uuidCiphertext)
    XCTAssertEqual(uuid, plaintext)

    // Create presentation
    let presentation = try clientZkAuthCipher.createAuthCredentialPresentation(randomness: TEST_ARRAY_32_5, groupSecretParams: groupSecretParams, authCredential: authCredential)

    // Verify presentation
    let uuidCiphertextRecv = try presentation.getUuidCiphertext()
    XCTAssertEqual(uuidCiphertext.serialize(), uuidCiphertextRecv.serialize())
    XCTAssertEqual(try presentation.getRedemptionTime(), redemptionTime)
    try serverZkAuth.verifyAuthCredentialPresentation(groupPublicParams: groupPublicParams, authCredentialPresentation: presentation)

    XCTAssertEqual(presentation.serialize(), authPresentationResult)
  }

  func testProfileKeyIntegration() throws {

    let uuid: UUID             = TEST_ARRAY_16
    // Generate keys (client's are per-group, server's are not)
    // ---

    // SERVER
    let serverSecretParams = try ServerSecretParams.generate(randomness: TEST_ARRAY_32)
    let serverPublicParams = try serverSecretParams.getPublicParams()
    let serverZkProfile    = ServerZkProfileOperations(serverSecretParams: serverSecretParams)

    // CLIENT
    let masterKey         = try GroupMasterKey(contents: TEST_ARRAY_32_1)
    let groupSecretParams = try GroupSecretParams.deriveFromMasterKey(groupMasterKey: masterKey)

    XCTAssertEqual(try groupSecretParams.getMasterKey().serialize(), masterKey.serialize())

    let groupPublicParams = try groupSecretParams.getPublicParams()
    let clientZkProfileCipher = ClientZkProfileOperations(serverPublicParams: serverPublicParams)

    let profileKey  = try ProfileKey(contents: TEST_ARRAY_32_1)
    let profileKeyCommitment = try profileKey.getCommitment(uuid: uuid)

    // Create context and request
    let context = try clientZkProfileCipher.createProfileKeyCredentialRequestContext(randomness: TEST_ARRAY_32_3, uuid: uuid, profileKey: profileKey)
    let request = try context.getRequest()

    // SERVER
    let response = try serverZkProfile.issueProfileKeyCredential(randomness: TEST_ARRAY_32_4, profileKeyCredentialRequest: request, uuid: uuid, profileKeyCommitment: profileKeyCommitment)

    // CLIENT
    // Gets stored profile credential
    let clientZkGroupCipher  = ClientZkGroupCipher(groupSecretParams: groupSecretParams)
    let profileKeyCredential = try clientZkProfileCipher.receiveProfileKeyCredential(profileKeyCredentialRequestContext: context, profileKeyCredentialResponse: response)

    // Create encrypted UID and profile key
    let uuidCiphertext = try clientZkGroupCipher.encryptUuid(uuid: uuid)
    let plaintext      = try clientZkGroupCipher.decryptUuid(uuidCiphertext: uuidCiphertext)

    XCTAssertEqual(plaintext, uuid)

    let profileKeyCiphertext   = try clientZkGroupCipher.encryptProfileKey(profileKey: profileKey, uuid: uuid)
    let decryptedProfileKey    = try clientZkGroupCipher.decryptProfileKey(profileKeyCiphertext: profileKeyCiphertext, uuid: uuid)
    XCTAssertEqual(profileKey.serialize(), decryptedProfileKey.serialize())

    let presentation = try clientZkProfileCipher.createProfileKeyCredentialPresentation(randomness: TEST_ARRAY_32_5, groupSecretParams: groupSecretParams, profileKeyCredential: profileKeyCredential)

    XCTAssertEqual(presentation.serialize(), profileKeyPresentationResult)

    // Verify presentation
    try serverZkProfile.verifyProfileKeyCredentialPresentation(groupPublicParams: groupPublicParams, profileKeyCredentialPresentation: presentation)
    let uuidCiphertextRecv = try presentation.getUuidCiphertext()
    XCTAssertEqual(uuidCiphertext.serialize(), uuidCiphertextRecv.serialize())

    let pkvB = try profileKey.getProfileKeyVersion(uuid: uuid)
    let pkvC = try ProfileKeyVersion(contents: pkvB.serialize())
    XCTAssertEqual(pkvB.serialize(), pkvC.serialize())
  }

  func testExpiringProfileKeyIntegration() throws {

    let uuid: UUID             = TEST_ARRAY_16
    // Generate keys (client's are per-group, server's are not)
    // ---

    // SERVER
    let serverSecretParams = try ServerSecretParams.generate(randomness: TEST_ARRAY_32)
    let serverPublicParams = try serverSecretParams.getPublicParams()
    let serverZkProfile    = ServerZkProfileOperations(serverSecretParams: serverSecretParams)

    // CLIENT
    let masterKey         = try GroupMasterKey(contents: TEST_ARRAY_32_1)
    let groupSecretParams = try GroupSecretParams.deriveFromMasterKey(groupMasterKey: masterKey)

    XCTAssertEqual(try groupSecretParams.getMasterKey().serialize(), masterKey.serialize())

    let groupPublicParams = try groupSecretParams.getPublicParams()
    let clientZkProfileCipher = ClientZkProfileOperations(serverPublicParams: serverPublicParams)

    let profileKey  = try ProfileKey(contents: TEST_ARRAY_32_1)
    let profileKeyCommitment = try profileKey.getCommitment(uuid: uuid)

    // Create context and request
    let context = try clientZkProfileCipher.createProfileKeyCredentialRequestContext(randomness: TEST_ARRAY_32_3, uuid: uuid, profileKey: profileKey)
    let request = try context.getRequest()

    // SERVER
    let now = UInt64(Date().timeIntervalSince1970)
    let startOfDay = now - (now % 86400)
    let expiration = startOfDay + 5 * 86400
    let response = try serverZkProfile.issueExpiringProfileKeyCredential(randomness: TEST_ARRAY_32_4, profileKeyCredentialRequest: request, uuid: uuid, profileKeyCommitment: profileKeyCommitment, expiration: expiration)

    // CLIENT
    // Gets stored profile credential
    let clientZkGroupCipher  = ClientZkGroupCipher(groupSecretParams: groupSecretParams)
    let profileKeyCredential = try clientZkProfileCipher.receiveExpiringProfileKeyCredential(profileKeyCredentialRequestContext: context, profileKeyCredentialResponse: response)

    // Create encrypted UID and profile key
    let uuidCiphertext = try clientZkGroupCipher.encryptUuid(uuid: uuid)
    let plaintext      = try clientZkGroupCipher.decryptUuid(uuidCiphertext: uuidCiphertext)

    XCTAssertEqual(plaintext, uuid)

    let profileKeyCiphertext   = try clientZkGroupCipher.encryptProfileKey(profileKey: profileKey, uuid: uuid)
    let decryptedProfileKey    = try clientZkGroupCipher.decryptProfileKey(profileKeyCiphertext: profileKeyCiphertext, uuid: uuid)
    XCTAssertEqual(profileKey.serialize(), decryptedProfileKey.serialize())

    XCTAssertEqual(Date(timeIntervalSince1970: TimeInterval(expiration)), profileKeyCredential.expirationTime)

    let presentation = try clientZkProfileCipher.createProfileKeyCredentialPresentation(randomness: TEST_ARRAY_32_5, groupSecretParams: groupSecretParams, profileKeyCredential: profileKeyCredential)

    // Verify presentation
    try serverZkProfile.verifyProfileKeyCredentialPresentation(groupPublicParams: groupPublicParams, profileKeyCredentialPresentation: presentation)
    try serverZkProfile.verifyProfileKeyCredentialPresentation(groupPublicParams: groupPublicParams, profileKeyCredentialPresentation: presentation, now: Date(timeIntervalSince1970: TimeInterval(expiration - 5)))
    XCTAssertThrowsError(try serverZkProfile.verifyProfileKeyCredentialPresentation(groupPublicParams: groupPublicParams, profileKeyCredentialPresentation: presentation, now: Date(timeIntervalSince1970: TimeInterval(expiration))))
    XCTAssertThrowsError(try serverZkProfile.verifyProfileKeyCredentialPresentation(groupPublicParams: groupPublicParams, profileKeyCredentialPresentation: presentation, now: Date(timeIntervalSince1970: TimeInterval(expiration + 5))))

    let uuidCiphertextRecv = try presentation.getUuidCiphertext()
    XCTAssertEqual(uuidCiphertext.serialize(), uuidCiphertextRecv.serialize())
  }

  func testPniIntegration() throws {
    let aci: UUID = TEST_ARRAY_16
    let pni: UUID = TEST_ARRAY_16_1

    // Generate keys (client's are per-group, server's are not)
    // ---

    // SERVER
    let serverSecretParams = try ServerSecretParams.generate(randomness: TEST_ARRAY_32)
    let serverPublicParams = try serverSecretParams.getPublicParams()
    let serverZkProfile    = ServerZkProfileOperations(serverSecretParams: serverSecretParams)

    // CLIENT
    let masterKey         = try GroupMasterKey(contents: TEST_ARRAY_32_1)
    let groupSecretParams = try GroupSecretParams.deriveFromMasterKey(groupMasterKey: masterKey)

    XCTAssertEqual(try groupSecretParams.getMasterKey().serialize(), masterKey.serialize())

    let groupPublicParams = try groupSecretParams.getPublicParams()
    let clientZkProfileCipher = ClientZkProfileOperations(serverPublicParams: serverPublicParams)

    let profileKey  = try ProfileKey(contents: TEST_ARRAY_32_1)
    let profileKeyCommitment = try profileKey.getCommitment(uuid: aci)

    // Create context and request
    let context = try clientZkProfileCipher.createPniCredentialRequestContext(randomness: TEST_ARRAY_32_3, aci: aci, pni: pni, profileKey: profileKey)
    let request = try context.getRequest()

    // SERVER
    let response = try serverZkProfile.issuePniCredential(randomness: TEST_ARRAY_32_4, profileKeyCredentialRequest: request, aci: aci, pni: pni, profileKeyCommitment: profileKeyCommitment)

    // CLIENT
    // Gets stored profile credential
    let clientZkGroupCipher  = ClientZkGroupCipher(groupSecretParams: groupSecretParams)
    let pniCredential = try clientZkProfileCipher.receivePniCredential(requestContext: context, response: response)

    let presentation = try clientZkProfileCipher.createPniCredentialPresentation(randomness: TEST_ARRAY_32_5, groupSecretParams: groupSecretParams, credential: pniCredential)

    XCTAssertEqual(presentation.serialize(), pniPresentationResult)

    // Verify presentation
    try serverZkProfile.verifyPniCredentialPresentation(groupPublicParams: groupPublicParams, presentation: presentation)
    let aciCiphertextRecv = try presentation.getAciCiphertext()
    XCTAssertEqual(try clientZkGroupCipher.encryptUuid(uuid: aci).serialize(), aciCiphertextRecv.serialize())
    let pniCiphertextRecv = try presentation.getPniCiphertext()
    XCTAssertEqual(try clientZkGroupCipher.encryptUuid(uuid: pni).serialize(), pniCiphertextRecv.serialize())
  }

  func testServerSignatures() throws {
    let serverSecretParams = try ServerSecretParams.generate(randomness: TEST_ARRAY_32)
    let serverPublicParams = try serverSecretParams.getPublicParams()

    let message = TEST_ARRAY_32_1

    let signature = try serverSecretParams.sign(randomness: TEST_ARRAY_32_2, message: message)
    try serverPublicParams.verifySignature(message: message, notarySignature: signature)

    XCTAssertEqual(signature.serialize(), serverSignatureResult)

    var alteredMessage = message
    alteredMessage[0] ^= 1
    do {
        try serverPublicParams.verifySignature(message: alteredMessage, notarySignature: signature)
        XCTAssert(false)
    } catch SignalError.verificationFailed(_) {
      // good
    }
  }

  func testInvalidSerialized() throws {
    let ckp: [UInt8] = Array(repeating: 255, count: 289)
    do {
        _ = try GroupSecretParams(contents: ckp)
        XCTFail("should have thrown")
    } catch SignalError.invalidType(_) {
        // good
    }
  }

  func testWrongSizeSerialized() throws {
    let ckp: [UInt8] = Array(repeating: 255, count: 5)
    do {
        _ = try GroupSecretParams(contents: ckp)
        XCTFail("should have thrown")
    } catch SignalError.invalidType(_) {
        // good
    }
  }

  func testBlobEncryption() throws {
    let groupSecretParams = try GroupSecretParams.generate()
    let clientZkGroupCipher = ClientZkGroupCipher(groupSecretParams: groupSecretParams)

    let plaintext: [UInt8] = [0, 1, 2, 3, 4]
    let ciphertext = try clientZkGroupCipher.encryptBlob(plaintext: plaintext)
    let plaintext2 = try clientZkGroupCipher.decryptBlob(blobCiphertext: ciphertext)

    XCTAssertEqual(plaintext, plaintext2)
  }

  func testBlobEncryptionWithRandom() throws {
    let masterKey           = try GroupMasterKey(contents: TEST_ARRAY_32_1)
    let groupSecretParams   = try GroupSecretParams.deriveFromMasterKey(groupMasterKey: masterKey)
    let clientZkGroupCipher = ClientZkGroupCipher(groupSecretParams: groupSecretParams)

    let plaintext: [UInt8]   = [
        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
        0x18, 0x19]

    let ciphertext: [UInt8] = [ 0xdd, 0x4d, 0x03, 0x2c, 0xa9, 0xbb, 0x75, 0xa4,
    0xa7, 0x85, 0x41, 0xb9, 0x0c, 0xb4, 0xe9, 0x57, 0x43, 0xf3, 0xb0, 0xda,
    0xbf, 0xc7, 0xe1, 0x11, 0x01, 0xb0, 0x98, 0xe3, 0x4f, 0x6c, 0xf6, 0x51,
    0x39, 0x40, 0xa0, 0x4c, 0x1f, 0x20, 0xa3, 0x02, 0x69, 0x2a, 0xfd, 0xc7,
    0x08, 0x7f, 0x10, 0x19, 0x60, 0x00]

    let ciphertext257: [UInt8] = [ 0x5c, 0xb5, 0xb7, 0xbf, 0xf0, 0x6e, 0x85, 0xd9,
    0x29, 0xf3, 0x51, 0x1f, 0xd1, 0x94, 0xe6, 0x38, 0xcf, 0x32, 0xa4, 0x76,
    0x63, 0x86, 0x8b, 0xc8, 0xe6, 0x4d, 0x98, 0xfb, 0x1b, 0xbe, 0x43, 0x5e,
    0xbd, 0x21, 0xc7, 0x63, 0xce, 0x2d, 0x42, 0xe8, 0x5a, 0x1b, 0x2c, 0x16,
    0x9f, 0x12, 0xf9, 0x81, 0x8d, 0xda, 0xdc, 0xf4, 0xb4, 0x91, 0x39, 0x8b,
    0x7c, 0x5d, 0x46, 0xa2, 0x24, 0xe1, 0x58, 0x27, 0x49, 0xf5, 0xe2, 0xa4,
    0xa2, 0x29, 0x4c, 0xaa, 0xaa, 0xab, 0x84, 0x3a, 0x1b, 0x7c, 0xf6, 0x42,
    0x6f, 0xd5, 0x43, 0xd0, 0x9f, 0xf3, 0x2a, 0x4b, 0xa5, 0xf3, 0x19, 0xca,
    0x44, 0x42, 0xb4, 0xda, 0x34, 0xb3, 0xe2, 0xb5, 0xb4, 0xf8, 0xa5, 0x2f,
    0xdc, 0x4b, 0x48, 0x4e, 0xa8, 0x6b, 0x33, 0xdb, 0x3e, 0xbb, 0x75, 0x8d,
    0xbd, 0x96, 0x14, 0x17, 0x8f, 0x0e, 0x4e, 0x1f, 0x9b, 0x2b, 0x91, 0x4f,
    0x1e, 0x78, 0x69, 0x36, 0xb6, 0x2e, 0xd2, 0xb5, 0x8b, 0x7a, 0xe3, 0xcb,
    0x3e, 0x7a, 0xe0, 0x83, 0x5b, 0x95, 0x16, 0x95, 0x98, 0x37, 0x40, 0x66,
    0x62, 0xb8, 0x5e, 0xac, 0x74, 0x0c, 0xef, 0x83, 0xb6, 0x0b, 0x5a, 0xae,
    0xaa, 0xab, 0x95, 0x64, 0x3c, 0x2b, 0xef, 0x8c, 0xe8, 0x73, 0x58, 0xfa,
    0xbf, 0xf9, 0xd6, 0x90, 0x05, 0x2b, 0xeb, 0x9e, 0x52, 0xd0, 0xc9, 0x47,
    0xe7, 0xc9, 0x86, 0xb2, 0xf3, 0xce, 0x3b, 0x71, 0x61, 0xce, 0xc7, 0x2c,
    0x08, 0xe2, 0xc4, 0xad, 0xe3, 0xde, 0xbe, 0x37, 0x92, 0xd7, 0x36, 0xc0,
    0x45, 0x7b, 0xc3, 0x52, 0xaf, 0xb8, 0xb6, 0xca, 0xa4, 0x8a, 0x5b, 0x92,
    0xc1, 0xec, 0x05, 0xba, 0x80, 0x8b, 0xa8, 0xf9, 0x4c, 0x65, 0x72, 0xeb,
    0xbf, 0x29, 0x81, 0x89, 0x12, 0x34, 0x49, 0x87, 0x57, 0x3d, 0xe4, 0x19,
    0xdb, 0xcc, 0x7f, 0x1e, 0xa0, 0xe4, 0xb2, 0xdd, 0x40, 0x77, 0xb7, 0x6b,
    0x38, 0x18, 0x19, 0x74, 0x7a, 0xc3, 0x32, 0xe4, 0x6f, 0xa2, 0x3a, 0xbf,
    0xc3, 0x33, 0x8e, 0x2f, 0x4b, 0x08, 0x1a, 0x8a, 0x53, 0xcb, 0xa0, 0x98,
    0x8e, 0xef, 0x11, 0x67, 0x64, 0xd9, 0x44, 0xf1, 0xce, 0x3f, 0x20, 0xa3,
    0x02, 0x69, 0x2a, 0xfd, 0xc7, 0x08, 0x7f, 0x10, 0x19, 0x60, 0x00 ]

    let ciphertext2 = try clientZkGroupCipher.encryptBlob(randomness: TEST_ARRAY_32_2, plaintext: plaintext)
    let plaintext2 = try clientZkGroupCipher.decryptBlob(blobCiphertext: ciphertext2)

    XCTAssertEqual(plaintext, plaintext2)
    XCTAssertEqual(ciphertext, ciphertext2)

    let plaintext257 = try clientZkGroupCipher.decryptBlob(blobCiphertext: ciphertext257)
    XCTAssertEqual(plaintext, plaintext257)
  }

  static var allTests: [(String, (ZKGroupTests) -> () throws -> Void)] {
    return [
      ("testAuthIntegration", testAuthIntegration),
      ("testProfileKeyIntegration", testProfileKeyIntegration),
      ("testServerSignatures", testServerSignatures),
      ("testInvalidSerialized", testInvalidSerialized),
      ("testWrongSizeSerialized", testWrongSizeSerialized),
      ("testBlobEncryption", testBlobEncryption),
      ("testBlobEncryptionWithRandom", testBlobEncryptionWithRandom),
    ]
  }
}
