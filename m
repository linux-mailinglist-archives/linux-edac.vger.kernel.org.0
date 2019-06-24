Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4350FED
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfFXPJK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:10 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:46498 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730218AbfFXPJJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:09 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8DQo025885;
        Mon, 24 Jun 2019 08:09:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=g2yPZvZnZPxp7REQr2O9loNXHPznbv3ZYyA2oH/C1zg=;
 b=m+mrgjwBxj+EGpc3tOW+NghAUasXBXC60P4dQpbwPbD7TZ7Ji5m67+mOrg9SsTs3aR49
 w7WcGqEJnMPJxh9kULwlP1R/eAxVdX8C7inB9v7y8BjBeI3W/p2WM9GVhJuewKEECc3m
 B0gmFo87rnrtSWRW/7yqw2wtyFiTEHrraFWEfkkXX80pG3lCcUlDjrr/Bl6vF0IQEXQb
 35woqmmg285dJUIwBuGMWNiVoSL17iXkeLD2LNYjybMzP4o+Co9ZkVFkP0H4uLmAy6Ay
 IQ0Sa05ZiM5x9xcryaoCk84Cpx7sCrfWruqhbmHR/wCWE4HgdCfOJq2ayV8vWx2bMU9E Aw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:02 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:00 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2yPZvZnZPxp7REQr2O9loNXHPznbv3ZYyA2oH/C1zg=;
 b=qLoRbvpd0b3f/NnXxFOiCDGzqdWWBNLpTE+5gqpg+7K0d+/mnWjPqB02zLc/C+OenPr0nKSCo2Gy1m0Yf3y+FjKYmzd0KkJ9ms6R/5/Lhf8qKy9MiB/NyERPWm6xyqSMw+xAemn8M/wwWGLVGePLVQLKFTgqOsJEa585rHewlkQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB2589.namprd18.prod.outlook.com (20.179.82.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 15:08:59 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:08:59 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 03/24] EDAC, ghes: Remove pvt->detail_location string
Thread-Topic: [PATCH v2 03/24] EDAC, ghes: Remove pvt->detail_location string
Thread-Index: AQHVKp6/16x+WuPF8U6tQfjgZBANZg==
Date:   Mon, 24 Jun 2019 15:08:59 +0000
Message-ID: <20190624150758.6695-4-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 9c5134ad-0fff-4e96-843a-08d6f8b5e23b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2589;
x-ms-traffictypediagnostic: MN2PR18MB2589:
x-microsoft-antispam-prvs: <MN2PR18MB2589A38C0FFF815B4BCDB236D9E00@MN2PR18MB2589.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(2906002)(2616005)(486006)(476003)(52116002)(14444005)(256004)(5660300002)(66446008)(73956011)(66946007)(1076003)(14454004)(6116002)(86362001)(3846002)(99286004)(6486002)(68736007)(81166006)(81156014)(6436002)(4326008)(305945005)(50226002)(53936002)(7736002)(8676002)(8936002)(478600001)(64756008)(66556008)(66476007)(6512007)(107886003)(71190400001)(71200400001)(36756003)(26005)(102836004)(386003)(186003)(11346002)(76176011)(6506007)(110136005)(316002)(54906003)(446003)(25786009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2589;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j3ev69SxGa/6z2N5b6Ngrv3UdravwyMs4kfjBWXK0ud54QzwXl6oSuaFyqHbOuO0bvQPQeyBpp+TRD41VAuGBM2p0kM1q2MPc81J3MMbugPbZ7lMCLitfnLYXsbf2m6WSNWNWFXaIwC5+xD06zHkfcSmhIIUR6oLyd39Oa2mp4R8pY8zD1cRQwrYfCd503T6Mc/9at41xdALwSBs3EaRcidIfxjD9I+0s1DcPJg51O2d2cWJ8ShFRB2kvGp0MxmkUME0GsI4EIHI7qKPEJUqqwHMfcJeq60FwRs51XHHW0kuUM0aQhodx7s/N5/Qv3XLbRVxPCJSi7lu5VJCAMN22u8O50B40EFrETLJois6WoLqAfjGVUa/FtfMhFHLFYIFHjyTmr1OLHskiWJx3jkcqk3ygTHSg/VhyztXjWDYyYI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5134ad-0fff-4e96-843a-08d6f8b5e23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:08:59.0372
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

VGhlIGRldGFpbF9sb2NhdGlvbltdIHN0cmluZyBpbiBzdHJ1Y3QgZ2hlc19lZGFjX3B2dCBpcyBj
b21wbGV0ZQ0KdXNlbGVzcyBhbmQgZGF0YSBpcyBqdXN0IGNvcGllZCBhcm91bmQuIFB1dCBldmVy
eXRoaW5nIGludG8NCmUtPm90aGVyX2RldGFpbCBmcm9tIHRoZSBiZWdpbm5pbmcuDQoNClNpZ25l
ZC1vZmYtYnk6IFJvYmVydCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvZWRhYy9naGVzX2VkYWMuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9lZGFjL2doZXNfZWRhYy5jIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQppbmRleCBk
MDk1ZDk4ZDZhOGQuLjA0OWRlNzNjM2JhZCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9naGVz
X2VkYWMuYw0KKysrIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQpAQCAtMjEsOCArMjEsNyBA
QCBzdHJ1Y3QgZ2hlc19lZGFjX3B2dCB7DQogCXN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaTsNCiAN
CiAJLyogQnVmZmVycyBmb3IgdGhlIGVycm9yIGhhbmRsaW5nIHJvdXRpbmUgKi8NCi0JY2hhciBk
ZXRhaWxfbG9jYXRpb25bMjQwXTsNCi0JY2hhciBvdGhlcl9kZXRhaWxbMTYwXTsNCisJY2hhciBv
dGhlcl9kZXRhaWxbNDAwXTsNCiAJY2hhciBtc2dbODBdOw0KIH07DQogDQpAQCAtMjI0LDEzICsy
MjMsMTQgQEAgdm9pZCBnaGVzX2VkYWNfcmVwb3J0X21lbV9lcnJvcihpbnQgc2V2LCBzdHJ1Y3Qg
Y3Blcl9zZWNfbWVtX2VyciAqbWVtX2VycikNCiAJZS0+ZXJyb3JfY291bnQgPSAxOw0KIAllLT5n
cmFpbiA9IDE7DQogCXN0cmNweShlLT5sYWJlbCwgInVua25vd24gbGFiZWwiKTsNCi0JZS0+bXNn
ID0gcHZ0LT5tc2c7DQotCWUtPm90aGVyX2RldGFpbCA9IHB2dC0+b3RoZXJfZGV0YWlsOw0KIAll
LT50b3BfbGF5ZXIgPSAtMTsNCiAJZS0+bWlkX2xheWVyID0gLTE7DQogCWUtPmxvd19sYXllciA9
IC0xOw0KLQkqcHZ0LT5vdGhlcl9kZXRhaWwgPSAnXDAnOw0KKwllLT5tc2cgPSBwdnQtPm1zZzsN
CisJZS0+b3RoZXJfZGV0YWlsID0gcHZ0LT5vdGhlcl9kZXRhaWw7DQorDQogCSpwdnQtPm1zZyA9
ICdcMCc7DQorCSpwdnQtPm90aGVyX2RldGFpbCA9ICdcMCc7DQogDQogCXN3aXRjaCAoc2V2KSB7
DQogCWNhc2UgR0hFU19TRVZfQ09SUkVDVEVEOg0KQEAgLTM2MSw2ICszNjEsOCBAQCB2b2lkIGdo
ZXNfZWRhY19yZXBvcnRfbWVtX2Vycm9yKGludCBzZXYsIHN0cnVjdCBjcGVyX3NlY19tZW1fZXJy
ICptZW1fZXJyKQ0KIA0KIAkvKiBBbGwgb3RoZXIgZmllbGRzIGFyZSBtYXBwZWQgb24gZS0+b3Ro
ZXJfZGV0YWlsICovDQogCXAgPSBwdnQtPm90aGVyX2RldGFpbDsNCisJcCArPSBzbnByaW50Zihw
LCBzaXplb2YocHZ0LT5vdGhlcl9kZXRhaWwpLA0KKwkJIkFQRUkgbG9jYXRpb246ICVzICIsIGUt
PmxvY2F0aW9uKTsNCiAJaWYgKG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZB
TElEX0VSUk9SX1NUQVRVUykgew0KIAkJdTY0IHN0YXR1cyA9IG1lbV9lcnItPmVycm9yX3N0YXR1
czsNCiANCkBAIC00NDMsMTIgKzQ0NSwxMCBAQCB2b2lkIGdoZXNfZWRhY19yZXBvcnRfbWVtX2Vy
cm9yKGludCBzZXYsIHN0cnVjdCBjcGVyX3NlY19tZW1fZXJyICptZW1fZXJyKQ0KIAlncmFpbl9i
aXRzID0gZmxzX2xvbmcoZS0+Z3JhaW4gLSAxKTsNCiANCiAJLyogR2VuZXJhdGUgdGhlIHRyYWNl
IGV2ZW50ICovDQotCXNucHJpbnRmKHB2dC0+ZGV0YWlsX2xvY2F0aW9uLCBzaXplb2YocHZ0LT5k
ZXRhaWxfbG9jYXRpb24pLA0KLQkJICJBUEVJIGxvY2F0aW9uOiAlcyAlcyIsIGUtPmxvY2F0aW9u
LCBlLT5vdGhlcl9kZXRhaWwpOw0KIAl0cmFjZV9tY19ldmVudCh0eXBlLCBlLT5tc2csIGUtPmxh
YmVsLCBlLT5lcnJvcl9jb3VudCwNCiAJCSAgICAgICBtY2ktPm1jX2lkeCwgZS0+dG9wX2xheWVy
LCBlLT5taWRfbGF5ZXIsIGUtPmxvd19sYXllciwNCiAJCSAgICAgICAoZS0+cGFnZV9mcmFtZV9u
dW1iZXIgPDwgUEFHRV9TSElGVCkgfCBlLT5vZmZzZXRfaW5fcGFnZSwNCi0JCSAgICAgICBncmFp
bl9iaXRzLCBlLT5zeW5kcm9tZSwgcHZ0LT5kZXRhaWxfbG9jYXRpb24pOw0KKwkJICAgICAgIGdy
YWluX2JpdHMsIGUtPnN5bmRyb21lLCBlLT5vdGhlcl9kZXRhaWwpOw0KIA0KIAllZGFjX3Jhd19t
Y19oYW5kbGVfZXJyb3IodHlwZSwgbWNpLCBlKTsNCiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
Z2hlc19sb2NrLCBmbGFncyk7DQotLSANCjIuMjAuMQ0KDQo=
