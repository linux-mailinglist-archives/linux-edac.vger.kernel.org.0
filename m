Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B571C3CD
	for <lists+linux-edac@lfdr.de>; Tue, 14 May 2019 09:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfENH0R (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 May 2019 03:26:17 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57802 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbfENH0R (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 May 2019 03:26:17 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4E7JlDQ029523;
        Tue, 14 May 2019 00:26:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=lJDALEBoXZOxu7jdHp+EtBTiZcrrDMVR/lTDNVXUQT4=;
 b=cOPqymd1+c6o0Cljb/Oqll7wTnYxu7OG8zriC+SyZ837jwMSUOwGcLL8zRfQcvkvM3ns
 E+iC6JikMjfGzJjrg/vLAxH9i/VAA8O/10r6skUea2a6aeBrQeXdH4/9ZlkJZsRyh2QM
 iN3hKknvjowlKcVHTwtfnkz/YOrDh3qkqrGJ7CVAUv+md9kt7M6olLo+85EBhfr0sNS4
 iZZXHUP+rSrwa1w/Gv8drTVuiw0kAGUFE7PnYdF8qgcVZJgO10oj8e7pR3ZGNpkRD64s
 WSVdYnDyQpH7bGgazF2dvgqvOUxKEYpE88iOkwXj1RmqngvtSnte+Yr0WPmNXc/1tzHG pQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sfppxgn9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 May 2019 00:26:03 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 14 May
 2019 00:26:02 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (104.47.34.50) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 14 May 2019 00:26:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJDALEBoXZOxu7jdHp+EtBTiZcrrDMVR/lTDNVXUQT4=;
 b=G5ztEwwUJcfqqvByQf0F8eb+wm36SXB2Nprn9RbBO/t0sRDojZHj/RKzDKNKE/M8/06tLOtFU5opgwYjcvwIbqH8QibxEyi0EzcVcEGih0jIFy6ocBLXhh65TFeGm7OjG6vWMPM+Bl40BqQuArb8X9vUMXb31FmfiWGIuXwz8nQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3360.namprd18.prod.outlook.com (10.255.238.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 14 May 2019 07:25:58 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7147:4fd1:1542:6b30]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7147:4fd1:1542:6b30%4]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 07:25:58 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
CC:     Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC, mc: Fix edac_mc_find() in case no device is found
Thread-Topic: [PATCH] EDAC, mc: Fix edac_mc_find() in case no device is found
Thread-Index: AQHVCiZGzxn6C4ySO0ahQavpHnPilw==
Date:   Tue, 14 May 2019 07:25:58 +0000
Message-ID: <20190514072514.312-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0017.eurprd05.prod.outlook.com
 (2603:10a6:209:1::30) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [78.54.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6d1849c-6e33-4b26-a006-08d6d83d6875
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR18MB3360;
x-ms-traffictypediagnostic: MN2PR18MB3360:
x-microsoft-antispam-prvs: <MN2PR18MB3360B74A60742BD0E9C9B967D9080@MN2PR18MB3360.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(199004)(189003)(26005)(68736007)(6512007)(36756003)(53936002)(54906003)(110136005)(6486002)(2906002)(316002)(6436002)(4326008)(8676002)(25786009)(50226002)(478600001)(14454004)(81156014)(81166006)(8936002)(52116002)(305945005)(66066001)(1076003)(186003)(6506007)(386003)(476003)(2616005)(99286004)(6116002)(3846002)(486006)(102836004)(5660300002)(66556008)(66946007)(64756008)(66476007)(73956011)(66446008)(4744005)(71200400001)(71190400001)(86362001)(256004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3360;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oLpryPEL+8c99J4xPKAYccuXG9ythC0RS+6iNCtrGznm0cngYXHKThBSoH8UQXgoeFW4tTpSBY34eyOPGmjdrC1lcp+aEk1WkTazVoCSwCmH28khnhmlkwM+LaN0widMF680GMzj2RemjTSLfFB2Cv9J++RLSyP4tmsEnhPI8pNHbhlrTjtmL5VI5jTuGuUzeKDSo5/W8knXDhhTaLcS7FOu3Jine4pc4Gk3xrz/1om9+COc/xlE0TH258IemlGwCjXSWlzr7TMLuKWBvFIfW8V4BgXxE8Yo2KMqORi0gLyjSBqOSxz6z2XQXqFlIgjyxfavYxo6thGiNkx/CUuMfejGNJwBLWD9908xegogMsNGZ2AHM4JS+URnEFbY+lNHYDgunvi1Cs2632DEiN4henI+0lxaWBO/IU9insJ9T4Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d1849c-6e33-4b26-a006-08d6d83d6875
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 07:25:58.1140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3360
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_04:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

VGhlIGZ1bmN0aW9uIHNob3VsZCByZXR1cm4gTlVMTCBpbiBjYXNlIG5vIGRldmljZSBpcyBmb3Vu
ZCwgYnV0IGl0DQphbHdheXMgcmV0dXJucyB0aGUgbGFzdCBjaGVja2VkIG1jIGRldmljZSBmcm9t
IHRoZSBsaXN0IGV2ZW4gaWYgdGhlDQppbmRleCBkaWQgbm90IG1hdGNoLiBUaGlzIHBhdGNoIGZp
eGVzIHRoaXMuDQoNCkkgZGlkIHNvbWUgYW5hbHlzaXMgd2h5IHRoaXMgZGlkIG5vdCByYWlzZSBh
bnkgaXNzdWVzIGZvciBhYm91dCAzDQp5ZWFycyBhbmQgdGhlIHJlYXNvbiBpcyB0aGF0IGVkYWNf
bWNfZmluZCgpIGlzIG1vc3RseSB1c2VkIHRvIHNlYXJjaA0KZm9yIGV4aXN0aW5nIGRldmljZXMu
IFRodXMsIHRoZSBidWcgaXMgbm90IHRyaWdnZXJlZC4NCg0KRml4ZXM6IGM3M2U4ODMzYmVjNSAo
IkVEQUMsIG1jOiBGaXggbG9ja2luZyBhcm91bmQgbWNfZGV2aWNlcyBsaXN0IikNClNpZ25lZC1v
ZmYtYnk6IFJvYmVydCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvZWRhYy9lZGFjX21jLmMgfCA3ICsrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2VkYWNf
bWMuYyBiL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMNCmluZGV4IDEzNTk0ZmZhZGNiMy4uYWVlYWFm
MzBiMzhhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KKysrIGIvZHJpdmVy
cy9lZGFjL2VkYWNfbWMuYw0KQEAgLTY4OCwxMCArNjg4LDkgQEAgc3RydWN0IG1lbV9jdGxfaW5m
byAqZWRhY19tY19maW5kKGludCBpZHgpDQogCQltY2kgPSBsaXN0X2VudHJ5KGl0ZW0sIHN0cnVj
dCBtZW1fY3RsX2luZm8sIGxpbmspOw0KIA0KIAkJaWYgKG1jaS0+bWNfaWR4ID49IGlkeCkgew0K
LQkJCWlmIChtY2ktPm1jX2lkeCA9PSBpZHgpIHsNCi0JCQkJZ290byB1bmxvY2s7DQotCQkJfQ0K
LQkJCWJyZWFrOw0KKwkJCWlmIChtY2ktPm1jX2lkeCAhPSBpZHgpDQorCQkJCW1jaSA9IE5VTEw7
DQorCQkJZ290byB1bmxvY2s7DQogCQl9DQogCX0NCiANCi0tIA0KMi4yMC4xDQoNCg==
