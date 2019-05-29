Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A06D42D821
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfE2Iob (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:44:31 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35326 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725894AbfE2Io2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:28 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8eZHM022625;
        Wed, 29 May 2019 01:44:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=6Fc5EB71Mh+CRL6fzdDB56EnuIF+olOEmhQM0dUtWPc=;
 b=OWXBNlegraFXHNmQWJ7jAA9cOOW5kFO0iFl0Th4hQusgAHrVo6M0DqdoVdlS8ol6OvLt
 XSIRX9vh/nGnEHaQIWKHUMqi48uVeAzpOQ8IgdYBjKN0CXKVCH1i0T3EuXnD4mS6nrr1
 1k8bZSCQ+K/vKG8Q5OeHl7D4OOvpK0+cwK/087FtAaEgpdDn7TwfgM6sT+qgpj0XmSRz
 PDKuLAnqd5fIQdLeyTm5gUEniYV8aLLQvo3QgwhyB08ZyExEPeHyOU30RuymDiZk+kmi
 YYJdML5ksFTJzEIlpUr2/kJe+qimLLJ4sMBfE8QAAnUDhLwCHZGTtayzuaJtQYB8yTCz rg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sspkpg1pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:20 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:20 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.51) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Fc5EB71Mh+CRL6fzdDB56EnuIF+olOEmhQM0dUtWPc=;
 b=bVjEhSPfZOSHf6u1UNTRg51Ay99giNwl5nj7IDyO8zzPPip1QTzCZFnHtt3RLQD2atv4qyAG2sYxcgDF5khpWjnUjIsJIaUDRdY66qz/IPbz5cBaqmGVb7iWpMLXv92JqsjXZnIyEl6ftA6cS7CqYV+s/+qD8Qh/IJ27qz1vljQ=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:17 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:17 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 06/21] EDAC, mc: Cleanup _edac_mc_free() code
Thread-Topic: [PATCH 06/21] EDAC, mc: Cleanup _edac_mc_free() code
Thread-Index: AQHVFfqzWWf6fvyfSkeGSvQ8S2Dm4Q==
Date:   Wed, 29 May 2019 08:44:17 +0000
Message-ID: <20190529084344.28562-7-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: c45f5fb5-a89e-40a2-71df-08d6e411d5d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB3437899BB90F74F8B9913CDDD91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GDQKjm+BbnrtTqfQAFGAj+L/KkcKEIW5kGhmWHAeuvqSeAzryqFEycebRPq0m0tBKuFDE5IWr2G3xhbhPs6tjSe89Rk6TWqNP3qEUjcgLFE9lRHQzMVWBeizgbxuYkMpAai/h+m4/rBcAfwTvEEScWvh0i7lFOpK5WkSAH7fwJIuq77Y8hu7GJ4wGi7vrkimSJLgrEYX6tM5Hz6Zlow10K4HBXftw8e+gUnW7gjOvmw1XCMsgjX4r4vb5QMIt2iHC15iv3DKvghrabIws0qn8Pb4qu4jTjeVRscbegt1vtGWic8oBsFmsnbsbEeMphcWy3mIeldXhP+R7H43iwuEuBnKyk/qhiHD6D9g+ojbh9C/iKOO+UPM6ofNLBGVynZ41OzikdOzzpcixKfIu31aByjH+piKBXciPMHlHrYxN3I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c45f5fb5-a89e-40a2-71df-08d6e411d5d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:17.5430
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

UmVtb3ZlIG5lZWRsZXNzIGFuZCBib2lsZXJwbGF0ZSB2YXJpYWJsZSBkZWNsYXJhdGlvbnMuIE5v
IGZ1bmN0aW9uYWwNCmNoYW5nZXMuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmVydCBSaWNodGVyIDxy
cmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZWRhYy9lZGFjX21jLmMgfCAyMSAr
KysrKysrKystLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9lZGFjX21jLmMgYi9k
cml2ZXJzL2VkYWMvZWRhY19tYy5jDQppbmRleCBhNmIzNGNjY2UzZDQuLmE4NDk5OTNhOGRjZCAx
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
