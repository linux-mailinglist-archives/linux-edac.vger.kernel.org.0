Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152A42D805
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfE2Ioj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:44:39 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35386 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbfE2Ioh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:44:37 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8eTkb022616;
        Wed, 29 May 2019 01:44:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=8mmEpGetGTGsC8KH3eiVJJd5ql01Z6s/28f7cnxCY4o=;
 b=ouk4ig5pbgaiIMsJQiMKVocfijMOwLX3v76QsJCrM1kTuQtiGFKs/l9hI1J8JLHIPO33
 vQKcp6Q+xSEHtrNarBDsEBsHhzXgapBkBHhvz1anYiQRjrcdlEVqDL8RFeDxofhPoFth
 iJKCpEEtyYOil/ofilyQlDalwnXLgGjKeQloUqbLt0X06cITx3TkGqCsRUYMJC1MLYZ9
 srxZwL8h5bSijPWQ9h2YjUlq3NM2/iTAPWDFflW5yBiR3Vf+2YcUnAtiZ6pVmC3O1im2
 /+pYTuGJ4qcxJMUtlUZSmG9PEXzSAjhMPmQt5d3KaL90Qa5BSGPTBYz+HwNUsU9L2oV4 5g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sspkpg1pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:28 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:28 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mmEpGetGTGsC8KH3eiVJJd5ql01Z6s/28f7cnxCY4o=;
 b=YEqVFC44h/zrsuVhyfaM9ci2MKyMTwmQYNdF3gMt8fAPWHi/eI6fFGljDr62dG+CjXJJpsMjp6boljisbFyQfjdIOyKR2T/cDIGGCRDln/vIDA/OxAXUmwE0/uTfBPx4tjOQAWrGTNkYyDpqESyAPO+wFa0xbXUq1zQrEzp8A0A=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:24 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:24 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH 09/21] EDAC, ghes: Use standard kernel macros for page
 calculations
Thread-Topic: [PATCH 09/21] EDAC, ghes: Use standard kernel macros for page
 calculations
Thread-Index: AQHVFfq3LwaRiST9SEqdF3CRJ+1mcg==
Date:   Wed, 29 May 2019 08:44:24 +0000
Message-ID: <20190529084344.28562-10-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: a4a8e694-4bae-4dd0-3098-08d6e411d9f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB343728B100BCDD1CE1CBBF88D91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(107886003)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(4744005)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CW2Ixfslo/QudURuo7rC3HGQ6+JiE6Zxb236qAg6O3ls6+QATbj1j8NcZrj7xn0WF7OgfwZIRPulwF8syYcRVkYiLg9opklXXfa0dc9v/A+63PGckLHBTvtf/p/UfZrInCRmageREUpt5bTgxoW6q7zJdVHBo7+yX5voo13PIXDpIhqgpr7kANQ3H6cq7RKIOaLa+c/0vHiOFJb8RBNNbO/7bfAYtxdJY0tiWEJURgbGBLCW1xZpHbs9Ts3+rCBv4Ydnqo4MxM7Q16APAFQk4k6l28iriPYnuD9ZcxDW4dXHhLlPiJtsGexDGj41uxXzYF9qy9eOTP8a92qK3VGO3yiFhvZ3ZbmKx50YS06rU4DQm8wlF3UHgmye7uG4mDbyZ4Dzh99rM3r2C8zsr11aesF0jsQ0IgZTlCq1trDpM5w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a8e694-4bae-4dd0-3098-08d6e411d9f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:24.5160
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

VXNlIHN0YW5kYXJkIG1hY3JvcyBmb3IgcGFnZSBjYWxjdWxhdGlvbnMuDQoNClNpZ25lZC1vZmYt
Ynk6IFJvYmVydCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
ZWRhYy9naGVzX2VkYWMuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvZ2hlc19lZGFj
LmMgYi9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCmluZGV4IDRhMTNjMzk0ZmE2Ni4uMzk3MDJi
YWM1ZWFmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQorKysgYi9kcml2
ZXJzL2VkYWMvZ2hlc19lZGFjLmMNCkBAIC0zMTMsOCArMzEzLDggQEAgdm9pZCBnaGVzX2VkYWNf
cmVwb3J0X21lbV9lcnJvcihpbnQgc2V2LCBzdHJ1Y3QgY3Blcl9zZWNfbWVtX2VyciAqbWVtX2Vy
cikNCiANCiAJLyogRXJyb3IgYWRkcmVzcyAqLw0KIAlpZiAobWVtX2Vyci0+dmFsaWRhdGlvbl9i
aXRzICYgQ1BFUl9NRU1fVkFMSURfUEEpIHsNCi0JCWUtPnBhZ2VfZnJhbWVfbnVtYmVyID0gbWVt
X2Vyci0+cGh5c2ljYWxfYWRkciA+PiBQQUdFX1NISUZUOw0KLQkJZS0+b2Zmc2V0X2luX3BhZ2Ug
PSBtZW1fZXJyLT5waHlzaWNhbF9hZGRyICYgflBBR0VfTUFTSzsNCisJCWUtPnBhZ2VfZnJhbWVf
bnVtYmVyID0gUEhZU19QRk4obWVtX2Vyci0+cGh5c2ljYWxfYWRkcik7DQorCQllLT5vZmZzZXRf
aW5fcGFnZSA9IG9mZnNldF9pbl9wYWdlKG1lbV9lcnItPnBoeXNpY2FsX2FkZHIpOw0KIAl9DQog
DQogCS8qIEVycm9yIGdyYWluICovDQotLSANCjIuMjAuMQ0KDQo=
