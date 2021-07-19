Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6593CEF7A
	for <lists+linux-edac@lfdr.de>; Tue, 20 Jul 2021 00:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348183AbhGSWPQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Jul 2021 18:15:16 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:42593
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1386999AbhGSTpU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Jul 2021 15:45:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4sk0zlHtnIxf+u6HofbqaC45JSZyawXgvRX7FTzZr4ZqEI+dzXOZdUs5C0nrEvhGgv9Zl4x6mj75kyOgcGQZKYuA8sw4UwZabFFPG4PRc6ue2jrQVeMa2D8B3gwTAVL/I38mwKW1609yg0uJmfji//J+LRMczriSQ+kmmkWpsKTYvExuLfp0rxB3EKrKd4rvLmiS2TayLXpbA2g5inTGE0xlXvDqAPQXV2kAQK4Huyb1VA57gA9J4sRjDy841etq+S31jfutFmVVVWUJBK/ITCLdo9XKKBjx6hFNnK+xBEY0IbHn1owSyPiZNdgAWt5X0mF8L4tqE8Y8Btuyo7X6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVrg2hM0wBEZ+bgcMscO41zwwPMX0MM2gm28wLhK+G0=;
 b=J4PCAkY1hsSPKjcg6sGRdw6+M4Cq8Q6NcPXYiattW7G1HfgpctxG7jVz2W/6nVI3SxNwOLjkRqdwCJP68zw81QFAYvP9wgC6LWeNv4/Pawn6Vhs/PMHKXD6uFKz3/vsgdpeKfFoaKcKlaJ/L0LppEP3Al3jRYIFEQZE+8U6J8QpjySzTcb9ydRHoiCqVli3thXQKxTW9spFIjGD9h+I4NSX5a/f3wbtCVX6haAcXam8GtykFsV1QcQnAAds0JZdutO503PNNTpbanQ5iXOrWvpoOo8q/7VC7vDbYZz8b2RFU4hrR/xXioDi1MGcDwjIVY6F1hpO7Js/GPDFxZ3CJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVrg2hM0wBEZ+bgcMscO41zwwPMX0MM2gm28wLhK+G0=;
 b=WnqP35jZ5TOLfaRXv3StpJPuOc+oh/XHKHLK675fx88wZeSc94s+3JZRZDCSPKZ4EhrgewKTkiPAbBECM3iSoj3/B1AVfSmmDaWh0brT3Ni+AfX9EPl0FmPFCzGDH+sUR9bOD/nqw7jK7jqFLyg3DycBZQGNr8dxZO8wO/HnLso=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1251.namprd12.prod.outlook.com (2603:10b6:404:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 20:25:57 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::c099:e7a1:249a:a8a2%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 20:25:57 +0000
Date:   Mon, 19 Jul 2021 16:25:54 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org
Subject: Re: [PATCH 2/7] x86/amd_nb: Add support for northbridges on Aldebaran
Message-ID: <20210719202554.GB19451@aus-x-yghannam.amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210630152828.162659-3-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630152828.162659-3-nchatrad@amd.com>
X-ClientProxiedBy: BN6PR12CA0036.namprd12.prod.outlook.com
 (2603:10b6:405:70::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aus-x-yghannam.amd.com (165.204.25.250) by BN6PR12CA0036.namprd12.prod.outlook.com (2603:10b6:405:70::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 20:25:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26fa6c69-dbc3-452c-5ece-08d94af36a29
X-MS-TrafficTypeDiagnostic: BN6PR12MB1251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB125110EB18FEEE10334665E9F8E19@BN6PR12MB1251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbbBysHyy/49I9Od2ySbfDWSa8JVEk5tjYINKA0RUj+aAykQUEc1+DBU5B4kAiXeKdbZ38u0B8oeZwtruR7aYFm0w/0AS/iF0Z/0mBi6WIp4mYwoTFGDrHCVsm1FwHi0kMh0tnk2XRzOZcfhVd6IxxrvXDy8jKlbuYETToBgrJ8wCs/XOh53hV0lCqqtKFqme5rnyklx3tFkcXIMoeVLRsTB2+bEyfOH9hBDuzYNNdO8xyx++A1nUGOmf2elbXmwyveHojedtfeNod+IdsduzyPWyUSiDuKvasBFzL/bH1mIV+5BWfC+mcobH+RaHlPMGIYn6ROCEW///v44bHjE8SiY+Cf7tqqw8d6w35/6Y9gzka1aDsRnwJyYjt+j+GpW7QYXwjdYhLIIHEmKw3Q49LB48LPPd77l4JYwy6evFqFFlTfvhDwPnRz6Lz2D16O1CyZO5YcGPq3p8od8dE8O2i3rkTf6DQNXY9R3vG0gIgRZ1xWu8eoXT8KAKuV13F/mVrjUvaihtYHzBv9HSIBWBXPhfMp7z5CSGT7ECaQIonQWdVsaB9S13V2R1lsYkYPCodABlY75qlrylwShfgHpdrDgxDA2wDTa7RI9RX1HgwGk/ceVCh63orxpmsA6vEMjvSlkt3tJqLN89I5uwHpLmb9WUtADHm13etZ/Qv5FfgbY7Gvm4bSeEq1Y3gTCVD4QqQrhHug3XuK1LrcvxoWN+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(5660300002)(66476007)(66556008)(33656002)(66946007)(38350700002)(38100700002)(478600001)(1076003)(316002)(8676002)(956004)(44832011)(8936002)(7696005)(52116002)(83380400001)(86362001)(186003)(26005)(2906002)(55016002)(6636002)(6862004)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0GD3ts/09jVXmB6W+R7pVViVejgbXigW3Jtjt4Yct+mvJIATdnaFEP23MUYf?=
 =?us-ascii?Q?Xjaqh52CjBMyTXj3qwvlhTU03NEerw9/MkMd+yXHFloh3iyPE0fvW5Mj5ocz?=
 =?us-ascii?Q?gtt2EqNtrK8DD+CVdwAVl4mIPNRHbHWDwC8pIRlULVxo5TUdc6aFglMdVY2y?=
 =?us-ascii?Q?P3B11zAvbFN28o8Ys8l/ndtLDrFxEObnEi+ZPHoeMx8d7kYuwr2QPyk4t11m?=
 =?us-ascii?Q?UVT5xzKsY/g//v9zK/V2vhSpBZ1SVb7bLmXRZaYwHregKCZlhQDqktLjhZz8?=
 =?us-ascii?Q?nSz+VlIWfaU5e0GUHDFkq3vW6SisSsxn3q4bnzVOfbLDlhFAGFVJQQ0ZVl5I?=
 =?us-ascii?Q?FpR8o3NRev5HqWNN0ywziU2zE0qLSeI4VGq7c1Ca/vJzyHPib7SG+3aq8DVy?=
 =?us-ascii?Q?dLC56Ino+fgBTUmLx/LrL4HLeEvOs64jtJ9ISSnYp0/DOYs9XLhNKz+JcxXT?=
 =?us-ascii?Q?12kgxzPfOTe0StHtHzJkmKTCUaedja9hH1F9C8syZO2GUOLYaZJs086CHIEr?=
 =?us-ascii?Q?FHIibg8qD2L9C9J/R8eMDj+Apdu7HB8iE/0ZROcqwsqYXu0dyQsIlKafRI0S?=
 =?us-ascii?Q?eIZRjUoP5x7M8tq21WlUZlVwa9cQIcL/qhWK0Yjis1nWDaihUdG5b4lc3AHd?=
 =?us-ascii?Q?6SwnNesWiKx8Sg19mDxKr9J4Vah44BkSUMDVsvB7wtRbzbtgiiEbSokZfbaP?=
 =?us-ascii?Q?rUd7ReEc9hlKtJJmpsJZdOP8aPqtkzWxakMIFiUUAmRT6uJLezaPpi0F0pX7?=
 =?us-ascii?Q?1hp9SWQGQ0NKNdT0y89+jWnA8MTOyZmg/h5aAvWaEYFYWChOi63ALjkMxWQN?=
 =?us-ascii?Q?iQepnGhAbid6W9AWVnep38jswMQdI2RkbVMIDMXwAXQH5qKpnIU7zqxP4tlY?=
 =?us-ascii?Q?e6vDMUthaf/9+kF2xCFbQFoz6qoNPRIiJv0VVgV1T2U78vc3IJD46/14HdUa?=
 =?us-ascii?Q?kDdwVDiMw2A2Pp9uMwL0SZf33UE/IJgwJdp18kdKRVZ1t4vK+bP7pVzsDC4G?=
 =?us-ascii?Q?yhFfCaIv6mC4GNGQoF7uyzBS/zWpnEu+y5j3aSwnjLlKmeeswp8FB3vsCwWu?=
 =?us-ascii?Q?kq1goiwC1Kau8wwDWNx7GFOiAnPqxNIs8B405FXnGttigjbt88M3bO5aZIZF?=
 =?us-ascii?Q?FQ7eRdxxSMn21FlvYET6PsJqqKljqX/UThOQROG4KNnVEGMi0qeOTVGXdLy/?=
 =?us-ascii?Q?nbIgNPDRbq1aH1O2RUxzUoE0iU/3Qut4j3w+u0sqTQqGVxJLupy/vGOWRiOy?=
 =?us-ascii?Q?9S3bTSyNafAbxiKZ2ySrs6X2cAxr3V5YiWqGMfb8UReB5qtWLCln0dqDgHsc?=
 =?us-ascii?Q?zKZibWHRvuUcwNQuLUYte/lr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fa6c69-dbc3-452c-5ece-08d94af36a29
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 20:25:57.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozikgCgTEO4BqwvP2Bw1Y6OyAUN1El3g58iaO/oX7dkevGe9gusD7fx/iiQPt/jib1SmOaixOLhWP06N4s6iHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1251
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 30, 2021 at 08:58:23PM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> On newer heterogeneous systems from AMD, there is a possibility of
> having GPU nodes along with CPU nodes with the MCA banks. The GPU
> nodes (noncpu nodes) starts enumerating from northbridge index 8.
>

"there is a possibility of having GPU nodes along with CPU nodes with
the MCA banks" doesn't read clearly to me. It could be more explicit.
For example, "On newer systems...the CPUs manages MCA errors reported
from the GPUs. Enumerate the GPU nodes with the AMD NB framework to
support EDAC, etc." or something like this.

Also, "northbridge index" isn't a hardware thing rather it's an internal
Linux value. I think you are referring to the "AMD Node ID" value from
CPUID. The GPUs don't have CPUID, so the "AMD Node ID" value can't be
directly read like for CPUs. But the current hardware implementation is
such that the GPU nodes are enumerated in sequential order based on the
PCI hierarchy, and the first GPU node is assumed to have an "AMD Node
ID" value of 8 (the second GPU node has 9, etc.). With this
implemenation detail, the Data Fabric on the GPU nodes can be accessed
the same way as the Data Fabric on CPU nodes.

> Aldebaran GPUs have 2 root ports, with 4 misc port for each root.
> 

I don't fully understand this sentence. There are 2 "Nodes"/Data Fabrics
per GPU package, but what do "4 misc port for each root" mean? In any
case, is this relevant to this patch?

Also, there should be an imperitive in the commit message, i.e. "Add
...".

> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> ---
>  arch/x86/include/asm/amd_nb.h |  6 ++++
>  arch/x86/kernel/amd_nb.c      | 62 ++++++++++++++++++++++++++++++++---
>  2 files changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index 00d1a400b7a1..e71581cf00e3 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -79,6 +79,12 @@ struct amd_northbridge_info {
>  
>  #ifdef CONFIG_AMD_NB
>  
> +/*
> + * On Newer heterogeneous systems from AMD with CPU and GPU nodes connected
> + * via xGMI links, the NON CPU Nodes are enumerated from index 8
> + */
> +#define NONCPU_NODE_INDEX	8

"Newer" doesn't need to be capatilized. And there should be a period at
the end of the sentence.

I don't think "xGMI links" would mean much to most folks. I think the
implication here is that the CPUs and GPUs are connected directly
together (or rather their Data Fabrics are connected) like is done with
2 socket CPU systems and also within a socket for Multi-chip Module
(MCM) CPUs like Naples.

> +
>  u16 amd_nb_num(void);
>  bool amd_nb_has_feature(unsigned int feature);
>  struct amd_northbridge *node_to_amd_nb(int node);
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 5884dfa619ff..489003e850dd 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -26,6 +26,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT	0x14bb
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4	0x14d4
>

These PCI IDs look correct.

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

I think separating the CPU and non-CPU IDs is a good idea.

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
> @@ -222,15 +250,27 @@ int amd_cache_northbridges(void)
>  		}
>  	}
>  
> -	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
> +	/*
> +	 * The valid amd_northbridges are in between (0 ~ misc_count) and
> +	 * (NONCPU_NODE_INDEX ~ NONCPU_NODE_INDEX + misc_count_noncpu)
> +	 */

This comment isn't clear to me. Is it even necessary?

> +	if (misc_count_noncpu)
> +		/*
> +		 * There are NONCPU Nodes with pci root ports starting at index 8
> +		 * allocate few extra cells for simplicity in handling the indexes
> +		 */

I think this comment can be more explicit. The first non-CPU Node ID
starts at 8 even if there are fewer than 8 CPU nodes. To maintain the
AMD Node ID to Linux amd_nb indexing scheme, allocate the number of GPU
nodes plus 8. Some allocated amd_northbridge structures will go unused
when the number of CPU nodes is less than 8, but this tradeoff is to
keep things relatively simple.

> +		amd_northbridges.num = NONCPU_NODE_INDEX + misc_count_noncpu;
> +	else
> +		amd_northbridges.num = misc_count;

The if-else statements should have {}s even though there's only a single
line of code in each. This is just to make it easier to read multiple
lines. Or the second code comment can be merged with the first outside
the if-else.

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
> @@ -251,6 +291,18 @@ int amd_cache_northbridges(void)
>  			root = next_northbridge(root, root_ids);
>  	}
>  
> +	link = misc = root = NULL;

This line can go inside the if statement below.

I'm not sure it's totally necessary since the GPU devices should be
listed after the CPU devices. But I guess better safe than sorry in case
that implementation detail doesn't hold in the future. If you keep it,
then I think you should do the same above when finding the counts.

> +	if (misc_count_noncpu) {
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
> -- 

Thanks,
Yazen
