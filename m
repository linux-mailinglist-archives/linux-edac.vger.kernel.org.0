Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CADA2D7FB
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfE2IoX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:44:23 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49450 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbfE2IoX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:23 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8dpBD017806;
        Wed, 29 May 2019 01:44:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=mLfng0e04lqD7OGwg2f9KyJsz6RBe7YwlynIHDYFLB8=;
 b=tGg5iKY+E8nTgirdSAWe6TXvRVIVMEBZ4LZv6ZG8D5QhZNU7woRcPMfDg0eY2J8wokJY
 LsVn0le9HRvccpuA4zCMHX1vcm+YRYv+qxlO1YyGDhBuJfYwr4mhc0EBzy28qDcenJ4i
 YJt3PcJ3Ub4u77lV8jtNDgtBhYVWe4vEPW+9RJrNgAiD/3c/gprH1k/Ra56tA8j0cqW/
 ADVDLD9sX4iGhXqIgOnv6O/liIWOFGx1H6Yuw+o9kD7i4hbViPTHsL6ZhwEhaZOlCL8w
 qiVscm9ooDrWCo3Pw8w6xQXwp96GCVx2w6YbIp//HQaabR8GCFdesoV82ZYGZGbsyhbp EQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sskp88p3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:09 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:07 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.53) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLfng0e04lqD7OGwg2f9KyJsz6RBe7YwlynIHDYFLB8=;
 b=IREQKL5BL0tcYNgbian3w+Emmn6D1KW2szzmQIRXncD5eZ9pz3kWTbrPfXhgsf4AA9K18wpgFpY0aBP9DVTjIsfkiU7PsbQu5SJGEh8X0yEQPNMjjjayN4Vy+nyWRg62q39rCiyDy9NPbXIVafbGFQLf5qmex0cx5Fm9QP92XOM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:04 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:04 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 01/21] EDAC, mc: Fix edac_mc_find() in case no device is found
Thread-Topic: [PATCH 01/21] EDAC, mc: Fix edac_mc_find() in case no device is
 found
Thread-Index: AQHVFfqrQ8tilup7g0mWUbmqRMwOlw==
Date:   Wed, 29 May 2019 08:44:03 +0000
Message-ID: <20190529084344.28562-2-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: ca3f281f-db7b-4160-6ec9-08d6e411cd51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB343774554E7C99AA96243C42D91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(14444005)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TTpPqP9c+BjDwGAftqAxjwosStakAdzNeHv8CwYMsfabjU6fxIIeUMsUL7M5a0ZxBEK27Xw/yCRAFOP4gWSuxBNGwO5VUUumritp09YTSpDo34BbxZ+cdp6EwYPkmNi5QVc7QAlD87mRj3nM9DVQfZgSRsxWbxp295Brsi9HROuOZ0GKtpTYNf/IjhbC+JXXkzKKNOwOgYJggxVkK7ZmKAvzuy+p63beKDtAU0sgdrGGh3fCVatVv+sRF9kNI0tUjOQ0fee4zPEJFObYUmz/PTvFcz7jbao2MyytZ/saaLKQan7hEDYG61/eiqBrrH4o/MUVRTeTY/rAUfQctXVX/8WaKpG1pnDAM/qk9e92LnH81R6w7PRmPE2twVx73iJ0tcnUmeZ+TJaAHtjin1knztDY5EExc/R98DBMxftE3XY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3f281f-db7b-4160-6ec9-08d6e411cd51
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:03.8523
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

VGhlIGZ1bmN0aW9uIHNob3VsZCByZXR1cm4gTlVMTCBpbiBjYXNlIG5vIGRldmljZSBpcyBmb3Vu
ZCwgYnV0IGl0DQphbHdheXMgcmV0dXJucyB0aGUgbGFzdCBjaGVja2VkIG1jIGRldmljZSBmcm9t
IHRoZSBsaXN0IGV2ZW4gaWYgdGhlDQppbmRleCBkaWQgbm90IG1hdGNoLiBUaGlzIHBhdGNoIGZp
eGVzIHRoaXMuDQoNCkkgZGlkIHNvbWUgYW5hbHlzaXMgd2h5IHRoaXMgZGlkIG5vdCByYWlzZSBh
bnkgaXNzdWVzIGZvciBhYm91dCAzDQp5ZWFycyBhbmQgdGhlIHJlYXNvbiBpcyB0aGF0IGVkYWNf
bWNfZmluZCgpIGlzIG1vc3RseSB1c2VkIHRvIHNlYXJjaA0KZm9yIGV4aXN0aW5nIGRldmljZXMu
IFRodXMsIHRoZSBidWcgaXMgbm90IHRyaWdnZXJlZC4NCg0KRml4ZXM6IGM3M2U4ODMzYmVjNSAo
IkVEQUMsIG1jOiBGaXggbG9ja2luZyBhcm91bmQgbWNfZGV2aWNlcyBsaXN0IikNClNpZ25lZC1v
ZmYtYnk6IFJvYmVydCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvZWRhYy9lZGFjX21jLmMgfCAxMiArKysrLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFj
L2VkYWNfbWMuYyBiL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMNCmluZGV4IDEzNTk0ZmZhZGNiMy4u
NjQ5MjJjOGZhN2UzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KKysrIGIv
ZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KQEAgLTY3OSwyMiArNjc5LDE4IEBAIHN0YXRpYyBpbnQg
ZGVsX21jX2Zyb21fZ2xvYmFsX2xpc3Qoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpKQ0KIA0KIHN0
cnVjdCBtZW1fY3RsX2luZm8gKmVkYWNfbWNfZmluZChpbnQgaWR4KQ0KIHsNCi0Jc3RydWN0IG1l
bV9jdGxfaW5mbyAqbWNpID0gTlVMTDsNCisJc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpOw0KIAlz
dHJ1Y3QgbGlzdF9oZWFkICppdGVtOw0KIA0KIAltdXRleF9sb2NrKCZtZW1fY3Rsc19tdXRleCk7
DQogDQogCWxpc3RfZm9yX2VhY2goaXRlbSwgJm1jX2RldmljZXMpIHsNCiAJCW1jaSA9IGxpc3Rf
ZW50cnkoaXRlbSwgc3RydWN0IG1lbV9jdGxfaW5mbywgbGluayk7DQotDQotCQlpZiAobWNpLT5t
Y19pZHggPj0gaWR4KSB7DQotCQkJaWYgKG1jaS0+bWNfaWR4ID09IGlkeCkgew0KLQkJCQlnb3Rv
IHVubG9jazsNCi0JCQl9DQotCQkJYnJlYWs7DQotCQl9DQorCQlpZiAobWNpLT5tY19pZHggPT0g
aWR4KQ0KKwkJCWdvdG8gdW5sb2NrOw0KIAl9DQogDQorCW1jaSA9IE5VTEw7DQogdW5sb2NrOg0K
IAltdXRleF91bmxvY2soJm1lbV9jdGxzX211dGV4KTsNCiAJcmV0dXJuIG1jaTsNCi0tIA0KMi4y
MC4xDQoNCg==
