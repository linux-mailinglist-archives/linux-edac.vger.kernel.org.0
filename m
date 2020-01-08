Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53247133A2C
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jan 2020 05:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAHEYk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Jan 2020 23:24:40 -0500
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:61582
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726146AbgAHEYk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Jan 2020 23:24:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heW2Q/luhwuzdUqUE/DJ386+V/nbfmvNbqqe6LlNvFKiPrXdJtPAzw2FSjxQwU9zlqls/qSAqGeaHd7pGrbowwwtxxHuy/71uYlQ7KMBIy0ien7JDBwlSKm8p3BmHhJzJwBcoGaRKuzAMomNNWkRjHu2lBPFeQXd3GXDQePNUw6onQL5QgpGUQTpvVMk6za8dH+o6HyCi913r+KfybjSb+FWNCc7ch+87MNG82jMNIFY7+FQm73ymGgNrJDjTYtTS9NqLdrLNaAt6HeFdPVEtDtaa47x9Is2Z0fmPVxwXc3nU9QWP1oTSeGjQR1990czG9SN0bqI72JVv+aHknZUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3XfytV3XsIcwKA7t2S234hLSVHRXYB8Pt4147+BXWk=;
 b=iJh681eNGWNLefdMhrIl9OTAR1FaHt+bFIdEtRCNM/qu2T49cVXy1kLFv4P1e3+YgB/Xip4t50bJ8K/nghsDuTRAa6R8o4qbIvOkJWguHuax6oRiyUXobOiEys7bGoopPPKHFNK/JT+EKFS846Y4gnPk4sqc8oX0ens5FiBcIMsMaFdD4xi8WSf09qZsf415twHH/px6dXfXJ8qG0cTiOlMtNLjCR528bwDgzZfM3vwoYegzEPt8G9scJ5VtNW5IjATIheMs97f9Bw4zakxebK+84Nrda4RCw4HL7bdHCYe2abWv7Hyv5eFJzSA9KNX7ZUbb6Ur5lm4yXBiILoP5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3XfytV3XsIcwKA7t2S234hLSVHRXYB8Pt4147+BXWk=;
 b=okoMGB4azzlYaWTpWu57/HWf2jj4Fg0aqgC93lJcW1nggZUD8SbZWYJ+MGP9S/R9jImXSN0m0PLlQkYyBZ8zq5U6Qe2fnC+qivptmITXv7kV8RKc9MOXlQ/R9sUujtq5LIlVpjH404TINefDZTZAVQNHu4wZ/GL3oDm2Ti4Dt4w=
Received: from BN6PR12MB1667.namprd12.prod.outlook.com (10.172.18.18) by
 BN6PR12MB1875.namprd12.prod.outlook.com (10.175.99.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 04:24:34 +0000
Received: from BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe]) by BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe%12]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 04:24:34 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        =?utf-8?B?SmFuIEguIFNjaMO2bmhlcnI=?= <jschoenh@amazon.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
Thread-Topic: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
Thread-Index: AQHVwkeaeemyAwBytkqJoMDznAoYNqfZfrIAgAatqgA=
Date:   Wed, 8 Jan 2020 04:24:33 +0000
Message-ID: <BN6PR12MB16670832D78F2799730FB95FF83E0@BN6PR12MB1667.namprd12.prod.outlook.com>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-7-jschoenh@amazon.de> <20200103220328.GF5099@zn.tnic>
In-Reply-To: <20200103220328.GF5099@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.25.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46a03172-12ba-4efe-95c3-08d793f2aa38
x-ms-traffictypediagnostic: BN6PR12MB1875:
x-microsoft-antispam-prvs: <BN6PR12MB187559C514177F757006FDE7F83E0@BN6PR12MB1875.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(13464003)(43544003)(316002)(66574012)(9686003)(52536014)(86362001)(5660300002)(2906002)(8676002)(55016002)(8936002)(81166006)(110136005)(81156014)(54906003)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(26005)(7696005)(6506007)(33656002)(4326008)(53546011)(478600001)(71200400001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1875;H:BN6PR12MB1667.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aINXw50Ikzn66Dtu1O2z+ZaPJWbcyKenIs/FIW8lclUrmY/LEQaQo2LOCpiOlyE7KNh5PaF/OuJKxpwUDwjHksqHcVSu4C9c/UmX1UH+8KFEQG4dwJukjdp8i+sIsCqt6BKBJ7shREZ14POI++f4fjBqIEakEMBiCy5ISLGr+EZs7KukH+WLxy9wkjjnd+ZHNzLrlfKO9FUgz8i45KR8uivm16oUwn0oO/rIViyJ6q+m2383HcSdH4vv2c8iDsgNZLsaoPSZFA1zudRriuqQPk1Q28/zsKUP7wQlOx+A+Qs7+Cy9LQ8HM2TxQV/zlAl3E+ljUYfB74cQ+oqjP9Z86f3gzbYU3RJoyy2FE0+PBJfEKO8+CEYknVdq2cDAO7QFG4Rz7u2Frbbtb2YIDMNZk8NZNw18Hj6mNTcNfTpb7rFGfijDy8jLOMBVGaop6Mvn14k+5LXX63/ft/nK/3UFjC1BZ5KbIWTRQ7FkHKIjrFrO4Hh24Z1ppveJUFqmryrivpszK4Do64mlDxjplRil+Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a03172-12ba-4efe-95c3-08d793f2aa38
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 04:24:34.0189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tfet3YDs3fx8qHQTg3Is5iK2Y97Jl3q6W/EpKdG2gVCuLQkzh0vNYHKGGaNuyp3DVHsUpA5K3aP14P1ww/Z0GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1875
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDMsIDIwMjAgNTowMyBQTQ0KPiBU
bzogSmFuIEguIFNjaMO2bmhlcnIgPGpzY2hvZW5oQGFtYXpvbi5kZT4NCj4gQ2M6IEdoYW5uYW0s
IFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgVG9ueSBMdWNrDQo+IDx0b255Lmx1Y2tA
aW50ZWwuY29tPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBJbmdvIE1v
bG5hciA8bWluZ29AcmVkaGF0LmNvbT47IEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPjsN
Cj4geDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA2LzZdIHg4Ni9tY2U6
IER5bmFtaWNhbGx5IHJlZ2lzdGVyIGRlZmF1bHQgTUNFIGhhbmRsZXINCj4gDQo+IE9uIEZyaSwg
SmFuIDAzLCAyMDIwIGF0IDA0OjA3OjIyUE0gKzAxMDAsIEphbiBILiBTY2jDtm5oZXJyIHdyb3Rl
Og0KPiA+IE9uIHRoZSBvdGhlciBoYW5kLCBJJ20gc3RhcnRpbmcgdG8gcXVlc3Rpb24gdGhlIHdo
b2xlIGxvZ2ljIHRvICJvbmx5IHByaW50DQo+ID4gdGhlIE1DRSBpZiBub3RoaW5nIGVsc2UgaW4g
dGhlIGtlcm5lbCBoYXMgYSBoYW5kbGVyIHJlZ2lzdGVyZWQiLiBJcyB0aGF0DQo+ID4gcmVhbGx5
IGhvdyBpdCBzaG91bGQgYmU/DQo+IA0KPiBZZXMsIGl0IHNob3VsZCBiZSB0aGlzIHdheTogaWYg
dGhlcmUgYXJlIG5vIGNvbnN1bWVycywgYWxsIGVycm9yDQo+IGluZm9ybWF0aW9uIHNob3VsZCBn
byB0byBkbWVzZyBzbyB0aGF0IGl0IGdldHMgcHJpbnRlZCBhdCBsZWFzdC4NCj4gDQo+ID4gRm9y
IGV4YW1wbGUsIHRoZXJlIGFyZSBoYW5kbGVycyB0aGF0IGZpbHRlciBmb3IgYSBzcGVjaWZpYyBz
dWJzZXQgb2YNCj4gPiBNQ0VzLiBJZiBvbmUgb2YgdGhvc2UgaXMgcmVnaXN0ZXJlZCwgd2UncmUg
bG9zaW5nIGFsbCBpbmZvcm1hdGlvbiBmb3INCj4gPiBNQ0VzIHRoYXQgZG9uJ3QgbWF0Y2guDQo+
IA0KPiBQcm9iYWJseSBidXQgSSBkb24ndCB0aGluayB0aGVyZSdzIGFuIGV4YW1wbGUgb2YgYW4g
YWN0dWFsIHN5c3RlbSB3aGVyZQ0KPiB0aGVyZSBhcmUgbm8gb3RoZXIgTUNFIGNvbnN1bWVycyBy
ZWdpc3RlcmVkLiBOb3QgaWYgaXRzIHVzZXJzIGNhcmUgYWJvdXQNCj4gUkFTLiBUaGlzIGRlZmF1
bHQgZmFsbGJhY2sgd2FzIGFkZGVkIGZvciB0aGUgaHlwb3RoZXRpY2FsIGNhc2UgYW55d2F5Lg0K
PiANCj4gPiBBIHBvc3NpYmxlIHNvbHV0aW9uIHRvIHRoZSBsYXR0ZXIgd291bGQgYmUgdG8gaGF2
ZSBhICJoYW5kbGVkIiBvciAicHJpbnRlZCINCj4gPiBmbGFnIHdpdGhpbiAic3RydWN0IG1jZSIg
YW5kIHByaW50IHRoZSBNQ0UgYmFzZWQgb24gdGhhdCBpbiB0aGUgZGVmYXVsdA0KPiA+IGhhbmRs
ZXIuIFdoYXQgZG8geW91IHRoaW5rPw0KPiANCj4gQmVmb3JlIHdlIGdvIGFuZCBmaXggd2hhdGV2
ZXIsIHdlIG5lZWQgdG8gZGVmaW5lIHdoYXQgZXhhY3RseSB3ZSdyZQ0KPiBmaXhpbmcuIElzIHRo
ZXJlIGFuIGFjdHVhbCBzeXN0ZW0geW91J3JlIHNlZWluZyB0aGlzIG9uIG9yIGlzIHRoaXMNCj4g
c29tZXRoaW5nIHRoYXQgd291bGQgbmV2ZXIgaGFwcGVuIGluIHJlYWxpdHk/IEJlY2F1c2UgaWYg
dGhlIGxhdHRlciwgSQ0KPiBkb24ndCByZWFsbHkgY2FyZSBUQkguIEFzIGluLCB0aGVyZSdzIG1v
cmUgaW1wb3J0YW50IHN0dWZmIHRvIHRha2UgY2FyZQ0KPiBvZiBmaXJzdC4NCj4gDQoNCkkndmUg
ZW5jb3VudGVyZWQgYW4gaXNzdWUgd2hlcmUgRURBQyBkaWRuJ3QgbG9hZCAoZWl0aGVyIGR1ZSB0
byBhIGJ1ZyBvcg0KbWlzc2luZyBoYXJkd2FyZSBlbmFibGVtZW50KSBhbmQgdGhlIE1DRSBnb3Qg
c3dhbGxvd2VkIGJ5IHRoZSBtY2Vsb2cgbm90aWZpZXIuDQpUaGUgbWNlbG9nIHV0aWxpdHkgd2Fz
bid0IGluIHVzZSwgc28gdGhlcmUgd2FzIG5vIHJlY29yZCBvZiB0aGUgTUNFLiBUaGlzIGNhbg0K
YmUgY29uc2lkZXJlZCBhIHN5c3RlbSBjb25maWd1cmF0aW9uIGlzc3VlIHRob3VnaCB0aGF0IGNh
biBiZSByZXNvbHZlZCB3aXRoIGENCmJpdCBvZiB0d2Vha2luZy4gQnV0IG1heWJlIHdlIGNhbiBm
aW5kIGEgc29sdXRpb24gdG8gcHJldmVudCBzb21ldGhpbmcgbGlrZQ0KdGhpcz8NCg0KVGhhbmtz
LA0KWWF6ZW4NCg==
