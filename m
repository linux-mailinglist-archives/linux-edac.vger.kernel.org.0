Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231622D0C62
	for <lists+linux-edac@lfdr.de>; Mon,  7 Dec 2020 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgLGI6Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Dec 2020 03:58:24 -0500
Received: from alln-iport-8.cisco.com ([173.37.142.95]:42891 "EHLO
        alln-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgLGI6Y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Dec 2020 03:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=868; q=dns/txt; s=iport;
  t=1607331506; x=1608541106;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P9efCInsjwoEOUF4UqlN7AvjefMuMXLrtT3jc8i0yQw=;
  b=dGlSqHCKVmuT2OUiECHUWk+NlaP35CCuCyoumzDBUxQPey8/L2BLBy22
   Nc7NCdJs2FnzMQCyh4nQ6qAB1WkKB4FPzyIssRp4C2bn+DSWTQrxtnXEu
   0Ess0CpMEE35EZ2Ol1plpttBVpL4qZax2COeaWKD/O8/K/u+Fs/4SBCsf
   s=;
X-IPAS-Result: =?us-ascii?q?A0A9AwCd7M1fmIYNJK1iHQEBAQEJARIBBQUBQIFPgVJRg?=
 =?us-ascii?q?VcvLoQ8g0gDjTcomQiBQoERA1QLAQEBDQEBLQIEAQGESgIXgX4CJTgTAgMBA?=
 =?us-ascii?q?QEDAgMBAQEBBQEBAQIBBgQUAQEBAQEBAQGGNgyFcwEBAQIBEhERDAEBNwEEC?=
 =?us-ascii?q?wIBCBoCJgICAjAVEAIEAQ0ngwSCVgMOIAGhJQKBPIhpdoEygwQBAQWFPRiCE?=
 =?us-ascii?q?AmBDiqCc4JmTkKCRIQUG4FBP4E4DBCCJy4+gQSDIIMxM4IsgkmCNIERknI/p?=
 =?us-ascii?q?QIKgnSbPAMfgw+fHZNynEyEUgIEAgQFAg4BAQWBbSGBWXAVZQGCPlAXAg2OI?=
 =?us-ascii?q?RgCg1eKHQE6dDcCBgoBAQMJfIwFAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3AtYnlhhCEKOcxkoy6NadfUyQJPHJ1sqjoPgMT9p?=
 =?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qw30A3ARp3W5v5YhuHW9avnXD9I7ZWAtSUEd5pBH1?=
 =?us-ascii?q?8AhN4NlgMtSMiCFQXgLfHsYiB7eaYKVFJs83yhd0QAHsH4ag7buWW/4DIOFx?=
 =?us-ascii?q?7/cwFyI7e9Fovblc/i0ee09tXaaBlJgzzoZ7R0IV22oAzdu9NQj5FlL/M6yw?=
 =?us-ascii?q?DCpT1DfOEFyA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.78,399,1599523200"; 
   d="scan'208";a="630137332"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 Dec 2020 08:57:10 +0000
Received: from XCH-RCD-001.cisco.com (xch-rcd-001.cisco.com [173.37.102.11])
        by alln-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 0B78v3vx028015
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 7 Dec 2020 08:57:04 GMT
Received: from xhs-rtp-001.cisco.com (64.101.210.228) by XCH-RCD-001.cisco.com
 (173.37.102.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Dec
 2020 02:57:02 -0600
Received: from xhs-aln-001.cisco.com (173.37.135.118) by xhs-rtp-001.cisco.com
 (64.101.210.228) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Dec
 2020 03:57:02 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-001.cisco.com (173.37.135.118) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 7 Dec 2020 02:57:01 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHJuuOFGv05hgmxJm1yhkc1Zu8w7VAbvyjQYfbj3hrofkjciziUCSJPb4WUYNbSQ0VP5g64fIhyivMPjyDJ0+OyU4BtSlRtuHpWBj8MnAnMdITrXISomhQt92bKbxbH8XyKZA4RKbBcGGGHTQkZQdHbov11mb6gmel+18rNPtXdaWFbteqtuXV4zLNflJYWsWDdqdAM7eT8/W8PggC7nCiRlEDKmaswXHlSRkXwkqCFVg+ildj0qNnvvUl051eR16qSF4dX6SV2QPPssEqugYVcssUzOvYmvgkrH9pAtT7s52lJUIN7dXfyxX7c7oCOEBPBf1KvPDIpnAXVQb8q9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9efCInsjwoEOUF4UqlN7AvjefMuMXLrtT3jc8i0yQw=;
 b=VOkEFL8nEkkyYWo4jiCHP62ZN0lsW44RVYWxDupG4kkDqCTPQ78tkS7SmLE7XKNK8pj4XgN6lwmNuK9G0TEubd6oBEFelnGKxr+9FaJl4tF+KEcpCAhBp5vYSITX+1VkL47vVzPygVRhxeEzEIpdtTnOy8QC2vFFCykg/F/7iWLWoIMyI0MRqVyBzpariEOtYfsl+8EqOSEeXPF0yOtYRph5l+YTfvSdkZdOnjG7E2C76X9xIfUApuT/s1RlBlyRnMOEXhYuGLCmnpFlI3n/tz+rhXyyN4C62KUHFO2C0uLe2tPjO7coDlGZtUof1v2DYk2CNeAH8q/1SVqFzzqgcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9efCInsjwoEOUF4UqlN7AvjefMuMXLrtT3jc8i0yQw=;
 b=TTl8a7kuQFRdVCqvrQIXbEVPgvD5yKyv9OQiQBFhOOw6r2nq/wMZeWwQF9VsxXBdXCWGpgMYvCFeCDfl+Lf3yRJEln4EY4PiWQmJvpnxD5MmvS3Cpru05dLQDI/uDvahH7GT01ZvBXGSIDmec0YusleyXuxnQZHARIeCUABmAiw=
Received: from BYAPR11MB3112.namprd11.prod.outlook.com (2603:10b6:a03:85::13)
 by SJ0PR11MB4942.namprd11.prod.outlook.com (2603:10b6:a03:2ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 08:57:00 +0000
Received: from BYAPR11MB3112.namprd11.prod.outlook.com
 ([fe80::1d73:ab72:dce5:430e]) by BYAPR11MB3112.namprd11.prod.outlook.com
 ([fe80::1d73:ab72:dce5:430e%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 08:57:00 +0000
From:   "Stefan Schaeckeler (sschaeck)" <sschaeck@cisco.com>
To:     Troy Lee <troy_lee@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Borislav Petkov" <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>
CC:     "leetroy@gmail.com" <leetroy@gmail.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Stefan Schaeckeler <schaecsn@gmx.net>
Subject: Re: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Topic: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Index: AQHWxvPQ/UqNooRbdUCtjP+oDaLSzqnf3r8AgAImKoCACNTqgA==
Date:   Mon, 7 Dec 2020 08:57:00 +0000
Message-ID: <40547026-144F-443C-BF14-C7FA0E3229C5@cisco.com>
References: <20201130083345.4814-1-troy_lee@aspeedtech.com>
 <20201130083345.4814-3-troy_lee@aspeedtech.com>
 <4AD4AB7A-54E7-4922-9547-7E26D61F7C77@cisco.com>
 <PS1PR06MB26008D10C46C5DF0B47F81368AF40@PS1PR06MB2600.apcprd06.prod.outlook.com>
In-Reply-To: <PS1PR06MB26008D10C46C5DF0B47F81368AF40@PS1PR06MB2600.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.43.20110804
authentication-results: aspeedtech.com; dkim=none (message not signed)
 header.d=none;aspeedtech.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2003:c6:2f0a:6e00:8072:30f2:2ac4:6def]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bf2b27f-9665-4906-6776-08d89a8e0f7e
x-ms-traffictypediagnostic: SJ0PR11MB4942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB49428EFD38FBC022F17F37F3C7CE0@SJ0PR11MB4942.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vsG8TevpJFV93tinw3PBq4cqVInzWcwBLCnrX+jJklsKO2A0HBiQtKIQmgF2bkId8Z93P9Pg7QHdwSnhGq66lbg4Q96caWT0cZqtxcMl+FB3Eovr8RHRWiMEX5FFCHD6KuyeWrQL2xb4SXPDf3y4npjsqmcQRmbtGHgqPFoY4sYQVPZ/WtqncbQRGItxqGahJFLsrbQO6WLFCyC8y3YNsyNy3ineUylhT2bwLk13IOlO/ALtUZ2NZQV9X0InzoUbbmaW05jsYWUeenmniTRTZaz5mv+15g0hC5P1S4LXpmxrReiliB3Zdeg9BEExP4K18gjuvHvvuP5dgykb8phZcRLHj0/rEMQakqZ53XulNi6BeDMEfLpXcJopNKoRptuVrIaotHeY/9HHu0ANZ5hPKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39860400002)(366004)(136003)(5660300002)(921005)(7416002)(36756003)(4326008)(54906003)(316002)(6506007)(110136005)(6486002)(8936002)(6512007)(4744005)(66446008)(66556008)(66946007)(86362001)(2616005)(71200400001)(66476007)(478600001)(83380400001)(2906002)(64756008)(33656002)(8676002)(91956017)(76116006)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VlJxeGlXYVdxT2M5V2NCRFZvNk9NdERVSGxIeEw2cVJ1V25NaEtzN3FLbG5p?=
 =?utf-8?B?OVNDcjhndVd0VUFNQ2FKK2hWWlBIY3p4TmJqcmRtMDh5VGN3dUZDZjFUUEtR?=
 =?utf-8?B?cDJLZWljRm1wNTdLeXdSK2RHNlJ2UWloekkzMVpFTGlKb3Q1WUhPcUNJbWJ6?=
 =?utf-8?B?QlpEL3o0S2NhbTZGWHZIejBmSVpUMUljU2l5RWlNL1JIOWZqbm9HdDJnbjY3?=
 =?utf-8?B?WG5EY0Z2MXFNMlFYY3dza0lMcG12cWtFN1huN05ZenNPTzcxSzdYa0QzU3Fh?=
 =?utf-8?B?a0RLNW42UWtZcE0vdlBhbC9GZUV5bE80NFdlanZIZmZ2ZFV3ZmVmOFA0QWtX?=
 =?utf-8?B?ZDA4bldBVG0zOU9LNHlUajJFZHRWVitsdllYUTVkL0Rhb3ppZjNBWWw1QmQ0?=
 =?utf-8?B?MS9DVzhPRVZkS0lLTVRIcWgzaC9NbkdqelpySGpsWVhVWUJoWkVXbm8zY21H?=
 =?utf-8?B?M3Y0SUlLUjBOR0l5QnhRRTJJZ094K2kyb3hNb2YwU2JlcmM5Z2xhOUVnQld6?=
 =?utf-8?B?RTMzL2NVQWVLRG92VE9paWdEeDdYVnVOSGVqVDczOU9xWG9XaEJSbURMbDlJ?=
 =?utf-8?B?UXQvSm5CUUZ2bUJlM0k1ZzlkMlZHaHNpMlVXaU0wK2lCNnc5ZEdwSWdvZmU4?=
 =?utf-8?B?N0RhKzRLYjJiT1d3WHpkMWxMcENuK2F4OW5HYVlPVmZaeThHeC9QM3VveTY5?=
 =?utf-8?B?MmY4MHhjMTlqUnZnS094bzk4STFaMllmaGNnTjlaaXpISi9lbi9pYW5zRVhL?=
 =?utf-8?B?RkIvZ3BpUHhUUTJUWTBNZ2tNU0lwaVE1Ykg5OVVQdHdQenpad0JzWDBNb0hp?=
 =?utf-8?B?MnRWT0tCVW9zWjh2ZTV0d2pxTFhJcERQOXFvVjdkbzBmcDI3YnRXd0ZUSEl1?=
 =?utf-8?B?NG9VaEhvdVcyNitpcENsWXhORkVHQnpkdU5YeDNkVWhOT0hTdkFnTjJmeXZv?=
 =?utf-8?B?SjFHbi9PRmpOYlg0OHo2Yy9Eb2FMT0pyc2JqMVB0OGxQUTVRTUM3WGZFdUU1?=
 =?utf-8?B?bUgrVGJyd0NoS3gvZXFpZ0pDZjhaWjRSYTVlaXZkdTNwbUIxNDBkVEV1TXM2?=
 =?utf-8?B?L3NOQTl1cVJ0UnR4NG9LY0tUOCs0N2dtbmlTemtkQVBpU0UyWjIrRWsvckNP?=
 =?utf-8?B?SHd1OEEydWppdzhWOTFDaGI5MmxMZDQ2OU1vZWNUdzNXT2pERFN2RXlxV0xR?=
 =?utf-8?B?T0p3RzFxb0t0eWk0bG9sT2NkSkh3ZG0zNEdDY1k1ZHluZ2Y5MVhqTk42cXNx?=
 =?utf-8?B?WG5Wa2d5dWpCOWczWlFGVG5HS1kyRHNHQUl4c1A4MnRUbjE3U3c2ekg0Sld4?=
 =?utf-8?B?dU0vSEUwdzlJQUx1MGp6amt6VW5Eb1oweEVEUGlnZEZoL3JqUTVGd1JvQmpH?=
 =?utf-8?B?Q2NLNWV5SE10RFNRYzhvM2I5MldXbk5XbVI2ZnMzYWJ2WE5zWTRxdnRsNnNV?=
 =?utf-8?Q?OXsAn7e+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6437A992E74E64A8C8A65B38AF3FE14@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf2b27f-9665-4906-6776-08d89a8e0f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 08:57:00.6829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NdTzKmzOSOH7sgexx9TnKZQItOjex4zIPvpzR07DcDVrCZTkvs/T4shfs75swkIF4exetNrrbnlbwv7i9xdQXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4942
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.11, xch-rcd-001.cisco.com
X-Outbound-Node: alln-core-12.cisco.com
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGVsbG8gVHJveSwNCg0KPiBIaSBTdGVmYW4sDQo+DQo+IFRoZSBkcml2ZXIgd2FzIHBvcnRlZCBm
cm9tIGxhdGVzdCBBU1BFRUQgQlNQLCBzbyBJIG9ubHkgdGVzdCB3aXRoIEVDQy1vbi9vZmYgDQo+
IGZyb20gdS1ib290IGFuZCBjaGVjayBpZiBkcml2ZXIgcnVucyBjb3JyZWN0bHkuDQoNCkkgbm90
aWNlZCBub3cgbW9zdCBjaGFuZ2VzIGFyZSB0aGVzZSAiZXhwb3J0cyIuIEFzIHlvdSByZW1vdmVk
IHRoZW0gYSBsYXRlciByZXZpc2lvbiwgdGhlIHBhdGNoIGxvb2tzIG5vdyBsZWFuIGFuZCBjbGVh
bi4gSSdsbCBnaXZlIHlvdSBteSBSZXZpZXdlZC1ieSB0YWcgYWZ0ZXIgeW91IGFkZHJlc3NlZCBB
bmRyZXcncyBsYXN0IGNvbW1lbnQuDQoNCg0KDQo+IFRoZSB0ZXN0IGRvYyB5b3UgcHJvdmlkZWQg
aXMgdmVyeSBuaWNlIGFuZCBkZXRhaWxlZCwgSSdsbCB0cnkgdG8gcmVwcm9kdWNlIHRoZSANCj4g
aW5qZWN0aW9uIHRlc3QgaW4gdjIgcGF0Y2guDQoNCkl0IGRvZXMgbm90IGhhcm0gdG8gcmVkbyB0
aGUgdGVzdGluZy4gVGhhdCBpcyB0aW1lLWNvbnN1bWluZyBhbmQgd2l0aCB5b3VyIGN1cnJlbnQs
IG5vdyB0cml2aWFsIGNoYW5nZXMsIGl0J3Mgbm90IHJlYWxseSBuZWNlc3NhcnkuDQoNCiBTdGVm
YW4NCg0K
