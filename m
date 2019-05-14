Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118381C739
	for <lists+linux-edac@lfdr.de>; Tue, 14 May 2019 12:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfENKtY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 14 May 2019 06:49:24 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49946 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbfENKtY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 14 May 2019 06:49:24 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EAiV4F005903;
        Tue, 14 May 2019 03:49:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=Rg6MXqva/u54PKsPFhJCWi1wvx8DobFjs6n97uiobds=;
 b=DzOCZYswUY/RZLJHTO09o9vWui2wI33TSJ+MYAPcy7JBVORsh0tnDRZ7Xn3sPf1U5xJQ
 Vz4QueMJpR80lcCqpZ/wPJJDUBGtPc5suM6EZJdA3jPweZsZIP7BVK0E9WnI3kbuvGMV
 DYy3U20MHqZhPjJnhE1xDhOoY1ImaEJ8pVP6YdsPMF6lhRZFRb8DgRTwOmQDoY9aOHe2
 7VjFIRR+hQKjb/WLS8lj/ddI0lO1DcBWy/pfX42pQE3+4ME0GsSoHk0mlDATZc6UWhj2
 eqRD7fawmbZDgnAaq1/Y+OFM9NCmva05+NsU0uMFmV6Q4ngd7v2eKpUUH5kucQ4kBpEX mw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sfmjxhvur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 May 2019 03:49:14 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 14 May
 2019 03:49:13 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 14 May 2019 03:49:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg6MXqva/u54PKsPFhJCWi1wvx8DobFjs6n97uiobds=;
 b=D4NfohFdrndf+sGQWfjdrB5GFMIorVEBpix01juosJ2peKBsO6KtkVR5w7q6fA4mleNWXGOzaHzmPlZySjaVc2Pr1+EMBlTXctGmRYvzt0KKxXYCYhKo3TJx+wGxX/uAi4bfDaVjocS0lwUg9UIKCPCPf4qY1Qc05Ib89mn/3AM=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3087.namprd18.prod.outlook.com (20.179.20.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Tue, 14 May 2019 10:49:09 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7147:4fd1:1542:6b30]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7147:4fd1:1542:6b30%4]) with mapi id 15.20.1878.024; Tue, 14 May 2019
 10:49:09 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
CC:     Robert Richter <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] EDAC, mc: Fix edac_mc_find() in case no device is found
Thread-Topic: [PATCH v2] EDAC, mc: Fix edac_mc_find() in case no device is
 found
Thread-Index: AQHVCkKo5PKK2ZFcyECIGexDLr7k0A==
Date:   Tue, 14 May 2019 10:49:09 +0000
Message-ID: <20190514104838.15065-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:203:90::24) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [78.54.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 321b8527-e652-4dd0-e3d4-08d6d859cad6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR18MB3087;
x-ms-traffictypediagnostic: MN2PR18MB3087:
x-microsoft-antispam-prvs: <MN2PR18MB308706F46D27E4C667CF99AAD9080@MN2PR18MB3087.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0037FD6480
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39860400002)(366004)(346002)(189003)(199004)(54906003)(2906002)(86362001)(66066001)(6486002)(99286004)(6436002)(71200400001)(110136005)(14454004)(71190400001)(3846002)(6116002)(102836004)(478600001)(6506007)(386003)(52116002)(53936002)(26005)(25786009)(8936002)(316002)(14444005)(256004)(305945005)(7736002)(66556008)(66476007)(81166006)(64756008)(66446008)(66946007)(50226002)(73956011)(81156014)(36756003)(8676002)(486006)(186003)(5660300002)(6512007)(1076003)(4326008)(476003)(2616005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3087;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yCzXOkiteNPU60UgMe9lienWgyOecyUk2FdumiweKk+8SM/pneGu+pjU+wBYCd10djUTkiSEpRFBrdvRcU+Vyvbq0IY+V4hBZz4acr3XtlSG2++RF3Szw0tIlscMl3p63n3TGhMk1zzRoXDyn0EUgeT8fuFN4eVcdw2vJpHl49e75+cj85F5GhqNhQIOt71m3saGA5OB2HvqgcFor2zkpefRoBCKtMALMxTof4ZrGdGFQ8dE20wGz1fdmkpiZOPbqob6XGLKl7jx3QjTgGJWoUk1+t35sJKjWqphCJMuaZZinn5asT/Xm2HR8ffQIuAovNUAsde3bMt5L0ltS3dwBEtY4MIl1Mhm9GfeUBBdc5qDGSGDaTRNWRfcNUYnf1XmVeUmZTiqIPkf3j3Tv1YsQyGo+fjz4v/tjmo6pmMrvoA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 321b8527-e652-4dd0-e3d4-08d6d859cad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2019 10:49:09.1237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3087
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_06:,,
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
cnMvZWRhYy9lZGFjX21jLmMgfCAxMiArKysrKy0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFj
L2VkYWNfbWMuYyBiL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMNCmluZGV4IDEzNTk0ZmZhZGNiMy4u
NjE0ZDRjMTBiMzM3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KKysrIGIv
ZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KQEAgLTY3OSwyMiArNjc5LDIwIEBAIHN0YXRpYyBpbnQg
ZGVsX21jX2Zyb21fZ2xvYmFsX2xpc3Qoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpKQ0KIA0KIHN0
cnVjdCBtZW1fY3RsX2luZm8gKmVkYWNfbWNfZmluZChpbnQgaWR4KQ0KIHsNCi0Jc3RydWN0IG1l
bV9jdGxfaW5mbyAqbWNpID0gTlVMTDsNCisJc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpOw0KIAlz
dHJ1Y3QgbGlzdF9oZWFkICppdGVtOw0KIA0KIAltdXRleF9sb2NrKCZtZW1fY3Rsc19tdXRleCk7
DQogDQogCWxpc3RfZm9yX2VhY2goaXRlbSwgJm1jX2RldmljZXMpIHsNCiAJCW1jaSA9IGxpc3Rf
ZW50cnkoaXRlbSwgc3RydWN0IG1lbV9jdGxfaW5mbywgbGluayk7DQotDQotCQlpZiAobWNpLT5t
Y19pZHggPj0gaWR4KSB7DQotCQkJaWYgKG1jaS0+bWNfaWR4ID09IGlkeCkgew0KLQkJCQlnb3Rv
IHVubG9jazsNCi0JCQl9DQorCQlpZiAobWNpLT5tY19pZHggPT0gaWR4KQ0KKwkJCWdvdG8gdW5s
b2NrOw0KKwkJaWYgKG1jaS0+bWNfaWR4ID4gaWR4KQ0KIAkJCWJyZWFrOw0KLQkJfQ0KIAl9DQog
DQorCW1jaSA9IE5VTEw7DQogdW5sb2NrOg0KIAltdXRleF91bmxvY2soJm1lbV9jdGxzX211dGV4
KTsNCiAJcmV0dXJuIG1jaTsNCi0tIA0KMi4yMC4xDQoNCg==
