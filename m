Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD91A5872FD
	for <lists+linux-edac@lfdr.de>; Mon,  1 Aug 2022 23:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiHAVUu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Aug 2022 17:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHAVUt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Aug 2022 17:20:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626ABF6C;
        Mon,  1 Aug 2022 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659388847; x=1690924847;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=JZA8ZjoFjmkfTMJZlfUtssEkR0Kjx7gU7tW5iqvppoE=;
  b=bH1Ydl1U4OmnR4PudOicLCpBMhhv+d5JVeFiToXtvKgyh2fT4nkLrQJD
   zLkgRlalkNVK5Hoauo6NUhHwI4RpwsOHBYOutrYMhHnSAyP/rrx2InOrw
   5g2egw5urqyBJRXqlMCbHOSzBHX35cUv0QfVXryJlp3336kpQK9Wu+S9N
   P7d01Q6FwDQnp5QKDs53WFNMvRDCNgcNw6yfVQuC+b7MKXw9EtvYpaLKI
   m2SHLBEqiimT1UGSTliFm6645ZpgZBjs+SiZCUDAxeBd97Ek0mdI4d/Ag
   YVKrZ8b1CVNj9xrf735dMT+CTOjbEwrXhuwvV9iBtaHTNlKqyGniIAXXs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="290466534"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="290466534"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 14:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="705125149"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2022 14:20:46 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 14:20:46 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 14:20:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 14:20:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 14:20:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE8ZSr0w5KjRq0+xh4BlLLRvglM7k/0ct/nxKvyMmaRnJuxW2u6NlFeMwP8vSdPQbJC/ymsC7Vj9LuUOKv6YZOH8On80tXI34qGzarDLwNYv4eom5SzMSf4ydnkfQl9PhZZiTcUp3pM8bBeSNpfZ3I5ax7skpqnwHiTYh7DjoX5kdZkvqD6MaZsRKZ8kscz1Ar+wZl3n3hFpXu0n7cXpqhTKpFfhlsvd+3u0690yDKTU+5vchzw/qKCuRKmAH4WtHRpoKdOwdnGRWRmXbRH3fgcNm18EFnA5SvO4W65IMNNi35cq7ROR9SvCeahc4bW6fowmS+dYNjjYDwF6RwFtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etSf/BBH9wDYrLfhfHg9Vnd4TXcFZpZsgVavIXetjNg=;
 b=oFGDqcbm3Bnu8SqX+cgaEo+zurv6/5aWnFhApuIEPz1pkqgAPmvfIbfPLUgsIhsfPYDMgfHRCHYMPMAdY+VnYJ3Ob9d9J9rObNNVdqThcO8B1ZYwn4a9B5SFSzNEzb+1vLUBqjzMtF6rysrNkJOEZd4Zi3RD0s44YzsmRaoxLsJVJ/Qdt9NxuBWs5QJ9MVsgfWrYxXduLzJ0J6BeznRDqcM1hirDlS/OVZ13GZL+GMy5ZNmFN2zhMPMDTPVHvjEa4xXEyoo+8o849OMrO5CovkL2MB19ey3Th/uiQB9s+sq+eVIC9ATUVslM+EftU/YWZLlMVDk5GHxZ6QWFG4JK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL0PR11MB2977.namprd11.prod.outlook.com
 (2603:10b6:208:7d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 21:20:42 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 21:20:41 +0000
Date:   Mon, 1 Aug 2022 14:20:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v5] x86/mce: retrieve poison range from hardware
Message-ID: <62e843a6ecf08_304402944b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220730061757.3441537-1-jane.chu@oracle.com>
 <62e802fb22f2f_b075294a8@dwillia2-xfh.jf.intel.com.notmuch>
 <e3234907-df27-f0d4-ef63-ee1ec9808f54@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e3234907-df27-f0d4-ef63-ee1ec9808f54@oracle.com>
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5977b8cf-10bd-4dae-3223-08da7403b03a
X-MS-TrafficTypeDiagnostic: BL0PR11MB2977:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +shZRJo/MmBr7ojkT3DFMHlIsbjca7RvU9UrlcFD0Qg3/CF+m2C7vFqRgTvMtNeRr0vBgk9E2fuBwHw8ouIae8OdCVJX67/+/ELBJ3GMmRAHIxDOe4U9Tn+c13tigdJ+E1DvnV2wUrEgs1hgsBBBcAaW3PwPH4mj82Tlm5CD08TO83hpOvN0cFyy6obyRN5AW1DdpjUEkK5yH8RjQck1dM8ijc1v6TujQ7wdfDvqYBp3EJBkKyaDkT+NuecmzTEgOdopia++WJJobtD0gqPR6DiuYYa3tLGzuXMpjH592cLTs0qPwMCUHagvEZ0zzqHl3xusxXExAuZZQ9L2Qn0eUK4xCR2Q4hM++k9nXhJMgep2isori10JHte1hotTlX10Skq9i4WQ04W8X3FlvtzvAp8dU98tCYW85mX8DXp+6tKZRaxdZIeoa7+ZhWDUJWfhB8+NuRpRJBQZNFCLbQLks4GinGHS2fiovjgRfbXCDTpnbBfs4k7QqI9JilNeauPMq5VlwS+CDKovLMDf13CKFJ7C2FyVNQp1DvW9W2lnFuzq8AAGAIC57o2ZdGm0tZK/7HgvfyZPXH0BEXPU7AdAKBKl2xQInjtpNa5c6xr/MZ2iR2F4vQJazbgAK6e+T69+i8MSsiJAQT/fbW9oppVTZtZBa+JCOIsKCxQxEN5aH51gCu0B++r2GSW4TjAjGZb/jk/kqW5iFZu2pOT1LjERE798dlmaHuCwJWT3Oyku6n1vK7YVaiA3GF1AxitWqldtVdzhzJWCuHwfQdZ4UPTOJK9btTNmxUA2swf2ztQOwa/hsl3e2kRpXPW92ALiL6h1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(136003)(396003)(376002)(110136005)(41300700001)(966005)(66946007)(2906002)(86362001)(8676002)(316002)(478600001)(6486002)(26005)(53546011)(186003)(38100700002)(82960400001)(921005)(6512007)(9686003)(6506007)(8936002)(7416002)(83380400001)(66476007)(66556008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JaZ9jte1rfLXiJpG4K2Yk6H05ObSVqleIkfxnQBak1q5ad7IFmLNz0T+/rRc?=
 =?us-ascii?Q?5+Uv7GYmTFVS/ASD3pYTpaT43VmhyXDIsx/M8CnzH6+OI/jbMpllFWTneRsl?=
 =?us-ascii?Q?wJNBK86ud7T7Vy+9dkWfMYzkCUDhDJCPnsRhXjX+8XWy48dcA7KEyiLcz3fj?=
 =?us-ascii?Q?cim/GasDzllWdk9nuoHQwAnFS6Ez7omC9giwUf6i8rUmq9MSAC8bGe4reCWc?=
 =?us-ascii?Q?C+Dbt/8pFQ/YgnkEzT7OTnRj7CyqjDPIo9KVKpBST73HOBW71xEB69XADo3d?=
 =?us-ascii?Q?Vc+32J6id2iaiAzUqxDHJh+YFnKlDXiKYhX4Upkm/p3e78JdDEYKI9Eq/608?=
 =?us-ascii?Q?tEzr6bfRAGUupNZ9tnYBlipfCCa7Vy8kHzsoMktBQq9PsG1diago27eilqym?=
 =?us-ascii?Q?zKrnOxT4kqTLFcuQXc3vEbL7qgEdmG5vn5CJ6JwskqvzDJPDDMuo8GBlwUIq?=
 =?us-ascii?Q?uP6uv8HxPOfR6EdmWIV3mLBt9oIsMJ8EXmoocC+cr0GqdDRUQObFcHunTHhF?=
 =?us-ascii?Q?oY3Aih5I+5qEqEybrdYQ2IFwsnLWi8csUax/kQWC7STvu7fydcBusMYwb3fF?=
 =?us-ascii?Q?CzJAK01kCa0UcsSh89vjJEp+JNbVe8+7gQoS3MczYYnPjWXm1uBA2+HoCxsx?=
 =?us-ascii?Q?y+rscyRv2ynM5Y1Nc9tfWwooTnqA85Bfc39sWEOm1DOHtDtdfG+fJnGBgWvV?=
 =?us-ascii?Q?kDNa6QpGQ3ehjVp5Hu7Bc7QV6TtTUIl3i/H7Vj6/phBd3CIwin4GJxbNW6AB?=
 =?us-ascii?Q?o6HDmlSMJ3VMBL9lI4KcLpGbJIUj428WoDSleyE8ofkVgjlzGhvbW2GA8r0H?=
 =?us-ascii?Q?jzbPLguhJqLWXWRuLJQ3G/TTKcgSgNEGxayZ9ecAcFj7vI2wAYRz7Lc28L35?=
 =?us-ascii?Q?M/5Vew/CEJkkdS/YHxG13MT67olWBMdWO4VxTN1VroC80lPxfAvY5J5K6BFC?=
 =?us-ascii?Q?DpxQ3IbLTztKaf/aTzUK5AiljakFCyZtNrOYqZ7Mse8fhUZBCFvH/VgnbBTE?=
 =?us-ascii?Q?VrRrK9GQpuMXcKa18eTiHLXp1JMLFY4wAOsP3dZU7MLVsMVpd6hgW+RkFdGb?=
 =?us-ascii?Q?Pygf4w7seNBHx51UmKJFPgkGeHwS/lGBCZsx9noPK326HYeYdvmVm4AIyMGr?=
 =?us-ascii?Q?AVHOumStsaz8E/tjN47tWvYYx3owrlPjr8f/l237kAlAAOiyI+Hdg5q/PjWo?=
 =?us-ascii?Q?gv6eyrArbBb+6i3MqzumsdDtx/aBdJpJWu6dRMcwnGN0WW2TZxT402KRZ8rG?=
 =?us-ascii?Q?5P8j9HWI4aJmNXsUVJxD8AwQSkVgQcCxQLCVZ3G8XzHpw5Jx4VPywjqeWduz?=
 =?us-ascii?Q?+u7q75dGt5caZKgZl7X+FnL66EsYT+RoNTdeazYZYY7GwlIwZ6nOQp39UP7Z?=
 =?us-ascii?Q?2tG3H4KvcmEhzdktiunGuLgzDjZNY2Tlw0J0ZqwKsYm/E+NcTPLWxbzDLD7p?=
 =?us-ascii?Q?aeVTiDH90qBc6oieycttnVayCX4S+he9aykdfojlupbSPo3/W0hYFmpvNuHK?=
 =?us-ascii?Q?NV68+epv4ccvemEZpxz6xkiMx06GypRLsdmnPEdc+t82+q6P7WnEnzVeL5YU?=
 =?us-ascii?Q?+F/yLFwLKRfzakQsMhZDCwqJUXwZtqQ0AK2N/2u0qq37WPZg+GRswM02EKgS?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5977b8cf-10bd-4dae-3223-08da7403b03a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 21:20:41.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: No+d8BD/xSYbCIf4dLlyazs2egbysFjs6b8pMrKP8HhC4Dcc3FzVnR++Jp7Uig0xdMmEJNXZsqYStqKZSvBiCs0I95A+s5jQ1VXku1ZLr+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2977
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Jane Chu wrote:
> On 8/1/2022 9:44 AM, Dan Williams wrote:
> > Jane Chu wrote:
> >> With Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine
> >> poison granularity") that changed nfit_handle_mce() callback to report
> >> badrange according to 1ULL << MCI_MISC_ADDR_LSB(mce->misc), it's been
> >> discovered that the mce->misc LSB field is 0x1000 bytes, hence injecting
> >> 2 back-to-back poisons and the driver ends up logging 8 badblocks,
> >> because 0x1000 bytes is 8 512-byte.
> >>
> >> Dan Williams noticed that apei_mce_report_mem_error() hardcode
> >> the LSB field to PAGE_SHIFT instead of consulting the input
> >> struct cper_sec_mem_err record.  So change to rely on hardware whenever
> >> support is available.
> >>
> >> Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com
> >>
> >> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> >> ---
> >>   arch/x86/kernel/cpu/mce/apei.c | 14 +++++++++++++-
> >>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> >> index 717192915f28..2c7ea0ba9dd7 100644
> >> --- a/arch/x86/kernel/cpu/mce/apei.c
> >> +++ b/arch/x86/kernel/cpu/mce/apei.c
> >> @@ -29,15 +29,27 @@
> >>   void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
> >>   {
> >>   	struct mce m;
> >> +	int lsb = PAGE_SHIFT;
> >>   
> >>   	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> >>   		return;
> >>   
> >> +	/*
> >> +	 * Even if the ->validation_bits are set for address mask,
> >> +	 * to be extra safe, check and reject an error radius '0',
> >> +	 * and fallback to the default page size.
> >> +	 */
> >> +	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
> >> +		lsb = __ffs64(mem_err->physical_addr_mask);
> >> +		if (lsb == 1)
> > 
> > This was the reason I recommended hweight64 and min_not_zero() as
> > hweight64 does not have the undefined behavior. However, an even better
> > option is to just do:
> > 
> >      find_first_bit(&mem_err->physical_addr_mask, PAGE_SHIFT)
> > 
> > ...as that trims the result to the PAGE_SHIFT max and handles the zero
> > case.
> 
> Thanks Dan!  However it looks like find_first_bit() could call into 
> __ffs(x) which has the same limitation as __ffs64(x), as Tony pointed out.

Not quite, no. __ffs() behavior is *undefined* if the input is zero.
find_first_bit() is *defined* and returns @size is the input is zero.
Which is the behavior this wants to default to PAGE_SHIFT in the absence
of any smaller granularity information.
