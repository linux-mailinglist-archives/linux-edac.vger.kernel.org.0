Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BFA2D801
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfE2Iob (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:44:31 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49466 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbfE2Io0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:26 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8do5C017769;
        Wed, 29 May 2019 01:44:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=aMNfwpkrfZlAQGOhWkeFqTQ7b5LUQt+8tswNsduhmqQ=;
 b=KIrs5vXX7NrJfTP0c3HDpMKKFfhgCzmsapOntFDME2J7mZq9tJLqhl0RzKl+SgMf7Ner
 ibeHrruNa3thVnp/dZ3XQdSwel2tPpZz8N2UQkGLB72dkpef+wOM6AZ5ff3O1ZSIDOOY
 ggKxM08uEEYDHRprA/UhkOVyL7RDac5/qec3lWGgSG3jT8AXTD/YjMD3/IwyoASE9K4h
 Kui777PfSlgLphzBQKEyzmfBFA9In/3MckSwYk7w5dOAuVjxwmyuk3HsB8FN48jgdtVo
 /tAa1EOObDmGsUh5gw/EjgP88JGkpaDM4h51kbPByqdJrT768wtD0ZV8ROthSo+PZUaf 6g== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sskp88p49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:17 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:16 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMNfwpkrfZlAQGOhWkeFqTQ7b5LUQt+8tswNsduhmqQ=;
 b=wioOTkbeE4MiLGChj8q5+gCSbDbX1HsgIWaUCthYiDHmjT/820myuomB4YeBaFjwdTroBaD5lClI7QcWzclgYf0WvrjbeViPGcTy9soa/MdJqcwedebSUDG3BMiPczGjEdzTdpGFqv1HP/6MGT1qt6SZdKR8OKR9hoMnKRnsJVM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:12 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:12 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 04/21] EDAC: Kill EDAC_DIMM_OFF() macro
Thread-Topic: [PATCH 04/21] EDAC: Kill EDAC_DIMM_OFF() macro
Thread-Index: AQHVFfqwIhFAZb80vEOV8UDI5b72FA==
Date:   Wed, 29 May 2019 08:44:12 +0000
Message-ID: <20190529084344.28562-5-rrichter@marvell.com>
References: <20190529084344.28562-1-rrichter@marvell.com>
In-Reply-To: <20190529084344.28562-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR01CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::23) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [78.54.13.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b27cfab3-a333-4011-5f1c-08d6e411d2fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB343708D9501BB91C1D6313D3D91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(14444005)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VFBK6KvWCj4o7Hi09AsGc6wEZmq7hf2G9oU1EKldWCnsAYa9lDJGecikawtuQL9zdiwPHFL8j02Fiiuel9GLJB7PCdA1Sl1so3go1Ie+T/J8qitreG9yPTTUvb3DHaksS5+jaPtULevJv/WQN+aYUCQ7OR1mk+eq/bbqadyuUlT22j+c11qcH3xqqe9sgZMS/Wo023Vm5WGeoBssJWdeL1uW2sYDOqvdjWNRA29z1PbzxMRB6jk7g+zPz3CBaJLh+6FTxqSJkcfPBkv6dOc0HLYqUSUa0csR9yqRMnT8ci5sP1QPLLaShwpXDRB4FOL+QinHpFYn25M8Cdum9O3c9X/T5P4okvdcMjN7ukoSEUQ5fo9I8Dy0V7zUQCzE+s5hmB3h0k1SthDdntpYKBRKoBC0SPfUfSj1cA6od2lmkDw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b27cfab3-a333-4011-5f1c-08d6e411d2fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:12.7436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3437
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_05:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

V2UgZG8gbm90IG5lZWQgdG8gY2FsY3VsYXRlIHRoZSBvZmZzZXQgaW4gdGhlIG1jJ3MgZGltbSBh
cnJheSwgbGV0J3MNCmp1c3Qgc3RvcmUgdGhlIGluZGV4IGluIHN0cnVjdCBkaW1tX2luZm8gYW5k
IHdlIGNhbiBnZXQgcmlkIG9mIHRoaXMNCm1hY3JvLg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JlcnQg
UmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5jb20+DQotLS0NCiBkcml2ZXJzL2VkYWMvZWRhY19t
Yy5jICAgICAgIHwgMTMgKysrKy0tLS0tLS0tDQogZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMu
YyB8IDIwICsrKystLS0tLS0tLS0tLS0tLQ0KIGluY2x1ZGUvbGludXgvZWRhYy5oICAgICAgICAg
fCA0MSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAzIGZpbGVzIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgNjYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2VkYWMvZWRhY19tYy5jIGIvZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KaW5kZXggNWY1NjVl
NTk0OWIzLi4wN2VkYmQ4MGFmMDcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5j
DQorKysgYi9kcml2ZXJzL2VkYWMvZWRhY19tYy5jDQpAQCAtMzE4LDcgKzMxOCw3IEBAIHN0cnVj
dCBtZW1fY3RsX2luZm8gKmVkYWNfbWNfYWxsb2ModW5zaWduZWQgbWNfbnVtLA0KIAl1bnNpZ25l
ZCBzaXplLCB0b3RfZGltbXMgPSAxLCBjb3VudCA9IDE7DQogCXVuc2lnbmVkIHRvdF9jc3Jvd3Mg
PSAxLCB0b3RfY2hhbm5lbHMgPSAxLCB0b3RfZXJyY291bnQgPSAwOw0KIAl2b2lkICpwdnQsICpw
LCAqcHRyID0gTlVMTDsNCi0JaW50IGksIGosIHJvdywgY2huLCBuLCBsZW4sIG9mZjsNCisJaW50
IGlkeCwgaSwgaiwgcm93LCBjaG4sIG4sIGxlbjsNCiAJYm9vbCBwZXJfcmFuayA9IGZhbHNlOw0K
IA0KIAlCVUdfT04obl9sYXllcnMgPiBFREFDX01BWF9MQVlFUlMgfHwgbl9sYXllcnMgPT0gMCk7
DQpAQCAtNDI2LDIwICs0MjYsMTUgQEAgc3RydWN0IG1lbV9jdGxfaW5mbyAqZWRhY19tY19hbGxv
Yyh1bnNpZ25lZCBtY19udW0sDQogCW1lbXNldCgmcG9zLCAwLCBzaXplb2YocG9zKSk7DQogCXJv
dyA9IDA7DQogCWNobiA9IDA7DQotCWZvciAoaSA9IDA7IGkgPCB0b3RfZGltbXM7IGkrKykgew0K
Kwlmb3IgKGlkeCA9IDA7IGlkeCA8IHRvdF9kaW1tczsgaWR4KyspIHsNCiAJCWNoYW4gPSBtY2kt
PmNzcm93c1tyb3ddLT5jaGFubmVsc1tjaG5dOw0KLQkJb2ZmID0gRURBQ19ESU1NX09GRihsYXll
ciwgbl9sYXllcnMsIHBvc1swXSwgcG9zWzFdLCBwb3NbMl0pOw0KLQkJaWYgKG9mZiA8IDAgfHwg
b2ZmID49IHRvdF9kaW1tcykgew0KLQkJCWVkYWNfbWNfcHJpbnRrKG1jaSwgS0VSTl9FUlIsICJF
REFDIGNvcmUgYnVnOiBFREFDX0RJTU1fT0ZGIGlzIHRyeWluZyB0byBkbyBhbiBpbGxlZ2FsIGRh
dGEgYWNjZXNzXG4iKTsNCi0JCQlnb3RvIGVycm9yOw0KLQkJfQ0KIA0KIAkJZGltbSA9IGt6YWxs
b2Moc2l6ZW9mKCoqbWNpLT5kaW1tcyksIEdGUF9LRVJORUwpOw0KIAkJaWYgKCFkaW1tKQ0KIAkJ
CWdvdG8gZXJyb3I7DQotCQltY2ktPmRpbW1zW29mZl0gPSBkaW1tOw0KKwkJbWNpLT5kaW1tc1tp
ZHhdID0gZGltbTsNCiAJCWRpbW0tPm1jaSA9IG1jaTsNCi0JCWRpbW0tPmlkeCA9IG9mZjsNCisJ
CWRpbW0tPmlkeCA9IGlkeDsNCiANCiAJCS8qDQogCQkgKiBDb3B5IERJTU0gbG9jYXRpb24gYW5k
IGluaXRpYWxpemUgaXQuDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMu
YyBiL2RyaXZlcnMvZWRhYy9lZGFjX21jX3N5c2ZzLmMNCmluZGV4IGRiZWY2OTkxNjJhOC4uOGJl
ZWZhNjk5YTQ5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMuYw0KKysr
IGIvZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMuYw0KQEAgLTU1OCwxNCArNTU4LDggQEAgc3Rh
dGljIHNzaXplX3QgZGltbWRldl9jZV9jb3VudF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCiB7
DQogCXN0cnVjdCBkaW1tX2luZm8gKmRpbW0gPSB0b19kaW1tKGRldik7DQogCXUzMiBjb3VudDsN
Ci0JaW50IG9mZjsNCi0NCi0Jb2ZmID0gRURBQ19ESU1NX09GRihkaW1tLT5tY2ktPmxheWVycywN
Ci0JCQkgICAgZGltbS0+bWNpLT5uX2xheWVycywNCi0JCQkgICAgZGltbS0+bG9jYXRpb25bMF0s
DQotCQkJICAgIGRpbW0tPmxvY2F0aW9uWzFdLA0KLQkJCSAgICBkaW1tLT5sb2NhdGlvblsyXSk7
DQotCWNvdW50ID0gZGltbS0+bWNpLT5jZV9wZXJfbGF5ZXJbZGltbS0+bWNpLT5uX2xheWVycy0x
XVtvZmZdOw0KKw0KKwljb3VudCA9IGRpbW0tPm1jaS0+Y2VfcGVyX2xheWVyW2RpbW0tPm1jaS0+
bl9sYXllcnMtMV1bZGltbS0+aWR4XTsNCiAJcmV0dXJuIHNwcmludGYoZGF0YSwgIiV1XG4iLCBj
b3VudCk7DQogfQ0KIA0KQEAgLTU3NSwxNCArNTY5LDggQEAgc3RhdGljIHNzaXplX3QgZGltbWRl
dl91ZV9jb3VudF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCiB7DQogCXN0cnVjdCBkaW1tX2lu
Zm8gKmRpbW0gPSB0b19kaW1tKGRldik7DQogCXUzMiBjb3VudDsNCi0JaW50IG9mZjsNCi0NCi0J
b2ZmID0gRURBQ19ESU1NX09GRihkaW1tLT5tY2ktPmxheWVycywNCi0JCQkgICAgZGltbS0+bWNp
LT5uX2xheWVycywNCi0JCQkgICAgZGltbS0+bG9jYXRpb25bMF0sDQotCQkJICAgIGRpbW0tPmxv
Y2F0aW9uWzFdLA0KLQkJCSAgICBkaW1tLT5sb2NhdGlvblsyXSk7DQotCWNvdW50ID0gZGltbS0+
bWNpLT51ZV9wZXJfbGF5ZXJbZGltbS0+bWNpLT5uX2xheWVycy0xXVtvZmZdOw0KKw0KKwljb3Vu
dCA9IGRpbW0tPm1jaS0+dWVfcGVyX2xheWVyW2RpbW0tPm1jaS0+bl9sYXllcnMtMV1bZGltbS0+
aWR4XTsNCiAJcmV0dXJuIHNwcmludGYoZGF0YSwgIiV1XG4iLCBjb3VudCk7DQogfQ0KIA0KZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZWRhYy5oIGIvaW5jbHVkZS9saW51eC9lZGFjLmgNCmlu
ZGV4IDEzNjdhM2ZjNTQ0Zi4uMmVlOWI4NTk4YWUwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51
eC9lZGFjLmgNCisrKyBiL2luY2x1ZGUvbGludXgvZWRhYy5oDQpAQCAtMzYyLDQ3ICszNjIsNiBA
QCBzdHJ1Y3QgZWRhY19tY19sYXllciB7DQogICovDQogI2RlZmluZSBFREFDX01BWF9MQVlFUlMJ
CTMNCiANCi0vKioNCi0gKiBFREFDX0RJTU1fT0ZGIC0gTWFjcm8gcmVzcG9uc2libGUgdG8gZ2V0
IGEgcG9pbnRlciBvZmZzZXQgaW5zaWRlIGEgcG9pbnRlcg0KLSAqCQkgICBhcnJheSBmb3IgdGhl
IGVsZW1lbnQgZ2l2ZW4gYnkgW2xheWVyMCxsYXllcjEsbGF5ZXIyXQ0KLSAqCQkgICBwb3NpdGlv
bg0KLSAqDQotICogQGxheWVyczoJYSBzdHJ1Y3QgZWRhY19tY19sYXllciBhcnJheSwgZGVzY3Jp
YmluZyBob3cgbWFueSBlbGVtZW50cw0KLSAqCQl3ZXJlIGFsbG9jYXRlZCBmb3IgZWFjaCBsYXll
cg0KLSAqIEBubGF5ZXJzOglOdW1iZXIgb2YgbGF5ZXJzIGF0IHRoZSBAbGF5ZXJzIGFycmF5DQot
ICogQGxheWVyMDoJbGF5ZXIwIHBvc2l0aW9uDQotICogQGxheWVyMToJbGF5ZXIxIHBvc2l0aW9u
LiBVbnVzZWQgaWYgbl9sYXllcnMgPCAyDQotICogQGxheWVyMjoJbGF5ZXIyIHBvc2l0aW9uLiBV
bnVzZWQgaWYgbl9sYXllcnMgPCAzDQotICoNCi0gKiBGb3IgMSBsYXllciwgdGhpcyBtYWNybyBy
ZXR1cm5zICJ2YXJbbGF5ZXIwXSAtIHZhciI7DQotICoNCi0gKiBGb3IgMiBsYXllcnMsIHRoaXMg
bWFjcm8gaXMgc2ltaWxhciB0byBhbGxvY2F0ZSBhIGJpLWRpbWVuc2lvbmFsIGFycmF5DQotICog
YW5kIHRvIHJldHVybiAidmFyW2xheWVyMF1bbGF5ZXIxXSAtIHZhciI7DQotICoNCi0gKiBGb3Ig
MyBsYXllcnMsIHRoaXMgbWFjcm8gaXMgc2ltaWxhciB0byBhbGxvY2F0ZSBhIHRyaS1kaW1lbnNp
b25hbCBhcnJheQ0KLSAqIGFuZCB0byByZXR1cm4gInZhcltsYXllcjBdW2xheWVyMV1bbGF5ZXIy
XSAtIHZhciIuDQotICoNCi0gKiBBIGxvb3AgY291bGQgYmUgdXNlZCBoZXJlIHRvIG1ha2UgaXQg
bW9yZSBnZW5lcmljLCBidXQsIGFzIHdlIG9ubHkgaGF2ZQ0KLSAqIDMgbGF5ZXJzLCB0aGlzIGlz
IGEgbGl0dGxlIGZhc3Rlci4NCi0gKg0KLSAqIEJ5IGRlc2lnbiwgbGF5ZXJzIGNhbiBuZXZlciBi
ZSAwIG9yIG1vcmUgdGhhbiAzLiBJZiB0aGF0IGV2ZXIgaGFwcGVucywNCi0gKiBhIE5VTEwgaXMg
cmV0dXJuZWQsIGNhdXNpbmcgYW4gT09QUyBkdXJpbmcgdGhlIG1lbW9yeSBhbGxvY2F0aW9uIHJv
dXRpbmUsDQotICogd2l0aCB3b3VsZCBwb2ludCB0byB0aGUgZGV2ZWxvcGVyIHRoYXQgaGUncyBk
b2luZyBzb21ldGhpbmcgd3JvbmcuDQotICovDQotI2RlZmluZSBFREFDX0RJTU1fT0ZGKGxheWVy
cywgbmxheWVycywgbGF5ZXIwLCBsYXllcjEsIGxheWVyMikgKHsJCVwNCi0JaW50IF9faTsJCQkJ
CQkJXA0KLQlpZiAoKG5sYXllcnMpID09IDEpCQkJCQkJXA0KLQkJX19pID0gbGF5ZXIwOwkJCQkJ
CVwNCi0JZWxzZSBpZiAoKG5sYXllcnMpID09IDIpCQkJCQlcDQotCQlfX2kgPSAobGF5ZXIxKSAr
ICgobGF5ZXJzWzFdKS5zaXplICogKGxheWVyMCkpOwkJXA0KLQllbHNlIGlmICgobmxheWVycykg
PT0gMykJCQkJCVwNCi0JCV9faSA9IChsYXllcjIpICsgKChsYXllcnNbMl0pLnNpemUgKiAoKGxh
eWVyMSkgKwlcDQotCQkJICAgICgobGF5ZXJzWzFdKS5zaXplICogKGxheWVyMCkpKSk7CQlcDQot
CWVsc2UJCQkJCQkJCVwNCi0JCV9faSA9IC1FSU5WQUw7CQkJCQkJXA0KLQlfX2k7CQkJCQkJCQlc
DQotfSkNCi0NCiBzdHJ1Y3QgZGltbV9pbmZvIHsNCiAJc3RydWN0IGRldmljZSBkZXY7DQogDQot
LSANCjIuMjAuMQ0KDQo=
