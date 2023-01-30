Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F5A681A3A
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jan 2023 20:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbjA3TWA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Jan 2023 14:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjA3TV7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 30 Jan 2023 14:21:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCF83B0F8;
        Mon, 30 Jan 2023 11:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675106518; x=1706642518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hezGOJtThAyX03R6N7y7EfWYTqIfF2BxaMnZaOOt+Wk=;
  b=EzLjlreYYN6g2+FHhcVT7/c1OYEIjC/NkpPRdVPVJTO1KaLGQO6Kch2y
   cDtNlIHTHf0XtMeVoA/hkpaJS50gGCJlUnawQ09EhOMnPHj73HdjZsV9g
   IY73AzXeSlXoYQnMEJBu4IwzVrdWRP8xV4SYddKUKzcFpQ5e10uFQ/5vh
   wPLrkxQXFpds7/Pojr6iRueYdPAJUzWxLGS4EkdJ4JZRJWjtV38Q+4jhb
   UsO27WSQo1+rFRZLUCcKGTnSEL+C0D0BCk7SHQ1ckqle7V+JtczkV/UMs
   prlcGfcvcYpIpTONOK4JjV3SUD3m/xKgO0EXFHI2C8SE0FXPFjk7mO9K4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="311274103"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="311274103"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 11:21:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="993004389"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="993004389"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jan 2023 11:21:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 11:21:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 11:21:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 11:21:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 11:21:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp8e/dtDm2uTm6FSVDbp3FQmqThns7TFYIG5sQtOFFKCf11s3f8ly2sGyRv+yNkEo8fWxVPjMHKICTdzAIVT+RknxYVq+PZPEYhdhy+oDjP+QurevsYOLz6AWZlDFq9VWl+sZEVgSCeIj0XYmyxA/eyJvmfoCJoxTtRWethlmFxJmjxabWI8zCRtBIo5mFbzZrAwKmYQ5BUNDjZkUkbIsGxR0V+970Odz9ObFULhzG9GLS3BzpLwqhWN0PoUfawihKIjlkmPCqGmuiTtL5UN6G+uN5YSk3F8aBd6/FGVA5ZtAJ5ewyXZls3t81z+aWerpF0S3nkEFO0EsmCHTdeiDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hezGOJtThAyX03R6N7y7EfWYTqIfF2BxaMnZaOOt+Wk=;
 b=CwjvVpJGfARQvZLQMwRVUlAu3gw9sKqUdjV9u3ssSiOexM9sMX+VR7/q+XWWCwXJIm8G7bAJf0+4qBpCtzpFjCoCD0QaFoM+VIBLD7Q2HeHL+5v8KZ1+dmuUMJ0Ux8WQAVMywdq+IEemFlRqdbripFnZjt2/AdrH/KW5E+j3lPvjDFlWr3Aj+w9PScHfliSOP9CXrUAliwz1TUMOxQV8YXpN+75AnHeRNA0Y3tS+wOa3WAG9T6BGkpu1y/os7/amZK64dR7wIMELTBuIlOVUs1Zq+YJQIxK3ZHTEqRFvzNc8wFZ4g4CsnxTBEY/6JIbvQ8eP4itUs8mEbqb3cYnQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB7090.namprd11.prod.outlook.com (2603:10b6:806:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Mon, 30 Jan
 2023 19:21:15 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::ee6a:b9b2:6f37:86a1%9]) with mapi id 15.20.6043.030; Mon, 30 Jan 2023
 19:21:15 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Li, Zhiquan1" <zhiquan1.li@intel.com>,
        "Song, Youquan" <youquan.song@intel.com>
Subject: RE: [PATCH] x86/mce: Set PG_hwpoison page flag to avoid the capture
 kernel panic
Thread-Topic: [PATCH] x86/mce: Set PG_hwpoison page flag to avoid the capture
 kernel panic
Thread-Index: AQHZMfHGxxBtYLGsIUOyOnx26oRfnq62QkyAgAEYxYA=
Date:   Mon, 30 Jan 2023 19:21:15 +0000
Message-ID: <SJ1PR11MB6083B06E5B75E429E5143B76FCD39@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230127015030.30074-1-tony.luck@intel.com>
 <20230130023226.GA3955454@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20230130023226.GA3955454@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB7090:EE_
x-ms-office365-filtering-correlation-id: faab2200-a10d-4b64-c7f6-08db02f7280c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zeAGfhz/YMzjth76AiPltPJSu9JHIs7Dg17126JhqnrD0tRt+4n25cvmrW0xVfUF/7KXGwEI74Gm0TD6PnKx/RX8g+0G3R2MNK86Qr9nsdgx0SsPolrkv+Vs7viWIq1cBkZezRfTcGtD/cwEy7WPpm5Ium8TjzwmU/P1mU4hQftZoa1ZIbWmyed7kgAoa0zjqvPpi3v2/3L6c0vFMCq+ueNnWcKsKbjcU4kLxX0DGSaadsIey16RNpEdlER88WW70UxeVg3HUHmCSrA1d96u0ungZ7SkU6moqGUwLxQG6dk22KuF7yzh3dbYbHQ12pxaTO4x10k8xwFPX7E/eUqY4Lp1NKHJ1WEFHTfp3pdVE5nHPALSSUAcILbLANciClZBiqVCfMSVjzbW6aOiVIal1sYNRNKoCcK045o2EFDaDXhKPnO/trSHyLJzANACGc4AY1nPPjnGoga5mTIHzfHsqwn1SP9PlPXxY2wHFXSMm6jfTI3tIQ9ln1WWhcw7kugdaABzWmfJwAvmsj6N6Ap1i1mpTe0xTmrvTSQkYxEyJhfSuJGBT+zd4hHZG8nPPMrevQ/adngD01pcoSoxfoc7Zrb17yjnzN1/zKfzFhFMtrU0Ip+va31vghd5s938b6K3WW529yvy5fifFEcoU2fVXJSD+U4Sg7859xVrDA8J78NlK5XcepgCen7L/n3am8Xgud8WCIcAksngDLRdjyborg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199018)(33656002)(316002)(54906003)(41300700001)(66556008)(76116006)(4326008)(8676002)(66476007)(52536014)(8936002)(66946007)(55016003)(66446008)(64756008)(6916009)(38070700005)(86362001)(122000001)(82960400001)(38100700002)(6506007)(107886003)(9686003)(26005)(71200400001)(7696005)(186003)(4744005)(478600001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXF4aXRINnFUMlhOTlhuSmtuazhuOE52NjRDZksyWlFJQU56elREQzRCZ25M?=
 =?utf-8?B?TlZONE5KM3o1UnliVHJOQnpYeWx3YVcwL3RNYzVYVEE3TjNzdnhQbWFwWWZm?=
 =?utf-8?B?dCt0OXJBZXcyNnJaOWU5bEpGektnZG9HU1JMeE9qZmhPeStYNm01Q3pxOFJV?=
 =?utf-8?B?b2VzaEc0bVZQeHR6bFNzMzErNXdXY2UvbVJuSmgwbmZXdWpoMTUvUnRoTDMy?=
 =?utf-8?B?UFhSWHorYk9wK1UrZDNPeDFrdnFpY2lESXNXWWhyMFBtdEJWalZnYndVd2lZ?=
 =?utf-8?B?M3daNXpHRnBRZk1pZ1J2S0dZeDFNNlhZb0NBOW5Rd2JDVm9JM0xQckRGQm1U?=
 =?utf-8?B?RjNoYjZSaHlhRHBmMUFRZE53WW02MzJyYXFMSDNWKy9aUWpPdTBzNE5jVFgv?=
 =?utf-8?B?VWRZZXNqZEhEZFhNd21kelF6Z0ZTWWU4WEdKUmk1SDBNblE2Y0Y5UkxhdEZN?=
 =?utf-8?B?SEFuL08rbFhKenNpWkNmQXZtWVNHVTh2TStaR0Z0Tko1bStRa2VNRUFXRDJU?=
 =?utf-8?B?UFpwSDV4emtSRzlWb2VEMDRySHVoNFZVVG15NElTQ1JRRzBVKzVwVzZQNjFC?=
 =?utf-8?B?Sldld09BMXVBR3pnd0MxQTdTVjAwTWRXbytvdXN1T2JJbDY2c0NYc2poYkNG?=
 =?utf-8?B?V3R1NHpiZzVibW5DK3B2aE1PVWtBMWxJUVFRbjdoUG5YSXF2RFRjN1BlUk8v?=
 =?utf-8?B?bXNPM2JzQjNIMEFFU21oU0s5QVhMWEE4OVc2OGFNTEJ2WnF1SVpqQ2xyUE94?=
 =?utf-8?B?dTRpdE8ybUpuNFVSWHdBSFZ3eS9wbVlDRXVQV0FLTjlGeWJ3QlppUmJCdzNx?=
 =?utf-8?B?aDF1NUxBa1Y4bGRXVkMvS29OUVM0bTFPckwzK2ptQ2V6U0JNbjVRNnA1eS9m?=
 =?utf-8?B?Mkg3bEQ0SEptU3YwVDB2Q0VRdjRjc1k3blFScWJWcnRYbCtDVEo3R29rK3dG?=
 =?utf-8?B?K1NxNEtJcUR6UTREY21WYTE4ck1YcFJsUllMZzVkU3E0Ny9DOFFucXFDVUVC?=
 =?utf-8?B?T0dkbzdSYm53VHlTcGdMLy8rdjVvSkNXdkNwWlUvcCs0aXdEeVczUGM1MXFa?=
 =?utf-8?B?TlY1R0FkSmtycG55TjgxM2JYdkN3UVBXc2dvM2k3ZnNjNVNWSGRRL3lPQk1V?=
 =?utf-8?B?aHZXWGNENFZubnNHNWlnbnhrWFdEY29aTzZKYlNaQnd5V2pBWG81dUVHU3kw?=
 =?utf-8?B?SGYvcVZiM2JPU0tteTV5R2ZlS3pIb1J4Ukl0cGVrVU1FZlJUV1I5TU5qSEZv?=
 =?utf-8?B?MkRrWmxnR3BRaVpJcWxpSzFTNTNHUkRjQUxQTitwc3BIaWdxNzdPYWxyVUJW?=
 =?utf-8?B?QW1EN2JVLzVieDJmRWN1L1VoMVE1MzV6eEdQZHVObGFTaGdNQmFMZ2Z1NXdv?=
 =?utf-8?B?clBYTWJpUjBJOWJoU05EeGZnWHNSNG1GYjFVTklHTVRDcE1KK0NPSVhsV2xq?=
 =?utf-8?B?bXZLQlROQjdYeHI4aWtSdVNHQktrRWRFZFZDUW5TdGJxa2o4MVBzZTdoMmFh?=
 =?utf-8?B?Y0ZTazVhU1pzdEt4c2NQRzFubFNxTXFlUVJ5TWRHZlZ5L0xOZHVPSk1VZEY1?=
 =?utf-8?B?YkFjVy8yQW8wcFBpakIwbVBLdjFQNlRMRjQ5TCtmRDZrWHlmMDJ5a1haRW9T?=
 =?utf-8?B?TVR3bjJFejFvVHo5ckpWNEZMSFkxRGFyQjg0bzFITFVPMDFVYVVXVzJBdFha?=
 =?utf-8?B?TFRrYW5GUnJVYlh2NFhaVXdCV0NxelZUbnVCaVkzcDArQU1ObnFCMXgwUGpn?=
 =?utf-8?B?aFNNcWlmOEJGdXpyNG5xUEQzT0pOQTBDalNXa2U0NG84ZWw4dDNEOCs5MUdE?=
 =?utf-8?B?a0JodEd2NzNGM1pCS2ZwVDZ6WDVtT2NaWVByRGI0d2Q2Q1RDYWdIQlRaaDYy?=
 =?utf-8?B?cFJsV1pkU211M3N0NGN3bGRaUzdRZUJ1NTBrNWFjcGkrWnllUTdnVzl6UlIr?=
 =?utf-8?B?TTFSNkxGcEdobWRpNzZGbCtkcHhmTnUyamdiVFVKUk5wUy9sT1Q5eFJ4SVlH?=
 =?utf-8?B?QjJZZDZwa0d4OEZ1QlRKc0Fac0FYWkZBYlp1WGdiYXV3MGNMcUg3bDN3cjRF?=
 =?utf-8?B?eXVwQi94Tloyd2toVVp4TnJGWTRiWmREd0NuZ0h4aFFRWDhMT042c1ZEdnZG?=
 =?utf-8?Q?7QMtk678gGm+7863yZNjNWjMl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faab2200-a10d-4b64-c7f6-08db02f7280c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 19:21:15.4536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AFzRfh/wW1BKc94YxrXwwHz+16jAQzW6qlTJINjvT8NVG8DThKc0f7rUSlfWnuBmCfyqugv2uHAUYp8EY1TTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBBbHRob3VnaCBJJ20gbm90IHN1cmUgdGhhdCBTR1ggbWVtb3J5IG9yIFBNRU0gcGFnZXMgYXJl
IGV4cGVjdGVkIHRvIGJlDQo+IGluY2x1ZGVkIGluIGtkdW1wLCBidXQgc2ltcGx5IHNldHRpbmcg
UGFnZUhXUG9pc29uIGRvZXMgbm90IHdvcmsgZm9yIHRoZW0/DQo+IChNYXliZSB0aGF0IGRlcGVu
ZHMgb24gaG93IGtkdW1wIGhhbmRsZXMgdGhlc2UgdHlwZXMgb2YgbWVtb3J5LikNCg0KU0dYL1RE
WCBwYWdlcyBjYW4ndCBiZSBkdW1wZWQuIFRoZXkgYXJlIGVuY3J5cHRlZCB3aXRoIG5vIHdheSBm
b3Iga2R1bXAgdG8NCmdldCB0aGUga2V5Lg0KDQpQTUVNIHNlZW1zIHBvaW50bGVzcyAoYnV0IEkg
ZG9uJ3Qga25vdyB3aGF0IGtkdW1wIGRvZXMgaGVyZSkuDQoNCj4gQXMgZm9yIEh1Z2VUTEIsIGtk
dW1wIHV0aWxpdHkgc2hvdWxkIHBhcnNlIHRoZSBzdHJ1Y3QgcGFnZSBhbmQgYmUgYXdhcmUgb2YN
Cj4gSHVnZVRMQiBwYWdlcywgc28gbWF5YmUgc2V0dGluZyBQYWdlSFdQb2lzb24gb24gdGhlIGhl
YWQgcGFnZSBjb3VsZCB3b3JrLg0KDQpPciBtYXliZSBrZHVtcCBjYW4gdGFrZSBub3Qgb2YgdGhl
IFBhZ2VIV1BvaXNvbiBmbGFnIG9uIHRoZSBzdWItcGFnZSBvZiB0aGUNCmh1Z2UgcGFnZT8gSXQg
ZGVwZW5kcyBvbiB3aGV0aGVyIHRoZXJlIGlzIGFueSBiZW5lZml0IHRvIHRoZSBkdW1wIHRvIGlu
Y2x1ZGUgdGhlDQpub3QtcG9pc29uZWQgcGFydHMgb2YgYSBodWdlIHBhZ2UuDQoNCg0KPiBJIHRo
aW5rIHRoYXQgc2V0dGluZyBQYWdlSFdQb2lzb24gb3V0c2lkZSBod3BvaXNvbiBzdWJzeXN0ZW0g
aXMgT0sgaGVyZSwNCj4gYmVjYXVzZSB0aGlzIGlzIGNhbGxlZCBqdXN0IGJlZm9yZSBjYWxsaW5n
IHBhbmljKCkgc28gaXQncyBleHBlY3RlZCB0byBub3QNCj4gY29uZmxpY3Qgd2l0aCBvdGhlciBo
d3BvaXNvbi1yZWxhdGVkIGNvZGUuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KLVRvbnkN
Cg==
