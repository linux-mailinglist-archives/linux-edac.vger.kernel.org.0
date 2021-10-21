Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CF94366CF
	for <lists+linux-edac@lfdr.de>; Thu, 21 Oct 2021 17:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhJUPzE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Oct 2021 11:55:04 -0400
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:21089
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231406AbhJUPzE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Oct 2021 11:55:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYvF7rSO65rWfH+7QEoBwOfEYeCNQXg22MTzySwEbXK9ojIjxtmRnLycTmwORN9NeqZjhxtgiSWvkkLMZV2K1aidNRiOZ0kVWcS9ghCscHTeIXYczcZeVPzctvpFEqm1fYHhhw+5QeTWzgVCMXoFet0GfUKzEO8fxhMNGVlYoAgcRRbHqukzuh2QFEQPnzw2XuXUb20bnI33ww/cZKfJsY1MtQojxmu1VfSREYjY+JqjSpwpkpE1/ZcjE9VtmyKC5Xd1s0w8xVtCv5afrCwhDipP8fH5R2PogE7kB0sbyfW+oOMPsP4lknNvSN5th65rpMpOewMTWlL5fZ1g9/J8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA6h60s3TSTSCkP74LFPizSp0jRuNPxOuc1PLKbihqg=;
 b=SB75NoO4xyCK6RDW+TNhJU1APKYkSAVIHRcnksvtcN1j9FubsZ6cU08L0D71VYEpzsY3Xu7A/GSsUsGrv/OZ3yhLtX2CH6Sca9yjXm77rhJcvNko+dKiJsZFZuvcdwBseE9mZXkDMYP14YyuPuwuQoQLQwjJguZcT/dGcsiAbiiuAnrEj5b/q33fNl/KMhjH+XPEIW0uHCWxIxOK7yGvGPMRNR/6RdiNZtfnIS/biLWZic48xyexCf+p0y6RLWUh3BSKyeAeFYmIrKkk3RVZP+OkoqL1y9kr86cvfCMKUdITEKS+2yWKBs7IEpaxwJKsJD7tX6dbyPkTJugHIL/ybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA6h60s3TSTSCkP74LFPizSp0jRuNPxOuc1PLKbihqg=;
 b=IWLCVlKfjrsjICYRvaYVBJt8ENhChLgX9bbX9ZqZ5+/JhJd58XT2A3YTNAVGCjiEEaD6R1XOJojh96xiK/4i6Wg8O/ov3aEuG/ySUfE3rw675WnKfADYBCRihOFg8Wj/Bj0NWfch5/djG3Jimy9HK4zWXdmMrz3Ka9R+Ifx0T9M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN6PR12MB1250.namprd12.prod.outlook.com (2603:10b6:404:17::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Thu, 21 Oct
 2021 15:52:45 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 15:52:45 +0000
Date:   Thu, 21 Oct 2021 15:52:36 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v4 1/4] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YXGMxByfAKr30meK@yaz-ubuntu>
References: <20210823185437.94417-1-nchatrad@amd.com>
 <20211014185400.10451-1-nchatrad@amd.com>
 <20211014185400.10451-2-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014185400.10451-2-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8)
 To BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 15:52:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02d9ce01-685b-4b84-9193-08d994aad297
X-MS-TrafficTypeDiagnostic: BN6PR12MB1250:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1250D6B68C1098D9811DA5BEF8BF9@BN6PR12MB1250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/PEKb/sLAAWzAo0mUIEuSjSdLc81G2IKSnpguXepy8fMRreH9sSE6PgKE0RrTyprIgW6jZlfjK/nlw2oZ5BuUcu6dJvH/DSCAjFnA7yrZXJO6nC7UbBNJ3fPuKb0TrPo2QYmcK+U8qcOrgnSsVNSOlXt9hfoyxe+dogC4mSsidmELjw0+jQeRR2XthAf88Pz1hAtYMQTe5o74FMI9RtditAR6X4f4IlYyHS/yh0hlCFytVkfkjzvTA5k7+hps4rUr7AyDze8AkIcp6bqVQ+v16H2VkFTWX0Z/LxOwGAJCaXjvoTG1mApGIn6SzGaoFjBLwY+oasNj6PvNI9Y/0++3NIaCGUcXE35iKF2o8WWQ4zHqSDFIt7KpjInXL6IKJM746W4tmEyCBeTcj0Ix3B45QLHA7NBb5EfcktuFVgHvjabjHFfuB53drcweUo93kl64/BVwi+mDny5JJCQRSydUeIOKAfZNV6Ux7LcNgx+nUoHndOh1DrgPnO3dk5SqyAJwWp5MGMfsyWBpwl+8bPipY5FbJRULf3wAS3jZQkOHISWIkMvjUkkJEwUl1OnKjmYFbaLSURFaNdrhRCLyMt83KZST596grKnhfVPLk1/25qDYjKdBbpUvlbmIxNXEmSyCODGD5Xf9QePgeHc6Os6vP8ndMUuTI5/h35Q4RRgK1rCJvwHCBo/u238uhoNvA0h7viKO+l2iO5FubGT06pbyrkROZGg+LUyc83ERm8GL8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33716001)(83380400001)(66476007)(26005)(38100700002)(86362001)(6636002)(2906002)(4326008)(8676002)(6862004)(6496006)(186003)(55016002)(5660300002)(316002)(8936002)(30864003)(508600001)(6666004)(9686003)(66556008)(44832011)(966005)(66946007)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LPjOjfLGnBOuCm4sQCsbLxP6bfTYqyKGgYnxqEMMikNB8z1Yb6C0Wparl+xt?=
 =?us-ascii?Q?GErZvPbGKUxJT4N4qAKwSm6nauLTofCzDqcfBW671aIFerKZK0SqmJbWNepB?=
 =?us-ascii?Q?y0YnBLvRMD42rVXr5VcNyHmenczICZzSYZDLASLSHvA4fLhEEuBw7HYkPsS6?=
 =?us-ascii?Q?o449QTKk4ZHbOSyJus4OqqT1bCwg3DS01fXRHz3axGLVZFnapDpEPpj8byQq?=
 =?us-ascii?Q?glz09Q1sK7t65FVBEaCKKnqpfTKfK7UGJnJdJzb7fzZAzHq598G4sSoaHwyi?=
 =?us-ascii?Q?lEDQSxZLXSq5Ivj+LuLQ7zaqxq+ohW7/zXeUBV/zoqhsicj990MIHmTHBG9i?=
 =?us-ascii?Q?zxEJjOhrHqKYOMx0RVCpk1vl6cXGyy4Ff6/XD9E6Sh4Gdyiy2SDFtbfVidOu?=
 =?us-ascii?Q?dyYsxONBpx2Phyt9FRJ63p5tELzM5EjnegyqPclKBEHTMV1+hxht9Fk9Q6Gj?=
 =?us-ascii?Q?6cpIZm5TjbD9QejIuuA71+kmtvk9D2cjayQhGsyJONB7YtBc0VWrKXrRJms4?=
 =?us-ascii?Q?L5Am5ldsS4cKNDRYVPmEBnjGNltJqek+w02wPPQ1nAd+ydcpsuLpftr9pdR0?=
 =?us-ascii?Q?AyYgL6K4XxGl3byopYwLT6DWyMhDAPm+qybpX+EBs3nOG4+BsanoTktH9pHD?=
 =?us-ascii?Q?vGPxVv22333DAiEpYeX1u8MqDGbNsy2MoqP4yfDuXI53Ctw76ajBrj+b3ZsZ?=
 =?us-ascii?Q?D6ZYwaVFJxi13IK5SovN8uUu0j/3pNaCT6NmwyGD11dM4RTp3ozxysu1kEOJ?=
 =?us-ascii?Q?X9g2nLaEz9MaV2+YSsP44kY7vOw2Ehwe68wZkI3NcxFXXd/Brj1rwnglNDvW?=
 =?us-ascii?Q?esiJGfq5Gci8bSsjDoeVha9GAT0IeQ+T3iNzbqq9TYWREsFXbvbHvznr8d/x?=
 =?us-ascii?Q?94CVejRoIWkZvi+v/1czRMCwkqBesuhwjzKWHbYGNQ63nP82ij/R2TQ49Qob?=
 =?us-ascii?Q?TEHWkdW5zurMUBXIhOHyOi+FDd93BJiwAwOJBNz4RplcTYq2KMD2dmcvtSen?=
 =?us-ascii?Q?5jurtIoOWXFKerJenY/hRZ1gJAn6B0Si7h4NNZeqhosX+cXWrdq7gq0rV8b3?=
 =?us-ascii?Q?X57Cf/hvUB2Edz32dfscMOAvEWdFZcwj+VT1KVXZuU5NywBd3NGmkumrwt/Q?=
 =?us-ascii?Q?4OrwxaXCBa0KUc0BaRmbBLHdTbHI+A5eR00v9X+beBVOkF64unzofGEhmELI?=
 =?us-ascii?Q?PZrnNjOll+zrLgJpaXFfkjhEG9JTvoS695xjzfLwDcEtGwPvHiYhoHrjGfyj?=
 =?us-ascii?Q?84lL6U1Cv4JRDz+eHpzVoBW2xJWeP286p4kA9VrTu/JnByyiEtkC1ZS7+iIG?=
 =?us-ascii?Q?WeTOs+PBBp0AaY3fXmgtamUgdXfZeFwO/Ps43Z6Tk520gF3vos0TmWAVy2Oz?=
 =?us-ascii?Q?24LPSfyBFdCXObElSAjJ9/SQDBPyj0hP4JSWQ/+82amx15MqsXAiFuf9rmfo?=
 =?us-ascii?Q?PpK+COgTpYU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d9ce01-685b-4b84-9193-08d994aad297
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 15:52:45.0824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1250
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 15, 2021 at 12:23:57AM +0530, Naveen Krishna Chatradhi wrote:
> From: Muralidhara M K <muralimk@amd.com>
> 
> On newer systems the CPUs manage MCA errors reported from the GPUs.
> Enumerate the GPU nodes with the AMD NB framework to support EDAC.
> 
> GPU nodes are enumerated in sequential order based on the PCI hierarchy,
> and the first GPU node is assumed to have an "AMD Node ID" value after
> CPU Nodes are fully populated.
> 
> Aldebaran is an AMD GPU, GPU drivers are part of the DRM framework
> https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html
> 
> Each Aldebaran GPU has 2 Data Fabrics, which are enumerated as 2 nodes.
> With this implementation detail, the Data Fabric on the GPU nodes can be
> accessed the same way as the Data Fabric on CPU nodes.
> 
> Special handling was necessary in northbridge enumeration as the
> roots_per_misc value is different for GPU and CPU nodes.
> 
> Signed-off-by: Muralidhara M K <muralimk@amd.com>
> Co-developed-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
> Link: https://lkml.kernel.org/r/20210823185437.94417-2-nchatrad@amd.com
> ---
> Changes since v3:
> 1. Use word "gpu" instead of "noncpu" in the patch
> 2. Do not create pci_dev_ids arrays for gpu nodes
> 3. Identify the gpu node start index from DF18F1 registers on the GPU nodes.
>   a. Export cpu node count and gpu start node id
> 
> Changes since v2:
> 1. Added Reviewed-by Yazen Ghannam
> 
> Changes since v1:
> 1. Modified the commit message and comments in the code
> 2. Squashed patch 1/7: "x86/amd_nb: Add Aldebaran device to PCI IDs"
> 
>  arch/x86/include/asm/amd_nb.h |   9 +++
>  arch/x86/kernel/amd_nb.c      | 131 ++++++++++++++++++++++++++++------
>  include/linux/pci_ids.h       |   1 +
>  3 files changed, 118 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
> index 455066a06f60..5898300f11ed 100644
> --- a/arch/x86/include/asm/amd_nb.h
> +++ b/arch/x86/include/asm/amd_nb.h
> @@ -68,10 +68,17 @@ struct amd_northbridge {
>  	struct threshold_bank *bank4;
>  };
>  
> +/* heterogeneous system node type map variables */
> +struct amd_node_map {
> +	u16 gpu_node_start_id;
> +	u16 cpu_node_count;
> +};
> +
>  struct amd_northbridge_info {
>  	u16 num;
>  	u64 flags;
>  	struct amd_northbridge *nb;
> +	struct amd_node_map *nmap;

Just a minor nit, but does the name "nmap" conflict with anything in the
kernel? At first glance it looks like "network" map.

>  };
>  
>  #define AMD_NB_GART			BIT(0)
> @@ -83,6 +90,8 @@ struct amd_northbridge_info {
>  u16 amd_nb_num(void);
>  bool amd_nb_has_feature(unsigned int feature);
>  struct amd_northbridge *node_to_amd_nb(int node);
> +u16 amd_gpu_node_start_id(void);
> +u16 amd_cpu_node_count(void);
>  
>  static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
>  {
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index c92c9c774c0e..54a6a7462f07 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -19,6 +19,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
>  #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
>  #define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT 0x14bb
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
> @@ -28,6 +29,7 @@
>  #define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
>  #define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4 0x14d4
>  
>  /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>  static DEFINE_MUTEX(smn_mutex);
> @@ -40,6 +42,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT) },
>  	{}
>  };
>  
> @@ -63,6 +66,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3) },
>  	{}
>  };
>  
> @@ -81,6 +85,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F4) },
>  	{}
>  };
>  
> @@ -126,6 +131,55 @@ struct amd_northbridge *node_to_amd_nb(int node)
>  }
>  EXPORT_SYMBOL_GPL(node_to_amd_nb);
>  
> +/*
> + * GPU start index and CPU count values on an heterogeneous system,
> + * these values will be used by the AMD EDAC and MCE modules.
> + */
> +u16 amd_gpu_node_start_id(void)
> +{
> +	return (amd_northbridges.nmap) ?
> +		amd_northbridges.nmap->gpu_node_start_id : 0;
> +}
> +EXPORT_SYMBOL_GPL(amd_gpu_node_start_id);
> +
> +u16 amd_cpu_node_count(void)
> +{
> +	return (amd_northbridges.nmap) ?
> +		amd_northbridges.nmap->cpu_node_count : amd_northbridges.num;
> +}
> +EXPORT_SYMBOL_GPL(amd_cpu_node_count);
> +
> +/* DF18xF1 regsters on Aldebaran GPU */
> +#define REG_LOCAL_NODE_TYPE_MAP		0x144
> +#define REG_RMT_NODE_TYPE_MAP		0x148
> +
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1 0x14d1
> +
> +static int amd_get_node_map(void)
> +{
> +	struct amd_node_map *np;
> +	struct pci_dev *pdev = NULL;
> +	u32 tmp;
> +

These lines should be ordered from longest to shortest.

You could even combine the "struct pci_dev" line with the line below. Just
pass NULL to pci_get_device().

> +	pdev = pci_get_device(PCI_VENDOR_ID_AMD,
> +			      PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1, pdev);
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	np = kmalloc(sizeof(*np), GFP_KERNEL);
> +	if (!np)
> +		return -ENOMEM;
> +
> +	pci_read_config_dword(pdev, REG_LOCAL_NODE_TYPE_MAP, &tmp);
> +	np->gpu_node_start_id = tmp & 0xFFF;
> +
> +	pci_read_config_dword(pdev, REG_RMT_NODE_TYPE_MAP, &tmp);
> +	np->cpu_node_count = tmp >> 16 & 0xFFF;
> +

The PCI device, register offsets, and bit fields all look correct.

I think a comment with explanation will be helpful. Something that mentions
how some DF devices have these registers with "Base Node ID" and a "Node
Count" fields. "Local Node Type" refers to nodes with the same type as that
from which the register is read, and "Remote Node Type" refers to nodes with
a different type. So if you read the registers from a GPU node, then "Local"
refers to GPU nodes and "Remote" refers to CPU nodes, and vice versa.

Since this information is only needed with we have CPU+GPU system, we only
need to gather it when we find a GPU device.
 
> +	amd_northbridges.nmap = np;
> +	return 0;
> +}
> +
>  static struct pci_dev *next_northbridge(struct pci_dev *dev,
>  					const struct pci_device_id *ids)
>  {
> @@ -230,6 +284,27 @@ int amd_df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
>  }
>  EXPORT_SYMBOL_GPL(amd_df_indirect_read);
>  
> +struct pci_dev *get_root_devs(struct pci_dev *root,
> +			      const struct pci_device_id *root_ids,
> +			      u16 roots_per_misc)
> +{
> +	u16 j;
> +
> +	/*
> +	 * If there are more PCI root devices than data fabric/
> +	 * system management network interfaces, then the (N)
> +	 * PCI roots per DF/SMN interface are functionally the
> +	 * same (for DF/SMN access) and N-1 are redundant.  N-1
> +	 * PCI roots should be skipped per DF/SMN interface so
> +	 * the following DF/SMN interfaces get mapped to
> +	 * correct PCI roots.
> +	 */
> +	for (j = 0; j < roots_per_misc; j++)
> +		root = next_northbridge(root, root_ids);
> +
> +	return root;
> +}
> +
>  int amd_cache_northbridges(void)
>  {
>  	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
> @@ -237,10 +312,10 @@ int amd_cache_northbridges(void)
>  	const struct pci_device_id *root_ids = amd_root_ids;
>  	struct pci_dev *root, *misc, *link;
>  	struct amd_northbridge *nb;
> -	u16 roots_per_misc = 0;
> -	u16 misc_count = 0;
> -	u16 root_count = 0;
> -	u16 i, j;
> +	u16 roots_per_misc = 0, gpu_roots_per_misc = 0;
> +	u16 misc_count = 0, gpu_misc_count = 0;
> +	u16 root_count = 0, gpu_root_count = 0;
> +	u16 i;
>  
>  	if (amd_northbridges.num)
>  		return 0;
> @@ -252,15 +327,23 @@ int amd_cache_northbridges(void)
>  	}
>  
>  	misc = NULL;
> -	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
> -		misc_count++;
> +	while ((misc = next_northbridge(misc, misc_ids)) != NULL) {
> +		if (misc->device == PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F3)

I think this may need to be extended for future devices. In which case, it may
make sense to go back to the original solution of having another list of IDs
just for GPUs.

I can't say for sure though. So maybe we keep this how you have it and deal
with future systems when we come to them.

> +			gpu_misc_count++;
> +		else
> +			misc_count++;
> +	}
>  
>  	if (!misc_count)
>  		return -ENODEV;
>  
>  	root = NULL;
> -	while ((root = next_northbridge(root, root_ids)) != NULL)
> -		root_count++;
> +	while ((root = next_northbridge(root, root_ids)) != NULL) {
> +		if (root->device == PCI_DEVICE_ID_AMD_ALDEBARAN_ROOT)
> +			gpu_root_count++;
> +		else
> +			root_count++;
> +	}
>  
>  	if (root_count) {
>  		roots_per_misc = root_count / misc_count;
> @@ -275,33 +358,35 @@ int amd_cache_northbridges(void)
>  		}
>  	}
>  
> -	nb = kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
> +	/*
> +	 * The number of miscs, roots and roots_per_misc might vary on different
> +	 * nodes of a heterogeneous system.
> +	 * calculate roots_per_misc accordingly in order to skip the redundant

Capitalize "calculate".

> +	 * roots and map the DF/SMN interfaces to correct PCI roots.
> +	 */
> +	if (gpu_root_count && gpu_misc_count) {
> +		if (amd_get_node_map())
> +			return -ENOMEM;

amd_get_node_map() can return ENODEV and ENOMEM, but only ENOMEM is passed
along here.

I'm not sure that the ENODEV case is necessary. I think you can just return
silently if the GPU PCI ID is not found. In this case, the nmap structure
won't be set, so the code will act as if the system is CPU-only.

Or you can save the return value from amd_get_node_map() and return that.
Maybe this would be the more conservative behavior. We want to give an error
if we found some GPU devices, but we didn't find the one device that we need
to gather the node map info.

Thanks,
Yazen
