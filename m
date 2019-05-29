Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967962D804
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfE2Ioi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:44:38 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35388 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726599AbfE2Ioi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:38 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8fJFb023313;
        Wed, 29 May 2019 01:44:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=D+Hh1I02195DBSaaVB19Bw/6l1Ypo9lTWFbg/cO3BOM=;
 b=HQFp/8Rhxh+/Hz9ndj7ZnpH3M6AggYaCJmYCr8oUiIgdCJCmC1t9cwZzBP7qhluPkA1y
 217tHqJ6t5yk6fVRBBW5e7n1CTmLu/pTxKJ/aUYvJ2YaUnpZZ69G5jz0RO7vlDssUdux
 aailovd3F5XzPAxr05FaNKKVKPymLHo7ILZQ4FmtFKNm7UiWQyofjRBmB+4iakqJIjnj
 t33Ox0vFerX6YuhCTpAZWb0eZdWlU/SjYIihAds1y6BwgngZrjG8TFKG8ktMCB3lWpWs
 xEeEjlT93uMcI0H//KtpkQ4vRIAzq47Q2OEKmGjYcFykHyv+GL51Shg3nizd0pzYjel5 uw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sspkpg1ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:29 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:28 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+Hh1I02195DBSaaVB19Bw/6l1Ypo9lTWFbg/cO3BOM=;
 b=Y9x4sspU2jJyhKxMRo2NFLBWbLUrWYRI1uSlnulEG7k0buyrrWFTvVAFAniyG/OwgxS72EkRlL6Nk0fnsCYE4IfTb76Ogk/a4PsflW9dgPdSnq+gXthMDKWfXMja8JMdufHt+uiXTtuLV21Dd4+n9RMAjnszbY4/ztfLSUox3k0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:26 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:26 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 10/21] EDAC, ghes: Remove pvt->detail_location string
Thread-Topic: [PATCH 10/21] EDAC, ghes: Remove pvt->detail_location string
Thread-Index: AQHVFfq4sJ/kBdA4SEWzCHEasvaD/g==
Date:   Wed, 29 May 2019 08:44:26 +0000
Message-ID: <20190529084344.28562-11-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: fdb97f67-9b3d-43ec-224b-08d6e411db2a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB343737888314212132E5C07BD91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HPUbDVvqvHYkKiwxI6UOkB+QXMt1At4nsJjuNs8E9VFi02BGlMGpkObRNNfatPnYItpsHMBjEWoFol2wJ/0rzxnGyqUY6raQRUkq4vP/N/wJaRWBwf1uGOowPa+eiebUJ/36OnSN5qKhBYJGnScdlrUIh4M/zcWBypvqlZL3PXkZXvCMFMiyhk1AspVfWveUUr7EFKjiBAbL1Qs94R9KRh6FAbI2XTBQYWbgnCH7PKbNu+w5HmxR3UM00/THahwX3oEdt2US6hVjNE88E6lbDupyZJq/2xDlFPgW7hu++Swc4TNu8X75/16IrHT8DuWvTH7oIWd8jyN9clQqKZdZfYqP8+Fa+CE7JojnlIqVsCQ7D4Km4UCPDMY406mEp/MZNWuRXE1urdjgtkPpm63a29fdmtaLipJhV8DsvDcUw+0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb97f67-9b3d-43ec-224b-08d6e411db2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:26.4914
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

VGhlIGRldGFpbF9sb2NhdGlvbltdIHN0cmluZyBpbiBzdHJ1Y3QgZ2hlc19lZGFjX3B2dCBpcyBj
b21wbGV0ZQ0KdXNlbGVzcyBhbmQgZGF0YSBpcyBqdXN0IGNvcGllZCBhcm91bmQuIFB1dCBldmVy
eXRoaW5nIGludG8NCmUtPm90aGVyX2RldGFpbCBmcm9tIHRoZSBiZWdpbm5pbmcuDQoNClNpZ25l
ZC1vZmYtYnk6IFJvYmVydCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvZWRhYy9naGVzX2VkYWMuYyB8IDE3ICsrKysrKysrKy0tLS0tLS0tDQogMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZWRhYy9naGVzX2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KaW5kZXgg
Mzk3MDJiYWM1ZWFmLi5jMThmMTZiYzllNGQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvZ2hl
c19lZGFjLmMNCisrKyBiL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYw0KQEAgLTIzLDggKzIzLDcg
QEAgc3RydWN0IGdoZXNfZWRhY19wdnQgew0KIAlzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2k7DQog
DQogCS8qIEJ1ZmZlcnMgZm9yIHRoZSBlcnJvciBoYW5kbGluZyByb3V0aW5lICovDQotCWNoYXIg
ZGV0YWlsX2xvY2F0aW9uWzI0MF07DQotCWNoYXIgb3RoZXJfZGV0YWlsWzE2MF07DQorCWNoYXIg
b3RoZXJfZGV0YWlsWzQwMF07DQogCWNoYXIgbXNnWzgwXTsNCiB9Ow0KIA0KQEAgLTIyNSwxMyAr
MjI0LDE0IEBAIHZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0
IGNwZXJfc2VjX21lbV9lcnIgKm1lbV9lcnIpDQogCW1lbXNldChlLCAwLCBzaXplb2YgKCplKSk7
DQogCWUtPmVycm9yX2NvdW50ID0gMTsNCiAJc3RyY3B5KGUtPmxhYmVsLCAidW5rbm93biBsYWJl
bCIpOw0KLQllLT5tc2cgPSBwdnQtPm1zZzsNCi0JZS0+b3RoZXJfZGV0YWlsID0gcHZ0LT5vdGhl
cl9kZXRhaWw7DQogCWUtPnRvcF9sYXllciA9IC0xOw0KIAllLT5taWRfbGF5ZXIgPSAtMTsNCiAJ
ZS0+bG93X2xheWVyID0gLTE7DQotCSpwdnQtPm90aGVyX2RldGFpbCA9ICdcMCc7DQorCWUtPm1z
ZyA9IHB2dC0+bXNnOw0KKwllLT5vdGhlcl9kZXRhaWwgPSBwdnQtPm90aGVyX2RldGFpbDsNCisN
CiAJKnB2dC0+bXNnID0gJ1wwJzsNCisJKnB2dC0+b3RoZXJfZGV0YWlsID0gJ1wwJzsNCiANCiAJ
c3dpdGNoIChzZXYpIHsNCiAJY2FzZSBHSEVTX1NFVl9DT1JSRUNURUQ6DQpAQCAtMzU5LDYgKzM1
OSw4IEBAIHZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNw
ZXJfc2VjX21lbV9lcnIgKm1lbV9lcnIpDQogDQogCS8qIEFsbCBvdGhlciBmaWVsZHMgYXJlIG1h
cHBlZCBvbiBlLT5vdGhlcl9kZXRhaWwgKi8NCiAJcCA9IHB2dC0+b3RoZXJfZGV0YWlsOw0KKwlw
ICs9IHNucHJpbnRmKHAsIHNpemVvZihwdnQtPm90aGVyX2RldGFpbCksDQorCQkiQVBFSSBsb2Nh
dGlvbjogJXMgIiwgZS0+bG9jYXRpb24pOw0KIAlpZiAobWVtX2Vyci0+dmFsaWRhdGlvbl9iaXRz
ICYgQ1BFUl9NRU1fVkFMSURfRVJST1JfU1RBVFVTKSB7DQogCQl1NjQgc3RhdHVzID0gbWVtX2Vy
ci0+ZXJyb3Jfc3RhdHVzOw0KIA0KQEAgLTQzNCwxMiArNDM2LDExIEBAIHZvaWQgZ2hlc19lZGFj
X3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNwZXJfc2VjX21lbV9lcnIgKm1lbV9l
cnIpDQogDQogCS8qIEdlbmVyYXRlIHRoZSB0cmFjZSBldmVudCAqLw0KIAlncmFpbl9iaXRzID0g
ZmxzX2xvbmcoZS0+Z3JhaW4pOw0KLQlzbnByaW50ZihwdnQtPmRldGFpbF9sb2NhdGlvbiwgc2l6
ZW9mKHB2dC0+ZGV0YWlsX2xvY2F0aW9uKSwNCi0JCSAiQVBFSSBsb2NhdGlvbjogJXMgJXMiLCBl
LT5sb2NhdGlvbiwgZS0+b3RoZXJfZGV0YWlsKTsNCisNCiAJdHJhY2VfbWNfZXZlbnQodHlwZSwg
ZS0+bXNnLCBlLT5sYWJlbCwgZS0+ZXJyb3JfY291bnQsDQogCQkgICAgICAgbWNpLT5tY19pZHgs
IGUtPnRvcF9sYXllciwgZS0+bWlkX2xheWVyLCBlLT5sb3dfbGF5ZXIsDQogCQkgICAgICAgKGUt
PnBhZ2VfZnJhbWVfbnVtYmVyIDw8IFBBR0VfU0hJRlQpIHwgZS0+b2Zmc2V0X2luX3BhZ2UsDQot
CQkgICAgICAgZ3JhaW5fYml0cywgZS0+c3luZHJvbWUsIHB2dC0+ZGV0YWlsX2xvY2F0aW9uKTsN
CisJCSAgICAgICBncmFpbl9iaXRzLCBlLT5zeW5kcm9tZSwgZS0+b3RoZXJfZGV0YWlsKTsNCiAN
CiAJZGltbV9pbmZvID0gZWRhY19nZXRfZGltbV9ieV9pbmRleChtY2ksIGUtPnRvcF9sYXllcik7
DQogDQotLSANCjIuMjAuMQ0KDQo=
