Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 000592D827
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfE2Ipx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:45:53 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35312 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725888AbfE2Io0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:26 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8eGJr022570;
        Wed, 29 May 2019 01:44:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=lQoZq7loVV5pKhsOJFBMbaakQmiE1B08uig6ldsAt6M=;
 b=qFaeIO0/2YcH4AQe77VJHrIjl8IMjqz42/5m3lO7w76a4M4h1cXcvo8JCd1HNM7WXYE9
 8E8317C6LOlk+HLBjmfHnsUkyNahNOd0O82sgPqXgyy4ZZRcM6tGZP5/pBndLxestw8i
 3ZwruiQrTf9BkHxGPAcA2lCsSG/lIPZSDCOL3gfe/P6CCyTZSzp81BLUtFTOhufJPMLc
 XQdsLbXxCde+vY94C/KQvKp/0vkiLIi3jb5LDs3NAIfKKyC30MfI7AFTcm8iQHQ5vz5O
 qDenoHAOGVuo5QNigh8vVyPXm59G1uyaW1eiObuvXUUHYk04+LaoQddFV8GryfuTYx5D Yg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sspkpg1ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:09 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:08 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.53) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQoZq7loVV5pKhsOJFBMbaakQmiE1B08uig6ldsAt6M=;
 b=nYyzid2i8u/dH7Mba8PO+2esypbKTHo8SyeYs4hsvT+GSbWdo+dsZHYb4PPo8vjOBUsbR+joz2G0U0I7UypXYscJ3jExMyXqVNqCL1e/0c6EnHScUrRKxrWvLlJqixtU9pKgEP+wZoNDi0Mdo6Xox0iWSok4MELer5rgMTsVA1k=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:05 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:05 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 02/21] EDAC: Fixes to use put_device() after device_add()
 errors
Thread-Topic: [PATCH 02/21] EDAC: Fixes to use put_device() after device_add()
 errors
Thread-Index: AQHVFfqscON641zZekePQqJCvaQr+Q==
Date:   Wed, 29 May 2019 08:44:05 +0000
Message-ID: <20190529084344.28562-3-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: ff4239af-1494-4fd7-a0a2-08d6e411ceda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB34373B86CDD8F5BDBBAC98F5D91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:78;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(14444005)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bQRXuxXA9tqwgHThqmWOYDPJiRxEPf7MYMootEWS/hFcgnw8btZg1ow57taOHsiEY2AYKgZyToEz39kiAXGOZOfiGvFF9fiZuHdglX1dIswwZKNuG+0I/2lIY/UgZEpPaqrFOKL7c0wNvd5ryBhE0DJtZAxHmKubSqNcg3jgmlybB+QkpceXlHpWVSCKxzVbJKLl83t9q5T8rhWN4SE4ghc1y1I78KdqsvIC5uEKiFk7AU6v80ygOTJOvNv0IJth7TOFjl1fjHoSo1WXtjQCX6eTeJ4Uwxd8Z95LWGQwijpzGD69k8dhK9cMuz5HbemEdaON8Qn2bBEtS18Cq0OH69CeRgliUdtbFZSWbUeLEpfUuhbEYv+B58jZ6WirUJHRsLV7yUJpt7WqXRm1PkjfnptQOs9+A6uiOx/b8PvFKW0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4239af-1494-4fd7-a0a2-08d6e411ceda
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:05.8207
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

QWx3YXlzIHVzZSBwdXRfZGV2aWNlKCkgYWZ0ZXIgZGV2aWNlX2FkZCgpIGZhaWxlZC4NCg0KU2ln
bmVkLW9mZi1ieTogUm9iZXJ0IFJpY2h0ZXIgPHJyaWNodGVyQG1hcnZlbGwuY29tPg0KLS0tDQog
ZHJpdmVycy9lZGFjL2VkYWNfbWNfc3lzZnMuYyB8IDM2ICsrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxNyBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9lZGFjX21jX3N5c2ZzLmMgYi9k
cml2ZXJzL2VkYWMvZWRhY19tY19zeXNmcy5jDQppbmRleCA0NjQxNzQ2ODU1ODkuLmRiZWY2OTkx
NjJhOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9lZGFjX21jX3N5c2ZzLmMNCisrKyBiL2Ry
aXZlcnMvZWRhYy9lZGFjX21jX3N5c2ZzLmMNCkBAIC00MDQsNiArNDA0LDggQEAgc3RhdGljIGlu
bGluZSBpbnQgbnJfcGFnZXNfcGVyX2Nzcm93KHN0cnVjdCBjc3Jvd19pbmZvICpjc3JvdykNCiBz
dGF0aWMgaW50IGVkYWNfY3JlYXRlX2Nzcm93X29iamVjdChzdHJ1Y3QgbWVtX2N0bF9pbmZvICpt
Y2ksDQogCQkJCSAgICBzdHJ1Y3QgY3Nyb3dfaW5mbyAqY3Nyb3csIGludCBpbmRleCkNCiB7DQor
CWludCBlcnI7DQorDQogCWNzcm93LT5kZXYudHlwZSA9ICZjc3Jvd19hdHRyX3R5cGU7DQogCWNz
cm93LT5kZXYuZ3JvdXBzID0gY3Nyb3dfZGV2X2dyb3VwczsNCiAJZGV2aWNlX2luaXRpYWxpemUo
JmNzcm93LT5kZXYpOw0KQEAgLTQxNSw3ICs0MTcsMTEgQEAgc3RhdGljIGludCBlZGFjX2NyZWF0
ZV9jc3Jvd19vYmplY3Qoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KIAllZGFjX2RiZygwLCAi
Y3JlYXRpbmcgKHZpcnR1YWwpIGNzcm93IG5vZGUgJXNcbiIsDQogCQkgZGV2X25hbWUoJmNzcm93
LT5kZXYpKTsNCiANCi0JcmV0dXJuIGRldmljZV9hZGQoJmNzcm93LT5kZXYpOw0KKwllcnIgPSBk
ZXZpY2VfYWRkKCZjc3Jvdy0+ZGV2KTsNCisJaWYgKGVycikNCisJCXB1dF9kZXZpY2UoJmNzcm93
LT5kZXYpOw0KKw0KKwlyZXR1cm4gZXJyOw0KIH0NCiANCiAvKiBDcmVhdGUgYSBDU1JPVyBvYmpl
Y3QgdW5kZXIgc3BlY2lmZWQgZWRhY19tY19kZXZpY2UgKi8NCkBAIC02NDYsOCArNjUyLDExIEBA
IHN0YXRpYyBpbnQgZWRhY19jcmVhdGVfZGltbV9vYmplY3Qoc3RydWN0IG1lbV9jdGxfaW5mbyAq
bWNpLA0KIAlwbV9ydW50aW1lX2ZvcmJpZCgmbWNpLT5kZXYpOw0KIA0KIAllcnIgPSAgZGV2aWNl
X2FkZCgmZGltbS0+ZGV2KTsNCi0NCi0JZWRhY19kYmcoMCwgImNyZWF0aW5nIHJhbmsvZGltbSBk
ZXZpY2UgJXNcbiIsIGRldl9uYW1lKCZkaW1tLT5kZXYpKTsNCisJaWYgKGVycikNCisJCXB1dF9k
ZXZpY2UoJmRpbW0tPmRldik7DQorCWVsc2UNCisJCWVkYWNfZGJnKDAsICJjcmVhdGluZyByYW5r
L2RpbW0gZGV2aWNlICVzXG4iLA0KKwkJCWRldl9uYW1lKCZkaW1tLT5kZXYpKTsNCiANCiAJcmV0
dXJuIGVycjsNCiB9DQpAQCAtOTI3LDggKzkzNiw5IEBAIGludCBlZGFjX2NyZWF0ZV9zeXNmc19t
Y2lfZGV2aWNlKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCiAJZWRhY19kYmcoMCwgImNyZWF0
aW5nIGRldmljZSAlc1xuIiwgZGV2X25hbWUoJm1jaS0+ZGV2KSk7DQogCWVyciA9IGRldmljZV9h
ZGQoJm1jaS0+ZGV2KTsNCiAJaWYgKGVyciA8IDApIHsNCisJCXB1dF9kZXZpY2UoJm1jaS0+ZGV2
KTsNCiAJCWVkYWNfZGJnKDEsICJmYWlsdXJlOiBjcmVhdGUgZGV2aWNlICVzXG4iLCBkZXZfbmFt
ZSgmbWNpLT5kZXYpKTsNCi0JCWdvdG8gb3V0Ow0KKwkJcmV0dXJuIGVycjsNCiAJfQ0KIA0KIAkv
Kg0KQEAgLTk3Nyw3ICs5ODcsNiBAQCBpbnQgZWRhY19jcmVhdGVfc3lzZnNfbWNpX2RldmljZShz
dHJ1Y3QgbWVtX2N0bF9pbmZvICptY2ksDQogCX0NCiAJZGV2aWNlX3VucmVnaXN0ZXIoJm1jaS0+
ZGV2KTsNCiANCi1vdXQ6DQogCXJldHVybiBlcnI7DQogfQ0KIA0KQEAgLTEwMzQsMTAgKzEwNDMs
OCBAQCBpbnQgX19pbml0IGVkYWNfbWNfc3lzZnNfaW5pdCh2b2lkKQ0KIAlpbnQgZXJyOw0KIA0K
IAltY2lfcGRldiA9IGt6YWxsb2Moc2l6ZW9mKCptY2lfcGRldiksIEdGUF9LRVJORUwpOw0KLQlp
ZiAoIW1jaV9wZGV2KSB7DQotCQllcnIgPSAtRU5PTUVNOw0KLQkJZ290byBvdXQ7DQotCX0NCisJ
aWYgKCFtY2lfcGRldikNCisJCXJldHVybiAtRU5PTUVNOw0KIA0KIAltY2lfcGRldi0+YnVzID0g
ZWRhY19nZXRfc3lzZnNfc3Vic3lzKCk7DQogCW1jaV9wZGV2LT50eXBlID0gJm1jX2F0dHJfdHlw
ZTsNCkBAIC0xMDQ2LDE1ICsxMDUzLDEwIEBAIGludCBfX2luaXQgZWRhY19tY19zeXNmc19pbml0
KHZvaWQpDQogDQogCWVyciA9IGRldmljZV9hZGQobWNpX3BkZXYpOw0KIAlpZiAoZXJyIDwgMCkN
Ci0JCWdvdG8gb3V0X3B1dF9kZXZpY2U7DQotDQotCWVkYWNfZGJnKDAsICJkZXZpY2UgJXMgY3Jl
YXRlZFxuIiwgZGV2X25hbWUobWNpX3BkZXYpKTsNCi0NCi0JcmV0dXJuIDA7DQorCQlwdXRfZGV2
aWNlKG1jaV9wZGV2KTsNCisJZWxzZQ0KKwkJZWRhY19kYmcoMCwgImRldmljZSAlcyBjcmVhdGVk
XG4iLCBkZXZfbmFtZShtY2lfcGRldikpOw0KIA0KLSBvdXRfcHV0X2RldmljZToNCi0JcHV0X2Rl
dmljZShtY2lfcGRldik7DQotIG91dDoNCiAJcmV0dXJuIGVycjsNCiB9DQogDQotLSANCjIuMjAu
MQ0KDQo=
