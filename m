Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85834140D8F
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 16:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAQPOJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Jan 2020 10:14:09 -0500
Received: from mail-dm6nam11on2043.outbound.protection.outlook.com ([40.107.223.43]:6040
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728982AbgAQPOJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 Jan 2020 10:14:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkgXw0bPYeBeeLipOb7aqTMQZw7TgqDrx0Dh56n/fVmEIxzRBDPOupQ+CEy9hfADni35ccsQxPdF2lzNs3VDG1HmZBDBYmOzqMhsamROvLkh0U0ukDf1UMnysSEXQZdjrqNTeay2VAmxe42NNsYK8E6nu5rN8dUjo9g8Vqn/kPYckBJiUHkYB08/ZlV9SOfZMJwDWleHMak57FBAZABCyYqrhjxwHNpqa57yanTrwt7ilXxobAM2D3EEpboQmko29NPsboI6ZdvaeVB6wqhrUuMdkPNurSuM83+Ip2ziMApCN8V2wH1gaErjkDHqbXDxPWV6RfMmuepRZLpvj2pnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRNLRPMNYBPc6BBMDvuvAbCg9omJQ9q4ub2oBqef1U8=;
 b=IFsHY88MravNi6iuxWBkIbEvNHo2zHLp6LAMS+FGkVDbPSW59uoXROVHNchl+0J73cwl1gtq0UIz/6Q+3tEMfOxs6nDa6Lzi1lxDMEIMkuCzw+Z/VBsA7uDovqkC0j61tbXnwCTTwMJ5QzsNL/WkYYH8URqMLDQLbRn+wvgkkFaMR/2ISxtNY4k4O1yym1QZrplGY9K8gRbwMHvMinrQSI2eHDPghSSWkhi6W4O17gbvWJr3mxgBDqDcjMIStb9G03w6iLlDFTkGVY9PU2cEa08skBgJ9o0YTAhRTRIsratBmZavpFaw23twrkuiQrV/2DkXVVkaiZP76JU7pHnmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRNLRPMNYBPc6BBMDvuvAbCg9omJQ9q4ub2oBqef1U8=;
 b=rW9SBPFRrsvlGHxEraTQ9BPBLdvg2wcUL/yGGr8PQ4pTW2u+4wDv3jzzxqdXlk/gV7j3OxuMob3JN7dxewzDkkkHW18rTTzv6C6Wu9grfGrattqD4Jexcz4GmIk/sDcRGAJJ6JvNwPol/nCgwMv6Y6A1cPtzOOA8KB6NkORgqjU=
Received: from BN6PR12MB1667.namprd12.prod.outlook.com (10.172.18.18) by
 BN6PR12MB1187.namprd12.prod.outlook.com (10.168.226.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Fri, 17 Jan 2020 15:14:06 +0000
Received: from BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe]) by BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe%12]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 15:14:06 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/5] x86/MCE/AMD, EDAC/mce_amd: Add new Load Store unit
 McaType
Thread-Topic: [PATCH 1/5] x86/MCE/AMD, EDAC/mce_amd: Add new Load Store unit
 McaType
Thread-Index: AQHVx1lBHKPVdFVwt0SkBHeLGJ2Praftet8AgAGHb7A=
Date:   Fri, 17 Jan 2020 15:14:06 +0000
Message-ID: <BN6PR12MB166790FFA9876C17E6C4D351F8310@BN6PR12MB1667.namprd12.prod.outlook.com>
References: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
 <20200110015651.14887-2-Yazen.Ghannam@amd.com>
 <20200116155116.GE27148@zn.tnic>
In-Reply-To: <20200116155116.GE27148@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-17T15:14:02Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=36a13822-6758-4daa-b8a2-0000872d18ba;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-17T15:14:02Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0f7dc268-9e0c-4949-8c6e-000007934f8b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: faedd888-8d13-4eeb-3a93-08d79b5fe525
x-ms-traffictypediagnostic: BN6PR12MB1187:
x-microsoft-antispam-prvs: <BN6PR12MB1187635D1C74D9FC3DED251EF8310@BN6PR12MB1187.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39850400004)(189003)(199004)(52536014)(2906002)(66946007)(66476007)(6916009)(76116006)(33656002)(53546011)(6506007)(26005)(5660300002)(66556008)(478600001)(66446008)(71200400001)(7696005)(64756008)(86362001)(8936002)(9686003)(186003)(81156014)(8676002)(81166006)(55016002)(316002)(54906003)(4744005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1187;H:BN6PR12MB1667.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kahYQN/XaVK+e26/WqwKmNIPAocRhDWHKj3l3UZadVqK9EoYUpLeru1DgYZa28U/pkTqWRean0RpQVjN1DIhpFIhLa7gD1xq7BQlBUyqafyfzG0KXwHUj+uu/4354m2tneJKOP+Sm4L71gDc8kcZra+f2S9iaTMvYs5pbtEbAt3HuLsk7Zf7y7GKQ5EuJ4q/1th8C3vrNatr7rkhuembLmOfjyS1hG1zwAjF9tMOdTUdcb4+kzkMIOerrTRPiOVeSBEe3/M5yjfFctpNJ07aoWU6eEXTetTRcyAj9AZ7PZWMpQE1GAHPpbuqpnF+FO23YTsuyFzjn+Kk6iK12+SXwfit9RvVs1ezEKfMUEcKsJe23jjiYwgM4+pavh/sL7RpIyxHoi4hn39oXgiYO7ag2vp3w57aneqf2jgjX1hNqRZid3BoBqlNDOYxsfevEHeC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faedd888-8d13-4eeb-3a93-08d79b5fe525
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 15:14:06.3825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4wdtuajvIlDtDYpdg37jENZshvaPMJlBkw+DV8DsZOV0SJlLJXjdg0V33m5JhJ0VE6hnjb2rf1CUnVUBE9SuaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1187
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LWVkYWMtb3duZXJAdmdl
ci5rZXJuZWwub3JnIDxsaW51eC1lZGFjLW93bmVyQHZnZXIua2VybmVsLm9yZz4gT24gQmVoYWxm
IE9mIEJvcmlzbGF2IFBldGtvdg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAxNiwgMjAyMCAx
MDo1MSBBTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4g
Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBicEBzdXNlLmRlOyB0b255Lmx1Y2tAaW50ZWwuY29tOyB4ODZAa2VybmVsLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvNV0geDg2L01DRS9BTUQsIEVEQUMvbWNlX2FtZDogQWRkIG5l
dyBMb2FkIFN0b3JlIHVuaXQgTWNhVHlwZQ0KPiANCj4gT24gRnJpLCBKYW4gMTAsIDIwMjAgYXQg
MDE6NTY6NDdBTSArMDAwMCwgWWF6ZW4gR2hhbm5hbSB3cm90ZToNCj4gPiBGcm9tOiBZYXplbiBH
aGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+ID4NCj4gPiBGdXR1cmUgU01DQSBzeXN0
ZW1zIG1heSBzZWUgYSBuZXcgdmVyc2lvbiBvZiB0aGUgTG9hZCBTdG9yZSB1bml0IGJhbmsNCj4g
CQkgICAgICBeXl5eXl5eXg0KPiANCj4gWWFoLCB5b3UndmUgYmVlbiBoYW5naW5nIGFyb3VuZCB3
aXRoIGh3IHBlb3BsZSB0b28gbXVjaC4gSSBjYW4ganVzdCBhcw0KPiB3ZWxsIHJlcGx5OiAid2Vs
bCwgSSdsbCBhcHBseSB0aGUgcGF0Y2ggd2hlbiBJIHNlZSBmdXR1cmUgU01DQSBzeXN0ZW1zIg0K
PiA6LSkNCj4gDQoNClllcywgeW91ICJtYXkiIGJlIHJpZ2h0LiA6KQ0KDQo+IEFsbCBJJ20gc2F5
aW5nIGlzLCBmb3JnZXQgdGhvc2UgIm1heSIgZm9ybXVsYXRpb25zIHdoZW4gaXQgY29tZXMgdG8N
Cj4ga2VybmVsIHBhdGNoZXMuIDotKQ0KPiANCg0KU2VyaW91c2x5IHRob3VnaCwgSSdsbCB3b3Jr
IG9uIGl0LiBUaGFua3MhDQoNCi1ZYXplbg0K
