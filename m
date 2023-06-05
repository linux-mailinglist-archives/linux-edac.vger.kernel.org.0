Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5358F723242
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jun 2023 23:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjFEV36 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jun 2023 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjFEV34 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jun 2023 17:29:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B552DC5
        for <linux-edac@vger.kernel.org>; Mon,  5 Jun 2023 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686000595; x=1717536595;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F/HuRrFB5nAdDcfiTucxCni4NyLUzFwUAn6i1iMZ5ns=;
  b=I9qPa3SV50ZBycxlJcztZIVuWBs3TfzLMnXcFWxpiN5frwGuXmaLTBvf
   1s8znvEFRJTkAjXZCws0ZUlE4QWxcb+/Jj4fhxi8s32D+vFAS7hjsmgd6
   WD0TA/5ZeOHdtTVPOycdsFkGXTl2VYC4PCidMbBZb+dGIg5BLvugV/nCZ
   mgDTBrlj7pYnKJwisqYT2ho1RhQQFSczCya6Oq+BCBE23ESpoQlWlLRS1
   0MHoHtl7hSBW0ZQNXkkciihSfx/tXLkcyf/sNFkxT52pBe8Y9mrwfp2rd
   wD3hCzTOZBfBG1gr2n8DegwQSznlnrnrn9jYUIRi9lwZ/rH/HoLWmjDi1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="341124408"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="341124408"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 14:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821324985"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821324985"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2023 14:29:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 14:29:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 14:29:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 14:29:45 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 14:29:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpYuMjAHTsIUWgGIGIO8lsBqXpA6yEBriZHShgvo9zMyf9XuAC3BEoIODRR8ulevZjHIc4GvFB4UTAIpTJS9CuYzSky+pC6vrUg45tEj7D+Tw/3Fr+INxp7XOZIQkTLHbuXtX1iyyhIqOmUKYE94g0431YtRTHJZTzQ7IWaDW1uuG/jeDQCsknohT1qeIy5tPeieQnMUUwysrtLjsJi2/N1F5w6f3nEaM51c8Rx6QfMz7O3YYLTrgZxBuF0dx1UzY6Mgilp81R0T5V9npshpo1JatdkKQjU9fRVgG2YrKimtB38Dr27MnPEDDzkPBUhK7alI0dTFT+41R/FVGdF8IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/HuRrFB5nAdDcfiTucxCni4NyLUzFwUAn6i1iMZ5ns=;
 b=feHZJOwmx44ep481Ky3Jd5febqH5Rv8mKsC8WfeQVYv9U3O7Qb0IZ6eDarpiHU11B+iFqyNZmRNoqsZZvMGTiJvq7pH76Bmvr622HDyqNoZHEoFaQUAzt8C+Zzya6qt8hKAM92lyjp1Y1wKH1Nn8VcPBPiVhVYvbULiJon6TphVzcOtqIvPpxxPgVaSLTmn7aIcF5qzrQ6cNdqbUb2IQklHw0tI0SLsyrfKsuLHmAtZEFXmLL4bbh+cC6O6asDPl5fNCAQqV/4th48V/EO0+Fpj/1lNatS1n0ljvnsotUjzEB6YmKuoAoeHQ0MS7z6QFyf3O5KOkWorn7mABr7qJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB5376.namprd11.prod.outlook.com (2603:10b6:5:397::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 21:29:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::8e5a:470a:d7dd:a012%6]) with mapi id 15.20.6455.027; Mon, 5 Jun 2023
 21:29:42 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@ruivo.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Aristeu Rozanski" <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7CAABk1AIAACA9ggAAMfoCAAALmcIAMM9WAgBL6hQCAAYhoUIAAJNkAgAABgaCAABzvAIAAEayAgAAGoACAAAEqAIAAAWgAgAAGQ1A=
Date:   Mon, 5 Jun 2023 21:29:42 +0000
Message-ID: <SJ1PR11MB608315031621B56B8A5244BEFC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB6083B867B6B95820366C08BDFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230523141523.GL4090740@cathedrallabs.org>
 <20230604160442.GN4090740@cathedrallabs.org>
 <SJ1PR11MB60830E9036D6D0181CF9CFD4FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
 <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
In-Reply-To: <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB5376:EE_
x-ms-office365-filtering-correlation-id: 633fc98f-b6d7-468b-940a-08db660bfa04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9tU5qh3R2qCDwLDHet0WSWDPLa4AtGO143HqQbf6f1Nzd6HQQp2bzL8HuB0nZHDUDdQMOJisp/LVuZcAlpKaxF9cZRlA5074XS1lc8KaTvJ6mI0VOtp5ywKTxdv2a1XKKMhCuRNWZ0ZZHdpGu/g98HBany6Cq6ktDmZ8uEimF/vfmdtvLoJfdnBr3VeGuxUdRMZyvbkVWaduqFx/mI6x74HNo3oDOTToMPT0bdkRhb1UzAYSkW4Bd5nXyESsV23niw270LtlO/jvqIlcNGS/793fhWCBVYobnl8Qy9hZvIuWh/0jVvFrD5t/FNLReBnz/K6qmswtYVsQWerhVzwdABjFI3eU//4mJjNV8UPHDkRNAT6Xj4zoEYJtkShfhzjfMsCt4+XkRy0dstA5iaOcVDYWgBRdPKlLY4IrdcWNb/R0vwYsb/LjT3E81Fnw/oBmgOaveb37FScCt16Tj70KdujDQrrttnwegWwsSI71wTIAvuWnAuizOEB/7PY8ufaiail3/Q6v6aoW+NEzXJQCxU9aFczGANwGfeHmhI00s0sI7JyWn6k5U4+zhOoqZowH4cQCKZjLyVEbxGzwWb7TnHqbs8fa86ThPOvKLLudDMu+PYQg9bLe52b8T+lW6M91
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(54906003)(110136005)(71200400001)(478600001)(8936002)(52536014)(5660300002)(8676002)(38070700005)(558084003)(33656002)(86362001)(2906002)(4326008)(122000001)(66446008)(66476007)(66556008)(64756008)(316002)(66946007)(76116006)(55016003)(82960400001)(38100700002)(41300700001)(9686003)(6506007)(7696005)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjU0SjYyeTAwU2ZSTGR0RVdiMEVwS2M0S0w3aWJkSjBLL3lWeWlDaUhWbXVs?=
 =?utf-8?B?TmNUd1F6aTFuL3IyeHdWMS84V3ZRQmc4RSsyZEVHMkU2RHRoU0g1cGx0b3VH?=
 =?utf-8?B?VGlpWUZTMlRHWnNMalNjV1BJa0N3Nk9lUmtqNWx5WWVsbmNHWEZKd2NyRnYw?=
 =?utf-8?B?N3FnR2NhUXhndmVqSUdtK0tyRnhYNXE0alFRTDJ6QWtyb3hibUJIaXhTekQ0?=
 =?utf-8?B?Y01FZVV5RlFWdjI0SitlbzBaYmxXTkN2T1pmcFZCelY5WmJVQkllb25iRE1a?=
 =?utf-8?B?L1dsQldKbXpWMTNrSUJyYm5zWnpMTm9CeEpvTUo1OEhDQ2ttNXhMYnJIK3U5?=
 =?utf-8?B?bXFnMW9JM3NoeGQ1bnNxaWJvbWJWMHZ6Y0tIVVRUSTBhVlVzZVV5STRxWFFQ?=
 =?utf-8?B?QUloWHBrRjZjanFPTVRnTmxQSW9GQWJ3d1lxZGp4L2tHV1diWk1tZTU2dDVM?=
 =?utf-8?B?WHpzSnBnYXZuQy9jZEN6Y3Yza1YrbUswL3prQkVQK010UGRVOCtsN080cU9I?=
 =?utf-8?B?TTBNYnl3dDFwbW9GajE4aGN3ZU01dUw1c1Vlc2Rzc0cxRVNDbXZITUFlSytq?=
 =?utf-8?B?dEJIbnhERi9PQWZlRmk5a2JYODFZUUMrcmwwOXlCK0xtZUtQbWhRcnlWRDRm?=
 =?utf-8?B?RE0xNnRSblA4cVpzZ0ZIMmdqMFU3ZTBTWGJ2NEhreDY4dWlSS2tVdDRMTGJ6?=
 =?utf-8?B?dC9qajF2blNZS25QeEtyQWh2bkthMGQrb0xQSU9NMzN6SkpzZStjSHdNZWhX?=
 =?utf-8?B?SmtJN2s4Vkp2cWNmcmE1NW16NzdhSmhEdWpHNUdBSEg5V05OL1hxdWYrUHow?=
 =?utf-8?B?VCs1N3JlSFY0d3BpQmU0NTlUSHRSakRFWDROL3Vjb3NWK2Z4UURMSmpoalZx?=
 =?utf-8?B?WnROZTduNDVsOXNTa2kvRlJvSkMranBLcS9IMWF3ODgra1VLTXB4cEhOVmZW?=
 =?utf-8?B?OEtJeFpRK2I4UWFHb2kxSXJ2bVdnV0pKdEFyZkh6ZW5ZRjAzcVR6UlZWSUZ5?=
 =?utf-8?B?K0daMHdxRzA1Umk0WWF0RFlBOWlWeDZJaDdPSmtwU0pCUlFVNjlZWjhlaFg2?=
 =?utf-8?B?T2NTcThSQmduOGZyVDNVTUFLck9pQkc3YjBHdWMrUlNHNVN3enFaUklwY2hS?=
 =?utf-8?B?MjVHN0RGZlFvSmFmTG5sUjhJL0VHdDhWdW5sSlM2NEZ3UGVOUlNBUVYzUE9W?=
 =?utf-8?B?Z3FmZHBJUVYzRjhnNnF4RDZvL3B0V3VrNUZVTjBLaFZmZHkweEYwcTN3MUpT?=
 =?utf-8?B?Z0tLdklkT281TkV1ZG9kakpQdVdLbTFXeFlGeDRyUEJsMUxSTVlwSTBQaUxk?=
 =?utf-8?B?MlVuNk5oZ1N1TWRwSFVvYWEyMUpKa3JxVnFwQ0FIMGwrc2ZNdUR3cStCYjZQ?=
 =?utf-8?B?T0ovbkZBUHpheDRHbnpNUHpFbXEvVlQwUkYyM2FldE1UN1FtaGs2NVo0bUpn?=
 =?utf-8?B?aUxjUXFzeDN5NjNDQy9PVGlNNnBKbFZQZkliOG9qUTQxN1N6dk9DY0dWVmZF?=
 =?utf-8?B?YzZJNXVCTGFUdXlKclNsSEx2d2R2Qml5dzZXN29RSW9JRmFrbjAyaDJaOE9w?=
 =?utf-8?B?K3pGK2pwY09SbkliV2NuMHhhMTZuckJTYUJNZ0tkelo2Y0o4cWtRaUpzVHc2?=
 =?utf-8?B?M2Z2dG85bmU3M3RGMWpoVG92enBIWk8rTXNyZTV4RmVDRDAxWVhRMk8yZEtt?=
 =?utf-8?B?a0toTXlubXV2YkZtWE9LcGxuKy8rK2ZLbjFramZsYlYyTEpJbTZNM05zak1Q?=
 =?utf-8?B?NEo3Zi9FMmF0ZTlqVXl4dEhBUU1WVGtRTzJDd09KWWlaOW5iekM4Vlc2NUxW?=
 =?utf-8?B?bEFCVjdab2dGbU9IUExwNmtNU2IzWkZaU2xDOG9uWGFaZFVJbTFBTjZXZmpp?=
 =?utf-8?B?YWNMR1E3V1pGV2w3N3plUEw4Y08rNkFNKzZhWEN6TXJOWmlVRGxHSHBzeUcv?=
 =?utf-8?B?aStqWHA2Qk9oZExzdjJOeUhhOWlQWEJrb0paQlBtMjRxZ2poemNBNXM4dGtv?=
 =?utf-8?B?dzZGZ0tPdm1hMHNOZElIZk9lTVpYYksvdW9BSHpUTkN3N044SDUyc3hnSGcz?=
 =?utf-8?B?YXZSY00xYmtaZEQ5T1JDTXZuR3dzczc3T2dVR00vbkJTRXkxQzNiSUpMRGI0?=
 =?utf-8?Q?lW+A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633fc98f-b6d7-468b-940a-08db660bfa04
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 21:29:42.8283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KuwQ7hEL6TvS6HprHcY+ki2q9xLZjFa1BhdRK0vz5BRLT5zRJ5xcIauDD965VR/lRb2zzk/ZgDsZGJjB2jIe4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5376
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBCdXQgbGV0J3Mgc2VlIGhvdyB2YWxpZCB0aGF0ICJ1c2UgY2FzZSIgYWN0dWFsbHkgaXMgZmly
c3QuLi4NCg0KSSdtIGdvaW5nIHRvIG1lZXQgd2l0aCB0aGUgdXNlcnMgbGF0ZXIgdGhpcyB3ZWVr
IHRvIGZpbmQgb3V0IHdoYXQgdGhleSBhcmUgZG9pbmcuDQoNCi1Ub255DQo=
