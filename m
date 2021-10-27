Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D000C43D359
	for <lists+linux-edac@lfdr.de>; Wed, 27 Oct 2021 22:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbhJ0U5j (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Oct 2021 16:57:39 -0400
Received: from mail-sn1anam02on2049.outbound.protection.outlook.com ([40.107.96.49]:27270
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244127AbhJ0U5j (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Oct 2021 16:57:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANHDHmrCBHuXwaUXAV0hi3dDytzV+ONsCOx5L+o2sZ3NIo+0Ef9cX3ZJ0og1LcRzIvnjhwqcHVVwRoUkgIG3VwijMuekgUspYvXpRpdui5wfWUmRMJghcq5tYVae5hMEoN5vOiI9pDS1EVDX8Q6Q3dl4vaBm6n5fA1aDaLVomVNr/vKwrhZSNecsp8j/pk9JX4GvfyZWUFcES2mszfFec4DNWdvSMtLgK7AvlJx4aVRltrG/5u+ycLlGSEV3PZ3Lg3gTfmDRezvFY7OqnfFbZPNjxX8IdZclP9ljJcYXlL1cljrstkTo47qb6BtU/uhbCpNjmnIV9JUjVrTVmYzHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctC2svP2PhjUtrkhfkKdwyAzk5K76pPLiewIEc0zUUo=;
 b=Js8BjMqvBbltvGLgxFqiUJI+evbHDYCUfS5EH9uE0BaMvKG72G5QxZ/JkL9RGb9OTGQSMA4twfKC8/y6xf/fIyxgyhqqdOe5bbAtmUezYiLDp23Vdhc4F0JK2yHiOtqIVcM0j/4/gX1RS3UAOJUv4iXwe1WXaevXROn4S7P5TVyXAB1/zzSz2SOh7nqvnuR5Z7wT2s881LDwvg8YLPDsLNcXcUf67ShQ5NslJcUKZY8hlSqPhCiHFCEjCJyizelMf+ddYbS09gdP08KLVGtP4Pn1+ubTbPU6Y2hix6Y7bnv6nE71MNlovhK1vLl+ebLwDfX7D3r5I8ky85GiwH0RHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctC2svP2PhjUtrkhfkKdwyAzk5K76pPLiewIEc0zUUo=;
 b=rjQrHQIIkzLConR+vXJMCYzHFzJmI633TmdHo4IRID0TrbjhCzjD3TbBwhEvT4pJBDKvfnOHs9TdITncL7ven6f9g/OWRM4mCi1IWp7Al63Ehvvw6cWnVCdPiwXh7udBnAuyxQ5iGjcM3aU3d7KFG+Q4xBx9F9D5YnQh4lRKKiE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3474.namprd12.prod.outlook.com (2603:10b6:408:46::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 27 Oct
 2021 20:55:10 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::d075:22bc:12ee:e73e%7]) with mapi id 15.20.4608.018; Wed, 27 Oct 2021
 20:55:09 +0000
Date:   Wed, 27 Oct 2021 20:54:58 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Naveen Krishna Chatradhi <nchatrad@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH v5 1/5] x86/amd_nb: Add support for northbridges on
 Aldebaran
Message-ID: <YXm8or71P9rcukk1@yaz-ubuntu>
References: <20211025145018.29985-1-nchatrad@amd.com>
 <20211025145018.29985-2-nchatrad@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025145018.29985-2-nchatrad@amd.com>
X-ClientProxiedBy: MN2PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:208:239::18) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
Received: from yaz-ubuntu (165.204.25.250) by MN2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:208:239::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Wed, 27 Oct 2021 20:55:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef865e45-818e-4abf-0a9a-08d9998c0fae
X-MS-TrafficTypeDiagnostic: BN8PR12MB3474:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3474D322589C0956788E1337F8859@BN8PR12MB3474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYmt+sexKXWFblkgEw85uHzjyfjPDXOZlBCwUTScDJJBvQ3JmiQ/yQfsPK/7L+gFt3k3YyzfXlVxijh7Vpoahc/xtP0IoFSUD2OkXm3V3dYRW9522sdro3yvWxkmeNfhqx3eqM0SzI3qqBF2R/Ohtl0p5f7Knb7a28SuysWvS1hX8ub1bh1xSadO/ROMmXgx4atq9jNnbwmVfpMQjygSk6x5AtsrmGysGj0ZruqnKPJEaZrLecS13KOCBbfsSPl1DYxAUxHEyF/kIPYgpui1mSg47VTmBPPDigg8S6bO/XnXqbzyL71YbNYJNiVjkjguRLXrrUCUCzcHuvimpegVgDyeks5jryfAgWj3SK4eMilazvDK2PATC/Od1pZTvDKmL8tJHx5j8fNzqWi86IcZFWtK3s04k/bRNTrrbsggpy4QKAgXN8qNnPgH6VFCvj7P5ye5ViW34H48AiB64vuiY9CecVAVrF50Mdr4WB5JgWiDTNxdMtwM5bJJYFppMS++6WeKKtFSBEuv4kZVNFqrTuVRv0npcbZT74RcSbUoaJdGm4K6/huNACOJE9fx55gEY05ua2Pxls2EnDxt3aQINsg9ASRajr58BhPUpqbbw7CCpb5/Pc1w/ArmX1cU0bTmSLdCDBHgASM2Nn7gVbjAVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(55016002)(956004)(6862004)(508600001)(9686003)(26005)(186003)(6496006)(316002)(8676002)(44832011)(5660300002)(6636002)(8936002)(2906002)(4326008)(66556008)(66476007)(6666004)(66946007)(33716001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wMVZFzB4fXta2oUIm1wpmNYZjkrpFHfVxY4HqRbRvUr/gWa5uVEgFay+UOzD?=
 =?us-ascii?Q?sgOVNkOvhTnC3f/JvI4VuqtL/KZtU80IO0o/jpLKVxI37ef7x0O6epI1j2NF?=
 =?us-ascii?Q?nMur4ifT78Dhgvz/OW2wH7gsUBG4hJiu18KBys1YCpB3apOmpdwtE4/kB4ka?=
 =?us-ascii?Q?MGzkfbEn4Z7b0JD4zaH/7cqZi85IEnA3HTqr1DDI1ZRO/bVBTcMDsq/u9f3y?=
 =?us-ascii?Q?vKHlOkLb4ti7MMm6/0EuK83oJihfH7dwTabqtwk3Bo7VtNrsZQEW457vhz3+?=
 =?us-ascii?Q?D3ZijnsmKbUKSWoIAu75qS8NcesROeg0mYH3DWam7uM9E5lBIIcEBpb/4TCf?=
 =?us-ascii?Q?HIiOLZxY+VdtK5tvbx7PO3DjnSkLnG8LS08g7g2T7mmdJDcpCR/Bdd/LFEjc?=
 =?us-ascii?Q?PWUJn/1riZhvGhy+vVWEw9wLdhmGBY1QyBJZ3FwO8KYb168FNXOYK6l/WFT6?=
 =?us-ascii?Q?0n2PRNUaEx0/CHwuX68PYLB3bJ5Ugh46B8TkK/LaaYgfBX7rlGg9zCAnp+ce?=
 =?us-ascii?Q?WRACj0FbrHYmjNioM5OflxfS8e3Xibn/6n49jCm4JB9iPXWENcUAbuML9qQn?=
 =?us-ascii?Q?DcST2nVPd8jutNF9utDXqAw/LoOaQXhbnhXSBBYHWlWOdWINAZKRX8vIR7w3?=
 =?us-ascii?Q?OwVhUnEUnxzydZfOLdYp37IwNZUbDLkK+3XMGP95ylhQOMRD2uzaUaRR3zZY?=
 =?us-ascii?Q?nP6xKLscK5oLtKZ6STLYH6EgylPymBorJMhqn9/o+OHqHY1rl4LJr9SME1r5?=
 =?us-ascii?Q?Gd6GUkeE7srg+GCNAYga1xHq0V9wz82TbbglGDIYkrXzePIbDw+z8QxJ7UiF?=
 =?us-ascii?Q?Vl2fM+gaxnitVb3uQUmRu38UT1u0oG2jLDyjWFib5MS6y1kWwwcM6NKj9wYI?=
 =?us-ascii?Q?9szFG89CnM28Vw/z170tEGzHpY9bUmXodonFrU3pT4GPBcjf3lE4Pcd9YUII?=
 =?us-ascii?Q?gVniT0lXSfaNiegxujuWYJODeJZU+dfgnMVm+TmLkJbpSAU+OCi8goX/FjsA?=
 =?us-ascii?Q?5i2DIKcsjnp/VC+uLIpILtHeVCqAhxlzoBnDzKPbSSb56WetRlUxu1+0IYfS?=
 =?us-ascii?Q?V2zKWqdA3o6ikrGbedXDtckBn64rdyEuo73U3sbHv8qH1uR7WSKgsBQyueTi?=
 =?us-ascii?Q?ZZX6oChdn2inku1PLtUuqTGtvH37y7NFfxzEQ4p3Zeb0torHrRyOw2qn9BKt?=
 =?us-ascii?Q?pZSlJ7V2sBFurVwJTP86UNqPWmBeSzRjbKoyvNSfEf7X13SfN2/rNZ8kkTlm?=
 =?us-ascii?Q?cvt+9p9yeL5lVJzULc4zLQ8uB4gKLy7iKSBR6q9QqH4W4N/1ArRLwLzr62lX?=
 =?us-ascii?Q?0ia4y3/rkjSyrG+7Zy9ahXVowFPJhE22iMmdWfNcni0R0Go84YYlScZAVNB9?=
 =?us-ascii?Q?in4pOU5lQ2Kle8ZL4UK3f+n0uN+1NubluYdVtBx0XGUWqoKa6U89Hf7wzizz?=
 =?us-ascii?Q?EZqJ86MHOVUeqVDV+G/LApPmNTaiFCFxtxqOXJekzF21KUSX0W5HNPznEQhR?=
 =?us-ascii?Q?HDyEu3tetCU7tgMfl0RjvqCRPIU9gQe0t3B7QpQ3Y6K/29a+lQwWhbJxR8Ri?=
 =?us-ascii?Q?hsnpqyhBa23ZgpTAl25JOt6Py3XZRl+CUg8ilUAb+qU5D8OTPglT2oN0zDRB?=
 =?us-ascii?Q?tlWC126ZcBSb9eT+3C7A7mY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef865e45-818e-4abf-0a9a-08d9998c0fae
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 20:55:08.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F99drHBw9OYZQeIez0kQdlNMBR08K5zG3eR9dzSnIdPb2dTzT6z0rqMnoBapfehsPVBynRvNR3PZ/ftdng/fmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3474
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 25, 2021 at 08:20:14PM +0530, Naveen Krishna Chatradhi wrote:
...
> +/* GPU Data Fabric ID Device 24 Function 1 */
> +#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1 0x14d1
> +
> +static struct pci_dev *get_gpu_df_f1(void)
> +{
> +	return pci_get_device(PCI_VENDOR_ID_AMD,
> +			      PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F1, NULL);
> +}
> +
> +/* DF18xF1 registers on Aldebaran GPU */
> +#define REG_LOCAL_NODE_TYPE_MAP		0x144
> +#define REG_RMT_NODE_TYPE_MAP		0x148
> +
> +/*
> + * Newer AMD CPUs and GPUs whose data fabrics can be connected via custom xGMI
> + * links, comes with registers to gather local and remote node type map info.
> + *
> + * "Local Node Type" refers to nodes with the same type as that from which the
> + * register is read, and "Remote Node Type" refers to nodes with a different type.
> + *
> + * This function, reads the registers from GPU DF function 1.
> + * Hence, local nodes are GPU and remote nodes are CPUs.
> + */
> +static int amd_get_node_map(struct pci_dev *pdev)
> +{
> +	struct amd_node_map *nodemap;
> +	u32 tmp;
> +
> +	nodemap = kmalloc(sizeof(*nodemap), GFP_KERNEL);
> +	if (!nodemap)
> +		return -ENOMEM;
> +
> +	pci_read_config_dword(pdev, REG_LOCAL_NODE_TYPE_MAP, &tmp);
> +	nodemap->gpu_node_start_id = tmp & 0xFFF;
> +
> +	pci_read_config_dword(pdev, REG_RMT_NODE_TYPE_MAP, &tmp);
> +	nodemap->cpu_node_count = tmp >> 16 & 0xFFF;
> +
> +	amd_northbridges.nodemap = nodemap;
> +	return 0;
> +}
> +
...
>  int amd_cache_northbridges(void)
>  {
>  	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
>  	const struct pci_device_id *link_ids = amd_nb_link_ids;
>  	const struct pci_device_id *root_ids = amd_root_ids;
> -	struct pci_dev *root, *misc, *link;
> +	struct pci_dev *root, *misc, *link, *dff1;
...
> +	/*
> +	 * The number of miscs, roots and roots_per_misc might vary on different
> +	 * nodes of a heterogeneous system.
> +	 * Calculate roots_per_misc accordingly in order to skip the redundant
> +	 * roots and map the DF/SMN interfaces to correct PCI roots.
> +	 */
> +	if (gpu_root_count && gpu_misc_count) {
> +		dff1 = get_gpu_df_f1();

dff1 is only used in this section, so it can be declared here.

> +		if (!dff1) {
> +			pr_debug("Failed to gather GPU node info.\n");

This message doesn't make sense to me. The failure is that a particular PCI
device was not found. Gathering node info hasn't even been attempted yet.

> +			return -ENODEV;
> +		}
> +
> +		if (amd_get_node_map(dff1))
> +			return -ENOMEM;
> +

Also, why do these functions need to be split up? If it was because of the
return values, then you could have done the following.

		int ret = amd_get_node_map();

		if (ret)
			return ret;

Thanks,
Yazen
