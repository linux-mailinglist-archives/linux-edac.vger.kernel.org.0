Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4636F66179C
	for <lists+linux-edac@lfdr.de>; Sun,  8 Jan 2023 18:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjAHRzD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 8 Jan 2023 12:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjAHRzB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 8 Jan 2023 12:55:01 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37069E0EB;
        Sun,  8 Jan 2023 09:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673200499; x=1704736499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MZ4AC4cOD5fTjpOGRiEXmba3Ilehs+WIi7VQARE+JRw=;
  b=GG393XWcRmo+QjhP3SFZBDlw/QCoE8To04Y01AUDDwrUKtQZr8cWsqfC
   kz4ivbCNC8/qCvLqhwgrbA/HgHfHRWkFkCTOUyFy59+Fd+tpDRtXGkhLm
   MtsD5t/a3HzvTIFn3f7GAN9uXuZ451bGSvVjARSiqkDGGejHVQ2hSijO3
   6OQsgIFLU0JtWU/aN4ewU0xc23iRBo3EUWefxtgdt5EogmivmO3xLKwxn
   lOBhRCiSJFY0hPQKTQAuA7MdB8+V4fRQ23yQaHcASxBnEFUXruQs6tZvv
   bIzMvJHjkXfDJ0TEYa/nhW2RY9/R6sTurT2d2PjoiwZ0zZ81m2RVQbj+n
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="302440933"
X-IronPort-AV: E=Sophos;i="5.96,310,1665471600"; 
   d="scan'208";a="302440933"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2023 09:54:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="764072319"
X-IronPort-AV: E=Sophos;i="5.96,310,1665471600"; 
   d="scan'208";a="764072319"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2023 09:54:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 8 Jan 2023 09:54:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 8 Jan 2023 09:54:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 8 Jan 2023 09:54:57 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 8 Jan 2023 09:54:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcXOXRcBkFCRG0RPHkAKaO5t0KABL013xIJQ/JT41X7Xx1tLoNBpx2PzWpMEMYQzcnlvFLuY8sKVb7Gfh0fJmNrl4z8xLZcXOhloZTxETYVnGhY/Pt+HWZTjZUGQsAaPEZbpAd4XIAIHSHd8V/vMgzBA8vhtnSZCY9pxfR1xQbbknjgmAPd35GNqmh/EKEVcS9Qsvp/HOYssw3PZLWgeZGD9DhAtKKyB6TQZKPVVARytgliNjOC4qsU+DH4rVl3AapUFzTZlXdSvgt4UidGQKqU0o/nJciNaqdLp/qrCKqLZctq6IXUvnidZbP11Hi3mEna3pH9Bp0IyCBkvrR8jaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ4AC4cOD5fTjpOGRiEXmba3Ilehs+WIi7VQARE+JRw=;
 b=NWkvuZXP1n/IsDriH42m4iylQnJOCIo01+qacwWu1gLk5QGgw7K70U0Tf/To2EtglZXvn9dZioFjj8nxOoN2vNICVf/kVbo4rYwVLizzTpTCCNGf/Fzy/i5BjKdqcJdl5gTnGHgCDz1DFTMVdYwKqJ38Tu4qWO8ume3eCBHW9JXgoQ2TkJ07ttRRHhDxKpSpIK1OipKulJfkYdCIB7Wuf70SlDU9lssSMl0YTGnxU+z8zUrcJfHbSrsmyLe0VAzOkfNHFuauFpcaww4/FJ/54vc8NXNPYYTw1ksJf7dVapgFmP9iU7jVVmjJYaptdZz1m3/W79GC8nyPWpR8hZlWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sun, 8 Jan
 2023 17:54:55 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3c14:aeca:37e2:c679%6]) with mapi id 15.20.5986.018; Sun, 8 Jan 2023
 17:54:55 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: RE: [PATCH] mce: fix missing stack-dumping in mce_panic()
Thread-Topic: [PATCH] mce: fix missing stack-dumping in mce_panic()
Thread-Index: AQHZBiod8rBYaoP1F0+0JAoGaAcDUa5aqxswgADD7ACAKX1GgIAACwCAgAAE7YCAANthAIAHiZWQgAN23gCAAQX3gIAAlLEAgAKUQSA=
Date:   Sun, 8 Jan 2023 17:54:55 +0000
Message-ID: <SJ1PR11MB60839243ADBEA755203CC352FCF99@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com> <Y61/+V47qH/8OVxp@zn.tnic>
 <1e97c11d-99b6-c06f-b67f-c56ba6653d27@huawei.com> <Y62NVThhnGtnj71u@zn.tnic>
 <276c9e6b-d647-6f7f-7bd1-c1f45ca23261@huawei.com>
 <SJ1PR11MB60831AB2202FF0C3CF99EF1DFCF49@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <b63056f9-0709-736b-ea5b-5e903410cb1d@huawei.com>
 <SJ1PR11MB608346981E53D14BF37788FCFCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <c89697aa-64c4-d65f-5f65-aa94c1de7e29@huawei.com>
In-Reply-To: <c89697aa-64c4-d65f-5f65-aa94c1de7e29@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5226:EE_
x-ms-office365-filtering-correlation-id: bf10cae3-3116-4d37-eef8-08daf1a17341
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ini8MF1AsXenJ9k6GfWOZ32HgU9F4itxe6+c9PPbrYK/5XDH45rSC88d9Tu+JpGtDxqOg7YTCRKzocgHjZqZ5nnts32OhOp60i3f3Z8vj7xBq1OyOEOa+drWlrcQsIiJpiJ/VWWhHNxucZA789eWTAmBVjI/FJxX5CI0M2r7idoqCtxwiBa9Gj47pr9Tu8HezzZugxkVA0ihKZTqRbYl9TybS+f/HpnEWsbcjgG2mWIW1Ywh4oNnsNJibcUrqCbQd32B2noWXJJ7ZM6LPdMcHi4ExZbfmiWNsyn71D2ypBK3ufnXwoPzWwvzPgBKEApf1XReEBNtfj/eNXky1PB1YaDZwp45qgTLWq80mSI83SgicXsT0WoM0lB//q6UEdbf3QmOOVFiLIeQCVuszAdnEIbWNYo57zho2kXkBbqX0Y+qpBugjU8FB0rId9xel83MmAlAd4cvL8IC8R0XkFiBG8bJ2XBaU2VVAbvbgZZ3bbbHorMJ/aXX/Pnw4qxB92qN4EYTSboAzgSzG25CXmARCulWNcKjmAdLa3iSuzlZdlrrXgOmBBrTBkWW9jpHao5IosrxPBPiroVjmEBsIXtf7ZkuJgSWvHoFNWyTjeG3TluOaeSlpl+tZ7BOj9HYferSakpmkW2+/Pboq/YAVtBWkzC1RtKYtoe7Cm/YJ0PL6jsC1q/akxI3cDd3hf5l0GEb+k22mf1eJjEegwkOGX7Y9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(8936002)(2906002)(5660300002)(52536014)(41300700001)(71200400001)(7696005)(66446008)(4326008)(66556008)(64756008)(66476007)(8676002)(6916009)(76116006)(316002)(66946007)(38070700005)(4744005)(54906003)(9686003)(186003)(26005)(55016003)(122000001)(38100700002)(83380400001)(86362001)(478600001)(6506007)(82960400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVlKTFo3eFdwS2J2MlU1S2wyY2ZmbTF6RFByUFAwSmUwT1p2T083MS9ocTVX?=
 =?utf-8?B?cmFkWGV1d1lYUWV6QXEwaVcyT0gxSHhxSzVGNmg5VFJwanZ3ODc0QUN0RDFk?=
 =?utf-8?B?ekl2YnpNMm9OWGY1TCtnZjRZRVVhdlE3SGFZRXZ6YWFCN3hrVTNaQjl5VnRJ?=
 =?utf-8?B?VWZyK3pYWUYyd3dBK2tqUEtGUlhmdFNjbHdhamliY0NkbG56bzlsUmp1T1p0?=
 =?utf-8?B?MDJYck5mU2RQMlhSSHJWYnZ1d2F3YTNqc3FBRTVyMFFrb1VibXg1NFQzZmxu?=
 =?utf-8?B?Y0NZRmEySUZtdWFOM2dsSFh2ZVZ5UVBaV085a1p6TUplbFEyRk81WUthL2hU?=
 =?utf-8?B?QUkvV1RCNjFEb2tQcHNZOVVmU3JGdWIwazd6RlNINnZpZ0FSM05UQUFDQkVq?=
 =?utf-8?B?UHdzMmdYUWdIUnI0VlpmREw3RzRqZ09YLzlLaXdiS2FrTm5NVkd3R2c3Mko3?=
 =?utf-8?B?YXJnVi9tb0FvZU9oNWxiczdlcDJTblExcHlWblpQM2lhWGNOTE05dXFHNFNB?=
 =?utf-8?B?VjIzS1JTMFhISnM0NVA4NHVGQ013VE5zTzlDMEpUQnRoL0RIK2pRQ0E3NVNN?=
 =?utf-8?B?bnhzQmIyWGh6QXJPOE4zb0QvdzVlQ3ppQkhxOXIvbE9RTVpTdmNmNjVKOFMz?=
 =?utf-8?B?RFJMVkVTN2JvUzN6MWsxMFZvWHZlWUlUaEt5RExjY29Dd3I5WnBsWElxRk9l?=
 =?utf-8?B?OVh3L1Q5cmtXbEJHVytPYWc1OFIwVzd5SXYwWXVOTlV1Ymh1bWNnVUNpQWxH?=
 =?utf-8?B?L2NRMjFlaGtMV0NKM3dmOFFGcjVLMHdxanBSS0dOa3FyY0t5ZHV6eFFwcjYv?=
 =?utf-8?B?QU1kNG1Ca2MrQUVHYlZPZmE2bkhnRHRZWTZkZEtVVW1mZit2Q3RSL2E2NmNH?=
 =?utf-8?B?R3ExSGxralJ0dUlWWXhkc0dzaThvNjN2QU5JVlkrOWlDWGxhejZCWFlRbkd1?=
 =?utf-8?B?ZVZ3ZVpCcmYzdzRrSUpWdG5jVVNaRkpjUmJjOThPRzAvYTV2Q2dSblFZREgy?=
 =?utf-8?B?UFZkbTRuNm9PcVpRd0tuUmR4ZTJRSGIyRGR2MVRpVFYxQlRVT2FQWCtVNlhu?=
 =?utf-8?B?R0J1WllQWnhYNUp4VjdRaE9GNmtEMGwvclVZOEFjUlNRcVVPV1drRFRPZFR6?=
 =?utf-8?B?TzM2QmNiSTYreWw5UzFHWlplVmEyU21JeEFxTTNYU0lDZVVCRWxMSGFVUy9l?=
 =?utf-8?B?SnRHbXBGSHVGS3VwY012eXU4TzZvTXdQd1kwcFhzenpPSzZmb3pzZ0tGTGtp?=
 =?utf-8?B?S2lhVzlqQzUxdXY0OWlwSVFWK2xhcE9hdHU3UkxsTTIwaDhudUt4SVpxUlNT?=
 =?utf-8?B?Ymw1QW1VQjhjcnhnbWJoa0c5ZTBqQ0xLSWMzZm5YVkk4WlZMM1hWZ1lRVWJr?=
 =?utf-8?B?Y2NBRWxIUUZiT2RSemFWTmVObHpwbVFtVFhabUxtdmhOeUZxaHBLaW42Y2d4?=
 =?utf-8?B?aEpFZFhieXZGNXhHK1ZOVkh0UDQ5SC82WmpuZFZ4NGFmY0ZYOXVaQlFJWkRK?=
 =?utf-8?B?amF1Yk45NTFUUEx3MHI5TUtxR0pmcEJRZjNJVjg3bWZ5U0JGclNuVGlYOEJx?=
 =?utf-8?B?S3NRaDRsMXFNK0RXS3J4TWJFaXdhS3c3WGJielVDNTNvVmtvam5oU0ZYNVZM?=
 =?utf-8?B?UHFqTFdqSU1jOTZnYXZVM2t1dm92UHJVNXY1WDh3UFRreU5PcklQWDVydTZa?=
 =?utf-8?B?SHcyV3NZOU5WUmdBM2s1bEN0dURGbVB6OXM3RFpwUmpKeldyWnovNW9ZZTIv?=
 =?utf-8?B?K0lMOEsraTRUOVBiTTVpcC9tM1JuNzZXdTh4UkN3cVJrTFNCK01QT2tndU9Y?=
 =?utf-8?B?NU1FRENzcjdML0F4VWZLRU45M1F5MUlXVjV1WFVEanVpUTN5NWF0NC9rcVVx?=
 =?utf-8?B?ZUlOSVRPK3kvZ1JWU3N3OGdITVE4YzZ0ZW9jS1hjOURSM3A3V3VMZFh0eFpi?=
 =?utf-8?B?eThwYmkvdW1GdS80bEVtUmtPaFAzbjIxaTFWYUJUc2t2UW40MEpKNi8wK0xs?=
 =?utf-8?B?cFBpZG9tOUNXYjZsSEduNGQ3OEVZRnl0byt4QWMxSk91SzNyM1lPTlZ4UDIr?=
 =?utf-8?B?aTI2ZElrM3U3WGpUSTdtRWsyeGdoWmZOa0I4R0JveVZ3bXIwcVA1eTdjaVZG?=
 =?utf-8?Q?YWUg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf10cae3-3116-4d37-eef8-08daf1a17341
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2023 17:54:55.1919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44e3siXOkEWFrjxgdOPcZ4DoC6u/D63U6/BzZLc5YFa+AVgG9DNvfhsMXRTX6m6qOCeU7YnPQ35rCeGOFvRiaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBBcyBhIGZpcnN0IHN0ZXAsIGxldCdzIGNoYW5nZSB0aGUgY3VycmVudCBiZWhhdmlvciBvZiBu
byBzdGFjayBkdW1wcyBmaXJzdD8gQW5kIHRoZW4sDQo+IHdlIGNvdWxkIHRyeSB0byBhY2hpZXZl
ICMxIHByZWZlcmVuY2UgaWYgcG9zc2libGUuDQoNCk9rLiBSZXBvc3QgdGhlIHBhdGNoIHRoYXQg
Zml4ZXMgdGhpbmdzIGZvciBhbiBvb3BzIGR1bXAgZm9yIGV2ZXJ5IG1jZV9wYW5pYygpLg0KDQpN
YXliZSB0aGVuIEkgY2FuIGxvb2sgYXQgc29tZSB3YXkgdG8gc3VwcHJlc3MgdGhlIG9vcHMgZHVt
cCBmb3IgdGhlICJ1c2VsZXNzIg0KY2FzZXM/IE9yIHBlcmhhcHMgYXQgbGVhc3QgYWRkIGFuIGV4
dHJhIG1lc3NhZ2UgdGhhdCBzdGFjayBkdW1wcyBmcm9tIGFyYml0cmFyeQ0KbWFjaGluZSBjaGVj
a3MgYXJlIHJhcmVseSB1c2VmdWwuDQoNCi1Ub255DQo=
