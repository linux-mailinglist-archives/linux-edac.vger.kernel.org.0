Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9399750FC2
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfFXPJX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:23 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:17790 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729578AbfFXPJX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:23 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF0N6l018740;
        Mon, 24 Jun 2019 08:09:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Y292rx7edbDtONNI7C9W/pDUNiNqgVRhbZOsl62+7B8=;
 b=zQD1vLe4Trqq3eb77ACOAMbrvrzLJ/mdQ4iogzIDOvwaQCCiCFuicdp882g7aRhsNA/U
 fv5I+4QdTd05pQnSH5MjtIVmcz+lokx/7dSnJRRBVkN46Kk0cFue84oqhvTOFgW0tSJG
 E3pFXre728kr2R2Xaqp3wXe9xpX7NehBgiqUtv+JXQsXFUcB8qFFD2fDDgDRSdMBB4jH
 UYSPh7pDvS5JPS1jwYwEbyJ6Kc8DKAjPhtRWxavt9XnMd15pK/4Dr+Z81RaaUFVdiu/w
 gNdPeMYcK6EjJ1/kqlDPtPPIR4aAIN4xAEHNA1KXM5qaGw3s30OEElFiZx/gmZZ0oksT LA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tarxr9ta1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:15 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:14 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.53) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y292rx7edbDtONNI7C9W/pDUNiNqgVRhbZOsl62+7B8=;
 b=RKZ1nRpAouOmi9yAJQ/zvBmn39g+7I5CWPRt8Hq3tGuX6lfb0jjjn3d9p9IKL5LggHp+YzP1foXSL1kUfBZcnsjgBqh7JXfYdhlm98PRiRpJedDluu3tgl8X0GDiGDU2lEYFJiNk0Ra4m3IMJ0WlkPJk+JJV0ZG78kw/rS/ej+g=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2589.namprd18.prod.outlook.com (20.179.82.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 15:09:13 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:13 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 09/24] EDAC, mc: Cleanup _edac_mc_free() code
Thread-Topic: [PATCH v2 09/24] EDAC, mc: Cleanup _edac_mc_free() code
Thread-Index: AQHVKp7Isx66NqK27UO6ldD/Ux6kpw==
Date:   Mon, 24 Jun 2019 15:09:13 +0000
Message-ID: <20190624150758.6695-10-rrichter@marvell.com>
References: <20190624150758.6695-1-rrichter@marvell.com>
In-Reply-To: <20190624150758.6695-1-rrichter@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0035.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::24)
 To MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:16c::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [92.254.182.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9a039d0-0f6a-4ec2-fe51-08d6f8b5eac6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2589;
x-ms-traffictypediagnostic: MN2PR18MB2589:
x-microsoft-antispam-prvs: <MN2PR18MB258985F9D45DBA3D11D186C2D9E00@MN2PR18MB2589.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(2906002)(2616005)(486006)(476003)(52116002)(256004)(5660300002)(66446008)(73956011)(66946007)(1076003)(14454004)(6116002)(86362001)(3846002)(99286004)(6486002)(68736007)(81166006)(81156014)(6436002)(4326008)(305945005)(50226002)(53936002)(7736002)(8676002)(8936002)(478600001)(64756008)(66556008)(66476007)(6512007)(107886003)(71190400001)(71200400001)(36756003)(26005)(102836004)(386003)(186003)(11346002)(76176011)(6506007)(110136005)(316002)(54906003)(446003)(25786009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2589;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jkDw62OY23uBhDRjNp91MVXJCRJwfehuekgVp9eBCG003v9b1vLLKQBoiFyHM6TwdcRR2ofyjkUTCTOsouTgJNJz4rpfg0IkfRr5vE2nkcpDEEEGhJMxEwCkAXqk1PcHBm1gp7Lvc42aZPeDwqEFEWbiqiijrCBaJbagNb5kSlNQTga6/K2Y6JX4ETnG98i8ank6XgCFWr78FtGWNGAXSWXMDigPHOcUlX5s0xPIRmxk+WN6hvaNjbT6CXBuUtUsvW8ckyzwm+4JxWjNwTxpQj9MduW6xLIfxRpU9a/RJGq/OsIimhXYI12eUKIxN595UMc+/GtHlydemNWchBzD40XnJ2Tb0OsLwiYpZBtM53cMQL4veNSEez7svhgTgddeRYNgf4L3wko5n6KLbRnsIilxPijJt2UZfn1d9N3pdc8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a039d0-0f6a-4ec2-fe51-08d6f8b5eac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:13.3951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2589
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

UmVtb3ZlIG5lZWRsZXNzIGFuZCBib2lsZXJwbGF0ZSB2YXJpYWJsZSBkZWNsYXJhdGlvbnMuIE5v
IGZ1bmN0aW9uYWwNCmNoYW5nZXMuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmVydCBSaWNodGVyIDxy
cmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZWRhYy9lZGFjX21jLmMgfCAyMSAr
KysrKysrKystLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMgYi9k
cml2ZXJzL2VkYWMvZWRhY19tYy5jDQppbmRleCAyNzI3N2NhNDZhYjMuLmYyYWNkYWIzNGViNyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMNCisrKyBiL2RyaXZlcnMvZWRhYy9l
ZGFjX21jLmMNCkBAIC0yODAsMjYgKzI4MCwyMyBAQCBzdGF0aWMgdm9pZCBfZWRhY19tY19mcmVl
KHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSkNCiB7DQogCWludCBpLCBjaG4sIHJvdzsNCiAJc3Ry
dWN0IGNzcm93X2luZm8gKmNzcjsNCi0JY29uc3QgdW5zaWduZWQgaW50IHRvdF9kaW1tcyA9IG1j
aS0+dG90X2RpbW1zOw0KLQljb25zdCB1bnNpZ25lZCBpbnQgdG90X2NoYW5uZWxzID0gbWNpLT5u
dW1fY3NjaGFubmVsOw0KLQljb25zdCB1bnNpZ25lZCBpbnQgdG90X2Nzcm93cyA9IG1jaS0+bnJf
Y3Nyb3dzOw0KIA0KIAlpZiAobWNpLT5kaW1tcykgew0KLQkJZm9yIChpID0gMDsgaSA8IHRvdF9k
aW1tczsgaSsrKQ0KKwkJZm9yIChpID0gMDsgaSA8IG1jaS0+dG90X2RpbW1zOyBpKyspDQogCQkJ
a2ZyZWUobWNpLT5kaW1tc1tpXSk7DQogCQlrZnJlZShtY2ktPmRpbW1zKTsNCiAJfQ0KIAlpZiAo
bWNpLT5jc3Jvd3MpIHsNCi0JCWZvciAocm93ID0gMDsgcm93IDwgdG90X2Nzcm93czsgcm93Kysp
IHsNCisJCWZvciAocm93ID0gMDsgcm93IDwgbWNpLT5ucl9jc3Jvd3M7IHJvdysrKSB7DQogCQkJ
Y3NyID0gbWNpLT5jc3Jvd3Nbcm93XTsNCi0JCQlpZiAoY3NyKSB7DQotCQkJCWlmIChjc3ItPmNo
YW5uZWxzKSB7DQotCQkJCQlmb3IgKGNobiA9IDA7IGNobiA8IHRvdF9jaGFubmVsczsgY2huKysp
DQotCQkJCQkJa2ZyZWUoY3NyLT5jaGFubmVsc1tjaG5dKTsNCi0JCQkJCWtmcmVlKGNzci0+Y2hh
bm5lbHMpOw0KLQkJCQl9DQotCQkJCWtmcmVlKGNzcik7DQorCQkJaWYgKCFjc3IpDQorCQkJCWNv
bnRpbnVlOw0KKwkJCWlmIChjc3ItPmNoYW5uZWxzKSB7DQorCQkJCWZvciAoY2huID0gMDsgY2hu
IDwgbWNpLT5udW1fY3NjaGFubmVsOyBjaG4rKykNCisJCQkJCWtmcmVlKGNzci0+Y2hhbm5lbHNb
Y2huXSk7DQorCQkJCWtmcmVlKGNzci0+Y2hhbm5lbHMpOw0KIAkJCX0NCisJCQlrZnJlZShjc3Ip
Ow0KIAkJfQ0KIAkJa2ZyZWUobWNpLT5jc3Jvd3MpOw0KIAl9DQotLSANCjIuMjAuMQ0KDQo=
