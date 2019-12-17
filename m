Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100701221AE
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2019 02:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfLQBtP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Dec 2019 20:49:15 -0500
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:38121
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726227AbfLQBtP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Dec 2019 20:49:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC4VX7m1LGfM8TTVNWBe3Z/T7XDXocoyVoMroPhQRcrqTw2fPhTz1UwS4V/gLWhg/FtnK+Ix5HrSvnXm8yJZ+021ASei/4OxP4snnf8wbY3ePr4GLdaO4m6bvOKeEzUJyYSOdCV+ebPiCkaRDE9WwzlZ1cCRb4u7jAECeC3eoz6WH2+mPvy3LVwE3Q67fphwcm/v/wuJSdMNq1GYLI64nLxewEn7eOPQjH//8kRjtnQ/t8KMdI1gml12fNAT4Dw64NeiOM61s0GZZgqZNJSN0x1OYQAAVAJ8iF4s9ma5jJT8t02VxSFLDBaZnV3cYW1PouaGqjhbLwF7FEIYO3bbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9xiV4uzyDT2SqDec4cyjJs1t2H20F/pz/XrqG2UofY=;
 b=Q7m486ERDHprcMoUExtRmcH8iwhKoC07blG09vJiq3gbD7+sUaeCmdDLIHM9gdHrFpZ+j1hPYmU8/BJibGMihzoPhevuRJvq0XhzO4sQ5v2F7lBTn0Xia25CAZWzPf2wxeFwAz/JoLEvmYbaXL+SpnpHzJ53YTuWpVej7FC4DNqRzmp240lgS9VXQa45agqe3Mp6/vQtDM1Qn9zW5ehj6eDjFRc3gVPjXsWSImyD7t48xEOwzW1L2wvNusoI6YlWfLDsF+3hqoPen944cK3qep8xIxrssvENiWIb3PxqxYcdE5IOFf7VM9jmPN7UTgi/3D3oKLZYxjCgm3X7+5APFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9xiV4uzyDT2SqDec4cyjJs1t2H20F/pz/XrqG2UofY=;
 b=iKw5nhFjEb64wcEquGW8fH20KLnywzgWyWsJ59r41TmW5PjLNqCzgGBWT1VBMR7n6i96Ikp2xrdNLs7iiQAocOyk6dW+ImT+qJtcN/jPpE0i018OPAI+m5cUwLZOkMKU18JDkqWtUSFjiHgOu7q4+3dYf/UQWqSP9PSaNhS7oU4=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.106.25) by
 SN6PR12MB2749.namprd12.prod.outlook.com (52.135.102.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 01:49:13 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::137:38a3:4901:29eb]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::137:38a3:4901:29eb%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 01:49:13 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>, Borislav Petkov <bp@suse.de>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>
Subject: RE: [tip: ras/core] x86/mce/AMD: Allow Reserved types to be
 overwritten in smca_banks[]
Thread-Topic: [tip: ras/core] x86/mce/AMD: Allow Reserved types to be
 overwritten in smca_banks[]
Thread-Index: AQHVr0GbE4lruW2NmkCxHMOrIVtGDKe9mCZA
Date:   Tue, 17 Dec 2019 01:49:13 +0000
Message-ID: <SN6PR12MB2639C1AF7F5EC7F16B22D244F8500@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20191121141508.141273-1-Yazen.Ghannam@amd.com>
 <157597242273.30329.4326721384243738456.tip-bot2@tip-bot2>
In-Reply-To: <157597242273.30329.4326721384243738456.tip-bot2@tip-bot2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [142.196.148.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bccc30f4-2e91-49e9-6de0-08d78293515c
x-ms-traffictypediagnostic: SN6PR12MB2749:
x-microsoft-antispam-prvs: <SN6PR12MB274996DC5120F9C042306505F8500@SN6PR12MB2749.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(13464003)(199004)(189003)(316002)(8676002)(76116006)(4326008)(54906003)(478600001)(110136005)(6506007)(53546011)(33656002)(52536014)(86362001)(26005)(71200400001)(55016002)(9686003)(2906002)(81166006)(81156014)(66946007)(64756008)(66446008)(66476007)(186003)(5660300002)(7696005)(66556008)(8936002)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2749;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZbzytL4ZJ9gurRR1mkWwfznoTdW4Z13AC2xgBLNLc7XADkm5glutilRuTOR/ypTeH979LiFJbtEWUNzw+FPT3kdkcDEC3rwnqzfE/qIaH74pGcUZiSgZ5g6rU+0T6xnlAVljGaDAMH6LqCpgwAv++7OrHt2v55P1fB9eQJpO0wuMsbEOM17rQzKrInFCueNziTR/PuUGvK5sFjQvUQXqEUKiIEvxauQHMumK9FU66FpR8XMBb8IHuMkwI6/Rak5smYCJ5++x9hWzZ2Xgd0MZNQyzR9ZMObxBpOuNbNMQri1mmnOYN2MYAEyMz4BJmmPwp3vqt7WwpszckFRxQ+xFbPEc24Fo4ZknxZ1q++6YaI2kjhTmiPA1jUBVTkvtOLSu3vRJEOg6c/jhry0hqjO35ZZX9GMrsIs+lzLeJAghS0Fza1e24ikaTlkgua4fLr/JRVHd4sg2pV0wzUasKHrwm+7Mtv/yXRqk6Pp85lNNYNTJz7ukWN1QR4VnxltlFc7R
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccc30f4-2e91-49e9-6de0-08d78293515c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 01:49:13.2080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7KtQOiM/o52/Hm+27YekJDjkny0bdteIUhbazj3VpLQvLMsyC5l3pfAbGLppAdB13vBCW8sI/0jz/PbMKgUR0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiB0aXAtYm90MkBsaW51dHJvbml4
LmRlIDx0aXAtYm90MkBsaW51dHJvbml4LmRlPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAx
MCwgMjAxOSA1OjA3IEFNDQo+IFRvOiBsaW51eC10aXAtY29tbWl0c0B2Z2VyLmtlcm5lbC5vcmcN
Cj4gQ2M6IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+OyBCb3Jpc2xhdiBQ
ZXRrb3YgPGJwQHN1c2UuZGU+OyBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT47IEluZ28g
TW9sbmFyDQo+IDxtaW5nb0BrZXJuZWwub3JnPjsgbGludXgtZWRhYyA8bGludXgtZWRhY0B2Z2Vy
Lmtlcm5lbC5vcmc+OyBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IFRvbnkg
THVjaw0KPiA8dG9ueS5sdWNrQGludGVsLmNvbT47IHg4Ni1tbCA8eDg2QGtlcm5lbC5vcmc+OyBM
S01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbdGlwOiByYXMv
Y29yZV0geDg2L21jZS9BTUQ6IEFsbG93IFJlc2VydmVkIHR5cGVzIHRvIGJlIG92ZXJ3cml0dGVu
IGluIHNtY2FfYmFua3NbXQ0KPiANCj4gVGhlIGZvbGxvd2luZyBjb21taXQgaGFzIGJlZW4gbWVy
Z2VkIGludG8gdGhlIHJhcy9jb3JlIGJyYW5jaCBvZiB0aXA6DQo+IA0KPiBDb21taXQtSUQ6ICAg
ICBhMGNhYzM1YzFkODMxODQxNTFiZTQ4NTFlYTkwYjVmOTIwOTU3OTY3DQo+IEdpdHdlYjoNCi4u
Lg0KPiBBdXRob3I6ICAgICAgICBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+
DQo+IEF1dGhvckRhdGU6ICAgIFRodSwgMjEgTm92IDIwMTkgMDg6MTU6MDggLTA2OjAwDQo+IENv
bW1pdHRlcjogICAgIEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4NCj4gQ29tbWl0dGVyRGF0
ZTogVHVlLCAxMCBEZWMgMjAxOSAwOToyNzo1OSArMDE6MDANCj4gDQo+IHg4Ni9tY2UvQU1EOiBB
bGxvdyBSZXNlcnZlZCB0eXBlcyB0byBiZSBvdmVyd3JpdHRlbiBpbiBzbWNhX2JhbmtzW10NCj4g
DQoNCkJvcmlzLA0KQ2FuIHRoaXMgcGxlYXNlIGJlIGFwcGxpZWQgdG8gcmFzL3VyZ2VudD8gSXQg
Zml4ZXMgYSBib290IGlzc3VlIG9uIHNvbWUNCnJlY2VudGx5IHJlbGVhc2VkIEFNRCBzeXN0ZW1z
Lg0KDQpJIGhhZCB0aGUgRml4ZXMgdGFnLCBidXQgSSBmb3Jnb3QgdG8gaW5jbHVkZSBDQzo8c3Rh
YmxlPi4gU29ycnkgYWJvdXQgdGhhdC4NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
