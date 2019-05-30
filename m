Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC73005B
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2019 18:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3Qu3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 May 2019 12:50:29 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:41232 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbfE3Qu2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 May 2019 12:50:28 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UGdQ7l016156;
        Thu, 30 May 2019 16:50:14 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 2stgx930rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 16:50:13 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id BCB0EAA;
        Thu, 30 May 2019 16:50:12 +0000 (UTC)
Received: from G4W9332.americas.hpqcorp.net (16.208.32.118) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 16:50:12 +0000
Received: from G4W10204.americas.hpqcorp.net (2002:10cf:5210::10cf:5210) by
 G4W9332.americas.hpqcorp.net (2002:10d0:2076::10d0:2076) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 30 May 2019 16:50:11 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W10204.americas.hpqcorp.net (16.207.82.16) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 30 May 2019 16:50:11 +0000
Received: from DF4PR8401MB0601.NAMPRD84.PROD.OUTLOOK.COM (10.169.84.9) by
 DF4PR8401MB0569.NAMPRD84.PROD.OUTLOOK.COM (10.169.84.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 30 May 2019 16:50:08 +0000
Received: from DF4PR8401MB0601.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::483b:6e8c:d210:bf5c]) by DF4PR8401MB0601.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::483b:6e8c:d210:bf5c%7]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 16:50:08 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "rrichter@marvell.com" <rrichter@marvell.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Topic: [PATCH] EDAC, ghes: Fix grain calculation
Thread-Index: AQHVFjL7mIChQJ6XCE+Jet7tVN31eaaD4ecA
Date:   Thu, 30 May 2019 16:50:08 +0000
Message-ID: <d5e3135cd92a713c0d1d34f25d330cc6e55f8508.camel@hpe.com>
References: <20190529152232.187580-1-james.morse@arm.com>
In-Reply-To: <20190529152232.187580-1-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.219.163.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd1d022d-454a-4965-1ea1-08d6e51edfe5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DF4PR8401MB0569;
x-ms-traffictypediagnostic: DF4PR8401MB0569:
x-microsoft-antispam-prvs: <DF4PR8401MB0569D940F1B9DECC1C7A98AD82180@DF4PR8401MB0569.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(39860400002)(396003)(51914003)(189003)(199004)(66066001)(76116006)(6512007)(81166006)(486006)(71200400001)(8936002)(11346002)(186003)(446003)(476003)(229853002)(2616005)(66946007)(66476007)(66556008)(64756008)(66446008)(73956011)(53936002)(25786009)(7736002)(6506007)(8676002)(6436002)(71190400001)(81156014)(102836004)(6486002)(5660300002)(14454004)(99286004)(4326008)(86362001)(3846002)(76176011)(6116002)(2906002)(110136005)(26005)(118296001)(6246003)(68736007)(316002)(256004)(54906003)(36756003)(305945005)(2501003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB0569;H:DF4PR8401MB0601.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IBTKOCNl/FQ/T3IctV/vnuzvkbHUixgJVbt6R6LagvfoyaS2BUENJ8l80rGc1XC3CZK2h56w8a+c7bgGZyB2INlgifXFf0sHImfgF7bp9N1mqta2LvYELFy5AMd8TXn/eDP7V/VPRR84oINOea916JJhnq/BHdbdBIxqUkYXuV6M3UDP8YahwZsdSuv0M/QOSfwBJtdhOASBwrB7OvpOgeLHNv7DFn2luL/gSTXDryqc9C3kQdtu4bFkTRjk8uh5xjlICAvqulcreJ1Hm5cyo/JHdORsaFC3ehX4LyCvqwbwc6OGtCAaETi46p3uGUxXMOIiiSdvDtB291PNCk5Fz4Gz80/bnwYae9lT7D5eP/jYTCo6vTizh395A3k77k4qaEor5x6jzebfjXkbZ3AJKLdaTLCqAxh1LhHdPTTCM8o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10049C3ECFA9A7428A631BDEEB062BEC@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1d022d-454a-4965-1ea1-08d6e51edfe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 16:50:08.5266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: toshi.kani@hpe.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0569
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300118
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTI5IGF0IDE2OjIyICswMTAwLCBKYW1lcyBNb3JzZSB3cm90ZToNCj4g
Z2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoKSBhdHRlbXB0cyB0byBjYWxjdWxhdGUgdGhlICdn
cmFpbicgb3INCj4gZ3JhbnVsZSBhZmZlY3RlZCBieSB0aGUgZXJyb3IgZnJvbSB0aGUgZmlybXdh
cmUtcHJvdmlkZWQgJ3BoeXNpY2FsIGFkZHJlc3MNCj4gbWFzaycuIFRoaXMgbWFzayB0ZWxscyB1
cyB3aGljaCBiaXRzIG9mIHRoZSBwaHlzaWNhbCBhZGRyZXNzIGFyZSB2YWxpZC4NCj4gDQo+IFRo
ZSBjdXJyZW50IGNhbGN1bGF0aW9uOg0KPiA+IGUtPmdyYWluID0gfihtZW1fZXJyLT5waHlzaWNh
bF9hZGRyX21hc2sgJiB+UEFHRV9NQVNLKTsNCj4gDQo+IHdpbGwgYWx3YXlzIGNhdXNlIHRoZSB0
b3AgYml0cyB0byBiZSBzZXQgYXMgdGhleSBhcmUgY2xlYXJlZCBieSAmLA0KPiB0aGVuIHNldCBh
Z2FpbiBieSB+LiBGb3IgYSBoeXBlcnZpc29yIHJlcG9ydGluZyBpdHMgcGFnZS1zaXplIGFzIHRo
ZQ0KPiByZWdpb24gYWZmZWN0ZWQgYnkgdGhlIGVycm9yOg0KPiA+IHsxfVtIYXJkd2FyZSBFcnJv
cl06ICAgcGh5c2ljYWxfYWRkcmVzczogMHgwMDAwMDAwMGRlYWRiZWVmDQo+ID4gezF9W0hhcmR3
YXJlIEVycm9yXTogICBwaHlzaWNhbF9hZGRyZXNzX21hc2s6IDB4ZmZmZmZmZmZmZmZmZjAwMA0K
PiA+IHsxfVtIYXJkd2FyZSBFcnJvcl06ICAgZXJyb3JfdHlwZTogNiwgbWFzdGVyIGFib3J0DQo+
ID4gRURBQyBNQzA6IDEgQ0UgTWFzdGVyIGFib3J0IG9uIHVua25vd24gbGFiZWwgKCBwYWdlOjB4
ZGVhZCBvZmZzZXQ6MHhiZWVmDQo+ID4gZ3JhaW46LTYxNDQxIHN5bmRyb21lOjB4MCAtIHN0YXR1
cygweDAwMDAwMDAwMDAwMDAwMDEpOiByZXNlcnZlZCkNCj4gDQo+IEhlcmUgdGhlIGdyYWluIGhh
cyBiZWVuIG1pc2NhbGN1bGF0ZWQgYXMgdGhlIGh5cGVydmlzb3IgcmVwb3J0ZWQgYSA0Sw0KPiBz
aXplIGdyYW51bGUsIGR1ZSB0byBpdHMgcGFnZSBzaXplLCB3aGVyZWFzIHRoZSBndWVzdCBrZXJu
ZWwgdXNlcyA2NEsuDQo+IFRoaXMgZ2l2ZXMgdXMgZS0+Z3JhaW4gb2YgMHhmZmZmZmZmZmZmZmYw
ZmZmDQo+IA0KPiBGaXggdGhpcywgY2FsY3VsYXRpbmcgZ3JhaW5fYml0cyBkaXJlY3RseSBmcm9t
IH5waHlzaWNhbF9hZGRyZXNzX21hc2ssDQo+IGFuZCBzZXR0aW5nIGUtPmdyYWluIGZyb20gdGhh
dC4gSW4gdGhlIHNhbWUgZXhhbXBsZSB3ZSBub3cgZ2V0Og0KPiA+IEVEQUMgTUMwOiAxIENFIE1h
c3RlciBhYm9ydCBvbiB1bmtub3duIGxhYmVsICggcGFnZToweGRlYWQgb2Zmc2V0OjB4YmVlZg0K
PiA+IGdyYWluOjQwOTYgc3luZHJvbWU6MHgwIC0gc3RhdHVzKDB4MDAwMDAwMDAwMDAwMDAwMSk6
IHJlc2VydmVkKQ0KPiANCj4gQ2M6IFJvYmVydCBSaWNodGVyIDxycmljaHRlckBtYXJ2ZWxsLmNv
bT4NCj4gQ2M6IFRvc2hpIEthbmkgPHRvc2hpLmthbmlAaHBlLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogSmFtZXMgTW9yc2UgPGphbWVzLm1vcnNlQGFybS5jb20+DQo+IC0tLQ0KPiBUaGlzIGhhcyBh
bHdheXMgYmVlbiBicm9rZW4sIHNvIEkgc3VzcGVjdCBuby1vbmUgY2FyZXMgYWJvdXQgdGhpcywg
aXQgd2FzDQo+IGFkZGVkIGJ5Og0KPiBGaXhlczogZjA0YzYyYTcwMzZhICgiZ2hlc19lZGFjOiBh
ZGQgc3VwcG9ydCBmb3IgcmVwb3J0aW5nIGVycm9ycyB2aWEgRURBQyIpDQo+IA0KPiBJJ3ZlIG9u
bHkgdGVzdGVkIHRoaXMgd2l0aCBmaXJtd2FyZSBJJ3ZlIHdyaXR0ZW4uDQoNClRoYW5rcyBmb3Ig
dGhlIGZpeC4gIFRlc3RlZCBvbiBteSB4ODYgc3lzdGVtLg0KDQpUZXN0ZWQtYnk6IFRvc2hpIEth
bmkgPHRvc2hpLmthbmlAaHBlLmNvbT4NCg0KVGhhbmtzLA0KLVRvc2hpDQo=
