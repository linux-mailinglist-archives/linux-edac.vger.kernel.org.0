Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 198E5A1665
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2019 12:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfH2Kjj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Aug 2019 06:39:39 -0400
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:15520
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727017AbfH2Kjj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 29 Aug 2019 06:39:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB09GPeaSU8n+X+l6zHCjEddDpgG0VCuNmv3PkBAtF/H5u2C1WBLV4vU7pmtmJmBaAkbY6ukrQwmx1vF41kooatGefgqjMeNX4CfAkuNK9C+kdFCgiznWR6Oy2xquKUwUpvhRCq00yImU4Q8DlwZCgz0ykwRrP0NJv9z/Dq8L6Z9yeKJQ0xiYEwaC86mZ9bocQrOjmRHtgb3+V3yb9+4pDWMYK/o72ZhFyUC+d43Z4ZFIE4vkBcX8AOs3lwn0HDKiKeqsDtpSf5ZIfVHuONiZAMERFVjl52BpT/Y78DYBGEh1OcdFfSZxigjyMN2sIW2hhKsOd7REqpLgntka0FiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjA67moHJr6qtEN8VLhgjXFJSBpKl/2hEYrvhB/Pajo=;
 b=Jbp0uwbrBBatU8CUgnWSK5SeL0Qaudxv1mr17JU0vJ1f78yApJstAClppsRVDm4ILCWaDNckMuoeMOPiiXT0SHA7JahCgJrW/NLukcOSe0+kP7Oohzlw4JV2+yyGat2cJU9itb37Y9iPYNu8Vqc6MM6u5tXnmkKpRz++nr19lPwLGnflLuqsaB38ODb8t0OcmGK+R1YpREEkv+H+Ys3EUTBQvYBaE93zUPxkwMC1HkubN8bnxBUCC9qXeIBeZAPYA8132C1Ivp6RH/b1z4u7gGc7CBrEKN22LCjFKmIVUxLBKmDUQtb5Xnrx5XsYhxwB5vqc9Nhob0a6DTDI1Ej4eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjA67moHJr6qtEN8VLhgjXFJSBpKl/2hEYrvhB/Pajo=;
 b=gRHWuHVPpmec6Ax4Lcn5xnrF1oGOlB8ZG5ApbmFLDhaBVDzaYODsCZc+TbXgJash0xMrDuoSCuPQsfLnCrA/qgdzx7QvfHaE+PXVyZa7LkT097BGyAKrN7yIlaS6AyCUlUrIgzSW6zL2VwklIyMukKnUHliOEYUllpP5UIkRW74=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.77.152) by
 BN8PR10MB3394.namprd10.prod.outlook.com (20.179.140.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Thu, 29 Aug 2019 10:39:36 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::e0e3:696d:ad87:592]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::e0e3:696d:ad87:592%7]) with mapi id 15.20.2220.013; Thu, 29 Aug 2019
 10:39:36 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "york.sun@nxp.com" <york.sun@nxp.com>
Subject: mpc85xx_edac PCI broken for P2010 and T1042, possibly more
Thread-Topic: mpc85xx_edac PCI broken for P2010 and T1042, possibly more
Thread-Index: AQHVXlYNMVx90vL3H0+OYJ1BrAUe5w==
Date:   Thu, 29 Aug 2019 10:39:36 +0000
Message-ID: <1b86d79d26eafe50731e0664e7b7bc05aab12b47.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22de06fe-c7b5-4d01-224b-08d72c6d3001
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR10MB3394;
x-ms-traffictypediagnostic: BN8PR10MB3394:
x-microsoft-antispam-prvs: <BN8PR10MB33947894E75E616325A01051F4A20@BN8PR10MB3394.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(199004)(189003)(8936002)(6436002)(66066001)(2501003)(25786009)(66946007)(36756003)(6512007)(6486002)(6116002)(305945005)(6506007)(110136005)(7736002)(99286004)(71190400001)(71200400001)(26005)(118296001)(2906002)(476003)(316002)(2616005)(3846002)(86362001)(102836004)(186003)(8676002)(5660300002)(66556008)(256004)(14454004)(66476007)(14444005)(81166006)(478600001)(81156014)(64756008)(486006)(91956017)(53936002)(66446008)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR10MB3394;H:BN8PR10MB3540.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mVZp2VjyhqoY3e52w59xn9xnnpRxWV6dfxU/ikm90edvRxlgaFLP4f3HLU36X3b/xJfG6QBwPEXPVFXEQecdJOSkMJWlndBZ8BkQ2WaMFSZd0KJ6G3HYhANsyFAfjvsh0NsOUuthwZHiqXBKiwDDrjmpInXpObsgD7MXmqfwC3ykpIHQo3kt7ZCdoXro47OSUD7sEZG9i0sF4JcfU1PkSh1e3i7/afZ4Ct3+fM8Y/93whMVGrNC7QSUCRpkjrhIYP9FS0BYqAsKpo9/H/P6qurCX7Sz4mq3d0afwuI5LdHh0uclKV1KlUf3FpUy84xTSKibiT0CMiHn26AZKJWlB841SblNs9GBhyoNsR7UY0lIm36go2/9hqwgu1QZBhdmEZdxHH3ix5vrm7xjF9PKCGoG2n7nCky65rzYI/okBAU4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <01BCDE041013C04398B4BD32CA5371C5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22de06fe-c7b5-4d01-224b-08d72c6d3001
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 10:39:36.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4LaMaJ7Snsbn4XhmRG8l0I+DHgj+zecbNHx7jBWEoX59RN2CdPfk08SNNt6AgvaFBQpY7p6dcep3/i1daaicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3394
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

UENJZSBlcnJvcnMsIGRvbid0IGtub3cgd2hpY2gsIGNhdXNlcyBlbmRsZXNzIElSUXMgZm9yIEVE
QUMncyBQQ0llIHJvdXRpbmU6DQoNClsgICAxNy42OTA3MTZdIGlycSAyNjogbm9ib2R5IGNhcmVk
ICh0cnkgYm9vdGluZyB3aXRoIHRoZSAiaXJxcG9sbCIgb3B0aW9uKQ0KWyAgIDE3LjY5NzQxN10g
Q1BVOiAwIFBJRDogMCBDb21tOiBzd2FwcGVyIE5vdCB0YWludGVkIDQuMTQuOTIrICMyNA0KWyAg
IDE3LjcwMzMzNF0gQ2FsbCBUcmFjZToNClsgICAxNy43MDU3ODBdIFtkZjllZGYxMF0gW2MwMDU2
OTkwXSBfX3JlcG9ydF9iYWRfaXJxLmlzcmEuNysweDM0LzB4ZGMgDQoodW5yZWxpYWJsZSkNClsg
ICAxNy43MTMxODFdIFtkZjllZGYzMF0gW2MwMDU2ZDIwXSBub3RlX2ludGVycnVwdCsweDI3NC8w
eDJjMA0KWyAgIDE3LjcxODg0MF0gW2RmOWVkZjYwXSBbYzAwNTQ5ZTBdIGhhbmRsZV9pcnFfZXZl
bnRfcGVyY3B1KzB4MWEwLzB4MjA4DQpbICAgMTcuNzI1MjgxXSBbZGY5ZWRmYTBdIFtjMDA1NGE4
MF0gaGFuZGxlX2lycV9ldmVudCsweDM4LzB4NWMNClsgICAxNy43MzA5NDBdIFtkZjllZGZiMF0g
W2MwMDU3NjY4XSBoYW5kbGVfZmFzdGVvaV9pcnErMHhiMC8weDFlMA0KWyAgIDE3LjczNjg2N10g
W2RmOWVkZmMwXSBbYzAwNTQwNGNdIGdlbmVyaWNfaGFuZGxlX2lycSsweDNjLzB4NWMNClsgICAx
Ny43NDI3MDNdIFtkZjllZGZkMF0gW2MwMDA0YmUwXSBfX2RvX2lycSsweDQ4LzB4MTBjDQpbICAg
MTcuNzQ3NzUyXSBbZGY5ZWRmZjBdIFtjMDAwYzM5OF0gY2FsbF9kb19pcnErMHgyNC8weDNjDQpb
ICAgMTcuNzUyOTc3XSBbYzA0NTNlODBdIFtjMDAwNGQwOF0gZG9fSVJRKzB4NjQvMHhjNA0KWyAg
IDE3Ljc1Nzc2OF0gW2MwNDUzZWEwXSBbYzAwMGRhM2NdIHJldF9mcm9tX2V4Y2VwdCsweDAvMHgx
OA0KWyAgIDE3Ljc2MzI1N10gLS0tIGludGVycnVwdDogNTAxIGF0IGFyY2hfY3B1X2lkbGUrMHg0
Yy8weDVjDQpbICAgMTcuNzYzMjU3XSAgICAgTFIgPSBjcHVfc3RhcnR1cF9lbnRyeSsweDE3Yy8w
eDIwYw0KWyAgIDE3Ljc3MzQzN10gW2MwNDUzZjYwXSBbYzAwNGRlMWNdIGNwdV9zdGFydHVwX2Vu
dHJ5KzB4NzQvMHgyMGMgKHVucmVsaWFibGUpDQpbICAgMTcuNzgwNDA1XSBbYzA0NTNmYjBdIFtj
MDNmYzk4OF0gc3RhcnRfa2VybmVsKzB4MzRjLzB4MzYwDQpbICAgMTcuNzg1ODg5XSBbYzA0NTNm
ZjBdIFtjMDAwMDM4MF0gc2V0X2l2b3IrMHgxMGMvMHgxNDgNClsgICAxNy43OTEwMjRdIGhhbmRs
ZXJzOg0KWyAgIDE3Ljc5MzI5Nl0gWzxjMDIzOGU3ND5dIG1wYzg1eHhfcGNpX2lzcg0KWyAgIDE3
Ljc5NzIxM10gRGlzYWJsaW5nIElSUSAjMjYNCg0KVGhpcyBpcyBiZWNhdXNlDQpzdGF0aWMgaXJx
cmV0dXJuX3QgbXBjODV4eF9wY2lfaXNyKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCnsNCglzdHJ1
Y3QgZWRhY19wY2lfY3RsX2luZm8gKnBjaSA9IGRldl9pZDsNCglzdHJ1Y3QgbXBjODV4eF9wY2lf
cGRhdGEgKnBkYXRhID0gcGNpLT5wdnRfaW5mbzsNCgl1MzIgZXJyX2RldGVjdDsNCg0KCWVycl9k
ZXRlY3QgPSBpbl9iZTMyKHBkYXRhLT5wY2lfdmJhc2UgKyBNUEM4NVhYX1BDSV9FUlJfRFIpOw0K
DQoJaWYgKCFlcnJfZGV0ZWN0KQ0KCQlyZXR1cm4gSVJRX05PTkU7DQphbHdheXMgZW5kIHdpdGgg
SVJRX05PTkUuDQoNCg0KTWFraW5nIEVEQUMgcG9sbGVkIGp1c3QgbG9ncyBlbmRsZXNzIGdhcmJh
Z2U6DQpBdWcgMjkgMTA6NDQ6MjIgeGhhdWwtYjAyIGtlcm5lbDogUENJZSBlcnJvcihzKSBkZXRl
Y3RlZA0KQXVnIDI5IDEwOjQ0OjIyIHhoYXVsLWIwMiBrZXJuZWw6IFBDSWUgRVJSX0RSIHJlZ2lz
dGVyOiAweDAwMDAwMDAwDQpBdWcgMjkgMTA6NDQ6MjIgeGhhdWwtYjAyIGtlcm5lbDogUENJZSBF
UlJfQ0FQX1NUQVQgcmVnaXN0ZXI6IDB4MDAwMDAwMDANCkF1ZyAyOSAxMDo0NDoyMiB4aGF1bC1i
MDIga2VybmVsOiBQQ0llIEVSUl9DQVBfUjAgcmVnaXN0ZXI6IDB4MDAwMDAwMDANCkF1ZyAyOSAx
MDo0NDoyMiB4aGF1bC1iMDIga2VybmVsOiBQQ0llIEVSUl9DQVBfUjEgcmVnaXN0ZXI6IDB4MDAw
MDAwMDANCkF1ZyAyOSAxMDo0NDoyMiB4aGF1bC1iMDIga2VybmVsOiBQQ0llIEVSUl9DQVBfUjIg
cmVnaXN0ZXI6IDB4MDAwMDAwMDANCkF1ZyAyOSAxMDo0NDoyMiB4aGF1bC1iMDIga2VybmVsOiBQ
Q0llIEVSUl9DQVBfUjMgcmVnaXN0ZXI6IDB4MDAwMDAwMDANCg0KSXQgc2VlbXMgdG8gdGhhdCBQ
Q0kgZWRhYyBoYXMgbmV2ZXIgd29ya2VkIGFuZCBuZWVkcyBzb21lIGxvdmUgZnJvbSBOWFANCm5v
dCBzdXJlIHdobyBpcyB0aGUgTlhQIG1haW50YWluZXIgdGhvdWdoLCBZb3JrPw0KDQogIEpvY2tl
DQo=
