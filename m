Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1977F186150
	for <lists+linux-edac@lfdr.de>; Mon, 16 Mar 2020 02:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgCPBau (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 15 Mar 2020 21:30:50 -0400
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:25573
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729334AbgCPBau (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 15 Mar 2020 21:30:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuCvPyqAdlg/MKCmfgjT0nusL2Z4wV09IokBR+4zG7C1D4aDVc7ysuHFHfXbzKYQgewaGAPeKXixW8+ioHeAKGKudDtj4keHeKAvHfpUJtb4zZQt0PPOEthpdTrDi5iqpX4foAVw6dfAzG7jZaAvQ/OfgcF8lMcciY5yMeiYUlWZjUO3ytBdUkO+oqs0uH+nPf2jvDp7vx/TANYufyVVCs5eF1GhSG52jf47ujBFFUJlOt6foFoDpFqP0mzxkbbJjtTuktITkzhH2Uh2PtklX7+jKO4BhqEYMRdsZWxk8/8ouM810lt3LT+/xuAcXCbb2ORmbjSeObzFhNKsc+QymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaOe1Qi0ZVta9DnAM1ONvA0fHvumS7edsay7BFbRvE0=;
 b=OfcN+jv1AulWsMugsT960UN3BRw0aEBLGOS89QEJc5E7mebfMrZ0AnPKsyjMoB/AZL1gGTf5YP+Wf9OPLz1yOsQgVbTR4TWYaY5c17lyKNpJI2kqheNHFo6s1D6aUAonPypoKVe1IVg0tjxeLNTi1FcThENXE71dLT/2mJbPL0/qYjZPDjnIuI+/QnrEDcWo0BZP9v9sk3CvebkSiS0l1hUP+X5ELmVIfPyQGhgS2EsbYmPjdncX5LMC5rvtO7Ovl8fJUdDW1tQzJ2o4smwok7g0eSmUo6BdsgCbyuEihKmcEURE3wxZoqkSVAbGtmg/CueXhSw96frMwKr8ipXduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaOe1Qi0ZVta9DnAM1ONvA0fHvumS7edsay7BFbRvE0=;
 b=MoHutAAx/INxJWTO6rjV5t9k+H2CBM+o2PUppQMIERzBQXVYuwQA6xNXDdHL6QdWyLtaRNgKRHCXXiAy6Hdr9u7p4Kuh9QxjHfP2wvA6weywy9nQfsN8M33QNJuszPfsO8c1iTO6hYk8KoRB6f63+/ueuvtd2lcQGd+VQ4/1O9o=
Received: from AM6PR04MB6584.eurprd04.prod.outlook.com (20.179.245.21) by
 AM6PR04MB6694.eurprd04.prod.outlook.com (20.179.247.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Mon, 16 Mar 2020 01:30:39 +0000
Received: from AM6PR04MB6584.eurprd04.prod.outlook.com
 ([fe80::3c28:9128:54b1:ee7c]) by AM6PR04MB6584.eurprd04.prod.outlook.com
 ([fe80::3c28:9128:54b1:ee7c%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 01:30:39 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v2] EDAC: synopsys: Fix the wrong call of pinf->col
 parameter
Thread-Topic: [PATCH v2] EDAC: synopsys: Fix the wrong call of pinf->col
 parameter
Thread-Index: AQHV7d33uILy8BVBmkGIj78HSs8mPahKKjMAgABbh2A=
Date:   Mon, 16 Mar 2020 01:30:39 +0000
Message-ID: <AM6PR04MB658495A13744517A6E263D2292F90@AM6PR04MB6584.eurprd04.prod.outlook.com>
References: <1582856183-5007-1-git-send-email-sherry.sun@nxp.com>
 <20200315195024.GB10926@zn.tnic>
In-Reply-To: <20200315195024.GB10926@zn.tnic>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sherry.sun@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 096d7247-a773-45c6-e09e-08d7c949a297
x-ms-traffictypediagnostic: AM6PR04MB6694:|AM6PR04MB6694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6694FC69D4C542715B1825B792F90@AM6PR04MB6694.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(199004)(76116006)(52536014)(86362001)(33656002)(44832011)(71200400001)(66946007)(2906002)(5660300002)(66446008)(64756008)(66476007)(66556008)(8936002)(478600001)(186003)(4326008)(55016002)(966005)(9686003)(45080400002)(316002)(6506007)(7696005)(26005)(81156014)(8676002)(81166006)(6916009)(54906003)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6694;H:AM6PR04MB6584.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XlgE7JpAbzbg5czfTfSaiSk3w4d7FVAm0bzWsYaymjsGBLxZoVLs7EvvqXwSbMzlTAfBBJZLZg+7gGdXgBKrbCKH+0nUabXId4gOK2J/MFQV+hPz8v8Lp59P53yMoyBvh8vWMw2ojRPpB85sWhmovyUTJqpwjPnNMVJTv4oCuu9+6wOKfPEMX3wXBBlln/NqBBwjhHqyojc9m7EQkT8q2OooWpk4bGL357yJ5/Sd+sUsXM+opo3V3qg4CeYzNVLoYJ4NXsiw791rFnJtSs2w3ddTcOkIE1bLJSeP+Zi0lWHvPS2VFxer/kgkG+vFP4zHVSyR75brbeplHoJTNSV50zkK1iCYfRxOgp9I/t0lrhF36NJm0oOVeU6H9QhugHl5NSVuo6HFrLyZKf1n+SLpI2Fqm3A1OHNXwqQlW7M0zIcW549ewGu/K5hCbRcLugh3YYayDeEmIZ3OoXrFAUYTVnjfLFcFy3tAvSo3mSYdKCR6ISejmFmt/disJgIQ0rWlz1ftAJ1YC5A4Sx5t53odfi4PcWhcZwJ6ARkBIFHXDgETxSiODBUtn/IG+NzxkiDihkIeGdgPmXAHdgZhFKZ63pJnt0VhTlDF7mEW710LRAjgHB45WAVFryIZmv3+Lkhv
x-ms-exchange-antispam-messagedata: BePMXkS8oMLyRGIu6fjSIGqKfOi33huhVfszwzVmzsM6hxub3zoo2xQyKiC1R+0/GBO39l2UOjd0hxM6jZ/1EQv1JwRbXDP82Ku7U/kSlCFIZnrGE56YL9FjwshVFLpfK6aWJ5C/MekouoeamScQAw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096d7247-a773-45c6-e09e-08d7c949a297
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 01:30:39.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6LkeTWIPu7WxsIn9cNZ/ByJ0g/tNiL90rcyqcOese1xY7OH16gi0CBOu+g1z1okgmxYDMme+5+nhyFFnynu0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6694
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXNsYXYsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9y
aXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IDIwMjDlubQz5pyIMTbml6UgMzo1
MA0KPiBUbzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiBDYzogbWNoZWhhYkBr
ZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50ZWwuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29tOw0KPiBy
cmljaHRlckBtYXJ2ZWxsLmNvbTsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207IG1hbmlzaC5uYXJh
bmlAeGlsaW54LmNvbTsNCj4gbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBG
cmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gRURB
Qzogc3lub3BzeXM6IEZpeCB0aGUgd3JvbmcgY2FsbCBvZiBwaW5mLT5jb2wNCj4gcGFyYW1ldGVy
DQo+IA0KPiBPbiBGcmksIEZlYiAyOCwgMjAyMCBhdCAxMDoxNjoyM0FNICswODAwLCBTaGVycnkg
U3VuIHdyb3RlOg0KPiA+IFNpbmNlIFp5bnFNUCBwbGF0Zm9ybSBjYWxsIHp5bnFtcF9nZXRfZXJy
b3JfaW5mbygpIGZ1bmN0aW9uIHRvIGdldA0KPiA+IGNlL3VlIGluZm9ybWF0aW9uLiBJbiB0aGlz
IGZ1bmN0aW9uLCBwaW5mLT5jb2wgcGFyYW1ldGVyIGlzIG5vdCB1c2VkLA0KPiA+IHRoaXMgcGFy
YW1ldGVyIGlzIG9ubHkgdXNlZCBieSBaeW5xIHBsYXRmb3JtZSBpbg0KPiA+IHp5bnFfZ2V0X2Vy
cm9yX2luZm8oKS4gU28gaGVyZSBwaW5mLT5jb2wgc2hvdWxkIG5vdCBiZSBjYWxsZWQgYW5kDQo+
ID4gcHJpbnRlZCBmb3IgWnlucU1QLCBuZWVkIHJlbW92ZSBpdC4NCj4gDQo+IEVyciwgdGhlIGlu
dGVycnVwdCBoYW5kbGVyIGludHJfaGFuZGxlcigpIGNhbGxzIHRoZSAtPmdldF9lcnJvcl9pbmZv
KCkgZnVuY3Rpb24NCj4gcG9pbnRlciBhbmQgdGhlbiBjYWxscyBoYW5kbGVfZXJyb3IoKS4gSS5l
LCB0aGUgc2FtZSBwYXRoIGVuZGluZyBpbg0KPiBoYW5kbGVfZXJyb3IoKSBpcyBjYWxsZWQgb24g
Ym90aDogWnlucSBhbmQgWnlucU1QLCBvbmUgdGhyb3VnaCB0aGUNCj4gaW50ZXJydXB0IGFuZCB0
aGUgb3RoZXIgdGhyb3VnaCB0aGUgcG9sbGVyLg0KPiANCj4gQmVjYXVzZSBpdCBsb29rcyBsaWtl
IHRoZSBpbnRlcnJ1cHQgc3VwcG9ydCBpcyBvbmx5IG9uIFp5bnFNUD8gSSdtIGxvb2tpbmcgYXQN
Cj4gdGhhdCBERFJfRUNDX0lOVFJfU1VQUE9SVCB0aGluZy4NCj4gDQo+IElmIHNvLCB0aGVuIHlv
dSBuZWVkIHRvIHJlbmFtZSB0aGUgaW50ZXJydXB0IGhhbmRsZXIgdG8NCj4genlucW1wX2ludHJf
aGFuZGxlcigpLg0KPiANCj4gQW5kIG5vcm1hbCBaeW5xIHBsYXRmb3JtIHVzZXMgY2hlY2tfZXJy
b3JzKCkgd2hpY2ggdGhlbiBjYWxscw0KPiBoYW5kbGVfZXJyb3IoKS4NCj4gDQo+IFNvIHN0aWxs
IG5vdCBnb29kIGVub3VnaDogeW91IHByb2JhYmx5ICJmaXhlZCIgaXQgb24gWnlucU1QIGJ1dCBi
cm9rZSBpdCBvbg0KPiBaeW5xIGJlY2F1c2UgY2hlY2tfZXJyb3JzKCkgY2FsbHMgLT5nZXRfZXJy
b3JfaW5mbygpIHdoaWNoIGlzDQo+IHp5bnFfZ2V0X2Vycm9yX2luZm8oKSBhbmQgd2lsbCBoYXZl
IHBvcHVsYXRlZCBwaW5mLT5jb2wuDQo+IA0KPiBZb3UgbmVlZCB0byBkaWZmZXJlbnRpYXRlIGJl
dHdlZW4gWnlucSBhbmQgWnlucU1QIGluIGhhbmRsZV9lcnJvcigpIGFuZA0KPiBpc3N1ZSB0aGUg
cHJvcGVyIHN0cmluZyBkZXBlbmRpbmcgb24gdGhlIHBsYXRmb3JtLg0KDQpNYXliZSB5b3UgbWlz
dW5kZXJzdG9vZCB0aGUgaGFuZGxlX2Vycm9yKCksIHRoaXMgZnVuY3Rpb24gaGFzIGFscmVhZHkg
DQpkaXN0aW5ndWlzaGVkIGJldHdlZW4gWnlucSBhbmQgWnlucU1QIHRocm91Z2ggcHJpdi0+cF9k
YXRhLT5xdWlya3MuDQpBbmQgd2hhdCBJIGFtIGRvaW5nIGluIHRoaXMgcGF0Y2ggaXMgdG8gcmVt
b3ZlIHRoZSB1c2VsZXNzIHBpbmYtPmNvbCBpbiBaeW5xTVANCnBhcnQsIHdoaWNoIHdvbid0IGJy
ZWFrIHRoZSBaeW5xIHBhcnQuDQoNClRoYW5rcw0KU2hlcnJ5IFN1bg0KDQoNCj4gDQo+IEFGQUlD
VC4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4gDQo+IGh0dHBz
Oi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRnBlb3BsDQo+IGUua2VybmVsLm9yZyUyRnRnbHglMkZub3Rlcy1hYm91dC0NCj4gbmV0aXF1
ZXR0ZSZhbXA7ZGF0YT0wMiU3QzAxJTdDc2hlcnJ5LnN1biU0MG54cC5jb20lN0M5NDhiZjExMjNm
NmYNCj4gNDcxN2E2MTUwOGQ3YzkxYTE5M2IlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMw
MTYzNSU3QzAlN0MwDQo+ICU3QzYzNzE5ODk4NjI1NzE3NTE0OSZhbXA7c2RhdGE9Tzh0eGNTa1Rw
TzNJMzRLVUwwcWJvUSUyQnZQbWUNCj4gRDdsWVBIc0FoV2F2ZXZXZyUzRCZhbXA7cmVzZXJ2ZWQ9
MA0K
