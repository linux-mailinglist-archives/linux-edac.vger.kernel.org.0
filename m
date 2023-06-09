Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9701729E40
	for <lists+linux-edac@lfdr.de>; Fri,  9 Jun 2023 17:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241133AbjFIPYH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Jun 2023 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjFIPYG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Jun 2023 11:24:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7557030F7
        for <linux-edac@vger.kernel.org>; Fri,  9 Jun 2023 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686324245; x=1717860245;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dSn7NH1KoiNC+E846DjzBxQO+eF7vpVE8p0wl2OBbyM=;
  b=WMW9vTTiPJ0sVOpq0/30CG2L+zdBjRB4caHbMx9QX1DrpGAvEF5xl01R
   FMw5pCp6R864s0NHTSfDrFGLDIc56+yhfNDG8Fu3hAVIfISzkOnTYPMim
   JWithHsW+iiT2rjtJaT/rhTWRuPky0tl4EuwyvTlEXzie6AGxQ6U8QCgS
   IVkgHr8i0LDZgwhWoVGZXiwDvgYY1WoXHJBDbiIqcIugkja1grVtoo6iy
   eomOY9w/dYDW1P+mr8zC7h+L37gUWeieq5s7hqVk3oNQYVON/W390AQzi
   LruTKaavyOns1cyZv9nQzdIC4xpj0T/h+cfgyfUMBGPHneNAyALRr+60m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="357622925"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="357622925"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="687773487"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="687773487"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2023 08:24:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 08:24:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 08:24:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 08:24:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMQygfXgUgG3+M8v1D4fNn+vmhh0vvWXHyYJPtwfC/JJvQXjtAKjYFwiXSTK9NteMR4TOFyJGyYeVsz4OurSs41wNuU2/zOMAqqiEy5Ja3XeGe0Kjnz9k74FpXeY0rgbChjqaFoXM1yPdLyWfp8ZD9JohMeSRWKMVm/Ov/TLR1QfQVUI8sleT8dpyNIj7gUsKUO80S72iZ3w+F/N4yunWrizr7MQS8lW2vU4ex+O24wHrBycEFXjCz1hjN1qWP/gnoduhY2NP5Qqom8UX8cmLADR7QK7KYCcHkz1F4lqgz4b403pi06tXjB7WXpjZZWp3k88YKlg71SIO8j2L12Y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSn7NH1KoiNC+E846DjzBxQO+eF7vpVE8p0wl2OBbyM=;
 b=OZvJMZ4fmS5qXLjggIEMj3BXte90/IxgN9ljAvOB/r0jK9EieT2jl7Ely+pmDtbhU2Go+tfDMoQyG6b7S59isv4cT/STovT6BcumdkE2CmRzmaND7kj2mlUD98tqy2eJONgox6MA1nxqVv5WcOOhC69pJ4IMzmsaLL6A8eyeRUCApV7/OXB6AxcyFCrovqNVH5cN1q4t5V2omDivPtS0SEl+5AfWVlwbrtLCTtVoxebIEdeSXX3RahqIfDPcuYeeJb8v48zELSZfrUGJQpKhKGE6twmr0VK6jA9kgSqKAWK1XwUKlzZaIkG0oJuQFDoA8fh1Md7EdlaiBrfztyOPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB7254.namprd11.prod.outlook.com (2603:10b6:8:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 15:24:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 15:24:02 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7CAABk1AIAACA9ggAAMfoCAAALmcIAMM9WAgBL6hQCAAYhoUIAAJNkAgAABgaCAABzvAIAAEayAgAAGoACAAAEqAIAAAWgAgAAOqoCAAK8xgIAAXXWAgAACaACAA83cIIAAqKOAgABO4ICAAAMx0A==
Date:   Fri, 9 Jun 2023 15:24:02 +0000
Message-ID: <SJ1PR11MB60831A82C6BACEBCCC50E397FC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
 <20230605215839.GT4090740@cathedrallabs.org>
 <20230606082541.GAZH7thXcj7SatSNtO@fat_crate.local>
 <20230606140011.GU4090740@cathedrallabs.org>
 <20230606140848.GCZH898MYjw6+b2yux@fat_crate.local>
 <SJ1PR11MB6083807C3144C28B3E30840DFC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230609101757.GAZIL8VaLwAckejYZt@fat_crate.local>
 <f84cc078-6cd9-f011-3c9b-8ade98c814f3@amd.com>
In-Reply-To: <f84cc078-6cd9-f011-3c9b-8ade98c814f3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB7254:EE_
x-ms-office365-filtering-correlation-id: 677605bb-a0b3-4190-0f9e-08db68fd8e1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UWrpJMm66OWgJywDn9bk+r8tJYUhmhITt3Po2i0jF7XwQXgRcZ3+9cgF/vDtYh4YTwnWxQtDDU1/tMlOLx1YKlUO/hgTvub4Sdx/2BltTLA7b3NvMpuuTWmyFG5c4vBF5mWj/dWo+dgQPcnqsZkyQE+tK+LvGuwJNJyxwspKov+q3/g1rQ39XtgWQPYSjSBPd5Q1rB8IhaR4X+ZczgfSWmICc9J1ZyFUon60g1bH/O9sCMUxll/mu3SOnQog4ADht6FSi8Cq0m3OKVOD7mHC/Fsw1q0Jz0g4URHhAbABPUVyCWSUuA9gJjJB6sukTsi7XE9jOWkELIllZ6mAaJro9yGiWBINVWFHClOZt3A8slnoLS9tcD7t1EDyfwdcdzqqeYRhmSuCVBG2jxviQbSOX7bSUFw9AlnkNnD/EcvqHm7pn4bhM8r9WgVEsu2ZdlniQQ6wB6zSk5YuZu6PbzGwrkh/wg57LnPrMRucKRLXXCNtKKXFlSMYfgzqD3ns34wwTb88gM3SJmzmARWcgUS9Fj2nSXapWCsY/+jB4VG6keve3kp3aqEu4Os0QKfvlTC7gkjxnoCtjOxxIE7pMcqUKtCFEFElff3jERqV7NZoWFZK7WxSF4oUrCfq2kmw6TaI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199021)(83380400001)(54906003)(82960400001)(33656002)(478600001)(55016003)(8936002)(41300700001)(8676002)(38070700005)(66476007)(76116006)(316002)(64756008)(66946007)(66446008)(66556008)(52536014)(122000001)(4326008)(86362001)(5660300002)(38100700002)(110136005)(7696005)(71200400001)(2906002)(6506007)(26005)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1hLZjRvZkpuWVNGODYxZnN4OFNVVlZudjIvRlhGVkhYV0I2cnBMUm9OaTEr?=
 =?utf-8?B?T2FCbko4R1dDK1FNKzYvRmJNS1ZVSmdVdjA1bWNkeUJBeDVYUGhOMGhOK0lG?=
 =?utf-8?B?b21pa08yYVJPYWVZRjVFblo5WG0xWDRXU3cwbnc3Y2dEWUhtdFdaQVNKdzM3?=
 =?utf-8?B?dTI2cGRQcHkwVzZXbk5raWdnMVJqWHVRRUFiZkw1TGNsMjlXYTQyNTFhbHlH?=
 =?utf-8?B?bFVVYUowa0sycE5XaE9oUmZkazdLTUlDL2RwY2RVQXIxZUJHM2VueHAxRlRt?=
 =?utf-8?B?ME5jZUJBTkxHQ3BSelZZeUpEUHN5V3FNdW14R2pVZ0szNHljZGRweDh0Ylc4?=
 =?utf-8?B?TDRlWll1UHhSSmF4eEYza3hzN2w5WjhTTWR4L2JET29MNldaLzFiL1NuSVJ5?=
 =?utf-8?B?Y2dXVFc1UGVSN2M1N0VpZDRWaHVoWkpIa0dzUHhheEl0bnBpc28xREZ2YmdH?=
 =?utf-8?B?Rkhta0hiZnVCK2lscnovcFVBeWpwc2JOMm5OS0dqU0FaSFo4WStnNyt2ZG5a?=
 =?utf-8?B?OHlvaVFJc2lhR0VrNW01OVNhYXhqVWZYQjZLRFUwU0JKaWYwSE9waTZMWnJk?=
 =?utf-8?B?S1hFUXdXR3hoenJ1cTNZRHdLWDc3dFhzalRFdVMrNmVrMnN1V044NlpRNVJP?=
 =?utf-8?B?NTg1c1d6azUrNWJrWXpQK0pLVkl4d1l3YnY0YkpkMWdQOUxrYnY0UWRGd3J4?=
 =?utf-8?B?MGk4T1JiMFNBcVdSZzRsTXpPSDE3dnlPQW4zS2c4RXRhZUcvUVF2YzEzWWpt?=
 =?utf-8?B?Um9KT1VxWlc1bE5VTVNEdXpMZ0J1QXZkaDR6U3pLTTllQUM2VG9iTWI1d0ZY?=
 =?utf-8?B?Uldkc1VaVkI1M3g1ZGhsemZXY3EybmxicVJTVmFjeXVZODRnbytmcitlSHFF?=
 =?utf-8?B?bmJ2L0VvRlZ4MzZ0SjU4cUJiV0FGcmxOU2Y1YnBRY1FmVHQvUEw2UWFHY1Rl?=
 =?utf-8?B?TlU5SVBXMHlWdnJuR3lUd0RaMXlEQ0NtWmNmci9nY0VTU3VqZFRSL2pWbklX?=
 =?utf-8?B?cFBpc25vQmc5eXg1TUJqMmMyRWEveHhia0xpbEVDaXZpbmFaa1IzbFZ3U0l3?=
 =?utf-8?B?aURNdHBiVlROTjlJbGhDaDJRbFZnQ1ZNaHZILzBlM3RFWkNqYkg3Mk9xZTBa?=
 =?utf-8?B?aTlINnVYRlYyak80RjFIZ1BEYU1mbXFVNmVkNGZSN3lJRkNBYmJMc2xjL0xh?=
 =?utf-8?B?eUZuRFVqemtqVWY3V1lodk5KczI0bTNvc1czaU1BL2s1MUVhSUlGMUZhVTdH?=
 =?utf-8?B?VEtKWTFxWlFVamJLd2lacktXNjY2WmNLenBEVHcrdmxoeFZmQVZTYUhyd2ZD?=
 =?utf-8?B?YXhOUUF3c253cjBLM3VuQ3M1bEd2UE1sZExreUZsRFJEL0pjS0FkSXFjZnVM?=
 =?utf-8?B?dzBkNC85TGdJWXF3ZkVNUC9OQUJIa25oWEhuUDY4alJNVjJOdlhLeityL0or?=
 =?utf-8?B?elJMWFRjZkg5RjBJbFJTUlQxdEY0K0lUSUNSc05jOFh4Q2J2ZFVzdnI5RkNQ?=
 =?utf-8?B?OEdvUkI1aE42MzA5QkYybG5NYjZVR3JDd3BRbnlCd0pxYW9rRm9jRm4zQUQ2?=
 =?utf-8?B?dG9RTThKeW1iaWVqN1FlTnVUM0FzakFBZzVsR2szZUFXb3FHalVWVTB6dXJI?=
 =?utf-8?B?QTBCWUk0bjAyeDlNWDhZWW5nNkUvZGRXc0ZBS25DbmlIRXdSNzZ5TndpWlFp?=
 =?utf-8?B?VXZVTEFRQUdDMEozclRGZGdOM1UwRFVjQk8wWG5NODB1cVNlVUpEb2RaZmZa?=
 =?utf-8?B?YnJvNGs2bWJmdkorc2R2YUJxeDAvZjZpeXZ3ZWVNQ213TzBRZlRQMGoxaDJX?=
 =?utf-8?B?akFXdmM5TXFwMkV3bXNEaGZEUk9tYTA2a1RKTk9wM25ZRXlGYnQ1eTFlYkFH?=
 =?utf-8?B?dWxuM0xuMVdaR0tEMUN6aSswdWhFTG45REhGOW5IaXJjeUpUYUhqYkVNcEJV?=
 =?utf-8?B?UTA1eVRLRTl0RklMZkdSNkZxZTNWMVBBZVZGcWN3VXhGbzNObExDVzBrcjlO?=
 =?utf-8?B?VVlTWHdEVEQ5QTFKa25Wdk9vOE54TE5hOUFCT1B0NU4yZVhDeTNVZG80R1Jz?=
 =?utf-8?B?R1lmMXlHUFQyVUJjTC80SDF1bFBXTzFaSkN2YzRRWG5ldEloc2gxVUpCcyty?=
 =?utf-8?Q?/aZw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677605bb-a0b3-4190-0f9e-08db68fd8e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 15:24:02.3151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J85Z+IMTMXv4tiSJ/IT9qfNyTp0FHn8uGhsGC7YgbeenFj7NO0pmxItCylxaqc+rqv4URaALrN705mUtb0P2og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7254
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBTbyAiVUNOQSIgaXMgbGlrZSB0aGUgQU1EICJEZWZlcnJlZCIgc2V2ZXJpdHkgaXQgc2VlbXMu
IEhvdyBpcyB0aGlzDQo+IGRpZmZlcmVudCBmcm9tICJBY3Rpb24gT3B0aW9uYWwiPyBJJ3ZlIGJl
ZW4gZXF1YXRpbmcgREZSIGFuZCBBTy4NCg0KQ2F0ZWdvcmllcyBvZiB1bmNvcnJlY3RlZCBlcnJv
cnMgbWVtb3J5IGVycm9ycyBvbiBJbnRlbA0KDQoxKSAiVUNOQSIgLi4uIHRoZXNlIGFyZSBsb2dn
ZWQgYnkgbWVtb3J5IGNvbnRyb2xsZXJzIHdoZW4gRUNDIHNheXMgdGhhdCBhIG1lbW9yeSByZWFk
IGNhbm5vdA0Kc3VwcGx5IGNvcnJlY3QgZGF0YS4gSWYgQ01DSSBpcyBlbmFibGVkLCBzaWduYWxl
ZCB3aXRoIENNQ0kuIE5vdGUgdGhhdCB0aGVzZSB3aWxsIG9jY3VyIG9uIHByZWZldGNoDQpvciBz
cGVjdWxhdGl2ZSByZWFkcyBhcyB3ZWxsIGFzICJyZWd1bGFyIiByZWFkcy4gVGhlIGRhdGEgbWln
aHQgbmV2ZXIgYmUgY29uc3VtZWQuDQoNCjIpICJTUkFPIi4gVGhpcyBpcyBub3cgbGVnYWN5LiBQ
cmUtSWNlbGFrZSBzeXN0ZW1zIGxvZyB0aGVzZSBmb3IgdW5jb3JyZWN0ZWQgZXJyb3JzIGZvdW5k
IGJ5DQp0aGUgcGF0cm9sIHNjcnViYmVyLCBhbmQgZm9yIGV2aWN0aW9ucyBvZiBwb2lzb24gZnJv
bSBMMyBjYWNoZSAoaWYgdGhhdCBwb2lzb24gd2FzIGR1ZSB0byBhbiBFQ0MNCmZhaWx1cmUgaW4g
dGhlIGNhY2hlIGl0c2VsZiwgbm90IGZvciBwb2lzb24gY3JlYXRlZCBlbHNld2hlcmUgYW5kIGN1
cnJlbnRseSByZXNpZGVudCBpbiB0aGUgY2FjaGUpLg0KU2lnbmFsZWQgd2l0aCBhIGJyb2FkY2Fz
dCBtYWNoaW5lIGNoZWNrLiBJY2VsYWtlIGFuZCBuZXdlciBzeXN0ZW1zIHVzZSBVQ05BIGZvciB0
aGVzZS4NCg0KMykgIlNSQVIiLiBBdHRlbXB0IHRvIGNvbnN1bWUgcG9pc29uIChlaXRoZXIgZGF0
YSByZWFkIG9yIGluc3RydWN0aW9uIGZldGNoKS4gU2lnbmFsZWQgd2l0aA0KbWFjaGluZSBjaGVj
ay4gUHJlLVNreWxha2UgdGhpcyB3YXMgYnJvYWRjYXN0LiBTa3lsYWtlIGFuZCBuZXdlciBoYXZl
IGFuIG9wdC1pbiBtZWNoYW5pc20NCnRvIHJlcXVlc3QgI01DIGRlbGl2ZXJ5IHRvIGp1c3QgdGhl
IGxvZ2ljYWwgQ1BVIHRyeWluZyB0byBjb25zdW1lIChMaW51eCBhbHdheXMgb3B0cy1pbikuDQoN
Cg0KVUNOQSA9IFVuY29ycmVjdGVkIE5vIEFjdGlvbiByZXF1aXJlZC4gQnV0IExpbnV4IGRvZXMg
dGFrZSBhY3Rpb24gdG8gdHJ5IHRvIG9mZmxpbmUgdGhlIHBhZ2UuDQoNClNSQU8gPSBTb2Z0d2Fy
ZSBSZWNvdmVyYWJsZSBBY3Rpb24gT3B0aW9uYWwuIEFzIHdpdGggVUNOQSBMaW51eCB0cmllcyB0
byBvZmZsaW5lIHRoZSBwYWdlLg0KDQpTUkFSID0gU29mdHdhcmUgUmVjb3ZlcmFibGUgQWN0aW9u
IFJlcXVpcmVkLiBMaW51eCB3aWxsIHJlcGxhY2UgYSBjbGVhbiBwYWdlIHdpdGggYSBuZXcgY29w
eQ0KaWYgaXQgY2FuICh0aGluayByZWFkLW9ubHkgdGV4dCBwYWdlcyBtYXBwZWQgZnJvbSBFTEYg
ZXhlY3V0YWJsZSkuIElmIG5vdCBpdCBzZW5kcyBTSUdCVVMgdG8gdGhlDQphcHBsaWNhdGlvbi4g
U29tZSBTUkFSIGluIHRoZSBrZXJuZWwgYXJlIHJlY292ZXJhYmxlIC4uLiBzZWUgdGhlIGNvcHlf
bWMqKCkgZnVuY3Rpb25zLg0KDQotVG9ueQ0K
