Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D10E2C80F0
	for <lists+linux-edac@lfdr.de>; Mon, 30 Nov 2020 10:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgK3JZj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Nov 2020 04:25:39 -0500
Received: from alln-iport-1.cisco.com ([173.37.142.88]:35442 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbgK3JZj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 30 Nov 2020 04:25:39 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Nov 2020 04:25:36 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=826; q=dns/txt; s=iport;
  t=1606728337; x=1607937937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZLQJ987S1Yqdtb5bY30vWDX24VamGgP6SzruM/6RylU=;
  b=lXZFZtugMyI99WLHDyJwTtSpfOowAOI0bFiOMKh+fi+CUhKptetMm2oz
   f9gClbTmWN2XdNlbBiOp5O742dZRlW3uF8Ht6nS9r47omXrAuVOctG7KW
   4vhscHp5gzgcSE7oUvCj9ogieXwho3MSNTAY5TRvNddbRjGaydbVflks9
   M=;
X-IPAS-Result: =?us-ascii?q?A0A+CgBet8RffZtdJa1iFggBAQsSDECDIVF8Wi8uhD2DS?=
 =?us-ascii?q?QONNCeZBoJTA1QLAQEBDQEBIwoCBAEBhEoCF4ISAiU4EwIDAQEBAwIDAQEBA?=
 =?us-ascii?q?QUBAQECAQYEFAEBhjwMhXMBAQMBEhERDAEBNwEECwIBCBoCJgICAjAVEAIEA?=
 =?us-ascii?q?Q0FIoMEAYJVAw4gAQ6hCgKBPIhpdoEygwQBAQWFBBiCEAmBDiqCc4JmTkKCR?=
 =?us-ascii?q?IQTG4FBP4E4DBCCJQIuPoEEgVkDhHUzgiyTPj6kcgqCcIkXkhUDH4MLgT2dT?=
 =?us-ascii?q?JNliweRLIQ8AgQCBAUCDgEBBYFtIYFZcBVlAYI+CUcXAg2OIQwMC4NOaokzA?=
 =?us-ascii?q?Tp0AgE0AgYKAQEDCXyOegEB?=
IronPort-PHdr: =?us-ascii?q?9a23=3A+q+gpRB2Gz/9jE/W4WOdUyQJPHJ1sqjoPgMT9p?=
 =?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qw30A3ARp3W5v5YhuHW9avnXD9I7ZWAtSUEd5pBH1?=
 =?us-ascii?q?8AhN4NlgMtSMiCFQXgLfHsYiB7eaYKVFJs83yhd0QAHsH4ag7buWW/4DIOFx?=
 =?us-ascii?q?7/cwFyI7e9Fovblc/i0ee09tXaaBlJgzzoZ7R0IV22oAzdu9NQj5FlL/M6yw?=
 =?us-ascii?q?DCpT1DfOEFyA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.78,381,1599523200"; 
   d="scan'208";a="603806869"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 30 Nov 2020 09:15:49 +0000
Received: from XCH-ALN-002.cisco.com (xch-aln-002.cisco.com [173.36.7.12])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 0AU9FmhW023428
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 30 Nov 2020 09:15:49 GMT
Received: from xhs-rtp-001.cisco.com (64.101.210.228) by XCH-ALN-002.cisco.com
 (173.36.7.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Nov
 2020 03:15:48 -0600
Received: from xhs-aln-002.cisco.com (173.37.135.119) by xhs-rtp-001.cisco.com
 (64.101.210.228) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 30 Nov
 2020 04:15:47 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-002.cisco.com (173.37.135.119) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 30 Nov 2020 03:15:47 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfhB3chLaVpAQNBjmUi8z+8ilo0tzRbYnUdlIvAh7WJse17oY6qU+1wYP/Sz0wl68FhYKQzAmAFKjBTdebjA9xFkmuxvwCEzhrgnnpN56NyIWIrLg0GMCjvytZyF1dMzzzZWCBDhZFEXfmmyWZO8ZED5ODd535qPJlCbaCX/EVn2DW2Jdy6UqUqvmBQR07KKBjZ598goehcZSl8nCLZXVckGocfdicl8333V9RpbVErTwwzJAeOkGkIORVCW1h1Ek41AQUikAMD0Ez6v2e7JWSG6eQE0Ay/D+/hdd8Cp6TRnddN+MA8cEDWWivGNl8yl5M5jseo+6IFMEyUtiaOT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLQJ987S1Yqdtb5bY30vWDX24VamGgP6SzruM/6RylU=;
 b=CZ/VRWMQthLPXRzKwOuEVCmdmyrNwp5JT0E98a7Pfgaxk0NjJs5o+gZBnB6PGKD1it1nqA1898HcXldnFCsCejBSd2HPXGsZ+YWC9wWf4kT0vkT7dcxdK1W5rBBOFUXkzBZ35YNL3jggMY2mBB8IhfEpgtbTxISdMLJBJ7a04Q1BZg+OTtaN+BmxGijGKogATWOetmDwy7iCyOdSZ84jeULs8lPY3lkkdTsqGEAlwYWJTbINCip0nEoZOzkYERDVFy/o+pWXg7QwiO11RKUlYofW+cH6FOeHzA4Qdx8sqQKZO497AkIHpzkE9Zu+/qRk1FO8aJckwa/f26VkPMfZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLQJ987S1Yqdtb5bY30vWDX24VamGgP6SzruM/6RylU=;
 b=hVUsut/g2eZJUd5PaINJewALl/FWkktRBVPSHHFgxMpRp6tdbxN6unqi3/RMh8DhIOahwSig/fQkA02nRKXtArS/+g9h5CCbvdciTvjDTLIMupib7JVfgNwQbpkwdAm1gP1Gm53cdbS5kxuAcyvIREXPgA2fIKxzVwQzmbT0fVQ=
Received: from BYAPR11MB3112.namprd11.prod.outlook.com (2603:10b6:a03:85::13)
 by BYAPR11MB2837.namprd11.prod.outlook.com (2603:10b6:a02:c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 09:15:46 +0000
Received: from BYAPR11MB3112.namprd11.prod.outlook.com
 ([fe80::b12f:b030:e1a1:132f]) by BYAPR11MB3112.namprd11.prod.outlook.com
 ([fe80::b12f:b030:e1a1:132f%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 09:15:46 +0000
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
        "ryan_chen@aspeedtech.com" <ryan_chen@aspeedtech.com>,
        Stefan Schaeckeler <schaecsn@gmx.net>
Subject: Re: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Topic: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
Thread-Index: AQHWxvPQ/UqNooRbdUCtjP+oDaLSzqnf3r8A
Date:   Mon, 30 Nov 2020 09:15:46 +0000
Message-ID: <4AD4AB7A-54E7-4922-9547-7E26D61F7C77@cisco.com>
References: <20201130083345.4814-1-troy_lee@aspeedtech.com>
 <20201130083345.4814-3-troy_lee@aspeedtech.com>
In-Reply-To: <20201130083345.4814-3-troy_lee@aspeedtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.43.20110804
authentication-results: aspeedtech.com; dkim=none (message not signed)
 header.d=none;aspeedtech.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2003:c6:2f0b:1500:78c1:2959:7405:3984]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fa0f86e-0fdd-4ef3-4d06-08d89510857e
x-ms-traffictypediagnostic: BYAPR11MB2837:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2837ACA419E01E13CEE608A4C7F50@BYAPR11MB2837.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:252;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMnPt+/XgP2q3sZ2TmzhyMJjxEDt1QWhYcpotjzmwPznfq2jMDU90ruMMv5UPEmdQFPpbUPkh9oRJ3T368Og3C1m6vglqaRm16aoIneqHpYYuBDXraCp8J5YHk1CXdfHy7gXla6saczOHEU3G5MSbJ0yGkwJWBS9DS2sIo7ookZHEUyr6wQ2s+da55fKOypF+m9qzH4HJTQGEzlqip8XsDBTAvildzMQgfvsHN8OwazeFqULo6QpMw54B6hLZYucTA6o+0x0P9fUuN1JsSRjpYSyh9EXWxjI1UcvIO0tdkW43DJ5mT13L7AG2rO1E/Lx24mEBv5srYC6sCVJlGZVLwAsQ2PvxbQhI3xo5ygzNvQAU29faM6bkqqErCpNcqvdfOfqTq+IHAwHZ89tFNDSxJTRqp+7mzzjR5loUqBXyGiqJVjZKXADreyyJ6PU4sQP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(4744005)(86362001)(33656002)(4326008)(2906002)(54906003)(8936002)(66946007)(316002)(64756008)(66446008)(66476007)(66556008)(110136005)(76116006)(966005)(478600001)(2616005)(7416002)(186003)(6506007)(6512007)(5660300002)(8676002)(71200400001)(921005)(83380400001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Wi9OTnczSlQ2SVVLUjNnOVZyMFJ4V2hLQ05BN0tRUGV1MmttbW5aV0lOWkJB?=
 =?utf-8?B?Q1JOWTZiMkRQelJQVUFrOEErWERTemxidUtja0cwSTkvL0x1dXlzOFZoU056?=
 =?utf-8?B?M0VNczFlQ1FUNkFuS3BNZVB3WHh3aitiTmE5ckZUMVpkMXhTOS9EYWU5ckJ2?=
 =?utf-8?B?dmxvbWFoOWM5aUZlZGphd3JHdzdudmVRMUlxekZYdDkzSkFTVFk3RmFvNmVv?=
 =?utf-8?B?STI1aXl1ZmR0eHltSjUwQjZ5UnFnVUVpa0JEMXpURDNnbHhXclA2UFd1VVBo?=
 =?utf-8?B?ME5XWGVNM1k4UE4vc2t5K1JlUE15QmhsMXVidE85QnZVVUtVSjBFWENJOWJQ?=
 =?utf-8?B?Q1lVUDh4UlVrcSsyd1U2QWk1amhLejg3S29ZbjdwU2pjV1pZaStHSFAzQ05a?=
 =?utf-8?B?dWpiUk41L01xUXBDbEgrWTdaRTNXbVVJdm1lSGI4Y2lYYTQxWC9VWFozV291?=
 =?utf-8?B?aVZSdUxaQXQ5aGE2WnJZZHN1bUY1YkNGYU5XaEhGLzg1ZEdSckViTDR4SkZq?=
 =?utf-8?B?NjZwTDg1YVZ1a0RhemdNczNjWGN3TGpsL2pZWi93YWhZYSs3NmYycWxTQlk3?=
 =?utf-8?B?S0xUT1VtRjRrdGhwQmprQTlYK0tQZW8rVWRiVmFGTmVTa0lxYzE2ODIwS25y?=
 =?utf-8?B?enUwaDJLOWhzdUVabThTOGVIcXAyTEREOWRwMEpZS05OY2JJd3dLQ05iRGV5?=
 =?utf-8?B?UzV5TTdnTEtETVpzWHB4SGNweXA2ZXJlSitMNDJvYlF6dFVXMXlWUGh3dmVN?=
 =?utf-8?B?bllHZE10RGxpbWVHMy9LZThNenRtUmdxWXBqRmxxN2VadUFqZW5TT1l5VDIz?=
 =?utf-8?B?b3lPeVNYRncxZTdqS2RLcVVRZDhYaUNrQnlxNVNwQ1loRjJMQ01lYXMwMlAw?=
 =?utf-8?B?SFIvQlh1cHNtMmsrODI1aEdMSWphaDhTMXFZRlk0UXpBNXUyL2ZHaklWL1RL?=
 =?utf-8?B?QzFpdEhzcm1FbTdiOGNnUkkwcHBhejZxL2NEdEVFNzJLSHF2MEx0UkhhbStJ?=
 =?utf-8?B?dFhMTVNBcENmcWF2Q1JSN2pXVTV3T1FIc1lUR2dqNWlsd2ZLOEJxQ0ZkSDdN?=
 =?utf-8?B?R3cySFdrOWNCbkNtajdKNHpJWTdwbmVreHFTdnV5cTlRMnBIcmFjSnBDMWFi?=
 =?utf-8?B?STFkQ2hiZDdMeFF5YUdKUy8xaDRkdUF4d3lHd0FwdXMwZ0R6NGhrVXgwMDI2?=
 =?utf-8?B?WUI5RUZZcFhHZldhV0lESEdVdnRuY0ZEQ01KOHRuVDNZOHc4enVYUGh4N2pv?=
 =?utf-8?B?WnBHMUZMaEJFTnlwOEZpa2FGbmR3dTNPT01PK1MvWG5CTDEvVHN1UVVObUo4?=
 =?utf-8?B?QXRLU1VRb1R5cThLMm9xeVU2R0NabjJiNXFCcCsvNVNURERUbUREeTZ2V0hu?=
 =?utf-8?B?RkNGeTcyaDZwVVgvUXN5c3pyR2ZsWExsaXZvZ01ENURaVVhDZjJhMzc2WGow?=
 =?utf-8?Q?3fHSF41J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CE6D1B90CB97A46814672EF13AD3C7E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa0f86e-0fdd-4ef3-4d06-08d89510857e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 09:15:46.3168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3hC6Xfb1kTm6cqml5eMI5uPLwpwC1b0NvTlr2/7cy71R5AHPcBXrfZudMBiL8T3WZ+/Rna2uNLLjb5UVvhi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2837
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.12, xch-aln-002.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGVsbG8gVHJveSwNCg0KPiBBZGRpbmcgQVNUMjQwMCBhbmQgQVNUMjYwMCBlZGFjIGRyaXZlciBz
dXBwb3J0Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVj
aC5jb20+DQo+IC0tLQ0KPiBkcml2ZXJzL2VkYWMvS2NvbmZpZyAgICAgICB8ICAgNiArLQ0KPiBk
cml2ZXJzL2VkYWMvYXNwZWVkX2VkYWMuYyB8IDExNCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tDQo+IDIgZmlsZXMgY2hhbmdlZCwgOTQgaW5zZXJ0aW9ucygrKSwgMjYgZGVs
ZXRpb25zKC0pDQoNClVoLCB0aGVyZSBhcmUgcXVpdGUgc29tZSBub24tdHJpdmlhbCBjaGFuZ2Vz
LiBJJ2xsIGhhdmUgYSBsb29rIG92ZXIgdGhlIGNvbWluZyB3ZWVrZW5kLg0KDQpUZXN0aW5nIGFu
IGVkYWMgZHJpdmVyIGNvbWVzIHdpdGggY2hhbGxlbmdlcy4gRGlkIHlvdSB0ZXN0IHlvdXIgY29k
ZT8gSWYgc28sIGhvdz8NCg0KVGhhdCdzIGhvdyBJIHdhcyB0ZXN0aW5nIG15IG9yaWdpbmFsIGVk
YWMgMjUwMCBkcml2ZXIgaHR0cDovL3N0dWRlbnRzLmVuZ3Iuc2N1LmVkdS9+c3NjaGFlY2svbWlz
Yy9hc3BlZWQtZWRhYy5odG1sDQoNCiBTdGVmYW4NCg0K
