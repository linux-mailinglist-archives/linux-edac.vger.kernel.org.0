Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234002D803
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfE2Iog (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:44:36 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35370 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbfE2Iof (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:35 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8fJFa023313;
        Wed, 29 May 2019 01:44:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=8FEAF0psG8LxSK8L9uX3vJMd6HSLnf5ElDoup3pLX9E=;
 b=P+jr15EO4IZgV6ff/td3lDe+Sg8H8RbpJvJBwTLjRAsdDyBegHz5zHlD1m8CAoAP9PIu
 hnsGXgjFYXCZW4kNMkh4vNcDfhYa/2AGzrG36AbGBEFTdBBYuPzPCxLM3RIP8CEigaOw
 YuTa8KdJyr7pm4CEtj38taFRxYc+LgOJZYFiWMftA8aiYrLTnetZen9MJ4k2Y28TwQP/
 QeJSJSiJJN5JnPle4fcqKEXHsIcwIVN4eASkmTC1D6BBppQsBDaMCaUMRXx00HTsVRpe
 HSsNoDCUx3wW+IhsHQ1bWNQdA8xM1BuVPKEs2HiIm+EJCv4J3IcyfbVhcox9L1AWHIHX 0A== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sspkpg1pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:28 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:27 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FEAF0psG8LxSK8L9uX3vJMd6HSLnf5ElDoup3pLX9E=;
 b=Eu947RFyt2D2GZMpY8FPjnW5vXK1pkgI3Tz4YKGjZ8SywE5RTjAP59QrJj4qKnzl0Lj6TFXwzmCwvz7VsHZ70kp7IqmyZ5UjOJAxC2NQ41piv+4XjepYOfjWW9Onw8/HRQyjPXldjNC6Gd69d8XjzemM1VRDOJEclRprOoQS55M=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:22 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:22 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 08/21] EDAC, mc: Rework edac_raw_mc_handle_error() to use
 struct dimm_info
Thread-Topic: [PATCH 08/21] EDAC, mc: Rework edac_raw_mc_handle_error() to use
 struct dimm_info
Thread-Index: AQHVFfq2kwJzIeiRI0WEsVWViUPdKQ==
Date:   Wed, 29 May 2019 08:44:22 +0000
Message-ID: <20190529084344.28562-9-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 815a934c-50db-40a7-f8ed-08d6e411d8c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB343765FE9148B18A2E4642DAD91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(14444005)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bx7JvwECjqQz3uHGXPqhlPpF9aXIyysgZ9Jy5IQlEDixijiJsnZ7EuM3kUBuTS9YkjzQNF6vaz6E0HW058lw/aw7fncSXUb9UT0Y79QJJdgMNmDRfkNV9W5MTfa4vlihGwHnWPvA6HxBk/UO69Q/hL7fF1FJeR2bkO03W5GYlbphBPz5cV4oWbQdAcnklkVkO0SPiFc7krEiz+ioyypezR6g7Z/d6g8ce4tSuYMaREteFcmlaAOLVcv6PChSslyrJMh2WGYCALvNalLUao0Sk9IbTAjLqGBW0FY7WQo66eselaDMN+hp0gAPTaNZSkx78eQr3X2ODsdYdAYFnzS0B/xS1c7JvavrfEjQt1p7atEBiSZyHXn216OyBUItScKPGSLk6o5GnNUG7bxc3waKnI4rMAGInRDZeWhD9HlDU40=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 815a934c-50db-40a7-f8ed-08d6e411d8c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:22.4695
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

UmV3b3JrIGVkYWNfcmF3X21jX2hhbmRsZV9lcnJvcigpIHRvIHVzZSBzdHJ1Y3QgZGltbV9pbmZv
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgUmljaHRlciA8cnJpY2h0ZXJAbWFydmVsbC5jb20+
DQotLS0NCiBkcml2ZXJzL2VkYWMvZWRhY19tYy5jICAgfCAyOCArKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tDQogZHJpdmVycy9lZGFjL2VkYWNfbWMuaCAgIHwgIDIgKysNCiBkcml2ZXJzL2Vk
YWMvZ2hlc19lZGFjLmMgfCAgNiArKysrKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2VkYWNf
bWMuYyBiL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMNCmluZGV4IDJlNDYxYzllMWE4OS4uYjFiZDBh
MjNkMDJiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2VkYWNfbWMuYw0KKysrIGIvZHJpdmVy
cy9lZGFjL2VkYWNfbWMuYw0KQEAgLTg4OSwxMSArODg5LDkgQEAgY29uc3QgY2hhciAqZWRhY19s
YXllcl9uYW1lW10gPSB7DQogRVhQT1JUX1NZTUJPTF9HUEwoZWRhY19sYXllcl9uYW1lKTsNCiAN
CiBzdGF0aWMgdm9pZCBlZGFjX2luY19jZV9lcnJvcihzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2ks
DQotCQkJICAgICAgY29uc3QgaW50IHBvc1tFREFDX01BWF9MQVlFUlNdLA0KKwkJCSAgICAgIHN0
cnVjdCBkaW1tX2luZm8gKmRpbW0sDQogCQkJICAgICAgY29uc3QgdTE2IGNvdW50KQ0KIHsNCi0J
c3RydWN0IGRpbW1faW5mbyAqZGltbSA9IGVkYWNfZ2V0X2RpbW0obWNpLCBwb3NbMF0sIHBvc1sx
XSwgcG9zWzJdKTsNCi0NCiAJbWNpLT5jZV9tYyArPSBjb3VudDsNCiANCiAJaWYgKGRpbW0pDQpA
QCAtOTAzLDExICs5MDEsOSBAQCBzdGF0aWMgdm9pZCBlZGFjX2luY19jZV9lcnJvcihzdHJ1Y3Qg
bWVtX2N0bF9pbmZvICptY2ksDQogfQ0KIA0KIHN0YXRpYyB2b2lkIGVkYWNfaW5jX3VlX2Vycm9y
KHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCi0JCQkJICAgIGNvbnN0IGludCBwb3NbRURBQ19N
QVhfTEFZRVJTXSwNCi0JCQkJICAgIGNvbnN0IHUxNiBjb3VudCkNCisJCQkgICAgICBzdHJ1Y3Qg
ZGltbV9pbmZvICpkaW1tLA0KKwkJCSAgICAgIGNvbnN0IHUxNiBjb3VudCkNCiB7DQotCXN0cnVj
dCBkaW1tX2luZm8gKmRpbW0gPSBlZGFjX2dldF9kaW1tKG1jaSwgcG9zWzBdLCBwb3NbMV0sIHBv
c1syXSk7DQotDQogCW1jaS0+dWVfbWMgKz0gY291bnQ7DQogDQogCWlmIChkaW1tKQ0KQEAgLTkx
Nyw4ICs5MTMsOCBAQCBzdGF0aWMgdm9pZCBlZGFjX2luY191ZV9lcnJvcihzdHJ1Y3QgbWVtX2N0
bF9pbmZvICptY2ksDQogfQ0KIA0KIHN0YXRpYyB2b2lkIGVkYWNfY2VfZXJyb3Ioc3RydWN0IG1l
bV9jdGxfaW5mbyAqbWNpLA0KKwkJCSAgc3RydWN0IGRpbW1faW5mbyAqZGltbSwNCiAJCQkgIGNv
bnN0IHUxNiBlcnJvcl9jb3VudCwNCi0JCQkgIGNvbnN0IGludCBwb3NbRURBQ19NQVhfTEFZRVJT
XSwNCiAJCQkgIGNvbnN0IGNoYXIgKm1zZywNCiAJCQkgIGNvbnN0IGNoYXIgKmxvY2F0aW9uLA0K
IAkJCSAgY29uc3QgY2hhciAqbGFiZWwsDQpAQCAtOTQ2LDcgKzk0Miw3IEBAIHN0YXRpYyB2b2lk
IGVkYWNfY2VfZXJyb3Ioc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KIAkJCQkgICAgICAgZXJy
b3JfY291bnQsIG1zZywgbXNnX2F1eCwgbGFiZWwsDQogCQkJCSAgICAgICBsb2NhdGlvbiwgZGV0
YWlsKTsNCiAJfQ0KLQllZGFjX2luY19jZV9lcnJvcihtY2ksIHBvcywgZXJyb3JfY291bnQpOw0K
KwllZGFjX2luY19jZV9lcnJvcihtY2ksIGRpbW0sIGVycm9yX2NvdW50KTsNCiANCiAJaWYgKG1j
aS0+c2NydWJfbW9kZSA9PSBTQ1JVQl9TV19TUkMpIHsNCiAJCS8qDQpAQCAtOTcwLDggKzk2Niw4
IEBAIHN0YXRpYyB2b2lkIGVkYWNfY2VfZXJyb3Ioc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0K
IH0NCiANCiBzdGF0aWMgdm9pZCBlZGFjX3VlX2Vycm9yKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1j
aSwNCisJCQkgIHN0cnVjdCBkaW1tX2luZm8gKmRpbW0sDQogCQkJICBjb25zdCB1MTYgZXJyb3Jf
Y291bnQsDQotCQkJICBjb25zdCBpbnQgcG9zW0VEQUNfTUFYX0xBWUVSU10sDQogCQkJICBjb25z
dCBjaGFyICptc2csDQogCQkJICBjb25zdCBjaGFyICpsb2NhdGlvbiwNCiAJCQkgIGNvbnN0IGNo
YXIgKmxhYmVsLA0KQEAgLTEwMDUsMTUgKzEwMDEsMTUgQEAgc3RhdGljIHZvaWQgZWRhY191ZV9l
cnJvcihzdHJ1Y3QgbWVtX2N0bF9pbmZvICptY2ksDQogCQkJICAgICAgbXNnLCBtc2dfYXV4LCBs
YWJlbCwgbG9jYXRpb24sIGRldGFpbCk7DQogCX0NCiANCi0JZWRhY19pbmNfdWVfZXJyb3IobWNp
LCBwb3MsIGVycm9yX2NvdW50KTsNCisJZWRhY19pbmNfdWVfZXJyb3IobWNpLCBkaW1tLCBlcnJv
cl9jb3VudCk7DQogfQ0KIA0KIHZvaWQgZWRhY19yYXdfbWNfaGFuZGxlX2Vycm9yKGNvbnN0IGVu
dW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwNCiAJCQkgICAgICBzdHJ1Y3QgbWVtX2N0bF9p
bmZvICptY2ksDQorCQkJICAgICAgc3RydWN0IGRpbW1faW5mbyAqZGltbSwNCiAJCQkgICAgICBz
dHJ1Y3QgZWRhY19yYXdfZXJyb3JfZGVzYyAqZSkNCiB7DQogCWNoYXIgZGV0YWlsWzgwXTsNCi0J
aW50IHBvc1tFREFDX01BWF9MQVlFUlNdID0geyBlLT50b3BfbGF5ZXIsIGUtPm1pZF9sYXllciwg
ZS0+bG93X2xheWVyIH07DQogDQogCS8qIE1lbW9yeSB0eXBlIGRlcGVuZGVudCBkZXRhaWxzIGFi
b3V0IHRoZSBlcnJvciAqLw0KIAlpZiAodHlwZSA9PSBIV19FVkVOVF9FUlJfQ09SUkVDVEVEKSB7
DQpAQCAtMTAyMSw3ICsxMDE3LDcgQEAgdm9pZCBlZGFjX3Jhd19tY19oYW5kbGVfZXJyb3IoY29u
c3QgZW51bSBod19ldmVudF9tY19lcnJfdHlwZSB0eXBlLA0KIAkJCSJwYWdlOjB4JWx4IG9mZnNl
dDoweCVseCBncmFpbjolbGQgc3luZHJvbWU6MHglbHgiLA0KIAkJCWUtPnBhZ2VfZnJhbWVfbnVt
YmVyLCBlLT5vZmZzZXRfaW5fcGFnZSwNCiAJCQllLT5ncmFpbiwgZS0+c3luZHJvbWUpOw0KLQkJ
ZWRhY19jZV9lcnJvcihtY2ksIGUtPmVycm9yX2NvdW50LCBwb3MsIGUtPm1zZywgZS0+bG9jYXRp
b24sDQorCQllZGFjX2NlX2Vycm9yKG1jaSwgZGltbSwgZS0+ZXJyb3JfY291bnQsIGUtPm1zZywg
ZS0+bG9jYXRpb24sDQogCQkJICAgICAgZS0+bGFiZWwsIGRldGFpbCwgZS0+b3RoZXJfZGV0YWls
LA0KIAkJCSAgICAgIGUtPnBhZ2VfZnJhbWVfbnVtYmVyLCBlLT5vZmZzZXRfaW5fcGFnZSwgZS0+
Z3JhaW4pOw0KIAl9IGVsc2Ugew0KQEAgLTEwMjksNyArMTAyNSw3IEBAIHZvaWQgZWRhY19yYXdf
bWNfaGFuZGxlX2Vycm9yKGNvbnN0IGVudW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwNCiAJ
CQkicGFnZToweCVseCBvZmZzZXQ6MHglbHggZ3JhaW46JWxkIiwNCiAJCQllLT5wYWdlX2ZyYW1l
X251bWJlciwgZS0+b2Zmc2V0X2luX3BhZ2UsIGUtPmdyYWluKTsNCiANCi0JCWVkYWNfdWVfZXJy
b3IobWNpLCBlLT5lcnJvcl9jb3VudCwgcG9zLCBlLT5tc2csIGUtPmxvY2F0aW9uLA0KKwkJZWRh
Y191ZV9lcnJvcihtY2ksIGRpbW0sIGUtPmVycm9yX2NvdW50LCBlLT5tc2csIGUtPmxvY2F0aW9u
LA0KIAkJCSAgICAgIGUtPmxhYmVsLCBkZXRhaWwsIGUtPm90aGVyX2RldGFpbCk7DQogCX0NCiAN
CkBAIC0xMjA2LDYgKzEyMDIsOCBAQCB2b2lkIGVkYWNfbWNfaGFuZGxlX2Vycm9yKGNvbnN0IGVu
dW0gaHdfZXZlbnRfbWNfZXJyX3R5cGUgdHlwZSwNCiAJCQkgICAgICAgKGUtPnBhZ2VfZnJhbWVf
bnVtYmVyIDw8IFBBR0VfU0hJRlQpIHwgZS0+b2Zmc2V0X2luX3BhZ2UsDQogCQkJICAgICAgIGdy
YWluX2JpdHMsIGUtPnN5bmRyb21lLCBlLT5vdGhlcl9kZXRhaWwpOw0KIA0KLQllZGFjX3Jhd19t
Y19oYW5kbGVfZXJyb3IodHlwZSwgbWNpLCBlKTsNCisJZGltbSA9IGVkYWNfZ2V0X2RpbW0obWNp
LCB0b3BfbGF5ZXIsIG1pZF9sYXllciwgbG93X2xheWVyKTsNCisNCisJZWRhY19yYXdfbWNfaGFu
ZGxlX2Vycm9yKHR5cGUsIG1jaSwgZGltbSwgZSk7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKGVk
YWNfbWNfaGFuZGxlX2Vycm9yKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5o
IGIvZHJpdmVycy9lZGFjL2VkYWNfbWMuaA0KaW5kZXggNDE2NWUxNTk5NWFkLi5iODE2Y2YzY2Fh
ZWUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2VkYWMvZWRhY19tYy5oDQorKysgYi9kcml2ZXJzL2Vk
YWMvZWRhY19tYy5oDQpAQCAtMjE0LDYgKzIxNCw3IEBAIGV4dGVybiBpbnQgZWRhY19tY19maW5k
X2Nzcm93X2J5X3BhZ2Uoc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KICAqDQogICogQHR5cGU6
CQlzZXZlcml0eSBvZiB0aGUgZXJyb3IgKENFL1VFL0ZhdGFsKQ0KICAqIEBtY2k6CQlhIHN0cnVj
dCBtZW1fY3RsX2luZm8gcG9pbnRlcg0KKyAqIEBkaW1tOgkJYSBzdHJ1Y3QgZGltbV9pbmZvIHBv
aW50ZXINCiAgKiBAZToJCQllcnJvciBkZXNjcmlwdGlvbg0KICAqDQogICogVGhpcyByYXcgZnVu
Y3Rpb24gaXMgdXNlZCBpbnRlcm5hbGx5IGJ5IGVkYWNfbWNfaGFuZGxlX2Vycm9yKCkuIEl0IHNo
b3VsZA0KQEAgLTIyMiw2ICsyMjMsNyBAQCBleHRlcm4gaW50IGVkYWNfbWNfZmluZF9jc3Jvd19i
eV9wYWdlKHN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaSwNCiAgKi8NCiB2b2lkIGVkYWNfcmF3X21j
X2hhbmRsZV9lcnJvcihjb25zdCBlbnVtIGh3X2V2ZW50X21jX2Vycl90eXBlIHR5cGUsDQogCQkJ
ICAgICAgc3RydWN0IG1lbV9jdGxfaW5mbyAqbWNpLA0KKwkJCSAgICAgIHN0cnVjdCBkaW1tX2lu
Zm8gKmRpbW0sDQogCQkJICAgICAgc3RydWN0IGVkYWNfcmF3X2Vycm9yX2Rlc2MgKmUpOw0KIA0K
IC8qKg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyBiL2RyaXZlcnMvZWRh
Yy9naGVzX2VkYWMuYw0KaW5kZXggMmM4ZjgxNmMyY2M3Li40YTEzYzM5NGZhNjYgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCisrKyBiL2RyaXZlcnMvZWRhYy9naGVzX2Vk
YWMuYw0KQEAgLTE5Niw2ICsxOTYsNyBAQCBzdGF0aWMgdm9pZCBnaGVzX2VkYWNfZG1pZGVjb2Rl
KGNvbnN0IHN0cnVjdCBkbWlfaGVhZGVyICpkaCwgdm9pZCAqYXJnKQ0KIA0KIHZvaWQgZ2hlc19l
ZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNwZXJfc2VjX21lbV9lcnIgKm1l
bV9lcnIpDQogew0KKwlzdHJ1Y3QgZGltbV9pbmZvICpkaW1tX2luZm87DQogCWVudW0gaHdfZXZl
bnRfbWNfZXJyX3R5cGUgdHlwZTsNCiAJc3RydWN0IGVkYWNfcmF3X2Vycm9yX2Rlc2MgKmU7DQog
CXN0cnVjdCBtZW1fY3RsX2luZm8gKm1jaTsNCkBAIC00NDAsNyArNDQxLDEwIEBAIHZvaWQgZ2hl
c19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0IGNwZXJfc2VjX21lbV9lcnIg
Km1lbV9lcnIpDQogCQkgICAgICAgKGUtPnBhZ2VfZnJhbWVfbnVtYmVyIDw8IFBBR0VfU0hJRlQp
IHwgZS0+b2Zmc2V0X2luX3BhZ2UsDQogCQkgICAgICAgZ3JhaW5fYml0cywgZS0+c3luZHJvbWUs
IHB2dC0+ZGV0YWlsX2xvY2F0aW9uKTsNCiANCi0JZWRhY19yYXdfbWNfaGFuZGxlX2Vycm9yKHR5
cGUsIG1jaSwgZSk7DQorCWRpbW1faW5mbyA9IGVkYWNfZ2V0X2RpbW1fYnlfaW5kZXgobWNpLCBl
LT50b3BfbGF5ZXIpOw0KKw0KKwllZGFjX3Jhd19tY19oYW5kbGVfZXJyb3IodHlwZSwgbWNpLCBk
aW1tX2luZm8sIGUpOw0KKw0KIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZnaGVzX2xvY2ssIGZs
YWdzKTsNCiB9DQogDQotLSANCjIuMjAuMQ0KDQo=
