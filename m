Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3572E20DB3
	for <lists+linux-edac@lfdr.de>; Thu, 16 May 2019 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfEPRJO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 May 2019 13:09:14 -0400
Received: from mail-eopbgr720051.outbound.protection.outlook.com ([40.107.72.51]:15529
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbfEPRJO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 May 2019 13:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3ya700rpjPkTv7AegvmK80EMTZuoqHzqSMl1zysNqc=;
 b=cXDvwoP5mKy5EXwMv77ZbCCpCS8of06vXC+9uwwziS2Xx8pdBuAkdtDqei3N94+9Deej/7Ve/Rx8TANyCCN2cAGtq7n5dzvM04je68n+qZQL+WSLKVLMrD2NmWJiOJjpQ4y09rHUyA0rgFOsZONQDgEjw9QrnCgAASYhLPbDNgU=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2751.namprd12.prod.outlook.com (52.135.107.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 17:09:11 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 17:09:11 +0000
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
Thread-Index: AQHU/5PPbonhoiIaT0+tpMBUt0fOpKZt/3MAgAAEtbCAAA1jAIAAAELg
Date:   Thu, 16 May 2019 17:09:11 +0000
Message-ID: <SN6PR12MB26392B440ED735C26AA2C678F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-6-Yazen.Ghannam@amd.com>
 <20190516155202.GA11517@agluck-desk>
 <SN6PR12MB26397B30A120E3426184727FF80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516165648.GB21857@zn.tnic>
In-Reply-To: <20190516165648.GB21857@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [208.54.70.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c0e6d1d-7341-4a72-ff8c-08d6da21377e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2751;
x-ms-traffictypediagnostic: SN6PR12MB2751:
x-microsoft-antispam-prvs: <SN6PR12MB2751E8C5F839EBBBC1C88A2DF80A0@SN6PR12MB2751.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(396003)(376002)(13464003)(199004)(189003)(6246003)(256004)(71190400001)(68736007)(4326008)(55016002)(6506007)(8936002)(86362001)(74316002)(54906003)(5660300002)(316002)(7696005)(81156014)(33656002)(2906002)(81166006)(52536014)(4744005)(71200400001)(9686003)(102836004)(25786009)(99286004)(53546011)(186003)(3846002)(6116002)(446003)(486006)(11346002)(26005)(476003)(76116006)(53936002)(66446008)(64756008)(66556008)(66946007)(73956011)(8676002)(76176011)(478600001)(229853002)(14454004)(6436002)(305945005)(66476007)(6916009)(7736002)(66066001)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2751;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Z+OvbUAvdE3dXrfraLzyoP9NCobp3B30BW6bTR2WIK8ibfYZRH3HPLcGElGa2H08WKVhTshhcZW9KAv2MrRGcJUXCTFAO4iGD3rtQKGZYHtW9umHcAl87tVv6fxx8DjxTz8jXNYobx1aiyqUeT/5cAeFkrXpHEA8JlKgyJkRTztZdfu8BWeeEcy9kWL0qgE8h8FqVsqzQ2vB+e/7iO1wza8K7DUY3DfVNdyk8qX5T+sBzoqzlgZNwugGC1HZF27HhOyzv7g0xaE09mdEioBxz8is0laX1HIfJoIpAvEdnGGo1fY9SuArDD4TTV2AMc9BE73jbN3v6biEmO3iHRYswGFwhhVMqQ8MsRj/5YOGfHoOZU8t5raUqpqI32UfOdILV171FobI0IrzSwJ3o1Mw0/16mZaUUQNsOdRhwDA53I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0e6d1d-7341-4a72-ff8c-08d6da21377e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 17:09:11.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2751
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogVGh1cnNkYXksIE1heSAxNiwgMjAxOSAxMTo1
NyBBTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6
IEx1Y2ssIFRvbnkgPHRvbnkubHVja0BpbnRlbC5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MyA1LzZdIHg4Ni9NQ0U6IFNhdmUgTUNBIGNvbnRyb2wgYml0cyB0
aGF0IGdldCBzZXQgaW4gaGFyZHdhcmUNCj4gDQo+IA0KPiBPbiBUaHUsIE1heSAxNiwgMjAxOSBh
dCAwNDoxNDoxNFBNICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiBJIGNhbiBwdXQg
YSB2ZW5kb3IgY2hlY2sgb24gdGhlIHJlYWQuIElzIHRoYXQgc3VmZmljaWVudD8NCj4gDQo+IE9y
IHdlIGNhbiBkcm9wIHRoaXMgcGF0Y2guIFJlbWluZCBtZSBhZ2FpbiBwbHMgd2h5IGRvIHdlIG5l
ZWQgaXQ/DQo+IA0KDQpTbyB0aGF0IHRoZSBzeXNmcyBmaWxlcyBzaG93IHRoZSBjb250cm9sIHZh
bHVlcyB0aGF0IGFyZSBzZXQgaW4gdGhlIGhhcmR3YXJlLiBJdCBzZWVtZWQgbGlrZSB0aGlzIHdv
dWxkIGJlIG1vcmUgaGVscGZ1bCB0aGFuIHNob3dpbmcgYWxsIDB4RidzLg0KDQpCdXQgSSdtIG9r
YXkgd2l0aCBkcm9wcGluZyB0aGlzIHBhdGNoLiBQYXRjaCA2IGluIHRoaXMgc2V0IGRlcGVuZHMg
b24gdGhpcywgc28gaXQnbGwgbmVlZCB0byBiZSBkcm9wcGVkIGFsc28uDQoNClNob3VsZCBJIHNl
bmQgb3V0IGFub3RoZXIgdmVyc2lvbiBvZiB0aGlzIHNldD8NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
