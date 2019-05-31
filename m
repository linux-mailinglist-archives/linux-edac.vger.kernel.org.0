Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E64831853
	for <lists+linux-edac@lfdr.de>; Sat,  1 Jun 2019 01:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfEaXp0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 19:45:26 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:10724
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726945AbfEaXpY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 31 May 2019 19:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MKdwETRsQSaeXTAQd01SxEG+UhgbcAoFL+88AVSciw=;
 b=KTkVn2u/LAOk4/OkBZWZEivhIHYC8Py/NgfNCDHNtmQgKmwcPh8TovgC2p3Kd2M/DtNmzlO76SAnRDw+NZz3Ol8a7n0WcBXp79PguxfQw4pbkkaFVUAuHt6O+j0rTWNaG+PJg0p9U7IRibxFNxcD1cwVZdUtqYXOeYilvO7Rlyc=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2671.namprd12.prod.outlook.com (52.135.103.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 23:45:14 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 23:45:14 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 4/8] EDAC/amd64: Initialize DIMM info for systems with more
 than two channels
Thread-Topic: [PATCH 4/8] EDAC/amd64: Initialize DIMM info for systems with
 more than two channels
Thread-Index: AQHVGArkwHwrwzhWnEWVyItlUonQwA==
Date:   Fri, 31 May 2019 23:45:13 +0000
Message-ID: <20190531234501.32826-5-Yazen.Ghannam@amd.com>
References: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:805:de::45) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d790233-4cac-4d05-44b2-08d6e622065a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2671;
x-ms-traffictypediagnostic: SN6PR12MB2671:
x-microsoft-antispam-prvs: <SN6PR12MB2671C71B891B376E58D6A370F8190@SN6PR12MB2671.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(5640700003)(25786009)(14444005)(6506007)(256004)(72206003)(2906002)(54906003)(6512007)(14454004)(186003)(86362001)(3846002)(6116002)(486006)(2501003)(71200400001)(6486002)(386003)(76176011)(2351001)(478600001)(71190400001)(52116002)(36756003)(6436002)(26005)(68736007)(6916009)(99286004)(446003)(66476007)(476003)(73956011)(66066001)(66946007)(2616005)(81156014)(305945005)(81166006)(1076003)(8936002)(316002)(7736002)(4326008)(8676002)(66446008)(64756008)(50226002)(53936002)(11346002)(5660300002)(66556008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2671;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bZQjNHw1jUt23ss38hMRZEIHZJlgUwhm+pHogk6nqtnKSeiT5C8G+2WEvWk9lBclq3yIChd0h9J6vX76jYafTP49lX/wC3IoFD91gXeWqCgzmLjJbfw/+WOnd2U5yPlwHaLVoSQDG2NleazT4i2avddAiZbiddC9xMTHXy3j9fZfQf3Vsydf2qd7STDQKHiaOxuYZauJwM6gRwOnkXObwsiHB4hKBWN77Zt5Bywh5++UBjqHNbEW1k8caegE9oHgvHQw3xANIpYSFhDVX+ksQDBNjD589i7zfPvZ/lccv36Le+mLpEpYWL1o38f9iCAQ9JlJdj554zDRZjR/CN4mHGPCGIuTT6r8CUoHCUe5Afo/LirnfYMhtu37WmqwSo/kcWCkX6RRYZ8UARnylb81htuXPtPA3OMUNFH8WG7T+Go=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d790233-4cac-4d05-44b2-08d6e622065a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 23:45:13.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2671
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpDdXJyZW50bHks
IHRoZSBESU1NIGluZm8gZm9yIEFNRCBGYW1pbHkgMTdoIHN5c3RlbXMgaXMgaW5pdGlhbGl6ZWQg
aW4NCmluaXRfY3Nyb3dzKCkuIFRoaXMgZnVuY3Rpb24gaXMgc2hhcmVkIHdpdGggbGVnYWN5IHN5
c3RlbXMsIGFuZCBpdCBoYXMgYQ0KbGltaXQgb2YgdHdvIGNoYW5uZWwgc3VwcG9ydC4NCg0KVGhp
cyBwcmV2ZW50cyBpbml0aWFsaXphdGlvbiBvZiB0aGUgRElNTSBpbmZvIGZvciBhIG51bWJlciBv
ZiByYW5rcywgc28NCnRoZXJlIHdpbGwgYmUgbWlzc2luZyByYW5rcyBpbiB0aGUgRURBQyBzeXNm
cy4NCg0KQ3JlYXRlIGEgbmV3IGluaXRfY3Nyb3dzX2RmKCkgZm9yIEZhbWlseTE3aCsgYW5kIHJl
dmVydCBpbml0X2Nzcm93cygpDQpiYWNrIHRvIHByZS1GYW1pbHkxN2ggc3VwcG9ydC4NCg0KTG9v
cCBvdmVyIGFsbCBjaGFubmVscyBpbiB0aGUgbmV3IGZ1bmN0aW9uIGluIG9yZGVyIHRvIHN1cHBv
cnQgc3lzdGVtcw0Kd2l0aCBtb3JlIHRoYW4gdHdvIGNoYW5uZWxzLg0KDQpGaXhlczogYmRjZWU3
NzQ3ZjVjICgiRURBQy9hbWQ2NDogU3VwcG9ydCBtb3JlIHRoYW4gdHdvIFVuaWZpZWQgTWVtb3J5
IENvbnRyb2xsZXJzIikNClNpZ25lZC1vZmYtYnk6IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5u
YW1AYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMgfCA2MyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNDkgaW5z
ZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMv
YW1kNjRfZWRhYy5jIGIvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KaW5kZXggMTI1ZDZlMmE4
MjhlLi5kMDkyNmIxODFjN2MgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5j
DQorKysgYi9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQpAQCAtMjgzNyw2ICsyODM3LDQ2IEBA
IHN0YXRpYyB1MzIgZ2V0X2Nzcm93X25yX3BhZ2VzKHN0cnVjdCBhbWQ2NF9wdnQgKnB2dCwgdTgg
ZGN0LCBpbnQgY3Nyb3dfbnJfb3JpZykNCiAJcmV0dXJuIG5yX3BhZ2VzOw0KIH0NCiANCitzdGF0
aWMgaW50IGluaXRfY3Nyb3dzX2RmKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSkNCit7DQorCXN0
cnVjdCBhbWQ2NF9wdnQgKnB2dCA9IG1jaS0+cHZ0X2luZm87DQorCWVudW0gZWRhY190eXBlIGVk
YWNfbW9kZSA9IEVEQUNfTk9ORTsNCisJZW51bSBkZXZfdHlwZSBkZXZfdHlwZSA9IERFVl9VTktO
T1dOOw0KKwlzdHJ1Y3QgZGltbV9pbmZvICpkaW1tOw0KKwlpbnQgZW1wdHkgPSAxOw0KKwl1OCB1
bWMsIGNzOw0KKw0KKwlpZiAobWNpLT5lZGFjX2N0bF9jYXAgJiBFREFDX0ZMQUdfUzE2RUNEMTZF
RCkgew0KKwkJZWRhY19tb2RlID0gRURBQ19TMTZFQ0QxNkVEOw0KKwkJZGV2X3R5cGUgPSBERVZf
WDE2Ow0KKwl9IGVsc2UgaWYgKG1jaS0+ZWRhY19jdGxfY2FwICYgRURBQ19GTEFHX1M0RUNENEVE
KSB7DQorCQllZGFjX21vZGUgPSBFREFDX1M0RUNENEVEOw0KKwkJZGV2X3R5cGUgPSBERVZfWDQ7
DQorCX0gZWxzZSBpZiAobWNpLT5lZGFjX2N0bF9jYXAgJiBFREFDX0ZMQUdfU0VDREVEKSB7DQor
CQllZGFjX21vZGUgPSBFREFDX1NFQ0RFRDsNCisJfQ0KKw0KKwlmb3JfZWFjaF91bWModW1jKSB7
DQorCQlmb3JfZWFjaF9jaGlwX3NlbGVjdChjcywgdW1jLCBwdnQpIHsNCisJCQlpZiAoIWNzcm93
X2VuYWJsZWQoY3MsIHVtYywgcHZ0KSkNCisJCQkJY29udGludWU7DQorDQorCQkJZW1wdHkgPSAw
Ow0KKwkJCWRpbW0gPSBtY2ktPmNzcm93c1tjc10tPmNoYW5uZWxzW3VtY10tPmRpbW07DQorDQor
CQkJZWRhY19kYmcoMSwgIk1DIG5vZGU6ICVkLCBjc3JvdzogJWRcbiIsDQorCQkJCQlwdnQtPm1j
X25vZGVfaWQsIGNzKTsNCisNCisJCQlkaW1tLT5ucl9wYWdlcyA9IGdldF9jc3Jvd19ucl9wYWdl
cyhwdnQsIHVtYywgY3MpOw0KKwkJCWRpbW0tPm10eXBlID0gcHZ0LT5kcmFtX3R5cGU7DQorCQkJ
ZGltbS0+ZWRhY19tb2RlID0gZWRhY19tb2RlOw0KKwkJCWRpbW0tPmR0eXBlID0gZGV2X3R5cGU7
DQorCQl9DQorCX0NCisNCisJcmV0dXJuIGVtcHR5Ow0KK30NCisNCiAvKg0KICAqIEluaXRpYWxp
emUgdGhlIGFycmF5IG9mIGNzcm93IGF0dHJpYnV0ZSBpbnN0YW5jZXMsIGJhc2VkIG9uIHRoZSB2
YWx1ZXMNCiAgKiBmcm9tIHBjaSBjb25maWcgaGFyZHdhcmUgcmVnaXN0ZXJzLg0KQEAgLTI4NTEs
MTUgKzI4OTEsMTYgQEAgc3RhdGljIGludCBpbml0X2Nzcm93cyhzdHJ1Y3QgbWVtX2N0bF9pbmZv
ICptY2kpDQogCWludCBucl9wYWdlcyA9IDA7DQogCXUzMiB2YWw7DQogDQotCWlmICghcHZ0LT51
bWMpIHsNCi0JCWFtZDY0X3JlYWRfcGNpX2NmZyhwdnQtPkYzLCBOQkNGRywgJnZhbCk7DQorCWlm
IChwdnQtPnVtYykNCisJCXJldHVybiBpbml0X2Nzcm93c19kZihtY2kpOw0KKw0KKwlhbWQ2NF9y
ZWFkX3BjaV9jZmcocHZ0LT5GMywgTkJDRkcsICZ2YWwpOw0KIA0KLQkJcHZ0LT5uYmNmZyA9IHZh
bDsNCisJcHZ0LT5uYmNmZyA9IHZhbDsNCiANCi0JCWVkYWNfZGJnKDAsICJub2RlICVkLCBOQkNG
Rz0weCUwOHhbQ2hpcEtpbGxFY2NDYXA6ICVkfERyYW1FY2NFbjogJWRdXG4iLA0KLQkJCSBwdnQt
Pm1jX25vZGVfaWQsIHZhbCwNCi0JCQkgISEodmFsICYgTkJDRkdfQ0hJUEtJTEwpLCAhISh2YWwg
JiBOQkNGR19FQ0NfRU5BQkxFKSk7DQotCX0NCisJZWRhY19kYmcoMCwgIm5vZGUgJWQsIE5CQ0ZH
PTB4JTA4eFtDaGlwS2lsbEVjY0NhcDogJWR8RHJhbUVjY0VuOiAlZF1cbiIsDQorCQkgcHZ0LT5t
Y19ub2RlX2lkLCB2YWwsDQorCQkgISEodmFsICYgTkJDRkdfQ0hJUEtJTEwpLCAhISh2YWwgJiBO
QkNGR19FQ0NfRU5BQkxFKSk7DQogDQogCS8qDQogCSAqIFdlIGl0ZXJhdGUgb3ZlciBEQ1QwIGhl
cmUgYnV0IHdlIGxvb2sgYXQgRENUMSBpbiBwYXJhbGxlbCwgaWYgbmVlZGVkLg0KQEAgLTI4OTYs
MTMgKzI5MzcsNyBAQCBzdGF0aWMgaW50IGluaXRfY3Nyb3dzKHN0cnVjdCBtZW1fY3RsX2luZm8g
Km1jaSkNCiAJCWVkYWNfZGJnKDEsICJUb3RhbCBjc3JvdyVkIHBhZ2VzOiAldVxuIiwgaSwgbnJf
cGFnZXMpOw0KIA0KIAkJLyogRGV0ZXJtaW5lIERJTU0gRUNDIG1vZGU6ICovDQotCQlpZiAocHZ0
LT51bWMpIHsNCi0JCQlpZiAobWNpLT5lZGFjX2N0bF9jYXAgJiBFREFDX0ZMQUdfUzRFQ0Q0RUQp
DQotCQkJCWVkYWNfbW9kZSA9IEVEQUNfUzRFQ0Q0RUQ7DQotCQkJZWxzZSBpZiAobWNpLT5lZGFj
X2N0bF9jYXAgJiBFREFDX0ZMQUdfU0VDREVEKQ0KLQkJCQllZGFjX21vZGUgPSBFREFDX1NFQ0RF
RDsNCi0NCi0JCX0gZWxzZSBpZiAocHZ0LT5uYmNmZyAmIE5CQ0ZHX0VDQ19FTkFCTEUpIHsNCisJ
CWlmIChwdnQtPm5iY2ZnICYgTkJDRkdfRUNDX0VOQUJMRSkgew0KIAkJCWVkYWNfbW9kZSA9IChw
dnQtPm5iY2ZnICYgTkJDRkdfQ0hJUEtJTEwpDQogCQkJCQk/IEVEQUNfUzRFQ0Q0RUQNCiAJCQkJ
CTogRURBQ19TRUNERUQ7DQotLSANCjIuMTcuMQ0KDQo=
