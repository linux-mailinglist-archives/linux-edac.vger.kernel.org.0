Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3888ADF352
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2019 18:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfJUQkt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Oct 2019 12:40:49 -0400
Received: from mail-eopbgr790073.outbound.protection.outlook.com ([40.107.79.73]:29146
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729011AbfJUQkt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 21 Oct 2019 12:40:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLJsq2qHaiK+ZgHpVaU1Msmjua9gVUpt9fLb162Qn6sb9UY/QHZkA92ZpwWwxsn67arthhaImMZiSl01CXWp0N3WWVWkQY7wCYLKruXRAQyDHTtJ5zScoP94t92nu1969N00qNhcKMaAWPrP2Oxcc8jUHDDFYnh04mk1ENXNLmx2cJL2q2WbUYGGVKGLle67oS51s0L8y0aq3j86YOvixlAfoPI5XUMY+vm8urLhtSqfaX3GsmB7k485YAX9qnNw7y+Mq9avDjg1MsVLmexlwwNcu3MHdQkvqT7IlVi/ixvkY0ut1sJPri7XneljbZLUmTKCc37/oFxKW1IXHgtyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jhDCcuz1BOoALwOTAI8b0aT1t+Uu6PkzO5MN1jYjCI=;
 b=eFXTRHuwe3N2fpWakcI36ckbj5PZuTHf+XcCWJvuJ+b5DRSNan1CcjuzZq8fZm8ADWptz8VwFuAXjNfD7fDGxwC9qTDbnV/WA8Ta9lkhOzCWVqJCA7Qf1Bh9AWvBeh36Y3DrJq703YIJLDkImDDtYbO4eyGJK2kyRTX3aGjPzynp4Her29ggvc8L0dJ2XsnhCCYmIjG8RMnh75cmyW5A+nSIqBHsqJdaP46j16k4KZQ6N/L4jLobyiwlrBeXTP+JHIkUIzfR/h3sLcb5wLEOF5yji7h03gEArrZvr3R1QvG0U+ztVPfno4QM3hFOhvqTZmbCrXmCk52KVuViyk5EeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jhDCcuz1BOoALwOTAI8b0aT1t+Uu6PkzO5MN1jYjCI=;
 b=XfiwCpJTjy/M+LWxHyX4CNei3ws5hEqJe2TiXSKCbUTrbZIMOIBjVjKqZwH4l+RD2Gcv/FV2o8fhcpDfBwo1iAITO1BDxxYJ3HBmVyf9pOpCOsGBPhe9QZx/n0elbFULpAZgrrFk81zV7CkRK9SvYR7b6t0uG7U1eRliZvZaxVk=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2751.namprd12.prod.outlook.com (52.135.107.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Mon, 21 Oct 2019 16:40:46 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2367.019; Mon, 21 Oct 2019
 16:40:46 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Topic: [PATCH 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Index: AQHVhcka4q8ovNc5PECMwVgUuntBS6dlMYeAgAAfVHA=
Date:   Mon, 21 Oct 2019 16:40:46 +0000
Message-ID: <SN6PR12MB26398930AFF9B992CFC9FF7DF8690@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
 <20191021144807.GE7014@zn.tnic>
In-Reply-To: <20191021144807.GE7014@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.25.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ece807fe-4c4c-4744-8c0e-08d756456c3c
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2751:
x-microsoft-antispam-prvs: <SN6PR12MB27518A1B8E430E135C57A7FBF8690@SN6PR12MB2751.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(199004)(189003)(13464003)(7736002)(11346002)(8936002)(71200400001)(71190400001)(478600001)(5660300002)(316002)(446003)(55016002)(2906002)(476003)(6916009)(305945005)(3846002)(25786009)(6116002)(256004)(74316002)(486006)(7696005)(86362001)(76176011)(6436002)(229853002)(66476007)(66556008)(64756008)(66446008)(76116006)(54906003)(99286004)(66066001)(9686003)(33656002)(52536014)(66946007)(14454004)(26005)(81166006)(81156014)(186003)(6506007)(53546011)(102836004)(4744005)(6246003)(4326008)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2751;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a906eh3A2tqaso3KrZDhzzZiJT5y8r6VpevMhOYUDKNbRbTNAlG4jPON5+fMd7E/zm0CobDEYguXVqAfXGdjEaW4QZ9xwVFErL7cCj+v3GUsIhT77pHY2NYMk2VCMwthsQ4cbazuZGz44GkCo24XDt1ti3JVQaaHqQOxXC3OTGLI3uOJ0WUcLyujKbt7lPkRA8p8oLZyYz6UqpxDOEQyQP6zp9Gj3Mr94gk2ihx0ZL0sRps+IhLm8B9Xu+DJrjgQsbS9oIY28m+sJsNOE08/8wFhAhxAQJKTOMBtnVKK/vrv7AgSUmrfPV5t30wRm+LQAF27wH2rhsdnPJhlhJFGMAe39MAbmpuSmmuiTQhnqszNwuwCws4nuEy+kceDTUdYDG2DsQRL2vGHMQco0FjwHZ4vzZFn6Fqluwb7ZkZaflSkp3Hvxs5Al9rvKv3A9glJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece807fe-4c4c-4744-8c0e-08d756456c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 16:40:46.3354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3FTWdbp/8xcNGniEnrm+wiS+NIzow/++rNcMTzPljlFAoVeBn43OQPEoi5qyXdferoDv2MclEXNkubbc7qJ/uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2751
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1rZXJuZWwtb3duZXJA
dmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBC
ZWhhbGYgT2YgQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyMSwgMjAx
OSAxMDo0OCBBTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4N
Cj4gQ2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC82XSBBTUQ2NCBFREFDOiBDaGVjayBmb3Ig
bm9kZXMgd2l0aG91dCBtZW1vcnksIGV0Yy4NCj4gDQo+IE9uIEZyaSwgT2N0IDE4LCAyMDE5IGF0
IDAzOjMxOjI1UE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdyb3RlOg0KPiA+IEZyb206IFlhemVu
IEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCj4gPg0KPiA+IEhpIEJvcmlzLA0KPiA+
DQo+ID4gVGhpcyBzZXQgY29udGFpbnMgdGhlIG5leHQgcmV2aXNpb24gb2YgdGhlIFJGQyBwYXRj
aGVzIEkgaW5jbHVkZWQgd2l0aA0KPiA+IHRoZSBsYXN0IEFNRDY0IEVEQUMgdXBkYXRlcy4gSSBk
cm9wcGVkIHRoZSBSRkMgdGFncywgYW5kIEkgYWRkZWQgYQ0KPiA+IGNvdXBsZSBvZiBuZXcgcGF0
Y2hlcy4NCj4gDQo+IFlhaCwgbG9va3MgcHJldHR5IG11Y2ggZ29vZCwgbW9kdWxvIHRoZSBtaW5v
ciB0aGluZ3MgSSBjb21tZW50ZWQgb24NCj4gZWFybGllci4NCj4gDQoNClRoYW5rIHlvdS4gSSds
bCBzZW5kIGFub3RoZXIgcmV2aXNpb24gc29vbi4NCg0KLVlhemVuDQo=
