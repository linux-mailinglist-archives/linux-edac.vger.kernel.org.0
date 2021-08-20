Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFF23F2F8B
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbhHTPhI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 11:37:08 -0400
Received: from mail-dm6nam10on2068.outbound.protection.outlook.com ([40.107.93.68]:32736
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240952AbhHTPhI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Aug 2021 11:37:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFMY7kMyJ9OUD++o2TUnwfMKcf4hSjwiTc5Pt/MnUjJklQG1qS2mzx4kUeyDUAtN3e+YgtZlZ7/6pdgA75Zhlrpe9pDd+l+N4W2k7lGvCLMTiJhIM0G6FDV74Ywx3iINO2etm8zkLSJUEFCtyTJotDw88yEWniZBTkEpifK5tOjod7OtwZobCw9FmHKpcRRt32xyhDIx8uSo2huKp511iiVpI7gTM3NQKh89KZE4234TJ7ouyteWmH8GhYuEAoT95i2iiLzhgRJtBNFxY814CDvKX0mjI7MurBTZrLNYwcxmL3Xp23QSiDlbQcEeMc+K3P9ZmUgEJhRk7f7EuTEu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re4q+qp5119facL05y/NY3XnTezEJ+THwhF+29r6Osw=;
 b=n6sjrXPoBOnSdgWvsd5vU0v3UhoGzEhaeo6BDL6doNpoKjVh9W2pyZ9pHc7EMZneg6fU1Gc0BAcGuTw4lT6gA+p5xVofyEYVQ7ihN5ouO1FPA5VJKVapCrJqXQBH7Lra+bhd2GzgmmsxJqIaQI2+oAmJoE5aFj8YzNJW5y+R6WiRiHTDtYi9povhBthpPveAXJaAOhaGj8ytncf+qzTzWJs/mr0ZyjLBcdOoLTlxD/XLCeGPkL83M2s7JdRd4UdavwvwzyHLP1T/8BXQj1QWa9nkoRPzNiqsI2m+CFoQQ7PWUkbfOCkvIDz1JyGLXVjtg/w0lbGC/GIzoDOig1CPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Re4q+qp5119facL05y/NY3XnTezEJ+THwhF+29r6Osw=;
 b=IGXVCn9eFhLI7Jfjw5nvmkIGxGaPgWFZz18N5aY2ZzmTPxxqYSBdt3sR2U/0I8M+7sEeVWanE7hqjKZK4z3FbH/j1x9OUqGPyv3aq3TAwr7mtoPYr4PYrzVOsuz7mrxZbk5RjGBuqI/X7WcvGidSeCx2CJcqQA9lySlVnwE9O0A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3475.namprd12.prod.outlook.com (2603:10b6:408:48::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 15:36:25 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::50b9:34d5:d81:f59]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::50b9:34d5:d81:f59%3]) with mapi id 15.20.4415.025; Fri, 20 Aug 2021
 15:36:25 +0000
Date:   Fri, 20 Aug 2021 15:36:17 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v2 1/3] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YR/L8XDyI8A6UR5o@yaz-ubuntu>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210806074350.114614-1-nchatrad@amd.com>
 <20210806074350.114614-2-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806074350.114614-2-nchatrad@amd.com>
X-ClientProxiedBy: BN9PR03CA0622.namprd03.prod.outlook.com
 (2603:10b6:408:106::27) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ubuntu (165.204.25.250) by BN9PR03CA0622.namprd03.prod.outlook.com (2603:10b6:408:106::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 15:36:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1316beb-dde7-44c9-9f85-08d963f044ad
X-MS-TrafficTypeDiagnostic: BN8PR12MB3475:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB347518E4ED8806F0D6DDD75EF8C19@BN8PR12MB3475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8Re3Kl5C3y/9jUKZ+At0Y6T2bHruK+GOOssiI3VV4XjnvZDnbUuxSMX7lzRHxnx/HyiqQE7Y492EJf90qCvB/Dg6/BkxtsHAWP+12wAw/4yrk8jc+cpWWkTeJHKKg1UdAZ0pWzUQ5SDfSAiRTBdyb39S/rjwaalPsZIgDqJruWaD/qWuH686677PRtZjemqoBwsHfDHJ7yvEK43usDCP6aA6rNSHzIW5G4JBROdY5Mw+g8jaVI33AuoYKutbGnrECn/HIgy7nCclYBSAPJaaOguy6n3F1VsdTEx7OKvE0bHmjOLJjORTLKuNxlZwVyrBZ+lownWCOW5lUvu8pxjYCTAr9zSQM2eRjWADdTGBE6IcJJ+IaniwxIx6wZH19rhXogIqKynetM6Mo+3EPQZ/hWVkwg3B06SdF3GHcfjquUX5KJvwpiibAtnB9uWDlg9x/CUNP+ymAixRqgT0ZcWjNl2Htsq3SEnmKxwiqQu/feFL8p1VB3zqgxlyxrhE2QkNqCb7oDAcfaHr+9ps1WpA/rqyS4XhBCNHMO/79cNQHl6aPav6ESd7UyFCr3J1vL9qBk23ZDLcm08P5FEz1ickp0dyopPcSXje2tOtTx8i4uSDyUc439twa7iTA2wEFBHLlI88Nc1ny+3MsPqcaYv+0fhpy8WudXPi5PAvrhUbr+bfuSjxdkE1yklLXOLBybBDcvMWil2AunrvVPIG3Hxs9j4gvtI+dnXHMkDbFNiKYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(9686003)(66946007)(55016002)(66556008)(66476007)(478600001)(316002)(38100700002)(4326008)(6636002)(44832011)(5660300002)(6862004)(6666004)(8676002)(8936002)(83380400001)(966005)(6496006)(26005)(33716001)(2906002)(956004)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3HfKhEVUckON2AMnMsmoiyx6x6Dmyv8NgwIwl3hBSbfFE9uEktHEM3jZgep?=
 =?us-ascii?Q?N2e9YVRFsm1BH3OC3aD49dTAkS7nuZZ7mevWthztpvOOpWwtf6jYbbG67Lsy?=
 =?us-ascii?Q?mRZhepWpOdkpOTTYGNoogcH3ZhGu/u7GZtCqClLoy3sc9prm+67GS+8hufTH?=
 =?us-ascii?Q?Itq2laufc1+I0hzpnp//2lGz5a1U8jw2XkDMDFMD3/cgEDoCo0Dp3be59Uiy?=
 =?us-ascii?Q?kXDtPClt6FGGCWUf071oIQoWz/aSo3WEunR3VMyzbsX+CvUPrMxvQLLDrSxE?=
 =?us-ascii?Q?nHFkZavkgoJsHB+DGmxQ2qJyfFlyuXeLIR/tzMq80ysmo9SLVNVk8aMl644x?=
 =?us-ascii?Q?P6zQwS/QIkqqk/zeo5pTGPEjvrrR/pom0R97nRWprdWcr2ws/BFpZIdDqozC?=
 =?us-ascii?Q?XaCnZGeK1Ac67XEIv3f99neg6RyOHY5Db+PY+qLSX4oVbveI5gFfEEl+TAeQ?=
 =?us-ascii?Q?17S/5oMcLjQZ9Q0pxbFmWj3DdXNM/ChOEUQOCMVyS/BzN1fAbD8qKcy5SWHK?=
 =?us-ascii?Q?+7Tftj3a6s7RcNqtpdKF9XvAnIe45nR0mq0hBFjTqXGVsAoLGdHsxPDzovkH?=
 =?us-ascii?Q?F2TY2aQTj3vZUtYXssIbUTOE898uKszd8hKtEKRRsF5uoJmi+vnR5+yQiMWf?=
 =?us-ascii?Q?M/OyIj6pOKBza/TfunlFajATVMOVCNwZNMsQGoLh3Jlr9Ak1jchTPPH1ixeV?=
 =?us-ascii?Q?5Z1LGVdURCP8EznOPi0YQtpLWjmtkV69VDHN6Vy/i2T1+bPvEJRwxl7oR3U2?=
 =?us-ascii?Q?QASVYaroML/3pvxA7/LK0TQUbtqP1LGmw8s/tiKm24H9tU0HoqRdzgfXZuH3?=
 =?us-ascii?Q?rB1Y0qUx2SIhAogibpTQIVHzDn24UU2bYVd6gk5ZlzzUgI17UjY5FyTDbAc0?=
 =?us-ascii?Q?4UltuG7ezDwcuiAuZZJHvPtV/cHkApkzF69CxUImmnCtI2xTm+MOEotC+7FN?=
 =?us-ascii?Q?XgnjNiPx9uIFG4fr9nZOPB5S7hG2fzgqfVGIQ63wyqGNmuvA82W6duGcLoGw?=
 =?us-ascii?Q?hypuB5u8a5pkNnLd+BOH0sV2hjMIu/2NcMrHTex5nRIVHafgPh3OOD35xwOo?=
 =?us-ascii?Q?thbf5LJBZjr/B4ULKzSduUDKLysu4sOracp7NUiCbK28CCgDXoL5I8z1jhQK?=
 =?us-ascii?Q?GIXQfxhNAmPYKFb8t19u4OPbjKSTpNCr+skfkgNtjsgjVpJGnJHcVVuHsMkB?=
 =?us-ascii?Q?sRkS5SezBZqvl7Y+FRbd03+9t/cQ+/e4hUBVWhshGNMxubtfppSmiCEd+lpB?=
 =?us-ascii?Q?pG4MAi6P5QNVgjy6d+/83R32oR3hX9Zx2XCPIGVgoRUjK6nzkmEnc5GFqPQH?=
 =?us-ascii?Q?hEEYPMf/BE7x/Iwx6Gq6Ftoh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1316beb-dde7-44c9-9f85-08d963f044ad
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 15:36:24.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4hj6tUq9SxgSi99i6ujv3lYIpiUWFBRkglK9FEnhn/U2Aqg2o41bOx03LK5wlfzncFsjPvR839wIg2gOhDxmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3475
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 06, 2021 at 01:13:48PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> On newer systems the CPUs manage MCA errors reported from the GPUs.
> Enumerate the GPU nodes with the AMD NB framework to support EDAC.
> 
> This patch adds necessary code to manage the Aldebaran nodes along with
> the CPU nodes.
> 
> The GPU nodes are enumerated in sequential order based on the
> PCI hierarchy, and the first GPU node is assumed to have an "AMD Node
> ID" value of 8 (the second GPU node has 9, etc.). Each Aldebaran GPU
> package has 2 Data Fabrics, which are enumerated as 2 nodes.
> With this implementation detail, the Data Fabric on the GPU nodes can be
> accessed the same way as the Data Fabric on CPU nodes. 
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
> Changes since v1:
> 1. Modified the commit message and comments in the code
> 2. Squashed patch 1/7: "x86/amd_nb: Add Aldebaran device to PCI IDs"

It's nice to have a link or links to previous patches here.

For example,
https://lkml.kernel.org/r/<Message-ID>

> 
>  arch/x86/include/asm/amd_nb.h | 10 ++++++
>  arch/x86/kernel/amd_nb.c      | 63 ++++++++++++++++++++++++++++++++---
>  include/linux/pci_ids.h       |  1 +
>  3 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index 00d1a400b7a1..f15247422992 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -79,6 +79,16 @@ struct amd_northbridge_info {
>  
>  #ifdef CONFIG_AMD_NB
>  
> +/*
> + * On newer heterogeneous systems the data gabrics of the CPUs and GPUs
> + * are connected directly via a custom links, like is done with
> + * 2 socket CPU systems and also within a socket for Multi-chip Module
> + * (MCM) CPUs like Naples.
> + * The first GPU node(non cpu) is assumed to have an "AMD Node ID" value
> + * of 8 (the second GPU node has 9, etc.).
> + */
> +#define NONCPU_NODE_INDEX	8
> +
>  u16 amd_nb_num(void);
>  bool amd_nb_has_feature(unsigned int feature);
>  struct amd_northbridge *node_to_amd_nb(int node);
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 5884dfa619ff..5597135a18b5 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -26,6 +26,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT	0x14bb
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4	0x14d4
>  
>  /* Protect the PCI config register pairs used for SMN. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -94,6 +96,21 @@ static const struct pci_device_id hygon_nb_link_ids[] = {
>  	{}
>  };
>  
> +static const struct pci_device_id amd_noncpu_root_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT) },
> +	{}
> +};
> +
> +static const struct pci_device_id amd_noncpu_nb_misc_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3) },
> +	{}
> +};
> +
> +static const struct pci_device_id amd_noncpu_nb_link_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4) },
> +	{}
> +};
> +
>  const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[] __initconst = {
>  	{ 0x00, 0x18, 0x20 },
>  	{ 0xff, 0x00, 0x20 },
> @@ -182,11 +199,16 @@ int amd_cache_northbridges(void)
>  	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
>  	const struct pci_device_id *link_ids = amd_nb_link_ids;
>  	const struct pci_device_id *root_ids = amd_root_ids;
> +
> +	const struct pci_device_id *noncpu_misc_ids = amd_noncpu_nb_misc_ids;
> +	const struct pci_device_id *noncpu_link_ids = amd_noncpu_nb_link_ids;
> +	const struct pci_device_id *noncpu_root_ids = amd_noncpu_root_ids;
> +
>  	struct pci_dev *root, *misc, *link;
>  	struct amd_northbridge *nb;
>  	u16 roots_per_misc = 0;
> -	u16 misc_count = 0;
> -	u16 root_count = 0;
> +	u16 misc_count = 0, misc_count_noncpu = 0;
> +	u16 root_count = 0, root_count_noncpu = 0;
>  	u16 i, j;
>  
>  	if (amd_northbridges.num)
> @@ -205,10 +227,16 @@ int amd_cache_northbridges(void)
>  	if (!misc_count)
>  		return -ENODEV;
>  
> +	while ((misc = next_northbridge(misc, noncpu_misc_ids)) != NULL)
> +		misc_count_noncpu++;
> +
>  	root = NULL;
>  	while ((root = next_northbridge(root, root_ids)) != NULL)
>  		root_count++;
>  
> +	while ((root = next_northbridge(root, noncpu_root_ids)) != NULL)
> +		root_count_noncpu++;
> +
>  	if (root_count) {
>  		roots_per_misc = root_count / misc_count;
>  
> @@ -222,15 +250,28 @@ int amd_cache_northbridges(void)
>  		}
>  	}
>  
> -	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
> +	if (misc_count_noncpu) {
> +		/*
> +		 * The first non-CPU Node ID starts at 8 even if there are fewer
> +		 * than 8 CPU nodes. To maintain the AMD Node ID to Linux amd_nb
> +		 * indexing scheme, allocate the number of GPU nodes plus 8.
> +		 * Some allocated amd_northbridge structures will go unused when
> +		 * the number of CPU nodes is less than 8, but this tradeoff is to
> +		 * keep things relatively simple.
> +		 */
> +		amd_northbridges.num = NONCPU_NODE_INDEX + misc_count_noncpu;
> +	} else {
> +		amd_northbridges.num = misc_count;
> +	}
> +
> +	nb = kcalloc(amd_northbridges.num, sizeof(struct amd_northbridge), GFP_KERNEL);
>  	if (!nb)
>  		return -ENOMEM;
>  
>  	amd_northbridges.nb = nb;
> -	amd_northbridges.num = misc_count;
>  
>  	link = misc = root = NULL;
> -	for (i = 0; i < amd_northbridges.num; i++) {
> +	for (i = 0; i < misc_count; i++) {
>  		node_to_amd_nb(i)->root = root =
>  			next_northbridge(root, root_ids);
>  		node_to_amd_nb(i)->misc = misc =
> @@ -251,6 +292,18 @@ int amd_cache_northbridges(void)
>  			root = next_northbridge(root, root_ids);
>  	}
>  
> +	if (misc_count_noncpu) {
> +		link = misc = root = NULL;
> +		for (i = NONCPU_NODE_INDEX; i < NONCPU_NODE_INDEX + misc_count_noncpu; i++) {
> +			node_to_amd_nb(i)->root = root =
> +				next_northbridge(root, noncpu_root_ids);
> +			node_to_amd_nb(i)->misc = misc =
> +				next_northbridge(misc, noncpu_misc_ids);
> +			node_to_amd_nb(i)->link = link =
> +				next_northbridge(link, noncpu_link_ids);
> +		}
> +	}
> +
>  	if (amd_gart_present())
>  		amd_northbridges.flags |= AMD_NB_GART;
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4bac1831de80..d9aae90dfce9 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -554,6 +554,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
> -- 

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen
