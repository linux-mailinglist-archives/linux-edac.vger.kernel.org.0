Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44AD576BE7
	for <lists+linux-edac@lfdr.de>; Sat, 16 Jul 2022 06:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiGPEuo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 16 Jul 2022 00:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGPEun (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 16 Jul 2022 00:50:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14CF18E3A;
        Fri, 15 Jul 2022 21:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657947042; x=1689483042;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=FAoOiY8D0WviwNAJN2q2SvCPJVC6eBlJoV/STrCbuGQ=;
  b=YHo3n8I9WWPfnBa0fkcL5hNFyr+xrm36mWi6NargPRm8xI75lKFlroIE
   vOcp+yIFIlkYXDUem7chEuyf2amep9B53GN3+ZriAfoxeVwMynuCUUkK9
   fLkcgvtsnrGWNzjZzwo8PFuAbbN9fQlh3dmwhydPqBHnwUp/yGCdvtQJ5
   H/bVBcp3DVdrdjbl7sfaTuKPHBbihW9QkkziU2F9eOnx3fspnzoN/FxpY
   U+FCsUMq7WlhTjHQFseTGxOlgIpsTflexv3gCHclIBJ3pv8r3xZwbjjb/
   Rbza0OwiLGUwtuRgzT7++kqgLWNFKo4pTWxvMaC/lMiSLnLoDpkCM2yhE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="266359298"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="266359298"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 21:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="546896602"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2022 21:50:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 21:50:41 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 21:50:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Jul 2022 21:50:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Jul 2022 21:50:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6D5Zn8PM3QnvaV2oxaBhusfP963tjCXC7Rn3SUezJEhiGvIYDYP48kdmaEI0OtSHZLW5IQKcRFQxnUc3RRCuvNsrydWtJTB68XZCtIUOfjuX2R9dzh5JUmK3gtlF5NDi8h29h0SOyLtR7yrD2u9wLd3R873s8+hVPm5fKoPXkMJCsLxY3KPPcdMEuuy+3HQmQIWU1DPurO5iaXCNOMipD5zztGQaTgkYp9eHuBdMFaxmsy/MkMw6TQV2J0ENwI2cofB92CZtkFK+QcaLkejTDlFEYXwY0H4TZCGQVIfaq8U+jHehy7snz/h9OghBH2gWD9pFcc5l3om7QFPuAn8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRhe1ofbC8Rs8XUi1teDsz5sRLEbfBQ7VQgxnICxtYQ=;
 b=Jq0ex6ugTfbHVEUqerWbcmkSHfNiQrY9hPg8PBFPbzi2wPuw1GbT/j6Nren9fhAJ1+/OzPB5iLJmCUgZGWi5JAy4CBwmkoFdb7TxhwWcLGN+HNELOCmk6ZA1vclfzH2+iWLmzuKWc4zmzz6ry9CrCP+7BQVfa6XAAfZoc4TJnnu/FvNGmaFG7KXeSGYCRHY/IWJnc9b3Qf7e7Ao7tOfKAMvvmMUMypLiCtuUXy1csuTaSWKTb+St1xEE4fVg+hha2Pti2zkjTwnnSuLOI5u356gIONl01JMwSph88LPn7d4RuXFVBHZiQPptjLf3J8TJswRJHnNECLFxjex5FlrnAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA0PR11MB4621.namprd11.prod.outlook.com
 (2603:10b6:806:72::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sat, 16 Jul
 2022 04:50:38 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.018; Sat, 16 Jul
 2022 04:50:38 +0000
Date:   Fri, 15 Jul 2022 21:50:35 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>,
        <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v2] x86/mce: retrieve poison range from hardware whenever
 supported
Message-ID: <62d2439bbeb43_242d29450@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220716033104.903163-1-jane.chu@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220716033104.903163-1-jane.chu@oracle.com>
X-ClientProxiedBy: BYAPR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0275d0ed-3191-443f-6559-08da66e6ba52
X-MS-TrafficTypeDiagnostic: SA0PR11MB4621:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGyE8kXOLzLYpMVP720r1s/+96cT/JkLKvliMVq5cgCma3YfsBmIYCvK6dCzMlMX6KtoV8wqYh3HI5L8VYubInbi1y+aoApNAwBqtwTZkCdcFNQT8UPhKErcWN9mWF6KCNXiz6JWLprTL/ZQj3fYtFQcuo+K3JyvMoMb6PHJr0zHynyPAcdtNnBykP5E87AyMpBAYe5VDhAf5BLopudZJGzJe+se8e122LMdP3abKVIKvg0wJlgzI6mWZU5p+eguzPmas87RKh00b77YiYHijEWWh4reU6hsbZq/FQl8DmGwmERrVjGinSDFJ3ND0+H5e/0jjU7k4Szn5aLfkiGq89/eAbsyBd9mn9UarMtlJZkdmLa0yA+CnoELd0ZHYdBq1Y7wP8AmApdPO8+fvlgzSL5OCOQ8dN/xaaiJpV1cHyksYFASy7Bl2U/0DMuL7f5mso8gRI6cqcSkQlZZDI1/2MWDfgHs6XKupOsUkZjwV41mY59IozpgsI9dICy7LlHHMGjY3aewyZ+QadPB1Tl5tPxZTbnPCvm011g/TShLa3kAUV+wZP+TQ8Y2XuUDFweiJ/8Jf4HRFNL8KOE9srCc9a0xOk4cR1eg9uwHkYEghsWkI+nrWw8NNvjI5uGpgP4kkVkb923QVltyDI0lPD3UGf6m24cKRzXF361S/ho8k5ZwUuR1oLtFsTY5zTZFlkpZl+ubgln4OZIjGUt8BAR2d8H26e5y1p816TjIOHMDr0R5YHvv4h+MGHv6exi3ROa9iPf2FzTnPcK39U6o1/iZFmZll23u9MGnR4nO57L3DKHz5TUhdX/7EbPB6U5lbl53fP3guYSSckMH7rPpQLDI4P01n5y6mA1RYZlwJa+d/sckzEqX82Kue9Ss+bBbOJNZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(136003)(396003)(39860400002)(66556008)(66946007)(41300700001)(2906002)(66476007)(8676002)(8936002)(6666004)(5660300002)(6512007)(9686003)(7416002)(478600001)(6506007)(6486002)(966005)(316002)(26005)(38100700002)(82960400001)(86362001)(921005)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UBcNLAevHUKHIK5KOk9uZy0286XN9vJaeIk755piUCGjQtEwM7Whc3H7iFZv?=
 =?us-ascii?Q?ifmZTEVerSWtoJbp/Y8h3bd2169xKcvvFKC+gYvsDKVSsrBGwY6Sq0g8bTZd?=
 =?us-ascii?Q?aEtasYDbYs/e6/EdEZmscbve65oWDyyPjX0gB1kSn+vVAlpMksWw6b7KoUGL?=
 =?us-ascii?Q?9sKDLZWroRn51a5kv7DN2O+/OBgFJWbtDFm9ejaQf78rUMKD9xJglnpDMGUd?=
 =?us-ascii?Q?w34YEW5D8kfOZ2ELBByEmRoX+jBVGjZNxabYzKTXxl3hNSfNn9DzTXGVOv8m?=
 =?us-ascii?Q?nWh0sNMHJqj/qCEzUun1zr7BHGYs55y1pOpxJeGukfS9xdsz96U5Ql5rxq+Y?=
 =?us-ascii?Q?2kW1UquZ3szOlxF79NYl+eOpiiudEhgcFqvMHwXmhjVSmMVkgp8eRmNFhYrh?=
 =?us-ascii?Q?bmYVmnt2Ds/v4o63g/a8r90L3Mb1xz2tIgubQj9zzMU4Q7ILZ4ElzAUfDG/6?=
 =?us-ascii?Q?59Z2UZdfNuA1hrZ2g1vi/Kwpc1QVhcdKmTN6gOLYtqg8PatobnutJGIx9Svb?=
 =?us-ascii?Q?0sIYUGMy4yjhwagVq64eJeRNYlNl63VJ8F3mnbfhWeSq4GtfRabuu7n8UgWw?=
 =?us-ascii?Q?8uOPBqprLeDepBDvbRwszY8ZZNQuVvmIPHpF4FAR4p1wCQm4WNPsbaexl2Bo?=
 =?us-ascii?Q?uWrOj6UyPv6Wc8nKKUVcQMFsaYY+kwLvyN6mcEkcTWxmq5VLgdBrqz/2PHvC?=
 =?us-ascii?Q?WURV7p1LxSSmyOoF5BiYZp/tKjn5YxstCOjuRzQFpBoEwQhirhbtZVOC2J2h?=
 =?us-ascii?Q?4q4OipYC22k8zzXHhG8oDL4Aht56pcDZI/U6vrO7QyY+EOhtsre2IM9jqUuO?=
 =?us-ascii?Q?FialwXi71Lm4xZ1JGN5RfuJqTmZydo6RdKnV0vgLyLwUrKKjt2jm1/xY5VuK?=
 =?us-ascii?Q?E0fO2LFuWNO/m8lraO1tOK0qWY5rVwxpuWwaoLG1iD67xoRpHwI3s+gDFCwM?=
 =?us-ascii?Q?KNb1QkJAZWOrYelsFRxxCmWd9GwbqZWDnJSZ9SXHCzITK2e6wHB9PWDV8Fhu?=
 =?us-ascii?Q?pGVmH2GpFLIjZo22Ufz6Yq0HiHH+No33yy0oIHQG7z7pmN5YtLr1G7nawgVu?=
 =?us-ascii?Q?D+POmvWnEG7T8j5pyGy5PeoxmrWYCtqjtzpFDsnj4Ssy96HNoY4SKHsiaFni?=
 =?us-ascii?Q?frRtIunViREDGtdZORXiZ9cCJaV+e7Q2AQRlsQnjK+5BhdA4xD+QrtBobyDJ?=
 =?us-ascii?Q?EdsCd5obVMiKZ+6A9fsCbKSlaEwg5SXxL8Tgc44P87e2ux0/gx6dQu9e/SKk?=
 =?us-ascii?Q?w/oJqQamo+85TxQL1Bf8MvQeOn4lCIrXp8xwhfwXu769WL9Uk5a5jO9eGxu5?=
 =?us-ascii?Q?QKMQlmMvZC4V7WguvQSE3n9sFdgxEvpdnlURWLybYFEJL6oEfL+j3Bu3eDd1?=
 =?us-ascii?Q?O8mznHUkyvtZ4YS8AfwszKGjABWhTIWTerHT91SMHoki9uNVaPqSrZpsHJ4M?=
 =?us-ascii?Q?k7HywwuOC4AbrbAyV+HwsJF6v3tT0Jt9/8HcXN/XP0tJ/qbj9I0b23tQZWWs?=
 =?us-ascii?Q?31M7yArE/MrJQVgW8QTB4DdMhrSBTe+Iz/BRzf/cJ80TwnEuEV72V2CnRSB2?=
 =?us-ascii?Q?eJkkF8j6+SJarJzerpFSHQIqJUrgQ0a3cw3mAM8g9HR5FF8RkSwQSpBo0JLi?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0275d0ed-3191-443f-6559-08da66e6ba52
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2022 04:50:38.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evesOq5qEcodqAH6QV18j9QJ/poVoBO9leredx38dD+4hJlnc2qrMNpTnqrVXDzD49VyG7UFrIDNaLYoef2PAF28qJ8IHG+McMpRAe7lgpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
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
> With Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine
> poison granularity") that changed nfit_handle_mce() callback to report
> badrange according to 1ULL << MCI_MISC_ADDR_LSB(mce->misc), it's been
> discovered that the mce->misc LSB field is 0x1000 bytes, hence injecting
> 2 back-to-back poisons and the driver ends up logging 8 badblocks,
> because 0x1000 bytes is 8 512-byte.
> 
> Dan Williams noticed that apei_mce_report_mem_error() hardcode
> the LSB field to PAGE_SHIFT instead of consulting the input
> struct cper_sec_mem_err record.  So change to rely on hardware whenever
> support is available.
> 
> v1: https://lkml.org/lkml/2022/7/15/1040

This should be "Link:" and it should reference lore.kernel.org by
msg-id. Lore is maintained by LF infrastructure and the message-id can
be used to search lore.kernel.org mirrors even if the LF infra is down.

Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com

> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  arch/x86/kernel/cpu/mce/apei.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 717192915f28..a4d5893632e0 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -29,6 +29,7 @@
>  void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  {
>  	struct mce m;
> +	int lsb;
>  
>  	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
>  		return;
> @@ -37,7 +38,10 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  	m.bank = -1;
>  	/* Fake a memory read error with unknown channel */
>  	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
> -	m.misc = (MCI_MISC_ADDR_PHYS << 6) | PAGE_SHIFT;
> +	lsb = __builtin_ffs(mem_err->physical_addr_mask) - 1;

Just use the kernel's __ffs64() which does not require the substraction
fixup, and you can assume that physical_address_mask is non-zero just
like trace_extlog_mem_event() does.

> +	if (lsb <= 0)
> +		lsb = PAGE_SHIFT;

This fixup can then be removed as well.

After the above comments are addressed you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
