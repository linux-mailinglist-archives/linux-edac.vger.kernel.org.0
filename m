Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9398850FD2
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 17:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfFXPJx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 11:09:53 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:28516 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730860AbfFXPJw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:52 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OF0Dhp018663;
        Mon, 24 Jun 2019 08:09:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=WGLFp4pMQEFqnYop+HzdF+dqUTZFIfj7jmF0nxJn8Zg=;
 b=eoFkrXJVOphEEUK0J7vYV8gCgNcDj4rkfeq2w3EoPD8CqtDKx10LgqeX2D7gQLsK0afi
 TBigNGdxpGgfnVJA3rpOYElU9+hVLL1Zg/EVN4YJBIDDtGx9elhBNGd12+e44O+BFRJy
 c0X/HvT1qNmhvRWVL8wWFyt9VM2zEy/Jcc8+O7Vim2Qi2Hx0zXsuVMHCAvqozPN8gS6L
 2InfJZlbYK8C3etP90jS0XGSL5d97LjBTpPXJZ5oeeLmuDMwvHEMXBurRK7lhtGdC1Wy
 B6T3zVwA8yD7H0SfvKo44sUA4r3cJM4mxPrKk7+KtLQlQmEhfFeWhXt7G7ErKdOxJq+c AA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tarxr9tcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 08:09:44 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 24 Jun
 2019 08:09:43 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.59) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Jun 2019 08:09:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGLFp4pMQEFqnYop+HzdF+dqUTZFIfj7jmF0nxJn8Zg=;
 b=HgRd42z+3vSbZhCy/yY+0RV0UimhQ5XYbGAJvBTQya1yNjpsMKoi3KzyUqPdxydlBZLzgvqjsA65+HNA9tAadF2Y4IX4ZnIevePosH3O3GOEoReaSymimM+oxn4QWr0cQcx9lZXAXQa0Q7NTQDBt1ihGVEMflFklxpbwzQFNxYg=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3197.namprd18.prod.outlook.com (10.255.236.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 15:09:42 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::d3:794c:1b94:cf3%4]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 15:09:42 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH v2 23/24] EDAC, Documentation: Describe CPER module definition
 and DIMM ranks
Thread-Topic: [PATCH v2 23/24] EDAC, Documentation: Describe CPER module
 definition and DIMM ranks
Thread-Index: AQHVKp7ZS8LjERln60y0i8Uoi5Y0PA==
Date:   Mon, 24 Jun 2019 15:09:42 +0000
Message-ID: <20190624150758.6695-24-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 8b4851e0-917e-461f-531a-08d6f8b5fc0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3197;
x-ms-traffictypediagnostic: MN2PR18MB3197:
x-microsoft-antispam-prvs: <MN2PR18MB3197AC70A49E41851C4711AFD9E00@MN2PR18MB3197.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(36756003)(110136005)(54906003)(81156014)(81166006)(68736007)(8676002)(25786009)(5660300002)(8936002)(305945005)(7736002)(4326008)(1076003)(186003)(6116002)(14454004)(476003)(486006)(2616005)(11346002)(256004)(14444005)(446003)(3846002)(50226002)(26005)(2906002)(52116002)(76176011)(71200400001)(71190400001)(99286004)(386003)(6506007)(102836004)(478600001)(316002)(86362001)(6512007)(66066001)(53936002)(6486002)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3197;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 35kuKiqfEN76kJTUZYkkbBY/gs7U2YHYeiY/T+PE74/hVW+deFE5f0k60h//r2BmFM1Sk2dThcC2yQbhDjErIvJFWgYOX4/mAmn19RXLRy/jRZv7zKrnCn0YEqByIi1UJCpI5QnVqA59tFeHpoJi5xR40N+NeG6AAezcGVZihfHL6ENm5k6JPhLFPMhaxHHipt7lIfO2mJVHYBlF0j4I+dGKe7idN+SGkc+/WvX29iKUTwJDUB/B/zzYGO1H+uc9eGHuXy+Mdf708O7H6xrNXvCy2PHMAIGxPEvfHCd4uvUvHwh9DMwEXX/0/ifMbicAQZEPFKZ4jal4vw02C+bsCylqEp+UDsgzzbr4W79Ni5L891SipcpYTI42CGfRUWGwTjo1C89L1dUFPYfLWz9VHHTHQ+HLVirn5Jj2u0kG1UI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4851e0-917e-461f-531a-08d6f8b5fc0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 15:09:42.2856
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

VXBkYXRlIG9uIENQRVIgRElNTSBuYW1pbmcgY29udmVudGlvbiBhbmQgRElNTSByYW5rcy4NCg0K
U2lnbmVkLW9mZi1ieTogUm9iZXJ0IFJpY2h0ZXIgPHJyaWNodGVyQG1hcnZlbGwuY29tPg0KLS0t
DQogRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9yYXMucnN0IHwgMzEgKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxMiBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcmFz
LnJzdCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcmFzLnJzdA0KaW5kZXggYzc0OTVlNDJl
NmY0Li40ZTJhMDFjNzdhOWMgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L3Jhcy5yc3QNCisrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvcmFzLnJzdA0KQEAgLTMz
MCw5ICszMzAsMTIgQEAgVGhlcmUgY2FuIGJlIG11bHRpcGxlIGNzcm93cyBhbmQgbXVsdGlwbGUg
Y2hhbm5lbHMuDQogDQogLi4gWyNmNF0gTm93YWRheXMsIHRoZSB0ZXJtIERJTU0gKER1YWwgSW4t
bGluZSBNZW1vcnkgTW9kdWxlKSBpcyB3aWRlbHkNCiAgIHVzZWQgdG8gcmVmZXIgdG8gYSBtZW1v
cnkgbW9kdWxlLCBhbHRob3VnaCB0aGVyZSBhcmUgb3RoZXIgbWVtb3J5DQotICBwYWNrYWdpbmcg
YWx0ZXJuYXRpdmVzLCBsaWtlIFNPLURJTU0sIFNJTU0sIGV0Yy4gQWxvbmcgdGhpcyBkb2N1bWVu
dCwNCi0gIGFuZCBpbnNpZGUgdGhlIEVEQUMgc3lzdGVtLCB0aGUgdGVybSAiZGltbSIgaXMgdXNl
ZCBmb3IgYWxsIG1lbW9yeQ0KLSAgbW9kdWxlcywgZXZlbiB3aGVuIHRoZXkgdXNlIGEgZGlmZmVy
ZW50IGtpbmQgb2YgcGFja2FnaW5nLg0KKyAgcGFja2FnaW5nIGFsdGVybmF0aXZlcywgbGlrZSBT
Ty1ESU1NLCBTSU1NLCBldGMuIFRoZSBVRUZJDQorICBzcGVjaWZpY2F0aW9uIChWZXJzaW9uIDIu
NykgZGVmaW5lcyBhIG1lbW9yeSBtb2R1bGUgaW4gdGhlIENvbW1vbg0KKyAgUGxhdGZvcm0gRXJy
b3IgUmVjb3JkIChDUEVSKSBzZWN0aW9uIHRvIGJlIGFuIFNNQklPUyBNZW1vcnkgRGV2aWNlDQor
ICAoVHlwZSAxNykuIEFsb25nIHRoaXMgZG9jdW1lbnQsIGFuZCBpbnNpZGUgdGhlIEVEQUMgc3lz
dGVtLCB0aGUgdGVybQ0KKyAgImRpbW0iIGlzIHVzZWQgZm9yIGFsbCBtZW1vcnkgbW9kdWxlcywg
ZXZlbiB3aGVuIHRoZXkgdXNlIGENCisgIGRpZmZlcmVudCBraW5kIG9mIHBhY2thZ2luZy4NCiAN
CiBNZW1vcnkgY29udHJvbGxlcnMgYWxsb3cgZm9yIHNldmVyYWwgY3Nyb3dzLCB3aXRoIDggY3Ny
b3dzIGJlaW5nIGENCiB0eXBpY2FsIHZhbHVlLiBZZXQsIHRoZSBhY3R1YWwgbnVtYmVyIG9mIGNz
cm93cyBkZXBlbmRzIG9uIHRoZSBsYXlvdXQgb2YNCkBAIC0zNDksMTIgKzM1MiwxNCBAQCBjb250
cm9sbGVycy4gVGhlIGZvbGxvd2luZyBleGFtcGxlIHdpbGwgYXNzdW1lIDIgY2hhbm5lbHM6DQog
CXwgICAgICAgICAgICB8ICBgYGNoMGBgICB8ICBgYGNoMWBgICB8DQogCSs9PT09PT09PT09PT0r
PT09PT09PT09PT0rPT09PT09PT09PT0rDQogCXwgYGBjc3JvdzBgYCB8ICBESU1NX0EwICB8ICBE
SU1NX0IwICB8DQotCSstLS0tLS0tLS0tLS0rICAgICAgICAgICB8ICAgICAgICAgICB8DQotCXwg
YGBjc3JvdzFgYCB8ICAgICAgICAgICB8ICAgICAgICAgICB8DQorCXwgICAgICAgICAgICB8ICAg
cmFuazAgICB8ICAgcmFuazAgICB8DQorCSstLS0tLS0tLS0tLS0rICAgICAtICAgICB8ICAgICAt
ICAgICB8DQorCXwgYGBjc3JvdzFgYCB8ICAgcmFuazEgICB8ICAgcmFuazEgICB8DQogCSstLS0t
LS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rDQogCXwgYGBjc3JvdzJgYCB8ICBESU1N
X0ExICB8IERJTU1fQjEgICB8DQotCSstLS0tLS0tLS0tLS0rICAgICAgICAgICB8ICAgICAgICAg
ICB8DQotCXwgYGBjc3JvdzNgYCB8ICAgICAgICAgICB8ICAgICAgICAgICB8DQorCXwgICAgICAg
ICAgICB8ICAgcmFuazAgICB8ICAgcmFuazAgICB8DQorCSstLS0tLS0tLS0tLS0rICAgICAtICAg
ICB8ICAgICAtICAgICB8DQorCXwgYGBjc3JvdzNgYCB8ICAgcmFuazEgICB8ICAgcmFuazEgICB8
DQogCSstLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rDQogDQogSW4gdGhlIGFi
b3ZlIGV4YW1wbGUsIHRoZXJlIGFyZSA0IHBoeXNpY2FsIHNsb3RzIG9uIHRoZSBtb3RoZXJib2Fy
ZA0KQEAgLTM3NCwxMSArMzc5LDEzIEBAIHdoaWNoIHRoZSBtZW1vcnkgRElNTSBpcyBwbGFjZWQu
IFRodXMsIHdoZW4gMSBESU1NIGlzIHBsYWNlZCBpbiBlYWNoDQogQ2hhbm5lbCwgdGhlIGNzcm93
cyBjcm9zcyBib3RoIERJTU1zLg0KIA0KIE1lbW9yeSBESU1NcyBjb21lIHNpbmdsZSBvciBkdWFs
ICJyYW5rZWQiLiBBIHJhbmsgaXMgYSBwb3B1bGF0ZWQgY3Nyb3cuDQotVGh1cywgMiBzaW5nbGUg
cmFua2VkIERJTU1zLCBwbGFjZWQgaW4gc2xvdHMgRElNTV9BMCBhbmQgRElNTV9CMCBhYm92ZQ0K
LXdpbGwgaGF2ZSBqdXN0IG9uZSBjc3JvdyAoY3Nyb3cwKS4gY3Nyb3cxIHdpbGwgYmUgZW1wdHku
IE9uIHRoZSBvdGhlcg0KLWhhbmQsIHdoZW4gMiBkdWFsIHJhbmtlZCBESU1NcyBhcmUgc2ltaWxh
cmx5IHBsYWNlZCwgdGhlbiBib3RoIGNzcm93MA0KLWFuZCBjc3JvdzEgd2lsbCBiZSBwb3B1bGF0
ZWQuIFRoZSBwYXR0ZXJuIHJlcGVhdHMgaXRzZWxmIGZvciBjc3JvdzIgYW5kDQotY3Nyb3czLg0K
K0luIHRoZSBleGFtcGxlIGFib3ZlIDIgZHVhbCByYW5rZWQgRElNTXMgYXJlIHNpbWlsYXJseSBw
bGFjZWQuIFRodXMsDQorYm90aCBjc3JvdzAgYW5kIGNzcm93MSBhcmUgcG9wdWxhdGVkLiBPbiB0
aGUgb3RoZXIgaGFuZCwgd2hlbiAyIHNpbmdsZQ0KK3JhbmtlZCBESU1NcyBhcmUgcGxhY2VkIGlu
IHNsb3RzIERJTU1fQTAgYW5kIERJTU1fQjAsIHRoZW4gdGhleSB3aWxsDQoraGF2ZSBqdXN0IG9u
ZSBjc3JvdyAoY3Nyb3cwKSBhbmQgY3Nyb3cxIHdpbGwgYmUgZW1wdHkuIFRoZSBwYXR0ZXJuDQor
cmVwZWF0cyBpdHNlbGYgZm9yIGNzcm93MiBhbmQgY3Nyb3czLiBBbHNvIG5vdGUgdGhhdCBzb21l
IG1lbW9yeQ0KK2NvbnRyb2xsZXIgZG9lc24ndCBoYXZlIGFueSBsb2dpYyB0byBpZGVudGlmeSB0
aGUgbWVtb3J5IG1vZHVsZSwgc2VlDQorYGByYW5rWGBgIGRpcmVjdG9yaWVzIGJlbG93Lg0KIA0K
IFRoZSByZXByZXNlbnRhdGlvbiBvZiB0aGUgYWJvdmUgaXMgcmVmbGVjdGVkIGluIHRoZSBkaXJl
Y3RvcnkNCiB0cmVlIGluIEVEQUMncyBzeXNmcyBpbnRlcmZhY2UuIFN0YXJ0aW5nIGluIGRpcmVj
dG9yeQ0KLS0gDQoyLjIwLjENCg0K
