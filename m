Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D485833E0
	for <lists+linux-edac@lfdr.de>; Wed, 27 Jul 2022 22:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiG0UBl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Jul 2022 16:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG0UBk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 27 Jul 2022 16:01:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697F758B6B;
        Wed, 27 Jul 2022 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658952099; x=1690488099;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=JBcJbKVWuHJ3p5DaePn/htKUavn/coCRLFXsLiI2Jkg=;
  b=TmtI1v1NXpW+YsL1vH5D4xq29zfsbHJ/Qj/RGzn+9oqNzcNXbn087LjI
   BdXMQV2DdNOReLwzjcfd9vMmZ5m0XyLBAqqKa29CLjfUhBc3e9mIwmZNM
   D6Fr5v8fmkC/wLriCivbQWhasvV2WhrbaSkjlBhBdGkx8A5jjulMkXHaI
   Pgz52Uk7eawmgyuj9aFcivMromcnGil6V6m0iaVb/+dVtEOEdU2XAIELm
   1AOxQiUWZ8x3qepNIcECxpnRONnCSWq2wetuC5i6ttjVXQP1D37PV0Kct
   G8vyBxE64gLX8duAFOGM3iGyaHFm9tVUblQGF2UMc4kPhemv5B3XGTSlM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="374635787"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="374635787"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 13:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="668487485"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2022 13:01:38 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 13:01:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 13:01:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 13:01:37 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 13:01:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzRrUb06s3sztlNhmGRh9voS7Uzu1gZ4Rlgn03Xtt1iP/K6uxGSZKigwTXOmlVvBZvSIM/Zpw9iglkYxSAm5CQl9U3u5xZ3QihIiE8E0tTvqqpE78Oy6X95ZYDfvaNIjW879nWO7Mrz9QHB1Em+VBJIsLxOt04IdOXJA3uwqn6b6mH7iq8AlqyfneB72z3Hd59hCH4Cddy56VQVmHGtqVUJDUir4Wfq9PNSYEIQPswcn1ALIeO3WIC4O8TVSdOErnf+CLFf3+R4H3dOT4/9sb4vgP5wyW0G9zqWFN9Jl+Sfsw/5zf68tuML+V7BYqw1msYB+H8U22/2DtoAy3W9yYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDjK4k3ShijVcP1ReO1kOCw0/MiQthQ3FFIEeELL98o=;
 b=gPk8mGilvmVXCAgNYxl33Fu2AxhWlx049drIgwIxpMbRCy77OZam7Cjpqsp1wrSwgz7iKRa5EQdK0d4/K2yMsXZATng9ihxqhsMFCkp/8iH68eBkBwJQ0Wd163vawNf64OibFoFYqcWdVVcMG+pyxjVv8Y/xbHVMj2SRWI+k8IOHO82O0SemX2ShQIQFvkN7CDkgR/R4oKdK1uPMNhJFC1EVOI0yGQIxz6ZjQmBr3sIDLoiplXrCsTf7JmRGjZdTJH2BoVNZdNnLPa1MEujqF6jSbkqTeNSUdDM9W9885oi6Crd3L7uhkI9lipJ8gZeJrEyG4cd8Lb8eFWdZ72NpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR11MB1703.namprd11.prod.outlook.com
 (2603:10b6:903:28::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Wed, 27 Jul
 2022 20:01:34 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5458.025; Wed, 27 Jul
 2022 20:01:34 +0000
Date:   Wed, 27 Jul 2022 13:01:31 -0700
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
Subject: Re: [PATCH v4] x86/mce: retrieve poison range from hardware
Message-ID: <62e1999b4121e_2d2079294ea@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220727184644.2685405-1-jane.chu@oracle.com>
 <62e18a687aac2_2d20792944b@dwillia2-xfh.jf.intel.com.notmuch>
 <f22faecf-b4ea-cb39-bed3-3647842b814e@oracle.com>
 <382e9410-d964-5600-4481-ccad90dbc97b@oracle.com>
 <8e817134-bfa9-72bc-3601-eeb1a138fe37@oracle.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e817134-bfa9-72bc-3601-eeb1a138fe37@oracle.com>
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f81fa35-56ef-40db-bd8b-08da700ace6a
X-MS-TrafficTypeDiagnostic: CY4PR11MB1703:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5KkL6NK64WcZ4HwwfZ29gOagXxn1gsR7wcTDlKKyx2LVTd93SOKaqaB3r1N3b4Z8v3T32HLHPHB7Z5b5eEdAUKzkN37SHNOqLaM60SaKb3HejcCO/L2jfqUcaGD4QtkqGxsmqLg95G8ClsNvd4Pxcpv0E4+Wp7W+Qi8aQlalvyjq5Of+bYl+eTdXr0TnWW8idEIZMf+DZc15scrBgfPpexw89tqEqYgvkMbXFj7AvHT+OwtKoRYcP0RiWJeZOAtEzpjPNm3oFclyVDUXheoX+f/dgs1runrg2KlHfDph5XWnhQVzbsvnit3TBGqllSseQO3LmILufeUm2BZbR3JqUM1CEiV6MPYIia7N4iADcBuf6D/IDHrXOuw0nX6LTFDsFdLaf67eUaW3YbTAciAnWhokroEhtBLB+aa0g3qzFYThE3Gc2EYTMBT0/JnxB1Nk4VTD1G2KeTUznXaqPdVCMUDX2hNs8AGJKIXe17q+9+OfPXb6cKKzUaueJpDRJXaM4lOQ+wt6AxXuXgxkPrCnknX0y6XeGw/EAXifwXBq7ht+HZJ7hkpN01UWLOm6PYgAB4i36vcEfVaZShk/VH6SYrFuerxLCShHwBIi4bsRV0Plu0TaDmoPVq6l+vbRNKgaVeVVrxpTy9Osvfi4cJ45ilBUZv1uGhmo87LOx1/raPbOlbS67HUBNcxcaMXX/N2Z7lzeSf1ctMZOTdsNv/H8CjRxfVJb34isIFFzKyMkne/Lw5YZHkgOUfoWOpd912wWFpL/s7ZtmXLfD1rp3UaJkMZkrzlxNOPNWE1pcgOdpsbXpM5g831QjGNYeVhE5bw9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(39860400002)(376002)(346002)(366004)(83380400001)(6666004)(38100700002)(2906002)(82960400001)(66946007)(921005)(66556008)(110136005)(66476007)(86362001)(8676002)(26005)(7416002)(316002)(9686003)(966005)(8936002)(6506007)(6512007)(186003)(478600001)(41300700001)(6486002)(5660300002)(53546011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?gD2KfjzN2qtBGIPcZ3O7hh/QWkpYWBlp4ok+1HHhRrvg9Aie0RCuDIoSm6?=
 =?iso-8859-1?Q?D00hdhHAK/N6PGtSpbh/NbQFvQo7JSQcaG7imhDMxSAUyra+paPv66M8d6?=
 =?iso-8859-1?Q?8sxhqAU9bdV0AI7YIBUz0dcPqpOpeeNGv2knGw3OgqDk1afJMQLt+2ZHiU?=
 =?iso-8859-1?Q?zhak8T8xfWzZh7sbSvBRhFp3q/inoU5oYnsBF3s3YmVzIOSf68M+sElFgT?=
 =?iso-8859-1?Q?MFEIsDXctDyH1kfSzHY1/yZDTC3R7Zyi+qXW6g1mzI5mSCk9cRt14sPXN0?=
 =?iso-8859-1?Q?eNSihA7+lK3TTpafem/4MgUkjQUZ9wnP5qrcW/jIscjmdFQ5+8zs48oosm?=
 =?iso-8859-1?Q?6nNls7YNGcTTVO0xNA7o+DFVp/9yY0lax2wBT1KiewY559QQ1F43xa++3t?=
 =?iso-8859-1?Q?0yEO69twQMzodRwd4sM5t9p3gQm4fWQzG/+Ur2LX9rEi42ef6N9LF2ZO9l?=
 =?iso-8859-1?Q?xYzyCwQYbXHX3amHjzHBGX+EbCK9QnWT6/HqY401LB1qiN/ND5oAKtUy14?=
 =?iso-8859-1?Q?6IqXQN328KyCmyWF+wNEOkOg3WPA7HSN1HM1K1h7ztjOVVet4PQ/7fKZfP?=
 =?iso-8859-1?Q?xPuoMCNVufYt+/pIpEY3+yJpo18VvvVRuktyZd+jDy79fsILdo/VnAx8lB?=
 =?iso-8859-1?Q?ftBS44dYoWCzKIe71SFxscW3biVcSithJ/HMsFLOHBr4fI+F1B3aRDjOZA?=
 =?iso-8859-1?Q?eEP+1usEkaUcoZi4uzFGQR7hYhyemol6D6yZmg+1VFxH8SKiqLJEUi2Wv8?=
 =?iso-8859-1?Q?2MPl7SeG9K/xP25P3Ge4rA2MZprSs0E7ehGdSdf1yMdlOp1E9Xe4StHmvi?=
 =?iso-8859-1?Q?GWfJ2mGeWaGEXL8i3dz1AJWeUtXqm0td4niYE+tR0vUJetyAJf2GQaO6Ks?=
 =?iso-8859-1?Q?wqrllLpEfu3lXTYArFjOKPZJ44bScqkGmOQtH8megssdSOuIu9bKxqa6dF?=
 =?iso-8859-1?Q?Wyh2JNqfKNBWbJMz91EtmmT3ZbIcaw/jSpwEoY6DSeNupejOYH3qpy66SL?=
 =?iso-8859-1?Q?d2zZ7KQZ1F2zJF8n+whjWwXwGHGIRezRhNi+hJGnour3GvYvIXCoDwZevF?=
 =?iso-8859-1?Q?l/zlyrIB/r6LogehR9yWEQ8v/SO1UpdhgaYnl0dy+ymW0oQT0aHiNeZhuR?=
 =?iso-8859-1?Q?uHulULOd7i64W4JbjDOeGqRsbT4sXk/9ZTiWblPe8J6cf7CvCouXtEY86d?=
 =?iso-8859-1?Q?oBl+3LMsY08DkI26eOP6lvrfzYEGWvd6pLmBYFqS24jeRHxmpgon1JluaX?=
 =?iso-8859-1?Q?xZE5zqKl55Z5puqYGBrBzepX4L6wtnwvDfgMzv5+Bwz/+0vzlg8XV5qo87?=
 =?iso-8859-1?Q?6UlET32PJsAUI4oGsX7Ph+XZI0Tip/2QpyfvZhd9pIF6JBPv110xPk9bEe?=
 =?iso-8859-1?Q?izUQpeELVSHzzMQAB53zWZdJrUm20b7mVx8p0/f2u2y3b1fC7OC/TMs8kO?=
 =?iso-8859-1?Q?iBMZwdGp6O/DowGCmf2l5p8N0FCWCKOtcE2hB1GLLGX76tqtbNbgHcfQsD?=
 =?iso-8859-1?Q?6W2FSXNC0MgQirF56J5h3o01yrYNvrtj4Mk88gKnmgGA2lXxEQUniepsOA?=
 =?iso-8859-1?Q?ZYyAvbpWpa6YmN8gYs/x0Xj8N642sRLA/dNZGbLE6+VP1J9bjqWN68/vQ0?=
 =?iso-8859-1?Q?Ztm112WvfGTNRnHgYeTzGdCC5PM/mkB+34vgFqoDb7cYKTtfPrFUEjbQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f81fa35-56ef-40db-bd8b-08da700ace6a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 20:01:34.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSLluh61O7ag7tBKfgUx948SjvfFt+WZQh79wmP4mq4sd/a5E/juz6J2u1NULXby39Voa1W8zhMCaVzTUTZjVjVMuYtVcznCLEP+G6eW234=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1703
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
> On 7/27/2022 12:30 PM, Jane Chu wrote:
> > On 7/27/2022 12:24 PM, Jane Chu wrote:
> >> On 7/27/2022 11:56 AM, Dan Williams wrote:
> >>> Jane Chu wrote:
> >>>> With Commit 7917f9cdb503 ("acpi/nfit: rely on mce->misc to determine
> >>>> poison granularity") that changed nfit_handle_mce() callback to report
> >>>> badrange according to 1ULL << MCI_MISC_ADDR_LSB(mce->misc), it's been
> >>>> discovered that the mce->misc LSB field is 0x1000 bytes, hence 
> >>>> injecting
> >>>> 2 back-to-back poisons and the driver ends up logging 8 badblocks,
> >>>> because 0x1000 bytes is 8 512-byte.
> >>>>
> >>>> Dan Williams noticed that apei_mce_report_mem_error() hardcode
> >>>> the LSB field to PAGE_SHIFT instead of consulting the input
> >>>> struct cper_sec_mem_err record.  So change to rely on hardware whenever
> >>>> support is available.
> >>>>
> >>>> Link: 
> >>>> https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com 
> >>>>
> >>>>
> >>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> >>>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> >>>> ---
> >>>>   arch/x86/kernel/cpu/mce/apei.c | 14 +++++++++++++-
> >>>>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/x86/kernel/cpu/mce/apei.c 
> >>>> b/arch/x86/kernel/cpu/mce/apei.c
> >>>> index 717192915f28..26d63818b2de 100644
> >>>> --- a/arch/x86/kernel/cpu/mce/apei.c
> >>>> +++ b/arch/x86/kernel/cpu/mce/apei.c
> >>>> @@ -29,15 +29,27 @@
> >>>>   void apei_mce_report_mem_error(int severity, struct 
> >>>> cper_sec_mem_err *mem_err)
> >>>>   {
> >>>>       struct mce m;
> >>>> +    int grain = PAGE_SHIFT;
> >>>>       if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> >>>>           return;
> >>>> +    /*
> >>>> +     * Even if the ->validation_bits are set for address mask,
> >>>> +     * to be extra safe, check and reject an error radius '0',
> >>>> +     * and fallback to the default page size.
> >>>> +     */
> >>>> +    if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
> >>>> +        grain = ~mem_err->physical_addr_mask + 1;
> >>>> +        if (grain == 1)
> >>>> +            grain = PAGE_SHIFT;
> >>>
> >>> Wait, if @grain is the number of bits to mask off the address, shouldn't
> >>> this be something like:
> >>>
> >>>      grain = min_not_zero(PAGE_SHIFT, 
> >>> hweight64(~mem_err->physical_addr_mask));
> >>
> >> I see. I guess what you meant is
> >>     grain = min(PAGE_SHIFT, (1 + 
> >> hweight64(~mem_err->physical_addr_mask)));
> > 
> > Sorry, take that back, it won't work either.
> 
> This will work,
>    grain = min_not_zero(PAGE_SHIFT - 1, 
> hweight64(~mem_err->physical_addr_mask));
>    grain++;
> but too sophisticated?  I guess I prefer the simple "if" expression.

An "if" is fine, I was more pointing out that:

    hweight64(~mem_err->physical_addr_mask) + 1

...and:

    ~mem_err->physical_addr_mask + 1;

...give different results.
