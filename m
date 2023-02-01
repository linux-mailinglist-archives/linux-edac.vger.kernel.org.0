Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDD5685D68
	for <lists+linux-edac@lfdr.de>; Wed,  1 Feb 2023 03:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjBACjG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 31 Jan 2023 21:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBACjF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 31 Jan 2023 21:39:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015163D920;
        Tue, 31 Jan 2023 18:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675219144; x=1706755144;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4o0Mh7+GNtJ5zJOlsW+K9j+iiVBXMNxRuLeOqQRX4wM=;
  b=HUzr1sOgD7p8LflUWsiBxad2fmnxRkmTmDhfettLF0bo/FI0QvfXjDp3
   gGUL2lpfiw58BwmPPtmCSd4yvvIRGi/IE+sxN3l9MgUUwwdqGCuhiQFwG
   Qn1inpE7Mo7cKMBoCb2922GnKCMxQCTqs71+r/fft789My2bBH92NbQ8X
   OuRNfEATC1sC0VVO4mXhhPTon7U5iLt1Ia5Ko9iUoQv5z1hoi85RtC7QM
   SSF3rYCiWL7ndaI1FkwJFctl6EQUhQoNWDRUV0XY+BvNtQNcS9Ta2+IgP
   x/0j1uvVZzpZSOpa9m9WZovV5kM+MCYc5sVsr9+4maxqULdCjBA9hiRiz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="392574648"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="392574648"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:39:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="788669274"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="788669274"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2023 18:39:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 18:39:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 18:39:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 18:39:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFdkmem6lsi6LfCxzRO3jd1BUOgk6krso65tt2e/X3edA0Kt4xBFw3aVsyOAHQZJNsYzmd33v3Ml1H721ZQJTc9abqka8bdFB8SCjHz+fkt3EIgo7TzpOEb9tup7/LbIjwN1KHgHSbTAUmj3bfPVntRY8H6qVjxlTPOchVCcCr4T+9T1KYlIi5FKFlyTlND9zUlbr2gcaGmbLGVX5bSxigkvjIpGYviR6TC/8i/k/ROb4S5/qHlcCVh1Nyr8msqDrXOOgajxXEQedthBzRbpsJtCU1RKzarhQoGBYqg/TWToxAro64JlB1baP440Ts8XZRuGh6FrNSvrwGIfgvsVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBmUrDbiwbNQBXzkdwWqQ+8Vc7XbV17cZbrZI0dgm8Q=;
 b=dW1S19iFGDqr2LynDwUCUGrayHwENmj8XMlfolN4yCjVDMxD71BguVno4obHhcfxFEFyfbvTR4jsUqGHX+00E2A8mesS02xkP2zX5n3B/OQ3A6pmgrfmlrXHunULm2Wd7f5o7hP0si45/Swm5Sb8IMz+uIVZ9iz89Fg7XIMC3YF7uvq/map9SdykzKC2LKEIW3/oOok1RnvVDfi6NPmfaKmtabpT1OZmPhcE8GONyKjx7n1d/Iaf8UsdkPrzOUhky+5lNFdppOLrjbkjhwY+temjISQN/xpMwaZIeGLeGLNC6wWg8AyCZ4hCAPMcTY/gws5qTIrYufEpCPM/kmjlAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3728.namprd11.prod.outlook.com (2603:10b6:208:f4::21)
 by MW4PR11MB7056.namprd11.prod.outlook.com (2603:10b6:303:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 02:38:57 +0000
Received: from MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::6ec4:b0ed:5f86:d39f]) by MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::6ec4:b0ed:5f86:d39f%4]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 02:38:56 +0000
Message-ID: <23268661-1501-beb3-726e-9e936bd8f53e@intel.com>
Date:   Wed, 1 Feb 2023 10:47:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] x86/mce: Set PG_hwpoison page flag to avoid the capture
 kernel panic
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Song, Youquan" <youquan.song@intel.com>
References: <20230127015030.30074-1-tony.luck@intel.com>
 <20230130023226.GA3955454@hori.linux.bs1.fc.nec.co.jp>
 <SJ1PR11MB6083B06E5B75E429E5143B76FCD39@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230131045011.GB3997492@hori.linux.bs1.fc.nec.co.jp>
Content-Language: en-US
From:   Zhiquan Li <zhiquan1.li@intel.com>
In-Reply-To: <20230131045011.GB3997492@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::15) To MN2PR11MB3728.namprd11.prod.outlook.com
 (2603:10b6:208:f4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3728:EE_|MW4PR11MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e4269c-2293-4c9f-4f7e-08db03fd7727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yBrh46LNngLoX0nKp4W4F8mbJvQd0bbJ0v1j7JQco5RHhdr3vhSriuMehIeodjsrhmn7Vu8yLzFfJwtLZE7+xmnxQe56E11DnxGQ+RMb2yMJzJhumSK/Mc/vvb/uU0rQ2en8iCewuAIdw7eVjKzx69bDvWFrU00Iykko08JLkMxlvw9qJYjlT2YvmcezLzuZhfCbgtfd4YoQlLEKJF2Hy1RnIzpQkHeOciIMPdvSC+HXb5nMLiCo1cTGy3Xi2jgjSqAuKEXmGXqHyDa8qwTBzVfKxF/Bp0iANJIEe2rE9kavv/WJXYiOyFuVjdBdt0FijDYzGln5b9m6aFfHl8J9YdvlCNiVK70sI846sUbK2sNU8O4m7hKoJJ2P7zDrceehmXD5wkdhcDVtnrhtmxj7XB8oU4HAlCDl8Hr0N8omDjC5FC1esqUIPN/MNr1XZDpIqKUm/W+EwE+6Hm9CEnOuc1AK3+9e1raOFP8UyNi+STh0s319eDaT4plXzumSZvTkRcQ+eCXmZ55AlVzfRGm+GB526oPhZEmLek5f3S4XObk/jrdQEuAs/4Ot/FEac6/gKH0hazv1WETGqSBm6RCZ17mGC2AA/QqF+9mEs06ZHKuaP4C8q/5kz5TqWpJCJIzyu3t8EzWolUho4fTnbw3EaUEwfimk0W/js52Rh8lbI7N8aV5fdeDoG+8ZpgC+EcMNMreVQeiz3swhwtJnrm3O0Un8nrm07ERG0n2ELO5Upq0OvLsMinRDybcWDq0uMV24omIkUE34VVEQ3atN2M0A16v44q046gwZKgl3Bkhl2plnjdR4J783wZhWh2OMLEy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3728.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199018)(41300700001)(6512007)(38100700002)(8936002)(26005)(66556008)(83380400001)(5660300002)(86362001)(6486002)(966005)(54906003)(6636002)(82960400001)(31696002)(66946007)(36756003)(66476007)(4326008)(316002)(478600001)(8676002)(110136005)(186003)(2616005)(6666004)(107886003)(53546011)(6506007)(66899018)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTlVVExsb2g3anFKU0p5Vis2TmNnc3VGMllnZGl2aXV2cEZZWGw2djBWanlB?=
 =?utf-8?B?NXF5QVcvS2E2L1NoVjZ3TGh4NzB3M1VUSlVvb056R09Zd0NFUE5GQXd3Yzh4?=
 =?utf-8?B?cFhqNnR0SmFuM2l0dVpveG83Y1RsemhVUTZsdXpsb1hkaE1DR2JiZVVoNDhO?=
 =?utf-8?B?N29PT09OVjRwbDdDQXNNTk9JUFZ5ZWtIYlpaRS80ZWRnOUsreXlCVU43NkM4?=
 =?utf-8?B?WDVQeDRJUnlHRzdRdEkramFsVzNBaWZ1bUZab0xSYUhMa092L1c2amhtVUJT?=
 =?utf-8?B?TlJPeThqRzhtMFhDYzVJaG9DanRrM1Q4Y2xyTnJnREg0cXpwZVJHd1J2YVk4?=
 =?utf-8?B?NWd3a1RhRENnZ096KzVCUWF0K0NPY3FNc1lNbUl6YzQyZlFlNzZxVGIrRDhO?=
 =?utf-8?B?U3g3RUhFRnRSREk4RGNPVC9JME1jc0hMZ3MyUmRLL2NNUGY3aGhRQkxpSm1Z?=
 =?utf-8?B?VFNQbjZVZnRJTWwzcSs4ajVLSjh0N3kvby94b1RCZk4zMnlQWnI1ZDVUZTFK?=
 =?utf-8?B?c09hNFU5Sys3dkdpVXVBNkhmT0VmeC8wdkV0akpnS3M5QldZaG4zOHhkNWdY?=
 =?utf-8?B?R1V3b1Q4M1FLQ0dvMDZHWjRzNC81c3I0YjBnY2IzVUt4bWJlL0trNkJWbFFP?=
 =?utf-8?B?RlZzTlhCUUNjU1Q2TlUycWhnZDZJVXNob3RwVEFoc25rWGVhRHgvWnY0UDlh?=
 =?utf-8?B?MFRhbmpsb0VLK296SVlkaTNvZmZYVWc3aGNKdjBISktwVWxTZ1ZaS2N3UFVj?=
 =?utf-8?B?bHlBUmZzYVRpaWVhWisvWkJkQm9WbHFrdXhFblRua094ZnBLTytnanltaldN?=
 =?utf-8?B?MEZJWVNvcEJIOWV3dVhZV205V1l6MU85U21GcFVBQlJmOVlXK0JHTkd4M2Nz?=
 =?utf-8?B?R0xFOGRoVzZrVWkxUmo5bHYwazRPaVc5d0QzRTlJZ205M0NFREYwdVBvMmht?=
 =?utf-8?B?TGpPcFFKSURHbHdRcnBqaVRrZ1Q3REw2dFM3MEF2UWs1SUFLc2xaU1pQVFYx?=
 =?utf-8?B?WDJSNVJHTUlkaXpKZTIzOTFuclkzYUxyenNlRUZCYzgreVM1M3RJS3ROV2FN?=
 =?utf-8?B?SDN3UXF2OU1jYWZraDNQM1NhazM0ZnNMR3poMktnRktmRTk3Y1lSNDlpVjNO?=
 =?utf-8?B?clp4V0VUTlkwVW5abk9aNnlIQmdxWlZIR2pwOFU0bVE2Z2c5RmJLMkZNdjdo?=
 =?utf-8?B?SUNub1UzUldIS25JQmlJdmFrVk91YzdGOEVLMHBEUEt2a0pocm5GOVBHQVNC?=
 =?utf-8?B?NzlhT2hLMnorZlhscWx3NFNWN1kyZmxYaVdrVllkRitNZVVnRkpibHRxM3VD?=
 =?utf-8?B?ekM1UHNRNkZOZVY5VGl5SmxGcmdBMiszY1RTTmZGL0pIcnRQaVROb2gwdUpZ?=
 =?utf-8?B?QzhVUWoxSlorU09BNWtTTmVvbjl5M1NUZElVMlFVYmxNWjJicFJoY0p3bTJT?=
 =?utf-8?B?REFmWTJPeDc3TlJ3akJhZFhUNVdJdDE3cm5oQ1dKU0NkWHc4ZDIyZGR5QkVE?=
 =?utf-8?B?ZE4xcHRsM3BvN3BoencrNFpLM1Fod1N6ekVuWXZBaHdlNEIySVF0RE12cDBO?=
 =?utf-8?B?eWdYNkQvdEx5VWo0NkxHSkdVRVM3cU5IeGRLc2lkQVhCc0I3emJnNTJQTE50?=
 =?utf-8?B?cWFpVmdtTlQ4aCtNUWJRWlJCS0lEOEpJUHJKTmFRcUV2WmdMdGJSbFU0cDZD?=
 =?utf-8?B?ZTdRSkN1MHN1TGxMMGZzcTlvMytwS2dBVENZdjZwWUhaeUwwZG5mL1ErTUlC?=
 =?utf-8?B?SldIVXFpNjRtVVlCb3VxUml6Wk9JQUFVVTQwWXI1NEhYUmtLWmpKK3FnTk9a?=
 =?utf-8?B?eEdlQXhFcTZXVmNGY1haVUFwVWt1dGd2c1M3WlJyWWI5SGsxUG9kOXFSSE4v?=
 =?utf-8?B?NzR5TllRbjhFTzBWcVdLVU1IWXVLM3NuWVh0STdXd21KM0dLcWtnQ0tIN29U?=
 =?utf-8?B?bi9UeWQyeW9xYVVHZHFoL1BBaS8rcnhweEFITUJvcGw2SWZpb01wSW1hOEtX?=
 =?utf-8?B?ZEsvYndmN2lDdTVFamNUSWNLTm9NNWFuQk9oZ0FvWHBJZ0xVaVgvSHk5bGlk?=
 =?utf-8?B?Q1NCMk9FeWhOQm1rYnhGOHVpOVQ1bnU0L3BzUlZzTmlEMGwyalpITDFSVzl3?=
 =?utf-8?B?b2tET1FnbXhBUVpXdCs3UTdXZ2ZoWW9RRWp0aTRTV2VnZm1UTTJDWFVQQ1c5?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e4269c-2293-4c9f-4f7e-08db03fd7727
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3728.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 02:38:56.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJtWFIYxSdN+5xEamsfP/RSo1hTVLgLxGxuzmvUgpaXyQgoWy9/enJzkHZKBi+zbP/mMKU3Za9G37aKUxax4Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 2023/1/31 12:50, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Jan 30, 2023 at 07:21:15PM +0000, Luck, Tony wrote:
>>> Although I'm not sure that SGX memory or PMEM pages are expected to be
>>> included in kdump, but simply setting PageHWPoison does not work for them?
>>> (Maybe that depends on how kdump handles these types of memory.)
>>
>> SGX/TDX pages can't be dumped. They are encrypted with no way for kdump to
>> get the key.
>>
>> PMEM seems pointless (but I don't know what kdump does here).
>>
>>> As for HugeTLB, kdump utility should parse the struct page and be aware of
>>> HugeTLB pages, so maybe setting PageHWPoison on the head page could work.
>>
>> Or maybe kdump can take not of the PageHWPoison flag on the sub-page of the
>> huge page? It depends on whether there is any benefit to the dump to include the
>> not-poisoned parts of a huge page.
> 
> I think that many kdump users filter out HugeTLB pages (setting dump_level
> to filter "User pages") to reduce the size of kdump.  User pages are not
> much helpful to investigate kernel problems, so filtering all sub-pages in
> hwpoisoned hugepage seems to me not so harmful.
> 
> I don't say that saving healthy subpages has no benefit, but I don't know
> much about usecases where user pages in kdump file help.
> 

Many thanks, Naoya and Tony.

The "TODO" comment was initially added by me. I referenced
memory_failure() that gets rid of the three cases specifically, so I'd
like the cases are fully discussed here to make sure it is a strong fix.

- SGX, as Tony said those pages can't be dumped.
- PMEM, although the memory region is figured out by kexec, kdump
utility doesn't have corresponding implementation for it.  So we can
ignore it.
- HugeTLB
  As we known there are complicated processes for HugeTLB pages at
memory_failure(). However, it doesn't make sense for a routine going to
call panic().  Kernel marks the page hwpoisoned would be enough.

The information is sufficient for kdump to make decision on how to deal
with a hwpoisoned huge pages, even though setting the PageHWPoison flag
on the sub-page of a huge page.  It's kdump's responsibility for the
not-poisoned parts of a huge page.  Currently the implementation is to
exclude the whole huge page simply:

-
https://github.com/makedumpfile/makedumpfile/commit/e8b4f93b3260defe86f5e13ca7536c07f2e32914
- https://bugzilla.redhat.com/show_bug.cgi?id=1181649

Best Regards,
Zhiquan
