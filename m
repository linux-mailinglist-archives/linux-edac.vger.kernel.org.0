Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C40650FDE
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfFXPKQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:10:16 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:58874 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730710AbfFXPJi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:38 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF8FJg025903;
        Mon, 24 Jun 2019 08:09:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=qh+kMCYPsGPcIQXuBR+Mk9lk7QB5CPrsdDS+ai29fy0=;
 b=gJMUJXY6MddOpRMiMIQG7Tv5i/ISD1JGfUyFh0whMfKamL8GTHQmqpnfQN/DMOixb9+o
 ehnrdqoy5TSPCZDCeQHfcgV6ZFEOcgdSF6QYbimgmaM27ByhZbfl2nXH1OSCRhfyFE4J
 ZWPNKL5Dhmxf+1cnRIwO05MILC3tOGlpZ0mmX3rA7Npmtc4uSpLAKslL8U2JHSeRfxqu
 IaTiv5Y8KeHNxOhxZ4IJJlUVGqokdDzezPlbdGwFPset+R3LAAdbrZUDE5bMnazFsEIY
 6EQ1r/y0uiNpvfmmZlXuhob04iaso9QhT7doLhPsiNHDA18CRZp8ofduaJtYaZUTz9zZ zQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2t9kujf7tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:30 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:29 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.56) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh+kMCYPsGPcIQXuBR+Mk9lk7QB5CPrsdDS+ai29fy0=;
 b=HARlrlBmpdXp0NnfPxtvulfmX7yDB4wSXdqbSD80U5y2zxEbgIC6qhGB8ZAqCuFVcyyjADRv/ixHqogMLRvDUP0qq4QiS9Xme/TcjK4yMyY4cZ7eItBeXr8DfjTL1Vv+p+KpjNcpqw9K2XdgewRbPOcTcTikxXtNl29JL0/Ve+o=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:28 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:28 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 16/24] EDAC, ghes: Moving code around ghes_edac_register()
Thread-Topic: [PATCH v2 16/24] EDAC, ghes: Moving code around
 ghes_edac_register()
Thread-Index: AQHVKp7RKr/OzzjWIEaSi7Jhu7Zp9Q==
Date:   Mon, 24 Jun 2019 15:09:27 +0000
Message-ID: <20190624150758.6695-17-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: dd1b1eb5-2feb-4620-8497-08d6f8b5f35e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB3197AF9540CC91650F1E9889D9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(107886003)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: evLgejGNoDenehVw1U1d0XQGXJ0Ly4Ci9j0tV+KyN5xxon4tCGtnD7ryrDgfi/pWo/CyWrbx//YcmSZqNs+kXS7PMfZUIRAImSaKO1/6kJ3dRfjd9MGbzADi+z67sT5o2b5XnMVzqvWDh7R12IqSQaS8E11T9q8OV/XFmbN2ByRvpWtNRUMPRQoY95TS4mtXbCRmwIOXbigW5Sr9hnjmPhdIQtBDA2vSWepIUC1NTlnaKKnwDPN7pDDIGu1mxoq00Oxqz3uDjTGJ2erI0bugv/p1JNUvEeFzcafif840aT6L3tZVFOuSLLwRrA9swOCLZMAU4j1PIPWL5i5L0C7/XYPa+WH85K98laamNNj/IQwlFL5hBhNey+3PV05Duz9RuhDgLjqE29oGeOy2s2Pjqb9a3r8spshKgsW9Cw6ViJk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1b1eb5-2feb-4620-8497-08d6f8b5f35e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:27.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrichter@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3197
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

VGhpcyBpcyBpbiBwcmVwYXJhdGlvbiBvZiB0aGUgbmV4dCBwYXRjaCB0byBtYWtlIHRoZSBjaGFu
Z2VzIHRoZXJlDQptb3JlIHZpc2libGUuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmVydCBSaWNodGVy
IDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyB8
IDk3ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMgYi9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCmluZGV4
IDc5MzM2MmJlYTA0NC4uMTNiNzQzNjhhZDgxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2do
ZXNfZWRhYy5jDQorKysgYi9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCkBAIC02NDAsNDUgKzY0
MCwxOSBAQCBzdGF0aWMgc3RydWN0IGFjcGlfcGxhdGZvcm1fbGlzdCBwbGF0X2xpc3RbXSA9IHsN
CiAJeyB9IC8qIEVuZCAqLw0KIH07DQogDQotaW50IGdoZXNfZWRhY19yZWdpc3RlcihzdHJ1Y3Qg
Z2hlcyAqZ2hlcywgc3RydWN0IGRldmljZSAqZGV2KQ0KK3N0YXRpYyBpbnQNCitnaGVzX2VkYWNf
cmVnaXN0ZXJfb25lKGludCBuaWQsIHN0cnVjdCBnaGVzICpnaGVzLCBzdHJ1Y3QgZGV2aWNlICpw
YXJlbnQpDQogew0KLQlib29sIGZha2UgPSBmYWxzZTsNCiAJaW50IHJjOw0KIAlzdHJ1Y3QgbWVt
X2N0bF9pbmZvICptY2k7DQogCXN0cnVjdCBlZGFjX21jX2xheWVyIGxheWVyc1sxXTsNCi0JaW50
IGlkeCA9IC0xOw0KLQ0KLQlpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2KSkgew0KLQkJLyogQ2hl
Y2sgaWYgc2FmZSB0byBlbmFibGUgb24gdGhpcyBzeXN0ZW0gKi8NCi0JCWlkeCA9IGFjcGlfbWF0
Y2hfcGxhdGZvcm1fbGlzdChwbGF0X2xpc3QpOw0KLQkJaWYgKCFmb3JjZV9sb2FkICYmIGlkeCA8
IDApDQotCQkJcmV0dXJuIC1FTk9ERVY7DQotCX0gZWxzZSB7DQotCQlpZHggPSAwOw0KLQl9DQot
DQotCS8qDQotCSAqIFdlIGhhdmUgb25seSBvbmUgbG9naWNhbCBtZW1vcnkgY29udHJvbGxlciB0
byB3aGljaCBhbGwgRElNTXMgYmVsb25nLg0KLQkgKi8NCi0JaWYgKGF0b21pY19pbmNfcmV0dXJu
KCZnaGVzX2luaXQpID4gMSkNCi0JCXJldHVybiAwOw0KLQ0KLQlyYyA9IG1lbV9pbmZvX3NldHVw
KCk7DQotCWlmIChyYyA9PSAtRUlOVkFMKSB7DQotCQkvKiB3ZSd2ZSBnb3QgYSBib2d1cyBCSU9T
ICovDQotCQlmYWtlID0gdHJ1ZTsNCi0JCXJjID0gbWVtX2luZm9fc2V0dXBfZmFrZSgpOw0KLQl9
DQotCWlmIChyYyA8IDApIHsNCi0JCXByX2VycigiQ2FuJ3QgYWxsb2NhdGUgbWVtb3J5IGZvciBE
SU1NIGRhdGFcbiIpOw0KLQkJcmV0dXJuIHJjOw0KLQl9DQogDQogCWxheWVyc1swXS50eXBlID0g
RURBQ19NQ19MQVlFUl9BTExfTUVNOw0KIAlsYXllcnNbMF0uc2l6ZSA9IG1lbV9pbmZvLm51bV9k
aW1tOw0KIAlsYXllcnNbMF0uaXNfdmlydF9jc3JvdyA9IHRydWU7DQogDQotCW1jaSA9IGVkYWNf
bWNfYWxsb2MoMCwgQVJSQVlfU0laRShsYXllcnMpLCBsYXllcnMsIHNpemVvZihzdHJ1Y3QgZ2hl
c19lZGFjX3B2dCkpOw0KKwltY2kgPSBlZGFjX21jX2FsbG9jKG5pZCwgQVJSQVlfU0laRShsYXll
cnMpLCBsYXllcnMsDQorCQkJc2l6ZW9mKHN0cnVjdCBnaGVzX2VkYWNfcHZ0KSk7DQogCWlmICgh
bWNpKSB7DQogCQlwcl9lcnIoIkNhbid0IGFsbG9jYXRlIG1lbW9yeSBmb3IgRURBQyBkYXRhXG4i
KTsNCiAJCXJldHVybiAtRU5PTUVNOw0KQEAgLTY4OCw3ICs2NjIsNyBAQCBpbnQgZ2hlc19lZGFj
X3JlZ2lzdGVyKHN0cnVjdCBnaGVzICpnaGVzLCBzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCWdoZXNf
cHZ0LT5naGVzCT0gZ2hlczsNCiAJZ2hlc19wdnQtPm1jaQk9IG1jaTsNCiANCi0JbWNpLT5wZGV2
ID0gZGV2Ow0KKwltY2ktPnBkZXYgPSBwYXJlbnQ7DQogCW1jaS0+bXR5cGVfY2FwID0gTUVNX0ZM
QUdfRU1QVFk7DQogCW1jaS0+ZWRhY19jdGxfY2FwID0gRURBQ19GTEFHX05PTkU7DQogCW1jaS0+
ZWRhY19jYXAgPSBFREFDX0ZMQUdfTk9ORTsNCkBAIC02OTYsMTkgKzY3MCw2IEBAIGludCBnaGVz
X2VkYWNfcmVnaXN0ZXIoc3RydWN0IGdoZXMgKmdoZXMsIHN0cnVjdCBkZXZpY2UgKmRldikNCiAJ
bWNpLT5jdGxfbmFtZSA9ICJnaGVzX2VkYWMiOw0KIAltY2ktPmRldl9uYW1lID0gImdoZXMiOw0K
IA0KLQlpZiAoZmFrZSkgew0KLQkJcHJfaW5mbygiVGhpcyBzeXN0ZW0gaGFzIGEgdmVyeSBjcmFw
cHkgQklPUzogSXQgZG9lc24ndCBldmVuIGxpc3QgdGhlIERJTU1TLlxuIik7DQotCQlwcl9pbmZv
KCJJdHMgU01CSU9TIGluZm8gaXMgd3JvbmcuIEl0IGlzIGRvdWJ0ZnVsIHRoYXQgdGhlIGVycm9y
IHJlcG9ydCB3b3VsZFxuIik7DQotCQlwcl9pbmZvKCJ3b3JrIG9uIHN1Y2ggc3lzdGVtLiBVc2Ug
dGhpcyBkcml2ZXIgd2l0aCBjYXV0aW9uXG4iKTsNCi0JfSBlbHNlIGlmIChpZHggPCAwKSB7DQot
CQlwcl9pbmZvKCJUaGlzIEVEQUMgZHJpdmVyIHJlbGllcyBvbiBCSU9TIHRvIGVudW1lcmF0ZSBt
ZW1vcnkgYW5kIGdldCBlcnJvciByZXBvcnRzLlxuIik7DQotCQlwcl9pbmZvKCJVbmZvcnR1bmF0
ZWx5LCBub3QgYWxsIEJJT1NlcyByZWZsZWN0IHRoZSBtZW1vcnkgbGF5b3V0IGNvcnJlY3RseS5c
biIpOw0KLQkJcHJfaW5mbygiU28sIHRoZSBlbmQgcmVzdWx0IG9mIHVzaW5nIHRoaXMgZHJpdmVy
IHZhcmllcyBmcm9tIHZlbmRvciB0byB2ZW5kb3IuXG4iKTsNCi0JCXByX2luZm8oIklmIHlvdSBm
aW5kIGluY29ycmVjdCByZXBvcnRzLCBwbGVhc2UgY29udGFjdCB5b3VyIGhhcmR3YXJlIHZlbmRv
clxuIik7DQotCQlwcl9pbmZvKCJ0byBjb3JyZWN0IGl0cyBCSU9TLlxuIik7DQotCQlwcl9pbmZv
KCJUaGlzIHN5c3RlbSBoYXMgJWQgRElNTSBzb2NrZXRzLlxuIiwgbWVtX2luZm8ubnVtX2RpbW0p
Ow0KLQl9DQotDQogCW1lbV9pbmZvX3ByZXBhcmVfbWNpKG1jaSk7DQogDQogCXJjID0gZWRhY19t
Y19hZGRfbWMobWNpKTsNCkBAIC03MzMsMyArNjk0LDUxIEBAIHZvaWQgZ2hlc19lZGFjX3VucmVn
aXN0ZXIoc3RydWN0IGdoZXMgKmdoZXMpDQogDQogCWtmcmVlKG1lbV9pbmZvLmRpbW1zKTsNCiB9
DQorDQoraW50IGdoZXNfZWRhY19yZWdpc3RlcihzdHJ1Y3QgZ2hlcyAqZ2hlcywgc3RydWN0IGRl
dmljZSAqZGV2KQ0KK3sNCisJYm9vbCBmYWtlID0gZmFsc2U7DQorCWludCByYzsNCisJaW50IGlk
eCA9IC0xOw0KKw0KKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfWDg2KSkgew0KKwkJLyogQ2hlY2sg
aWYgc2FmZSB0byBlbmFibGUgb24gdGhpcyBzeXN0ZW0gKi8NCisJCWlkeCA9IGFjcGlfbWF0Y2hf
cGxhdGZvcm1fbGlzdChwbGF0X2xpc3QpOw0KKwkJaWYgKCFmb3JjZV9sb2FkICYmIGlkeCA8IDAp
DQorCQkJcmV0dXJuIC1FTk9ERVY7DQorCX0gZWxzZSB7DQorCQlpZHggPSAwOw0KKwl9DQorDQor
CS8qIFdlIGhhdmUgb25seSBvbmUgZ2hlcyBpbnN0YW5jZSBhdCBhIHRpbWUuICovDQorCWlmIChh
dG9taWNfaW5jX3JldHVybigmZ2hlc19pbml0KSA+IDEpDQorCQlyZXR1cm4gMDsNCisNCisJcmMg
PSBtZW1faW5mb19zZXR1cCgpOw0KKwlpZiAocmMgPT0gLUVJTlZBTCkgew0KKwkJLyogd2UndmUg
Z290IGEgYm9ndXMgQklPUyAqLw0KKwkJZmFrZSA9IHRydWU7DQorCQlyYyA9IG1lbV9pbmZvX3Nl
dHVwX2Zha2UoKTsNCisJfQ0KKwlpZiAocmMgPCAwKSB7DQorCQlwcl9lcnIoIkNhbid0IGFsbG9j
YXRlIG1lbW9yeSBmb3IgRElNTSBkYXRhXG4iKTsNCisJCXJldHVybiByYzsNCisJfQ0KKw0KKwlp
ZiAoZmFrZSkgew0KKwkJcHJfaW5mbygiVGhpcyBzeXN0ZW0gaGFzIGEgdmVyeSBjcmFwcHkgQklP
UzogSXQgZG9lc24ndCBldmVuIGxpc3QgdGhlIERJTU1TLlxuIik7DQorCQlwcl9pbmZvKCJJdHMg
U01CSU9TIGluZm8gaXMgd3JvbmcuIEl0IGlzIGRvdWJ0ZnVsIHRoYXQgdGhlIGVycm9yIHJlcG9y
dCB3b3VsZFxuIik7DQorCQlwcl9pbmZvKCJ3b3JrIG9uIHN1Y2ggc3lzdGVtLiBVc2UgdGhpcyBk
cml2ZXIgd2l0aCBjYXV0aW9uXG4iKTsNCisJfSBlbHNlIGlmIChpZHggPCAwKSB7DQorCQlwcl9p
bmZvKCJUaGlzIEVEQUMgZHJpdmVyIHJlbGllcyBvbiBCSU9TIHRvIGVudW1lcmF0ZSBtZW1vcnkg
YW5kIGdldCBlcnJvciByZXBvcnRzLlxuIik7DQorCQlwcl9pbmZvKCJVbmZvcnR1bmF0ZWx5LCBu
b3QgYWxsIEJJT1NlcyByZWZsZWN0IHRoZSBtZW1vcnkgbGF5b3V0IGNvcnJlY3RseS5cbiIpOw0K
KwkJcHJfaW5mbygiU28sIHRoZSBlbmQgcmVzdWx0IG9mIHVzaW5nIHRoaXMgZHJpdmVyIHZhcmll
cyBmcm9tIHZlbmRvciB0byB2ZW5kb3IuXG4iKTsNCisJCXByX2luZm8oIklmIHlvdSBmaW5kIGlu
Y29ycmVjdCByZXBvcnRzLCBwbGVhc2UgY29udGFjdCB5b3VyIGhhcmR3YXJlIHZlbmRvclxuIik7
DQorCQlwcl9pbmZvKCJ0byBjb3JyZWN0IGl0cyBCSU9TLlxuIik7DQorCQlwcl9pbmZvKCJUaGlz
IHN5c3RlbSBoYXMgJWQgRElNTSBzb2NrZXRzLlxuIiwgbWVtX2luZm8ubnVtX2RpbW0pOw0KKwl9
DQorDQorCXJjID0gZ2hlc19lZGFjX3JlZ2lzdGVyX29uZSgwLCBnaGVzLCBkZXYpOw0KKw0KKwly
ZXR1cm4gcmM7DQorfQ0KLS0gDQoyLjIwLjENCg0K
