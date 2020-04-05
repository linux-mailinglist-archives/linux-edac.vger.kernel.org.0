Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10ECF19ED38
	for <lists+linux-edac@lfdr.de>; Sun,  5 Apr 2020 20:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgDESBq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 5 Apr 2020 14:01:46 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:60200 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgDESBq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 5 Apr 2020 14:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3072; q=dns/txt; s=iport;
  t=1586109705; x=1587319305;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yyFIe/0R+H3yRctjiCihqkFHmmMG2W6alMOFji4H4js=;
  b=k9F9ioXTg7bum7XLrqkBjrbOYUd8qKV4ZRypTQTlPauYLgljfm2ChduA
   KyrIuq5KIh1CvLNAtxSF3rctmZVLw3e2FYsKABaBE03n92/YjPPExEwqC
   kENqzPs3uIqQndVMF4gIUCxp9+f5JxDTkHnoAIFQyTXRPE9r73G8n4mp1
   c=;
IronPort-PHdr: =?us-ascii?q?9a23=3AH2dYVhyH7kx366HXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5YhWN/u1j2VnOW4iTq+lJjebbqejBYSQB+t7A1RJKa5lQT1?=
 =?us-ascii?q?kAgMQSkRYnBZuAAEvyN/73bAQxHd9JUxlu+HToeUU=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CIAgDAHIpe/5pdJa1mGwEBAQEBAQE?=
 =?us-ascii?q?FAQEBEQEBAwMBAQGBe4FUUAVsWCAECyoKhBGDRQOKZU6BbCWYHoJSA1QKAQE?=
 =?us-ascii?q?BDAEBIwoCBAEBhEQCF4IvJDgTAgMBAQsBAQUBAQECAQUEbYVWDIVwAQEBAQM?=
 =?us-ascii?q?SEREMAQE3AQ8CAQYCFQMCAiYCAgIwFRACBA4FIoMEAYJLAy0BAQ6TQJBnAoE?=
 =?us-ascii?q?5iGJ1gTKCfwEBBYEvAYQLGIINAwYUeiqMMxqBQT+BEScMEIJNPoROF4J7MoI?=
 =?us-ascii?q?si1iEcTugHgqCPYdwjzodnAKYXZJ/AgQCBAUCDgEBBYFpIoFXcBVlAYI+Ez0?=
 =?us-ascii?q?YDY4dDBeDUIUUhUF0AgGBJo0cAYEPAQE?=
X-IronPort-AV: E=Sophos;i="5.72,348,1580774400"; 
   d="scan'208";a="471644696"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 05 Apr 2020 18:01:25 +0000
Received: from XCH-RCD-003.cisco.com (xch-rcd-003.cisco.com [173.37.102.13])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 035I1PVx023417
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 5 Apr 2020 18:01:25 GMT
Received: from xhs-rtp-001.cisco.com (64.101.210.228) by XCH-RCD-003.cisco.com
 (173.37.102.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 5 Apr
 2020 13:01:25 -0500
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by xhs-rtp-001.cisco.com
 (64.101.210.228) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 5 Apr
 2020 14:01:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-001.cisco.com (173.37.227.246) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 5 Apr 2020 13:01:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSnMPIrplGX3cj2fZsP4FjZIUtHWZvvVLpHCRIhruZB9D2fx+GUKM+KN2eR01qH7zkcXNG16qepQrjrxwheqD+g4EpOwKa4WkF69RYnoFc+tX/XEGE+cUJ3OqU3ieM1MQpMQImNc8cPm0GEaA1johHEI+eHSsw9Jxi+VZhWfzuzqZPIVIv0R1g/4hklaRXwWTbbyn42u1SYvDYil8P6uobRiDhbL6RaVdmDatiM8E/lV1bevfdn93a6gsnQkq3aDAaEXQgD5R+tM7twEq8VlDi8misa95nx6IOh7p6NGLa4mVPwMd8cwdJr4iGSIb9sj7O2UdJFhZpP8a+BJHL7IYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyFIe/0R+H3yRctjiCihqkFHmmMG2W6alMOFji4H4js=;
 b=hpGCvUie9R2wezo0VKzpFKNk+BtTVY4/5Kp7guABMo2t/uuBVPbJD/GJ7Rm3DtNDpuFMUskuepuwXjxYk9NVvdDf0ZaMh3uv+nXIZXB865jDnN12NlrTiZZaFInZSIwU4RuZMgVe3Kw4VcpV9wINp9QDpFRqOTAC/DPBMxtmxDnwnFyG0o0G5dXp6W7oZtm/Gv4hk/a52kN0iH1xNXja4UJM4MkBGq+iq3uWhtRJoWb4IEmH6sI4bUIsyLvkGzQo62iVUYBf53vhRKN4ANf7IlLW6K18lTLl8muEZbhITMLQ9s42JYM4FGhl87Q+AV5Qv7ormIbRt+jRme6yolauzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyFIe/0R+H3yRctjiCihqkFHmmMG2W6alMOFji4H4js=;
 b=fFXNXxJHhadsXZeGXkDXJAqdB2Pk1R/XLcPjMnJlEVxChqqOEL1693gVFb951bY4n5Ag4zdhNVv+ZAZh6PGwms6y2M5vT5zU29WTg+ITZG2liypvsfTcPreVm9S/fWKTQX9CSVUw7ZyOYX/9xqqJJXOS6Jki/EOF5h2dOXE6Sd8=
Received: from DM6PR11MB2539.namprd11.prod.outlook.com (2603:10b6:5:bf::30) by
 DM6PR11MB3562.namprd11.prod.outlook.com (2603:10b6:5:13f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.21; Sun, 5 Apr 2020 18:01:21 +0000
Received: from DM6PR11MB2539.namprd11.prod.outlook.com
 ([fe80::805b:a037:1a5a:362a]) by DM6PR11MB2539.namprd11.prod.outlook.com
 ([fe80::805b:a037:1a5a:362a%4]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 18:01:21 +0000
From:   "Manali Shukla (manashuk)" <manashuk@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Borislav Petkov" <bp@suse.de>,
        Aristeu Rozanski Filho <arozansk@redhat.com>,
        "Justin Ernst" <justin.ernst@hpe.com>, Russ Anderson <rja@hpe.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [ PATCH stable v4.19] EDAC: Drop per-memory controller buses
Thread-Topic: [ PATCH stable v4.19] EDAC: Drop per-memory controller buses
Thread-Index: AQHV+C49gAe7MhzwwUqG/ujZrWDTQahMm6eAgB64nIA=
Date:   Sun, 5 Apr 2020 18:01:21 +0000
Message-ID: <5D56C6A7-B076-47BB-9016-7BD54DFE71E7@cisco.com>
References: <20200312052201.49456-1-manashuk@cisco.com>
 <20200317102249.GC1130294@kroah.com>
In-Reply-To: <20200317102249.GC1130294@kroah.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.35.20030802
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=manashuk@cisco.com; 
x-originating-ip: [171.76.93.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71ec50cd-cf44-4500-8b40-08d7d98b5947
x-ms-traffictypediagnostic: DM6PR11MB3562:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3562A9AB2AD83D133CB55A26C6C50@DM6PR11MB3562.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 03648EFF89
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(5660300002)(6506007)(8676002)(7416002)(316002)(66946007)(54906003)(81156014)(81166006)(66446008)(64756008)(6916009)(8936002)(2906002)(91956017)(76116006)(66556008)(66476007)(36756003)(2616005)(33656002)(26005)(71200400001)(4326008)(186003)(6512007)(478600001)(6486002)(86362001)(966005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: cisco.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1abfmewMU2Mn8OnSyD/zwW0pQk1w+tQCpUc3UkIbUqZROhH5CeRnoj8Qz/OCFz9MQwsFxwi4l3fnjIt04TbXi/6yH3KXTShofsTqJ0ZV9EHSAMRlhoimAc40WTex/MmFIICVcBk279Za8BunJKGCN2x47OtJ8Ws3BffsPH4kwamp6v2fD6iL0CbTQpYtk3Fqz2Ra2vV9BVddFvsVmhEfVGSj4yiGpb3cfX1iJDP6g2zgKcBswKztltJE/1pUO5voKLqFlx+hhisR7gql2BFdaO37NecInzQKmnFedgxmR6fT0NRpkyD0j0wgsqjDApWD11JQhPIpD77e5z3Jk6hFIX5wp9IBAu27vWv6Yi6oYn2YUkzm4w3ft4C/onvpvEAfbcbUQSWqxH25ZvHSfX+f5KJocbajJa418cPNe75hWNWSRVvyD4rA1etCB9C2H1+zOvNVkhXdkaRFTF63L04qwa6Xe7NmR2dKPGvIMaMDKzpten19Ko0Hxt+pJ1MeUSe6s3PDPY5wlyjGHcpB4zsRw==
x-ms-exchange-antispam-messagedata: WBGMVfqpZm0vkhRSLg3wmq2ZrTdkUxrtAL23h5fyD3rKTHLsDuOzjRP/IF8js72s9zj2zhTkP1lg8VfdqymT2aQuV/ii4bIACce3t6JKdbnQiUjJuvSpSGw/8yDEu00yRNzBx5U7hj85MftBDc5blw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D3C4C8E9D78BB468986A54B3DE675EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ec50cd-cf44-4500-8b40-08d7d98b5947
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2020 18:01:21.7157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apRGpdLMZnLKcwJPa9xhUKIzRVTP6zRVVvlK4ViAj8Ly6e0wPxvjxkny4ZuY7i3eQb6Z1yFod09oE/yBmHwmpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3562
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.13, xch-rcd-003.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgR3JlZw0KDQpXaXRoIHRoaXMgcGF0Y2ggLCB3ZSBhcmUgcmVtb3ZpbmcgcGVyLU1DIGJ1cywg
dGhpcyByZW1vdmVzIGRlcGVuZGVuY3kgb24gdmFsdWUgb2YgbWF4IG51bWJlciBvZiBjb250cm9s
bGVycyAoRURBQ19NQVhfTUNTKSB3aGljaCBpcyBoYXJkY29kZWQgdG8gMiAqIE1BWF9OVU1OT0RF
UyAgaW4gYWxsIHN0YWJsZSB2ZXJzaW9ucyBvZiBrZXJuZWwuIA0KDQpPbiB0d28gbm9kZXMgc3lz
dGVtIE1BWF9OVU1OT0RFUyB2YWx1ZSBpcyDigJgx4oCZICwgc28gdmFsdWUgb2YgbWF4IG51bWJl
ciBvZiBtZW1vcnkgY29udHJvbGxlciBiZWNvbWVzIOKAmDLigJksIHRoaXMgcGF0Y2ggZml4ZXMg
dGhpcyBpc3N1ZSB3aGVuIHRoZXJlIGFyZSBvbmx5IDIgbm9kZXMgb24gdGhlIHN5c3RlbSBhbmQg
bnVtYmVyIG9mIG1lbW9yeSBjb250cm9sbGVycyBhcmUgbW9yZSB0aGFuIOKAmDInDQoNCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWVkYWMvMjAxODA5MjYxNTI3NTIuR0c1NTg0QHpuLnRu
aWMvDQoNCi1NYW5hbGkNCg0K77u/T24gMTcvMDMvMjAsIDM6NTIgUE0sICJHcmVnIEtIIiA8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KDQogICAgT24gV2VkLCBNYXIgMTEsIDIw
MjAgYXQgMTA6MjI6MDFQTSAtMDcwMCwgTWFuYWxpIEsgU2h1a2xhIHdyb3RlOg0KICAgID4gRnJv
bTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KICAgID4gDQogICAgPiB1cHN0cmVhbSA4
NjFlNmVkNjY3YzgzZDY0YTQyYjBkYjQxYTIyZDZiNGRlNGU5MTNmIGNvbW1pdA0KICAgID4gDQog
ICAgPiAuLi4gYW5kIHVzZSB0aGUgc2luZ2xlIGVkYWNfc3Vic3lzIG9iamVjdCByZXR1cm5lZCBm
cm9tDQogICAgPiBzdWJzeXNfc3lzdGVtX3JlZ2lzdGVyKCkuIFRoZSBpZGVhIGlzIHRvIGhhdmUg
YSBzaW5nbGUgYnVzDQogICAgPiBhbmQgbXVsdGlwbGUgZGV2aWNlcyBvbiBpdC4NCiAgICA+IA0K
ICAgID4gU2lnbmVkLW9mZi1ieTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KICAgID4g
QWNrZWQtYnk6IE1hdXJvIENhcnZhbGhvIENoZWhhYiA8bWNoZWhhYitzYW1zdW5nQGtlcm5lbC5v
cmc+DQogICAgPiBDQzogQXJpc3RldSBSb3phbnNraSBGaWxobyA8YXJvemFuc2tAcmVkaGF0LmNv
bT4NCiAgICA+IENDOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCiAgICA+
IENDOiBKdXN0aW4gRXJuc3QgPGp1c3Rpbi5lcm5zdEBocGUuY29tPg0KICAgID4gQ0M6IGxpbnV4
LWVkYWMgPGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnPg0KICAgID4gQ0M6IE1hdXJvIENhcnZh
bGhvIENoZWhhYiA8bWNoZWhhYkBrZXJuZWwub3JnPg0KICAgID4gQ0M6IFJ1c3MgQW5kZXJzb24g
PHJqYUBocGUuY29tPg0KICAgID4gQ2M6IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4N
CiAgICA+IExpbms6IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxODA5MjYxNTI3NTIuR0c1
NTg0QHpuLnRuaWMNCiAgICA+IFtNYW5hbGk6IGJhY2twb3J0IHRvIHY0LjE5IC1zdGFibGUgOg0K
ICAgID4gLSByZW1vdmluZyBwZXItTUMgYnVzLCB0aGlzIGVuYWJsZXMgdG8gZ2V0IHJpZCBvZiBt
ZW1vcnkgY29udHJvbGxlcnMNCiAgICA+ICAgbWF4aW11bSBudW1iZXIgbm90aW9uDQogICAgPiAt
IHZhbHVlIG9mIG1heCBudW1iZXIgb2YgbWVtb3J5IGNvbnRyb2xsZXJzIGlzIDIgKiBNQVhfTlVN
Tk9ERVMuIE9uIHR3byBub2RlcyBzeXN0ZW0gTUFYX05VTU5PREVTIHZhbHVlIGlzIOKAmDHigJkg
YW5kDQogICAgPiAgIHNvIHZhbHVlIG9mIG1heCBudW1iZXIgb2YgbWVtb3J5IGNvbnRyb2xsZXIg
YmVjb21lcyDigJgy4oCZLCB0aGlzIHBhdGNoIGZpeGVzIHRoaXMgaXNzdWUgd2hlbiB0aGVyZSBh
cmUgb25seSAyIG5vZGVzIG9uIHRoZSBzeXN0ZW0NCiAgICA+ICAgYW5kIG51bWJlciBvZiBtZW1v
cnkgY29udHJvbGxlcnMgYXJlIG1vcmUgdGhhbiDigJgy4oCZXQ0KICAgID4gKGNoZXJyeSBwaWNr
ZWQgZnJvbSBjb21taXQgODYxZTZlZDY2N2M4M2Q2NGE0MmIwZGI0MWEyMmQ2YjRkZTRlOTEzZikN
CiAgICA+IFNpZ25lZC1vZmYtYnk6IE1hbmFsaSBLIFNodWtsYSA8bWFuYXNodWtAY2lzY28uY29t
Pg0KICAgIA0KICAgIFdoeSBpcyB0aGlzIGEgcGF0Y2ggZm9yIHRoZSBzdGFibGUgdHJlZXM/ICBX
aGF0IHByb2JsZW0gZG9lcyBpdCBzb2x2ZT8NCiAgICANCiAgICB0aGFua3MsDQogICAgDQogICAg
Z3JlZyBrLWgtDQogICAgDQoNCg==
