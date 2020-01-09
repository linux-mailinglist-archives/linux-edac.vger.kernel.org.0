Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0689D1361E6
	for <lists+linux-edac@lfdr.de>; Thu,  9 Jan 2020 21:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgAIUkB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jan 2020 15:40:01 -0500
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70]:63969
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730929AbgAIUkA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Jan 2020 15:40:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrpIAiLX0qrvvAkXTZpb+FDBx+msvgC5a9NTxp/xQrfRSWvUAG59VdG5mhVgvQOtXVoERg3eiyde16tzqBlTt95l2fXlnKe7mlwCoPHF8om/tcGSHPBh+2wddmxIQbwXE6cx1a4Ijw8q8ft9LvCAH0joGy+J96+iKoB3Wt6aTEWT9jD9vKdYselDWpx8dQ8htR5sNVeUTslNpR7wVV6FqA9dxIH3O338ommQf7j0wIIiSVAOQnSReE1VBziDdVszebcNi2TcV3UngLAoNMkLw2N2yvn2HwCmlfs8jxYf5bih4FfK1pIoNXMP4mCOr3Zm4DbXue8ugDs6FrkSDnIx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PKsXwmGQ/zfEDIBSOWAwxoWDl+umW3UesSdEkWzPOI=;
 b=J6zo4tetuXh+1ozLJl1V8XMGw09iIn8bzr+J9LstLBr3Gkt92b7tq6GRzpC9hsC6xDIgJolCz67RMvmPVhnvMNnGIKfzj+6yEYJFsUNVs2nqo/oYFEVpZyoftvd7/VItLXQ0F3RHaehod3xMswy44Rs3O9h7Kbdf3qzsxnrowRKn1qxOifnsuMwORrmVq/vbSxaLMsQk1bu/p01z6flt2N699YII54RdjUWxJB8PlCCZQkZ7EhlekIqJ/6aD5UkPy5qulS7No+Iw9Gx0jPQbnxWRE45Gcu16v7t5HgNNX/b24AkVCRSggWrarDYBuLYgQ40R9mpdcplTs2ke6S5K0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PKsXwmGQ/zfEDIBSOWAwxoWDl+umW3UesSdEkWzPOI=;
 b=YxbqLGUkKaSwTa6M57cF4p0BCzMCXaySAkBYThCjPkaoHc/4YdylDLHgZiWF0mHS+mSQQ4/KJUyrmaaVMGynQfZtl5KetxH+LARBmqfJnvo8ZVLsWnf7DfNJWJ29IsRE8ifTQpJOM15J5Ux2r1waFjfFXC+IQ+eC2tZkUoNjXuQ=
Received: from BN6PR12MB1667.namprd12.prod.outlook.com (10.172.18.18) by
 BN6PR12MB1331.namprd12.prod.outlook.com (10.168.224.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 20:39:58 +0000
Received: from BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe]) by BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe%12]) with mapi id 15.20.2602.017; Thu, 9 Jan 2020
 20:39:57 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     =?utf-8?B?SmFuIEguIFNjaMO2bmhlcnI=?= <jschoenh@amazon.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
Thread-Topic: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
Thread-Index: AQHVwkeaeemyAwBytkqJoMDznAoYNqfZfrIAgAatqgCAAGT1AIACQ7eg
Date:   Thu, 9 Jan 2020 20:39:57 +0000
Message-ID: <BN6PR12MB166720AEED7FE086308BC4ABF8390@BN6PR12MB1667.namprd12.prod.outlook.com>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-7-jschoenh@amazon.de> <20200103220328.GF5099@zn.tnic>
 <BN6PR12MB16670832D78F2799730FB95FF83E0@BN6PR12MB1667.namprd12.prod.outlook.com>
 <20200108100356.GA27363@zn.tnic>
In-Reply-To: <20200108100356.GA27363@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.25.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e094d998-eb1c-4886-4a58-08d79544176e
x-ms-traffictypediagnostic: BN6PR12MB1331:
x-microsoft-antispam-prvs: <BN6PR12MB133159DF0E02337CAE7EBF94F8390@BN6PR12MB1331.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(13464003)(189003)(199004)(6506007)(7696005)(81156014)(33656002)(186003)(71200400001)(6916009)(81166006)(316002)(5660300002)(53546011)(76116006)(8936002)(8676002)(52536014)(2906002)(478600001)(66476007)(66556008)(66946007)(54906003)(4326008)(64756008)(66446008)(66574012)(26005)(55016002)(9686003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1331;H:BN6PR12MB1667.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8o5C4BB33Lv9EGyWFhsbRN8TvsHPOW8ATS+yjSnQHeK8pyYP/vUAhKwhrwJdlTfTA0cdOI8nYmY5gj3AUonGINuF+JqqfdZ2/UEnZP20Qbq/F6mCAJjwx1CdOcp7LuUv+gzdobn5ApuUzIzmCsswbm1gq4QGJbRFPKIeQtBzF8e9TDFtw0rVXm1UCIMboSrBPFilj8eD38JdrFTkE/BgxZrR5Ew+aUgOmD0tPYrhDqxcvrEn2U7f+i8B34K9nZuu/mlXFbWcKMfasnurjqpjRITD1dyk8ACEE7E+FSwbQudPw7CcdOJDxh94etGr0V7A/AuhCVz4xpgFYwcVdNhju1vwdXBPMz36T1NnEBNaZ+xLucrJy/8gBfkcG8M+pLrakdk4bNOuFqJhSjPzQ+Kp7TIcUiugiQ7hqQjCUYaA4WT7ksamcysWPU5GPo4V5AQ+syqWlEFfTYdtuLGeK8DY4DHobHX2EnGWBEG5PyszXe/IrE+VZkJrbeuKYsFiED09
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e094d998-eb1c-4886-4a58-08d79544176e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 20:39:57.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fjhrMrfRPM/6davyLQQwAMilEyZSZ+Dxd3LT32jqAIaWRFkSCJytFwY5Es7hPfTbilfL/J0jL0F6luEVqbeVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1331
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDgsIDIwMjAgNTowNCBBTQ0K
PiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6IEphbiBI
LiBTY2jDtm5oZXJyIDxqc2Nob2VuaEBhbWF6b24uZGU+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgVG9ueSBMdWNrDQo+IDx0b255Lmx1
Y2tAaW50ZWwuY29tPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29t
PjsNCj4geDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiA2LzZdIHg4Ni9t
Y2U6IER5bmFtaWNhbGx5IHJlZ2lzdGVyIGRlZmF1bHQgTUNFIGhhbmRsZXINCj4gDQo+IE9uIFdl
ZCwgSmFuIDA4LCAyMDIwIGF0IDA0OjI0OjMzQU0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdyb3Rl
Og0KPiA+IEkndmUgZW5jb3VudGVyZWQgYW4gaXNzdWUgd2hlcmUgRURBQyBkaWRuJ3QgbG9hZCAo
ZWl0aGVyIGR1ZSB0byBhDQo+ID4gYnVnIG9yIG1pc3NpbmcgaGFyZHdhcmUgZW5hYmxlbWVudCkg
YW5kIHRoZSBNQ0UgZ290IHN3YWxsb3dlZCBieSB0aGUNCj4gPiBtY2Vsb2cgbm90aWZpZXIuIFRo
ZSBtY2Vsb2cgdXRpbGl0eSB3YXNuJ3QgaW4gdXNlLCBzbyB0aGVyZSB3YXMgbm8NCj4gPiByZWNv
cmQgb2YgdGhlIE1DRS4NCj4gDQo+IENhbiB5b3UgcmVwcm9kdWNlIHRoaXMgdXNpbmcgdGhlIGlu
amVjdG9yPw0KPiANCg0KWWVzLCBJIHdhcyBqdXN0IGFibGUgdG8gZG8gaXQuIEhlcmUncyB3aGF0
IEkgZGlkLg0KDQoxKSBVbmxvYWQgRURBQyBkZWNvZGVyIG1vZHVsZXMuDQoyKSBJbmplY3QgYSBj
b3JyZWN0ZWQgTUNFIHVzaW5nIG1jZS1pbmplY3QuDQozKSBPYnNlcnZlICJNYWNoaW5lIGNoZWNr
IGV2ZW50cyBsb2dnZWQiIG1lc3NhZ2UgYW5kIG5vIG90aGVyIE1DRSBpbmZvLg0KNCkgTWFudWFs
bHkgbG9hZCBtY2Vsb2cgYW5kIGZpbmQgTUNFIGluZm8uDQoNCkl0IHNlZW1zIHRvIG1lIHRoYXQg
dGhlIGlzc3VlIGlzIHRoZSBtY2Vsb2cgbm90aWZpZXIgY291bnRzIHRvd2FyZCB0aGUgbnVtYmVy
DQpvZiBub3RpZmllcnMsIHNvIHRoZSBkZWZhdWx0IG5vdGlmaWVyIGRvZXNuJ3QgcHJpbnQgYW55
dGhpbmcuDQoNCk9mIGNvdXJzZSwgdGhpcyBjYW4gYmUgYXZvaWRlZCBpZiB0aGUgRURBQyBtb2R1
bGVzIGFyZSBsb2FkZWQsIG9yIGlmIG1jZWxvZyBpcw0KZGlzYWJsZWQgaW4gdGhlIGtlcm5lbCBj
b25maWcsIG9yIGlmIHJhc2RhZW1vbiBpcyB1c2VkLCBldGMuDQoNClRoYW5rcywNCllhemVuDQo=
