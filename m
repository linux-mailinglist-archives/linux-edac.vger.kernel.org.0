Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FAF728C62
	for <lists+linux-edac@lfdr.de>; Fri,  9 Jun 2023 02:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjFIA1D (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Jun 2023 20:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjFIA1D (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Jun 2023 20:27:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF02115
        for <linux-edac@vger.kernel.org>; Thu,  8 Jun 2023 17:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686270421; x=1717806421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LUfpSRer0NDhFERkKL/sfBTH0pq7so0DaG+sChmFexw=;
  b=MgSORQn4EpTbZ6KfGBTX3br9G25c+XOEWPLa8IlOYzJ6qTzZDbz993PE
   138inYMjlZeWZ0Obj3p1IPST3ZsGcv1eiqE7F4qB/VY+qTkuHUm4VLW68
   uvN3ac/UsOEfCgJe/siNGRR/uMeUdFkuufBHWTbD88nAXHPgKjWx2uOMN
   fMN59/aXMm/6m5z10nhl2RLG2Lb0aX1e6fockCqUvTFR/n3hm3CDhINHu
   rMZkvyRn0hSreRbvSvWOdaZxjJa8fd8EDOEWO403s1xiSacn8Jsvxwyk3
   +18R2WbT6U/ZmjfY4ECHPFkyu5W4Wo4uedePf/nYPasuR+uU2NDQPpFKI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="359958749"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="359958749"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 17:27:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="1040308249"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="1040308249"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jun 2023 17:27:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 17:26:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 17:26:59 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 17:26:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiWtqgj0U3JoYEADexKLVBWiaOXoW48PRfRBS7uPjvvCkY+Kj7kmVL7N2DwLgbv2Iie43VjSEFr5MAWbQMMfCBqOHc+eCmTkig7710gHGYc454AgX60UmYGASRMN0hdKJi1dlTGKKgF/Ypj3PlaDDaP1b5ABVrsAP0pN1vFTYBzXSy+bU6cRcwCPBTqcb5Np60iXwvNuZvuYUd0gtSmIjQ4aidYmor7chtItD9bUU1vgBXjl+hz8MxBuTAna3p3D3sMBD4cYGoMaY4Q1cG0SNe6F0liq0aGVSoKlfkgACy81zq1b2oxPMWPxj2fM5W4VJ8TexnGrIdKUq+UmXeQsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUfpSRer0NDhFERkKL/sfBTH0pq7so0DaG+sChmFexw=;
 b=J7TgCphSwhcSuQUoD5Sp9Gc0z5mTsrCD4F9ErEBVntyNUXNWu2uEfACnAjJyVCXK2pSmgOaYRZ145ONTZqU8ovvl6tJXq/TGeS3Xu4VdeM0riw9NwJoENasS9TOYoos0Xd8jh5vlu9O/zAHzMeSUdA/hVj3hm9HnmD8Bf7Q4iddS0wb46ee5bHxii/Kn9PJvPSzbaEYYP7wGPQ/CS0+pAuKogJOBoBu+3oXSBeYAAB3oXG8p9N4JPB9E6Sx6yv/0qoNYEMf6kxzQDzWYeXkD/DZ93M3nvJvInROn3o3t8kn3KxinSFhqAzjnnw6CHlzb/Ykshl0FnYC8hrmcRwoUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Fri, 9 Jun
 2023 00:26:58 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 00:26:56 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@ruivo.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Aristeu Rozanski" <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7CAABk1AIAACA9ggAAMfoCAAALmcIAMM9WAgBL6hQCAAYhoUIAAJNkAgAABgaCAABzvAIAAEayAgAAGoACAAAEqAIAAAWgAgAAOqoCAAK8xgIAAXXWAgAACaACAA83cIA==
Date:   Fri, 9 Jun 2023 00:26:56 +0000
Message-ID: <SJ1PR11MB6083807C3144C28B3E30840DFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230605174104.GBZH4eMLx1cp+nQJH2@fat_crate.local>
 <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
 <20230605215839.GT4090740@cathedrallabs.org>
 <20230606082541.GAZH7thXcj7SatSNtO@fat_crate.local>
 <20230606140011.GU4090740@cathedrallabs.org>
 <20230606140848.GCZH898MYjw6+b2yux@fat_crate.local>
In-Reply-To: <20230606140848.GCZH898MYjw6+b2yux@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA3PR11MB8073:EE_
x-ms-office365-filtering-correlation-id: 28f74857-3b49-42c4-18a2-08db68803b29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: beVBkYdKnBew3+do7pdHUeCW2oRBIEHDbf5DRr/ebPiKzPFBhNzjr0/PFHuBgGmR/yTYpTPUesnGW2FUoLGzIfsptGel+Yjt2Gu+r+pSyh5Br2IpJhCEPzRJo9Fc/FEdcWlwf1VgkTUsHHsVxEeb0Tr7h+1C1/Qv1V21JhK1cXK5kQiyhAKlIhjwYFis8X2qqB1uQUPdtEfeGdQOPe3XtOhuCnJluoFjZ+8hl76GV94Puup+8rXRrXxB3AM6TbJ6fP4IW6LGEJD/Zl1qciwQpqI1+3eGG/p02ZMbbVyJEbma8S8TGTZs1b+ad3D1c7uOeE/pP84tQdHf2lp4leEIXldLVQUzqfapaLFOx7+yzhnqj0zlWRxweCS8XiJmipWbtcLfF4Pi+MkAWntrakmOSacK5hIF8gXg1gZOkr7vMTFi5w9kbf+kz2GHt4f2xjHEryi4dVjJVtTYRfrQKi8vdp9HwTZ5bf+OtPTyk96cdrj7LqQpUM8YwYgH4PSSN1YnX9fEJx7/4nWucoNViX0x5B0nwOY6ZOWesFpO8l1kiiX/uhpY7J2FJ/ddbdj02JyPFI2vkX4mu2bf10x3hzQLiAEXl5x+lbVYYABVr/IDjNc4j5JUBm7EnyMqcL7ez6is
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(478600001)(71200400001)(82960400001)(66946007)(122000001)(76116006)(66476007)(4326008)(64756008)(66556008)(66446008)(110136005)(54906003)(55016003)(8936002)(8676002)(38070700005)(86362001)(33656002)(5660300002)(52536014)(41300700001)(2906002)(316002)(38100700002)(83380400001)(26005)(6506007)(9686003)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUJjdU9pbFBFNlNmRDdGWTNsSlA4QllyMTEweURUZGVnaENOSUF2cDkvMVl4?=
 =?utf-8?B?NjAvME1lOEZndDR0emN1MFlrT3JJbHdsQk54bkRvYU8xQUJOVHYvYUEyNGdU?=
 =?utf-8?B?dTZhb1FyRHFvaDRRMVdUOCs2M0JUSWRUZ0RoS2Z1dkMxdUdCS0N5ME1XK2s3?=
 =?utf-8?B?Z0dDMlQxZFZNQy9XNHVNZlRlNGhieGQwZkVpR0wybTRsdTlXMkxWVTlvVU1P?=
 =?utf-8?B?U3ZMWEVlV3BwcnBEMVlQZEd2RE5MOWdMU1BKRDd3ZGd1ek0wVmdFVXorUFdT?=
 =?utf-8?B?YXdoWTFBejdwbmpTNGRObjMyL1hjSXp5R3JQN20yNjd1MklJTFV6MXlCdWsx?=
 =?utf-8?B?c0FTcmtCdWZrZytYMGM5OGo0ck9xYjdYTU9XQmNqajVhL3hNTFZob2V5a0I3?=
 =?utf-8?B?OHIxbElsVzd0Q09RaGxhSVdnZHB3Z2NUYmwrRThUNVM1amg1aTdCRFBXajFa?=
 =?utf-8?B?Vjh0QTNqRVNKeDlsWms1aVA5dXhyaGpPT3dUYlFxQkpwLzBzY1g0emlZdGRn?=
 =?utf-8?B?WlJjNXZPamZrcUdhc21RcVRkTjh3YzNIUDhGVzlYYUFYN3h5a1YzN2QzTnhM?=
 =?utf-8?B?ZE1MU2NHL3pGUWtxZVV5SCtTUUx2d1dFTjhRdnFxZ3p1cVErRzdvK1Bkek96?=
 =?utf-8?B?K2xlNzZYUkxFZkdLNmhnRzlpaldGZ0g2amdza2cycGx6dkhXQzVYUFFyWW4y?=
 =?utf-8?B?a0s4SnNBUDdhSFl5bVRHcmxSWkExa2dObk1kTUc3emFxNDlhUjNKZmFOdWZn?=
 =?utf-8?B?LytTeE9zUzh5U2J2RGxrMzFEcG5VZWxIeHEybnArMHF3TXRuMmpXVmdVMm5Q?=
 =?utf-8?B?TnJ1d29RbUtrL2xtRjNUZnFPeFVRWFdUbU11M1dMUGtZMlZaKzZsZU5oOEpu?=
 =?utf-8?B?WFpDTm1henNWL3RsQm1CUlNqY05tbkNpbjBTZUpLdGVYMzhDUUR4WWs0MEJU?=
 =?utf-8?B?Q1h4a04rRHRnUy9GdThuMzczeTRFY2N2YWREYTVYc09DYmtqZzd6VXlmdDk2?=
 =?utf-8?B?ZU9Qb1RNUU5oSmk0UERxemVVOWM5TmUwQlhteml1akhoV1lTVGEwb2FnWmgv?=
 =?utf-8?B?L1ZnNEFDZVczMnhyNlJadzB2b1FWN1g5ZnZtN2dScndSS2JtOURaTGk2ZDVa?=
 =?utf-8?B?Ym9NN3BTbVdJeWJzNGdsSDdYNEQ1WDZPR1pDUnB2VkpJalMyWXoydTBQMDR1?=
 =?utf-8?B?bjVBSHhWeUJvM1R3QVZiQk1qeWQraFpwN1VnekdjSTJXRGFCNWxoeHRYM2c0?=
 =?utf-8?B?Qk1kU21XdjR5dmFjVlpjUlVoRmdhUVFpcFZXRVRXT3hQaXBmSWRXT25ldHhz?=
 =?utf-8?B?Y2JyZi9YcXJYcFpBNFo3NDc5Wis3MXlFcHF6dnFTM2k0TE11T2gvRzRTMWQz?=
 =?utf-8?B?NituSHJRdHp4NXRiTGlnRWNvd3BwQStmOVZ3eERyZTlZZEVrRjJFSGN4bWRh?=
 =?utf-8?B?SGhLdDg5RXJvVmo1SWdpN0FNUkwvVEVYWFJLekkzcUFRa2V1QzYwQWNleUZH?=
 =?utf-8?B?VTlwWkRKNVRrL296MGFYSVE1bVhyMWxFZEdyd1ZISUJyeW4wNXNycms0Vzcr?=
 =?utf-8?B?cnNGRUdVNEFtSzZ5V2h1bWsvbGhOWVJrK2tuVFBYWDhyd3I4L0kxaVp2bjgv?=
 =?utf-8?B?U2FoZWs3OXNVN2tzY0Z0aldjM3FCLy9VYnJyMmM3OVJPUERGVmw3VEp2RVVW?=
 =?utf-8?B?d3NCN1JxWlNxTnNJZUFzQm5MeFBnYkxVaTM5ZW96cUI2ZmNxSVhUL0syaFNJ?=
 =?utf-8?B?Ty9GT0JWR3E2TXE1Y2Nnb2FoeEkzQVdleUlDWnlRRVhjS2NkOVdENzRUMS8w?=
 =?utf-8?B?ZzcyNTZmTktNMjdzb1h0TXJFU3BmNzdvY25pUlplWHVOdnZtTi9JWXVVRW9l?=
 =?utf-8?B?RzJsLy9GNWV5eEJoVUx0dGNkbit4M3JjeGp4bmRUWk5tU3hjcFVnaDJwY2k1?=
 =?utf-8?B?azFiQkplRnZwQVFKOEdxM3o0K2NoMGRwdkx0djdXNkRqbFhreHhrWVBRQ3RD?=
 =?utf-8?B?eC92cWxnVGlZWGcvTUdHQUk1dWdaekFrMDRHWG4xa3hMcjVHUkNWbFA3Rmt5?=
 =?utf-8?B?dmZ5UmYrbURyMXRTd3RkNm9mR0czQkNQNTE5YW90OGpDdG9pS28xenJCMk5Q?=
 =?utf-8?Q?xUg0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f74857-3b49-42c4-18a2-08db68803b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 00:26:56.0260
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mREThSLdP24kYY6n5I0mYQ3EQvu0nJDrR5N3izwxEoU/qk60qiqBAfbXA1G1+cdaAps/d80H+6K+WNK80FBQgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBJbmRlcGVuZGVudCBvZiB0aGF0LCB5ZXMsIHdlIHdpbGwgdHJ5IG5vdCB0byBwb2xsdXRlIGl0
IHdpdGggZHVwbGljYXRlcw0KPiBvbmNlIHdlIGtub3cgd2hhdCB0aGUgaXNzdWUgZXhhY3RseSBp
cyB3aGljaCBtYWtlcyBwZW9wbGUgZGlzYWJsZSBDTUNJLg0KDQpJIHRhbGtlZCB0byB0aGUgdmVu
ZG9yIHRvZGF5LiBUaGV5IGhhdmUgY3VzdG9tZXJzIHdobyB3YW50IHRoZSBPUyB0byBzZWUNCmFs
bCByZXBvcnRlZCBjb3JyZWN0ZWQgZXJyb3JzLCBidXQgdGhleSBhbHNvIG5lZWQgdG8gaGF2ZSB0
aGVpciBmaXJtd2FyZSBrZWVwDQpsb2dzIG9mIGFsbCB1bmNvcnJlY3RlZCBlcnJvcnMgKHNvIHRo
ZWlyIGZpZWxkIGVuZ2luZWVycyBjYW4gcmVwbGFjZSB0aGUgRElNTXMNCnRoYXQgYXJlIHRocm93
aW5nIHRoZSBVQyBlcnJvcnMpLg0KDQpJbnRlbCBtYWNoaW5lIGNoZWNrIGFyY2hpdGVjdHVyZSBo
YXMgY29uZmxhdGVkIHByb2Nlc3Npbmcgb2YgY29ycmVjdGVkIGVycm9ycw0KYW5kICJVQ05BIiAo
dGhlIGxvZyB0aGF0IGNvbWVzIGZyb20gdGhlIG1lbW9yeSBjb250cm9sbGVyIHdoZW4gRUNDIHNh
eXMNCnRoZSBlcnJvciBpcyB1bmNvcnJlY3RlZCAuLi4gdGhpcyBpcyBkaXN0aW5jdCBmcm9tIHRo
ZSBsb2cgdGhhdCBjb21lcyBmcm9tIHRoZSBjb3JlDQp3aGVuIHRoZSBwb2lzb24gZGF0YSBpcyBj
b25zdW1lZCBhbmQgc2lnbmFscyBhIG1hY2hpbmUgY2hlY2spLg0KDQpTbyB0aGUgY2xvc2VzdCB0
aGV5IGNhbiBnZXQgdG8gbWVldGluZyBib3RoIHRoZSBjdXN0b21lciByZXF1aXJlbWVudCBhbmQN
CnRoZWlyIHNlcnZpY2UgcmVxdWlyZW1lbnQgaXMgdG8gaGF2ZSB0aGVpciBCSU9TIGNvbmZpZ3Vy
ZSB0byBnZXQgYW4gU01JIGZvcg0KdGhlIFVDTkEgKmFuZCogdGVsbCB0aGUgdXNlcnMgdG8gcnVu
IGluIG1jZT1ub19jbWNpIG1vZGUuIElmIExpbnV4IGVuYWJsZXMNCkNNQ0ksIHRoZW4gdGhlIGgv
dyB3aWxsIGFsc28gZ2VuZXJhdGUgYW4gU01JIGZvciBldmVyeSBjb3JyZWN0ZWQgZXJyb3IuIE5l
aXRoZXINCnRoZSBjdXN0b21lciwgbm9yIHRoZSB2ZW5kb3Igd2FudHMgdGhhdCBvdmVyaGVhZC4N
Cg0KQm90dG9tIGxpbmU6IFRoaXMgaXMgYSBsZWdpdGltYXRlLCBwcm9kdWN0aW9uLCB1c2UgY2Fz
ZS4NCg0KLVRvbnkNCg==
