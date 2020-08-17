Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547682467B0
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 15:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgHQNtW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 09:49:22 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:3990 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbgHQNtT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Aug 2020 09:49:19 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HDgpD6008031;
        Mon, 17 Aug 2020 13:49:05 GMT
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 32x6pm6em7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 13:49:05 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id 1DDA94F;
        Mon, 17 Aug 2020 13:49:04 +0000 (UTC)
Received: from G9W8668.americas.hpqcorp.net (16.220.49.27) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 13:49:04 +0000
Received: from G2W6311.americas.hpqcorp.net (16.197.64.53) by
 G9W8668.americas.hpqcorp.net (16.220.49.27) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 17 Aug 2020 13:48:51 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.241.52.12) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 17 Aug 2020 13:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/KCrDR3Rk/PCt/NHSy8/PXiWGxXOIkjXZtwiVzf2feNuw9xQwdaAlxb1IC0/NqKAET58IclI1u2PNZ2FR1RyobDsenYYnQ4cfYWfhZzYa+DEFG/J1k48eHBKB7D4FYfHV0JSYvHgc+vuMvt+C/I/itvpNGdefBPP/tn9CXCnVoWsR+HYsXGJCsumX+jJMSg24zqez4aGuEC8Rveg6ON6fWTM5NxissVPUMoE6xM26vm8ZJaMpCZ6X4movnpV2NHpfHG0MuCr7usgg/BqsY/nF0r3pn0afspGDrJgCQBSqJLYAKsz8fQ5Xrpa0PvJAeTyTtoYDZ55g44+VKfngtsyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4nwP2rqDdCNWMQXDRBBnssd46Hm6MxgK/19rnSKjjc=;
 b=AiyDz1iMr36IU5Np7MgGU3su3HrM4CuvYyNDit8HtbnVuNPMpn9EbroPEc21QoXR08mCOcq88x//jm+Drg0grl9pGIoYWy1CRYjIB3If0go226JG1mRcnjEcaZ9RRv6xIGbNJz2A+UL5HtmdNLDvLnfJ+U8AFLgkDUvSBglJyCjK7umgiyhAaNVnaDvXT8HEYxHdkriIG6tRLk5YFZRbonA0LP9+ExDLcAenx9Tq6yhLU8Y4z147hZekppfsgVOxlZEXXIqvD0g2EIIHO00ZrX3ZVZIXEtDk7C5jSflGQu3mc7lzf/v5YSynQ+gHtyjYNM8Q+AEZg3uDWC6B4Jo31A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from AT5PR8401MB0978.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7425::12) by AT5PR8401MB0884.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7428::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 13:48:29 +0000
Received: from AT5PR8401MB0978.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8856:8df7:eaf0:43d4]) by AT5PR8401MB0978.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8856:8df7:eaf0:43d4%10]) with mapi id 15.20.3283.028; Mon, 17 Aug
 2020 13:48:29 +0000
From:   "Kluver, Alex" <alex.kluver@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>
Subject: RE: [PATCH] edac,ghes,cper: Add Row Extension to Memory Error Record
Thread-Topic: [PATCH] edac,ghes,cper: Add Row Extension to Memory Error Record
Thread-Index: AQHWZEHkCLvLaIuISEm/49GAlStGt6k5BcQAgANnvlA=
Date:   Mon, 17 Aug 2020 13:48:29 +0000
Message-ID: <AT5PR8401MB0978F8063A4F5157E67D4553E55F0@AT5PR8401MB0978.NAMPRD84.PROD.OUTLOOK.COM>
References: <20200727181445.111002-1-alex.kluver@hpe.com>
 <20200815093332.GD25814@zn.tnic>
In-Reply-To: <20200815093332.GD25814@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2600:6c46:6f80:1d7:89ad:44a3:8003:6c6a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 737efa38-8d9b-4630-00a1-08d842b4390f
x-ms-traffictypediagnostic: AT5PR8401MB0884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AT5PR8401MB0884F05EFE4303FD2D1A6E04E55F0@AT5PR8401MB0884.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7CgZINVBVV3zM+fDCwGnUiGTa4VlQt07Nk8XYq9BhZen8zI7L9tl5R5TYNo2/ndh1Ws35aBNdFy5gXD/4dD59k3/U3a558Cg3lFJONlsa7opfbQ7m8oAt75debpphgjGqKrAJLKQsfuAiKHX9/cqDktlJhXrcdkMLUUncnpeZvrPhKb8kDW7E7ZvNLF7ujRNuLmM4efIbrCLuUOX9QwfJNBL/xalOcffXtZtlf6hRGPgsRIU3UpOWv2j844cASt8Ab+XQv51NHTubnvWdAvj9TYjQIq9zY0Ve5QTuYDqHZjOJc9YMf1uYEyIuKfZYACbzzs7HANARx+vlpH+u86tlGd8eyPOJ4PHpRRAy0mxUsw47qrC8ycm0Q45g8AezKPmKOuAta0J2bw6cEhmUx2Xogv9RdDbY+yXk/Sr+IY9+CUwpaY2K6K+WskQysd+PWgiikvDRKPb7majtwjMYsLOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AT5PR8401MB0978.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(39860400002)(346002)(396003)(316002)(53546011)(6506007)(83380400001)(54906003)(7696005)(5660300002)(86362001)(186003)(33656002)(6916009)(66556008)(66446008)(66476007)(478600001)(76116006)(66946007)(52536014)(9686003)(71200400001)(8936002)(966005)(2906002)(55016002)(64756008)(4326008)(8676002)(142933001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +spB1svowFI/0fs76IZm1qwPU8ieJbO2yyxAG0DgtLutKPOwHt72Gwoq6p1m8j1Jz8WZ2tdc6VYbgWcXyg6F3ehB5UhwCHEDp1ke/uo05n526MjN2k06VU22uNAM64K+l5LITMzX6HofHwLScwFuIrNnL61QYeafb+3lw/Is01am6OOsJFNaS6dmWH3F5S/TvgA/ojz23iAT0dO70nSqDaGca4hj5r0RfkAAK0eCC1rECDKq0rGxT6OIBTPxAHYjo2KwPOXaX/QhkgskqlII9cnOUjnLcmDc8v6gZNWGFcocr2yk9JtzhoJbadZacCiTjTBMS4iEMlvUOkjx7hovEw3a9CIjav8i45teviFTV5x7PuWZnIVY8011sPwkd8tYhxdgAarZyJj1hS64vSWFsENnOL1IwUK1Zy0RUDrxIrM3sOKAtqy3w/VhPj7Cehv+ZXyxdIMXqtHaFiq4Fj4YOBaRxAE2WYWiExmWPE2kN9z4BS7/M7loaeGRUtbUDRD3ME+m8lJUjz0HfECjxbY3+v/Y4rwd2kS9t9C9FHcpf2f9nZzlrFaU2cW9R5jZ2QzxrDRIQFJJTymegQBMjTmrUmBRx+MPSZMoAe6sbt64T5B8xfxU7OtUV00axJ1dDnZ94Ozjt7AVF2Deakf9TXc7m23PVF16l2JixcyOAIJbVu3KC27VXKZhzaoAMLdZBGIgXITcbcxWrGFEDwqheD9G5g==
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT5PR8401MB0978.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 737efa38-8d9b-4630-00a1-08d842b4390f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 13:48:29.0616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GakPEBOA7ImsfpZofxVI22QUUnp8d2UgnDDh+1QM1pmFNRVwhVCJpKxlxgsCjKjIVUCoM7gGUOtlo4r0dQMyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0884
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_09:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008170105
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

WWVzLCBJIGFtIHdvcmtpbmcgb24gYSByZXN1Ym1pdC4gVGhlIHVwZGF0ZWQgcGF0Y2ggd2lsbCBi
ZSByZXN1Ym1pdHRlZCBpbiBhIHNlcmllcyBvZiBwYXRjaGVzIHRoYXQgaW5jbHVkZSBvdGhlciB1
cGRhdGVzIHRvIHRoZSBjcGVyIG1lbW9yeSByZWNvcmQuDQoNClRoYW5rcywNCi0tQWxleCBLbHV2
ZXINCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCb3Jpc2xhdiBQZXRr
b3YgPGJwQGFsaWVuOC5kZT4gDQpTZW50OiBTYXR1cmRheSwgQXVndXN0IDE1LCAyMDIwIDQ6MzQg
QU0NClRvOiBLbHV2ZXIsIEFsZXggPGFsZXgua2x1dmVyQGhwZS5jb20+DQpDYzogbGludXgtZWRh
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGFyZGJAa2Vy
bmVsLm9yZzsgbWNoZWhhYkBrZXJuZWwub3JnOyBBbmRlcnNvbiwgUnVzcyA8cnVzcy5hbmRlcnNv
bkBocGUuY29tPjsgU2l2YW5pY2gsIERpbWl0cmkgPGRpbWl0cmkuc2l2YW5pY2hAaHBlLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGVkYWMsZ2hlcyxjcGVyOiBBZGQgUm93IEV4dGVuc2lvbiB0
byBNZW1vcnkgRXJyb3IgUmVjb3JkDQoNCk9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0IDAxOjE0OjQ1
UE0gLTA1MDAsIEFsZXggS2x1dmVyIHdyb3RlOg0KPiBNZW1vcnkgZXJyb3JzIGNvdWxkIGJlIHBy
aW50ZWQgd2l0aCBpbmNvcnJlY3Qgcm93IHZhbHVlcyBzaW5jZSB0aGUgDQo+IERJTU0gc2l6ZSBo
YXMgb3V0Z3Jvd24gdGhlIDE2IGJpdCByb3cgZmllbGQgaW4gdGhlIENQRVIgc3RydWN0dXJlLiAN
Cj4gVUVGSSBTcGVjaWZpY2F0aW9uIFZlcnNpb24gMi44IGhhcyBpbmNyZWFzZWQgdGhlIHNpemUg
b2Ygcm93IGJ5IA0KPiBhbGxvd2luZyBpdCB0byB1c2UgdGhlIGZpcnN0IDIgYml0cyBmcm9tIGEg
cHJldmlvdXNseSByZXNlcnZlZCBzcGFjZSB3aXRoaW4gdGhlIHN0cnVjdHVyZS4NCj4gDQo+IFdo
ZW4gbmVlZGVkLCBhZGQgdGhlIGV4dGVuc2lvbiBiaXRzIHRvIHRoZSByb3cgdmFsdWUgcHJpbnRl
ZC4NCj4gDQo+IEJhc2VkIG9uIFVFRkkgMi44IFRhYmxlIDI5OS4gTWVtb3J5IEVycm9yIFJlY29y
ZA0KPiANCj4gVGVzdGVkLWJ5OiBSdXNzIEFuZGVyc29uIDxydXNzLmFuZGVyc29uQGhwZS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggS2x1dmVyIDxhbGV4LmtsdXZlckBocGUuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvZWRhYy9naGVzX2VkYWMuYyAgICB8IDEwICsrKysrKysrLS0NCj4gIGRy
aXZlcnMvZmlybXdhcmUvZWZpL2NwZXIuYyB8IDExICsrKysrKysrKy0tDQo+ICBpbmNsdWRlL2xp
bnV4L2NwZXIuaCAgICAgICAgfCAgOSArKysrKysrLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMjQg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2VkYWMvZ2hlc19lZGFjLmMgYi9kcml2ZXJzL2VkYWMvZ2hlc19lZGFjLmMgaW5kZXggDQo+IGNi
M2RhYjU2YTg3NS4uY2ZhMzE1NjMwMGY1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2VkYWMvZ2hl
c19lZGFjLmMNCj4gKysrIGIvZHJpdmVycy9lZGFjL2doZXNfZWRhYy5jDQo+IEBAIC0zMzcsOCAr
MzM3LDE0IEBAIHZvaWQgZ2hlc19lZGFjX3JlcG9ydF9tZW1fZXJyb3IoaW50IHNldiwgc3RydWN0
IGNwZXJfc2VjX21lbV9lcnIgKm1lbV9lcnIpDQo+ICAJCXAgKz0gc3ByaW50ZihwLCAicmFuazol
ZCAiLCBtZW1fZXJyLT5yYW5rKTsNCj4gIAlpZiAobWVtX2Vyci0+dmFsaWRhdGlvbl9iaXRzICYg
Q1BFUl9NRU1fVkFMSURfQkFOSykNCj4gIAkJcCArPSBzcHJpbnRmKHAsICJiYW5rOiVkICIsIG1l
bV9lcnItPmJhbmspOw0KPiAtCWlmIChtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01F
TV9WQUxJRF9ST1cpDQo+IC0JCXAgKz0gc3ByaW50ZihwLCAicm93OiVkICIsIG1lbV9lcnItPnJv
dyk7DQo+ICsJaWYgKG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIChDUEVSX01FTV9WQUxJRF9S
T1cgfCBDUEVSX01FTV9WQUxJRF9ST1dfRVhUKSkgew0KPiArCQl1MzIgcm93X2V4dGVuZGVkID0g
MDsNCj4gKwkJaWYgKG1lbV9lcnItPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX1JP
V19FWFQpDQo+ICsJCQlyb3dfZXh0ZW5kZWQgPSAobWVtX2Vyci0+ZXh0ZW5kZWQgJiBDUEVSX01F
TV9FWFRfUk9XX01BU0spDQo+ICsJCQkJPDxDUEVSX01FTV9FWFRfUk9XX1NISUZUOw0KPiArCQly
b3dfZXh0ZW5kZWQgfD0gbWVtX2Vyci0+cm93Ow0KPiArCQlwICs9IHNwcmludGYocCwgInJvdzol
ZCAiLCByb3dfZXh0ZW5kZWQpOw0KPiArCX0NCj4gIAlpZiAobWVtX2Vyci0+dmFsaWRhdGlvbl9i
aXRzICYgQ1BFUl9NRU1fVkFMSURfQ09MVU1OKQ0KPiAgCQlwICs9IHNwcmludGYocCwgImNvbDol
ZCAiLCBtZW1fZXJyLT5jb2x1bW4pOw0KPiAgCWlmIChtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMg
JiBDUEVSX01FTV9WQUxJRF9CSVRfUE9TSVRJT04pIGRpZmYgDQo+IC0tZ2l0IGEvZHJpdmVycy9m
aXJtd2FyZS9lZmkvY3Blci5jIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvY3Blci5jIA0KPiBpbmRl
eCBmNTY0ZTE1ZmJjN2UuLjVmYWFmNmVjZDY1OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJt
d2FyZS9lZmkvY3Blci5jDQo+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL2NwZXIuYw0KPiBA
QCAtMjM0LDggKzIzNCwxNCBAQCBzdGF0aWMgaW50IGNwZXJfbWVtX2Vycl9sb2NhdGlvbihzdHJ1
Y3QgY3Blcl9tZW1fZXJyX2NvbXBhY3QgKm1lbSwgY2hhciAqbXNnKQ0KPiAgCQluICs9IHNjbnBy
aW50Zihtc2cgKyBuLCBsZW4gLSBuLCAiYmFuazogJWQgIiwgbWVtLT5iYW5rKTsNCj4gIAlpZiAo
bWVtLT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9ERVZJQ0UpDQo+ICAJCW4gKz0g
c2NucHJpbnRmKG1zZyArIG4sIGxlbiAtIG4sICJkZXZpY2U6ICVkICIsIG1lbS0+ZGV2aWNlKTsN
Cj4gLQlpZiAobWVtLT52YWxpZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9ST1cpDQo+IC0J
CW4gKz0gc2NucHJpbnRmKG1zZyArIG4sIGxlbiAtIG4sICJyb3c6ICVkICIsIG1lbS0+cm93KTsN
Cj4gKwlpZiAobWVtLT52YWxpZGF0aW9uX2JpdHMgJiAoQ1BFUl9NRU1fVkFMSURfUk9XIHwgQ1BF
Ul9NRU1fVkFMSURfUk9XX0VYVCkpIHsNCj4gKwkJdTMyIHJvd19leHRlbmRlZCA9IDA7DQo+ICsJ
CWlmIChtZW0tPnZhbGlkYXRpb25fYml0cyAmIENQRVJfTUVNX1ZBTElEX1JPV19FWFQpDQo+ICsJ
CQlyb3dfZXh0ZW5kZWQgPSAobWVtLT5leHRlbmRlZCAmIENQRVJfTUVNX0VYVF9ST1dfTUFTSykN
Cj4gKwkJCQk8PENQRVJfTUVNX0VYVF9ST1dfU0hJRlQ7DQoNClRoaXMgaXMgbm90IHZlcnkgcmVh
ZGFibGUuDQoNCj4gKwkJcm93X2V4dGVuZGVkIHw9IG1lbS0+cm93Ow0KPiArCQluICs9IHNjbnBy
aW50Zihtc2cgKyBuLCBsZW4gLSBuLCAicm93OiAlZCAiLCByb3dfZXh0ZW5kZWQpOw0KPiArCX0N
Cg0KQm90aCB0aG9zZSBodW5rcyBjb250YWluIGR1cGxpY2F0ZWQgY29kZSB3aGljaCBraW5kYSB3
YW50cyB0byBiZSBhbiBpbmxpbmUgZnVuY3Rpb24gaW4gY3Blci5oIHdoaWNoIHJldHVybnMgcm93
X2V4dGVuZGVkIGFuZCBnZXRzIGNhbGxlZCBieSBib3RoIHNpdGVzLiBBbmQgdGhlbiB0aGUgY2Fs
bCBzaXRlIGNhbiBsb29rIHZlcnkgc2ltcGxlOg0KDQogICAgICAgIGlmIChtZW1fZXJyLT52YWxp
ZGF0aW9uX2JpdHMgJiBDUEVSX01FTV9WQUxJRF9ST1cpDQogICAgICAgICAgICAgICAgcm93ID0g
bWVtX2Vyci0+cm93Ow0KDQogICAgICAgIC8qIGFkZCByb3cgZXh0ZW5zaW9uICovDQogICAgICAg
IHJvdyB8PSBjcGVyX2dldF9tZW1fZXh0ZW5zaW9uKCk7DQoNCiAgICAgICAgcCArPSBzcHJpbnRm
KHAsICJyb3c6JWQgIiwgcm93KTsNCg0Kd2l0aA0KDQpzdGF0aWMgaW5saW5lIHUzMiBjcGVyX2dl
dF9tZW1fZXh0ZW5zaW9uKHZvaWQpIHsNCglpZiAoIShtZW1fZXJyLT52YWxpZGF0aW9uX2JpdHMg
JiBDUEVSX01FTV9WQUxJRF9ST1dfRVhUKSkNCgkJcmV0dXJuIDA7DQoNCglyZXR1cm4gKG1lbV9l
cnItPmV4dGVuZGVkICYgQ1BFUl9NRU1fRVhUX1JPV19NQVNLKSA8PCBDUEVSX01FTV9FWFRfUk9X
X1NISUZUOyB9DQoNClNvbWV0aGluZyBhbG9uZyB0aG9zZSBsaW5lcy4uLg0KDQpUaHguDQoNCi0t
DQpSZWdhcmRzL0dydXNzLA0KICAgIEJvcmlzLg0KDQpodHRwczovL3Blb3BsZS5rZXJuZWwub3Jn
L3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQ0K
