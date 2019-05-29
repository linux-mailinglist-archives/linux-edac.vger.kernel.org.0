Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676A22D816
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfE2IpJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 04:45:09 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35598 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726943AbfE2IpA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 04:45:00 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4T8ir3e026203;
        Wed, 29 May 2019 01:44:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=WGLFp4pMQEFqnYop+HzdF+dqUTZFIfj7jmF0nxJn8Zg=;
 b=mXo9X9jST62+y77wx7xYgiQ8QlhDDGoTTTCCK/QpCLUkSX76q0NIUMO4dVmBTgOT+0Hp
 y0Tszk0GLWWgdenMI5ipC8h5psavm1x9b+fIBUIrwT7TGM4AliKLGFTl2X8f0pzSR0In
 7ZqRQOZshBBNRLu2m5VcyXSOKieNhUy/oCdmI0d/5qwHWnM4Oz0M0MiFx/HCIAOlyghV
 YYJfepLOmIGBWVooPrIMnd+m2vZHfM6cAH0TW6g+Q6hwAQTwYlBXDuxqgQhL93dy0AF9
 BIH48UcOWEmOhokIimVNLFCnUDqMcdS+/qGNgkoTp1zn0z2lWYM9KhnlHGgwcKsQpUds RA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2sspkpg1rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 29 May 2019 01:44:52 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 29 May
 2019 01:44:52 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.51) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 29 May 2019 01:44:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGLFp4pMQEFqnYop+HzdF+dqUTZFIfj7jmF0nxJn8Zg=;
 b=BL25x7GMgBd9YkcsPkVnPo45i538m88ubp/AkybYVAmlaTSLXHUpZMUaynSbrK6yo1AtZtnNG7OxHTWi7WESDSJYe+bU97+rgYG6m+spbJsK5JPrJrfNgpPkNnVAycpnCJb3Gk51t7/x0Hd2aCuxb2a35R3QuKIOJD8C9sMkQYE=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (10.255.238.217) by
 MN2PR18MB3437.namprd18.prod.outlook.com (10.255.239.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Wed, 29 May 2019 08:44:50 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::7c9a:f3bf:fe2e:fe4a%4]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 08:44:50 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: [PATCH 21/21] EDAC, Documentation: Describe CPER module definition
 and DIMM ranks
Thread-Topic: [PATCH 21/21] EDAC, Documentation: Describe CPER module
 definition and DIMM ranks
Thread-Index: AQHVFfrG8kotEYU2/kiYp+ZR4jzKsA==
Date:   Wed, 29 May 2019 08:44:50 +0000
Message-ID: <20190529084344.28562-22-rrichter@marvell.com>
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
x-ms-office365-filtering-correlation-id: 72569946-e427-43a1-d470-08d6e411e940
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB3437;
x-ms-traffictypediagnostic: MN2PR18MB3437:
x-microsoft-antispam-prvs: <MN2PR18MB3437ADED990E47976B416707D91F0@MN2PR18MB3437.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8936002)(4326008)(53936002)(50226002)(110136005)(68736007)(36756003)(5660300002)(54906003)(11346002)(26005)(186003)(52116002)(2906002)(2616005)(476003)(446003)(6506007)(14454004)(66476007)(25786009)(478600001)(386003)(86362001)(486006)(81166006)(81156014)(8676002)(305945005)(316002)(7736002)(14444005)(256004)(99286004)(76176011)(6512007)(6436002)(73956011)(64756008)(66446008)(66556008)(66066001)(3846002)(66946007)(1076003)(6486002)(102836004)(71190400001)(71200400001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3437;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5XuTA4jAGJ/VfwfBoe2s4eaInHwdRrcEXfFZazxtwTuP4T8MKva2c8LGvdjFd/bzvjYFQyLaMHR+Qc6aKIPoMBGXI+VU171untRJBcmwH4KTJSZHeRpGCKSqcQki+GCrGo6GBkZomwGDJpP6Dwd70LASeNJUrm8ekyjlfZFG7teS18mwAlrwsbXvToRqQqqpenGTpH+Q5pCEtgmQIBkJFCw1GyvQ/R1PUOVSeVpYOpdN2+vq3FeFW17aUtv2i9VKEnd5/Jh77JuudWCv3DX7EZY0kQYOir7+DJMHccNT2XgH4xIp1YPfoRqlpyVXH9sryJdKAFgBUYt9bSqbzqYC8Zui5gp3BAGz81od+gTIegBvIOLFLNfv8PiH3WIypAL2z7iWax1ii0olNzBdkL1OTsZt5BfuoQq0hQMDw8gvtn0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72569946-e427-43a1-d470-08d6e411e940
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 08:44:50.1853
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
