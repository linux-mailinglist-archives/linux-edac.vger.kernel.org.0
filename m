Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6E586EF1
	for <lists+linux-edac@lfdr.de>; Mon,  1 Aug 2022 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiHAQo7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Aug 2022 12:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiHAQo6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Aug 2022 12:44:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9766D1CB29;
        Mon,  1 Aug 2022 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659372296; x=1690908296;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=vmYDSOHw90luruLiNY2lSLcPmL9AA2qBuB/lZMjJn9A=;
  b=lMw7Y31tRGoGAb3Lkgv8/P8nbeuke0s7/2VFqVCjkPSavLcGYmOMAocJ
   Dv6X0DcmfyjhHlN9eXCV+5Yt0qq435/xJ0I0132ZbG0NduEvk4PUSRApo
   LvUVnaasfejezn04utSxUDophwv1CY8zzmsD5O8/NIiBq2Lg2zZzpK7W8
   QihErKwxLPUCfWAkZsszvCJjBd+JWiSGZEGWSw7Ggd1Ze8gDh+tW75K4a
   xkiBf53MLHmcRPb2yE0CqqcdaJC7pWeyOnnJg8L1pKnQLz5NyIpC+aRgh
   dQ9tlPRd0lQU0p2eLNtfB9j6JpubC+368hSgHBmI0RtXlzntU5JI/w45R
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="287948045"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="287948045"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 09:44:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="634954653"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2022 09:44:55 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 09:44:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 09:44:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 09:44:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 09:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rn/HJzC19ibWhLA6PTMkATFn6Lo61OD9pr+TqdMw59l97CiRr60pGI1DtaqbSfPH2n3IBWlcnQj+GlD5bi3fx61gsGnnehfehZcW9qqTk8aFBcOXrPh+KntkfHmEIqjrwNNqryIipgQOw3174iKRU+U2uT6tm3ee4oveSsmiPqUZ/UsTJIGDE1PJo6/LoT8IxqPbTAKzFLiiwIQ7+YC//4W8n53wiLHCKYuF+SHbQ95j2sf5k3vyq57XhO08nNuqD+AcThYdA3Ecf3yDqthpGlUw8p1bJIXJPg6900M9SWUjIp/oUqTw2hGGjAHx5GkxD8fwHDfoQdocrP5LKznOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4CGhlMYTbK21V0BKSiN/fqr2j7YLt5v7XpxOPOpnaw=;
 b=jRfxJQ0XjN1fl2gT/8T4yBkHRisRQjLFIip4f5IUcbzqnpYOaf0RbGnjSFOg0nIGw4LtIjaVxE7rZtmO8wkanJoktA5/Xc23iriMDt67L7SRhz6d+kooXm58qdeNQj59+mh54/ehRc5s+U4zMQ8bxbS2ZaXv9BYamRHIbiudQL00T0rvkH1/z6+Sd25K66E8uVCmpIo7umUmcTiaaClB993JrApwOj8pftBx1Lw8BriZQ8WYVjuW7KJz6DB5yTnqwSoHow8D4lAEMfV2zRG7Ex65HPsb3sZFZe7yNP9+54iHO+OCwYgDVApZHkb951O8/qeccME5QY1RAZeX45tfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4122.namprd11.prod.outlook.com
 (2603:10b6:5:195::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 16:44:46 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 16:44:46 +0000
Date:   Mon, 1 Aug 2022 09:44:43 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>,
        <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v5] x86/mce: retrieve poison range from hardware
Message-ID: <62e802fb22f2f_b075294a8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220730061757.3441537-1-jane.chu@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220730061757.3441537-1-jane.chu@oracle.com>
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9acbaee8-b74d-47a1-0e75-08da73dd246b
X-MS-TrafficTypeDiagnostic: DM6PR11MB4122:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxuAnTpKtmUr5XQplTugSy8GXfpaKZGpc5pEfg5w5/P6Imm8gCYOGcfs+n4I9an2++tA77/Yj6v6cF3lZZDdJWwSgjg2QRY6gwOajulIv2nRYHNmxkMFYasPjlxBTyHizHZPx4EPCIeaNc1daec0GDvvj+NDGSoySLz0ETODMmE0mbZG/eqCU1QHZIkni/KlCPgea37nh99sQ19uwpqBguiJ+a0bcy+xscEENLOuzc07KmmvBp4xo+qfYYHn11q0ZgtwAFY4utOxCS5/jH3kDR0Bw8K9UkFLlzcfzkZMHvFsKc730VSvaWdb2twbQyHYL56bF4faBDTsVCglyCv0YL6vNNtN24PNBfp5R1FuXXWo2UoBSRLM0GhtcwyMy4+asaXKv2sP3ZUbKZgM4mvXgdNDp0XWs6IwdY1XawjyEjB6181HKXi4I04Fl0snKvh3+b1044gIIMzYZTaT6sQAs+ea7vSHNQYcIAz75xKjzECM+SUQfvv8NiT9aeQDQ0VF8HrYSNeIfSgsGvky3ZsDXR/wiWc3oxTn9lN450oB6YaaqWMXJKls90gMvs9F4sGJ4gib7J9VtG0nFklmdx1Tq4DsbiF1MwL1XMtmLMJqRvyiD5WuK59cErNRPLkq42uEutdiZX+0hxE4chyg/aFt2idJeA3dHsOy3lAf6oBcXLq57/upDlhomU7o2yTP4bomNhs2ipYakNNA8oq83/aUzszDlIjZptrDxxrE3YxnlQG4nyL5Hhm8rJcgHxaznQFktntNYuerbgOOTPodPlbAO57QkxPvE2JVZezHGqwE0o9FmwHLCfod5zWZjGlkgpJF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(346002)(376002)(136003)(921005)(82960400001)(7416002)(316002)(83380400001)(5660300002)(8936002)(86362001)(2906002)(66556008)(6666004)(66946007)(8676002)(66476007)(6506007)(966005)(6486002)(26005)(478600001)(38100700002)(9686003)(41300700001)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4JiwrqD1gT947PB/ZdV5zvaK39oJtPZRtcnShDr1I/oX9XgKEw/gHZMiBjm3?=
 =?us-ascii?Q?KZRKQ4j26jxEfWFCNM+o4uK2V1/1w5yGOPQEJjq8+04mro4eksIzphb+9WST?=
 =?us-ascii?Q?eopVxkCqG2/hle/aXpSVCHvcaUk0OGWtfUXWVzjOGSEXvec9u67xjnDrodwo?=
 =?us-ascii?Q?ZGEcwkqhWzBSiXsEWADjk7IJLNf6auvkIcct8wlXKq3GvzBnKTqnT2T/4Jty?=
 =?us-ascii?Q?LRHrD0UGPD95UKIBp+cL+s5rHHXwpojvVXcqWjy8yJdR1PjIKM0t5NY8vJZ1?=
 =?us-ascii?Q?Pu+A8aDYkBeEiMXYaF+9cv1QkuNWvgnGt5GIAZGr1PEkF4KYp0vyJCjv6As0?=
 =?us-ascii?Q?qJDJCfdBmltZ0FkgN9TqNokoFT5BrE34HXUtsudSAsQYP+hSe+oIdiP1RQDi?=
 =?us-ascii?Q?Ue6V+mU0bdm3CuWlJgphFIBu8gOZTWFCdSfOGuUMJG+FhU4mwJY7eUOTuyHK?=
 =?us-ascii?Q?G2B0Xyj+PsgqE0/md1/Axm0SyLWPKup7+yN4ckxb5JhEefgNCoOkQGjI+zpR?=
 =?us-ascii?Q?VnPXr6kEzfI3snveBpeiLuDHuvekigw3XsuimsiuQnT71O4z4PIhX4zg1pOd?=
 =?us-ascii?Q?SQEbPUhUpjwys4L5Bd1VOPjCYY1bLgQtprxhJMjjAnPwpOVwfp2UC705YYLn?=
 =?us-ascii?Q?pOV5E32DgzRk4xu8eShiCFTWnAydGSBVDHbVhnHLOfIamiAgn4lgUK4eOdc5?=
 =?us-ascii?Q?0J9Z8GKDkOqXd+QldXRmBBp3XjvH+q0J1xInzK9PATol78bWA9CXKfksaN7z?=
 =?us-ascii?Q?oTCdxNgnqClF96yU4bAJ+5WDhpBOupxNXf4PLrS492RWw+FAS4ehp9dEuQuW?=
 =?us-ascii?Q?vyxq+YQrbVOnKO9beWu5kfOmuKIlHtbAeYYMDPpPPdRyEytL0xIncE9o2eXt?=
 =?us-ascii?Q?zHSuBwKXEmlviwCf1gsMKZUQu4KpqhsrVlU//cxWmfLzut4mPwAmR5sx9f0m?=
 =?us-ascii?Q?KGQqKKCcQ0TJXKUomqxXZzZYQTH3DzorSxlW8lQYFbK3+9Vr8F7AYCIzhJKS?=
 =?us-ascii?Q?SZexeIhaNZA2VXhKo2H6MylcOBBuQhSxpE3qjFFMxZRz/HBX+fkgrgpaVuHK?=
 =?us-ascii?Q?dZC55ojUnGZdHfKVHh1RBQuJkpnbWfFYvJUUP3v4ST394cO/RFwFCNw1ZhD6?=
 =?us-ascii?Q?rIZ/YS8JY3nkLAPwx79YZqv7fN+sdsCydz8VdrOUInmMB4BCIg4AktcJq5ul?=
 =?us-ascii?Q?KvnSKWOj4orCyZmquV/QkQc2CwG0lKL+ROc+WQHae1OyJtGUj2dM0e/lX0SX?=
 =?us-ascii?Q?gGxVOX6L7FOfXhdv17rFZe9qQgDzj9tYg/2YDCSP8OveC8mt78jHvVVRZoBA?=
 =?us-ascii?Q?FgMd1Cz1LDZzm2etbwIAr8+2QnNhhvYmwY+/gsGAfiHHqjc4pwm/34Az9bEM?=
 =?us-ascii?Q?Vb2cEP9RGL+S6s/B+FD2Qc3c/eTKSV87HfdJK0D8ehC1ETcaoZxC9p08KZrF?=
 =?us-ascii?Q?ezMX/ovJcn6bJkwVlKeVBCkdYe2TIqtHXBbi6buQ3mWBZlTgm7JhzE+TpFlR?=
 =?us-ascii?Q?BjTe1jGWB3RaXeJdAIBdGUNB2aHMSjqYyV3WUO7xsfczeQsvPB4AqH2L4DMB?=
 =?us-ascii?Q?L1qXxuE9GSVpSIycCtUJ/w4R0JvnNzYLFVo+B4frnCloyMdbvvTqcLyGXBTK?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acbaee8-b74d-47a1-0e75-08da73dd246b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 16:44:46.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYfh6QV4M/AeKBT6kHR0agRPH2Sii0mNx5ceitcATYxc9iP0SzaxoJrbFOY1XmmFw/2vq53KES8m/zR1Lft7IRNH5WmKC0ok9Q8JY9jpCGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4122
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
> Link: https://lore.kernel.org/r/7ed50fd8-521e-cade-77b1-738b8bfb8502@oracle.com
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  arch/x86/kernel/cpu/mce/apei.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
> index 717192915f28..2c7ea0ba9dd7 100644
> --- a/arch/x86/kernel/cpu/mce/apei.c
> +++ b/arch/x86/kernel/cpu/mce/apei.c
> @@ -29,15 +29,27 @@
>  void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
>  {
>  	struct mce m;
> +	int lsb = PAGE_SHIFT;
>  
>  	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
>  		return;
>  
> +	/*
> +	 * Even if the ->validation_bits are set for address mask,
> +	 * to be extra safe, check and reject an error radius '0',
> +	 * and fallback to the default page size.
> +	 */
> +	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
> +		lsb = __ffs64(mem_err->physical_addr_mask);
> +		if (lsb == 1)

This was the reason I recommended hweight64 and min_not_zero() as
hweight64 does not have the undefined behavior. However, an even better
option is to just do:

    find_first_bit(&mem_err->physical_addr_mask, PAGE_SHIFT)

...as that trims the result to the PAGE_SHIFT max and handles the zero
case.
