Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F7438DFE
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfFGOtp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 10:49:45 -0400
Received: from mail-eopbgr730067.outbound.protection.outlook.com ([40.107.73.67]:32448
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbfFGOtp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 10:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0hjsscWqNJJ5vRHA6SBePtSA7WR1luZIOLFq/NYB6c=;
 b=ePbaYKCUo+ywPdzZlo860wOXWYIGfgbVXXsBjAsuhCR/8sgOBVKcbfhuX3y3yV+v0BVA8XPNFF511PPONOqDdf+Ijf7J1cRb8bWojXLiHyMsGT+AIn20ScCdObQ2deBbuWrVr6aXv0P9NOP4PirU+RwDGM5HSWmMao9H1kh9Hkg=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2784.namprd12.prod.outlook.com (52.135.107.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 14:49:42 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 14:49:42 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Topic: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Index: AQHU/5PPbonhoiIaT0+tpMBUt0fOpKZt/3MAgAAEtbCAAA1jAIAAAELggAAGlYCAADB8kIAABZ8AgAAG7YCAANzUAIAAUaUwgAAal4CAAA3JgIAABf+AgAAE/ICAABizgIAAAygAgAAEo4CACWuboIAGhWIAgBC3iXA=
Date:   Fri, 7 Jun 2019 14:49:42 +0000
Message-ID: <SN6PR12MB263998ECCDF1E345FEB0869AF8100@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517163729.GE13482@zn.tnic> <20190517172648.GA18164@agluck-desk>
 <20190517174817.GG13482@zn.tnic> <20190517180607.GA21710@agluck-desk>
 <20190517193431.GI13482@zn.tnic>
 <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517200225.GK13482@zn.tnic>
 <SN6PR12MB26390759DB43763D3A482918F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190527232849.GC8209@cz.tnic>
In-Reply-To: <20190527232849.GC8209@cz.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ece35cb9-9527-4cb4-3728-08d6eb576046
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2784;
x-ms-traffictypediagnostic: SN6PR12MB2784:
x-microsoft-antispam-prvs: <SN6PR12MB2784B80BBE025AE0D5137105F8100@SN6PR12MB2784.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(13464003)(102836004)(229853002)(6506007)(53546011)(5660300002)(6436002)(316002)(76176011)(74316002)(256004)(6916009)(54906003)(72206003)(99286004)(52536014)(71190400001)(7696005)(478600001)(71200400001)(68736007)(186003)(86362001)(2906002)(66066001)(486006)(26005)(8676002)(33656002)(14454004)(6246003)(305945005)(4326008)(9686003)(66446008)(66476007)(11346002)(476003)(64756008)(66556008)(66946007)(446003)(7736002)(3846002)(6116002)(53936002)(73956011)(81156014)(76116006)(8936002)(25786009)(55016002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2784;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cfnd7yfoVWUY/9B+6maghkkL1i8VqEX/eICo03/HJ2vxVfSQAXnA+HevAVVaVxkmwk1iRtkkwhQSy8Fq28GiTNCP0jI2sS22aUDNKuP1nCl/6Q/wus2rus3dRSIn1kBnzgREXbwyPCsqFViDgwHsZJ6TEw2Hoh4xfZPJQoP1GDZzjBB72LlrEWS3lpNCE66A2apWaH6XhgVT/jbg3OcjUxK8UjF8vcEfeNVGrCxKClrcwOJIdzLxPlS9k074plZdbTF7nQKp6c5uRPpMbw9gCxAVrli4RlSoQU2dzGWo0MqxhHDSjM+9/ssZH4LviH2K1l0QPRL5u7zsfLKoRHZ/6XjgoiCRCFkYhnXRKKFOdWgmcn2jPFJNcWBMARAlGTHBmuOv4gTJeCy4P1zsFq1+uaR5B8FXzKI/ei8pR5cMDEc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece35cb9-9527-4cb4-3728-08d6eb576046
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 14:49:42.8910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogTW9uZGF5LCBNYXkgMjcsIDIwMTkgNjoyOSBQTQ0KPiBUbzog
R2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6IEx1Y2ssIFRvbnkg
PHRvbnkubHVja0BpbnRlbC5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyA1LzZdIHg4Ni9NQ0U6IFNhdmUgTUNBIGNvbnRyb2wgYml0cyB0aGF0IGdldCBzZXQg
aW4gaGFyZHdhcmUNCj4gDQo+IA0KPiBJIGd1ZXNzIHRoZSBjbGVhbmVzdCB3YXkgdG8gaGFuZGxl
IGhpcyBwcm9wZXJseSB3b3VsZCBiZSB0byBoYXZlIGENCj4gZnVuY3Rpb24gY2FsbGVkIHNvbWV0
aGluZyBsaWtlIF9fbWNoZWNrX2NwdV9pbml0X2JhbmtzKCkgd2hpY2ggZ2V0cw0KPiBjYWxsZWQg
aW4gbWNoZWNrX2NwdV9pbml0KCkgYWZ0ZXIgdGhlIHF1aXJrcyBoYXZlIHJ1biBhbmQgdGhlbiBk
b2VzIHRoZQ0KPiBmaW5hbCBwb2tpbmcgb2YgdGhlIGJhbmtzIGFuZCBzZXRzIGItPmluaXQgcHJv
cGVybHkuDQo+IA0KPiBfX21jaGVja19jcHVfaW5pdF9jbGVhcl9iYW5rcygpIHNob3VsZCB0aGVu
IGJlIHJlbmFtZWQgdG8NCj4gX19tY2hlY2tfY3B1X2NsZWFyX2JhbmtzKCkgdG8gZGVub3RlIHRo
YXQgaXQgb25seSBjbGVhcnMgdGhlIGJhbmtzIGFuZA0KPiB3b3VsZCBvbmx5IGRvOg0KPiANCj4g
ICAgICAgICAgICAgICAgIGlmICghYi0+aW5pdCkNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
Y29udGludWU7DQo+IA0KPiAgICAgICAgICAgICAgICAgd3Jtc3JsKG1zcl9vcHMuY3RsKGkpLCBi
LT5jdGwpOw0KPiAgICAgICAgICAgICAgICAgd3Jtc3JsKG1zcl9vcHMuc3RhdHVzKGkpLCAwKTsN
Cj4gDQoNCldvdWxkIHlvdSBtaW5kIGlmIHRoZSBmdW5jdGlvbiBuYW1lIHN0YXllZCB0aGUgc2Ft
ZT8gVGhlIHJlYXNvbiBpcyB0aGF0IE1DQV9DVEwgaXMgd3JpdHRlbiBoZXJlLCB3aGljaCBpcyB0
aGUgImluaXQiIHBhcnQsIGFuZCBNQ0FfU1RBVFVTIGlzIGNsZWFyZWQuDQoNCkkgY2FuIHVzZSBh
bm90aGVyIG5hbWUgZm9yIHRoZSBjaGVjaywgZS5nLiBfX21jaGVja19jcHVfY2hlY2tfYmFua3Mo
KSBvciBfX21jaGVja19jcHVfYmFua3NfY2hlY2tfaW5pdCgpLg0KDQpUaGFua3MsDQpZYXplbg0K
