Return-Path: <linux-edac+bounces-4763-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B082CB50274
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD4D17296C
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76B1350D5F;
	Tue,  9 Sep 2025 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k2K0vEYa"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192625D209;
	Tue,  9 Sep 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435091; cv=fail; b=f1R+cMTtzf15HGwru0iw1iV1QUQqwo3BBF20oZpXrpi2Y5gU43NY3Hd5c29HO5WbwM+OO70tFf7Xsc3E6Jrnrm4tn6E9ZbqQZzhMyqVA56zDThfJ5exQIB9/C6qFjsERV/GSGxivCGh1w5FnWD5G1VAQVu5hHoNU84kskr/OMX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435091; c=relaxed/simple;
	bh=KyB3MIiAaVlnNClDnS2Srum2r8JFHEwxrA5XKKuLpHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sIyJv13DNeX/J9sz9UqqYArETO/z2xw5c5Wx85eclztKnJCJs9BwuACaX8dOQSIPNcjHX5jN5ehlO3Z1fDtyTaYcIeHz2at4Ymu+ekHcrbqJMoy3E23q/59LHgGtPGAESK20254Eq8KmlneXDlXEM26Wp+5/eIhW07SWBDPuCnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k2K0vEYa; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INq1TOudiZ1cZfRn93iFYydK6q9sw5M5eycpohprXO6qXUagiXii7w0GzDtW66blC0FpPE9VFLr3EpueQyAT2OWKkRjRrDenfVp7DkyIT/HSGBGM8YcaXYYOwzwYzsnWt1zu0K487Ot9PwtjdDbhzOei2R23Z96+Utf+EeiLWvjKTmJC/9Cf10P0xtkY98dpFb2AnF/Y34iep+boYKX+8yJ2pxQpWoY0sXzISkLHt6GiBGrcSxTYZTSbgoVwwUmOqRcXXMyImPazT++KKoXOacMEmEsInXVhYW7nfFKfcaESYw2YFaMmR5tXmNg7wrqTBwU7j8dSsYCIleN+Qzqfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2xxbcb68LaceO53kIsqpcw/8YOexoQzd7ii5rDhQk8=;
 b=vVLjWTe0J2NL8TgPwn00hN9AUpWdqfE1UNLSjQ/7ETXq9Coazz1jx2omJGgKbACehdGM5QSCwO3wwY3TvL1zAirUJptCg0ImPJ4yXG8UytueKkI7ea0yS9TyjO8OfJ/prIj44dqBtxCu3A0M8ll6wQKCU4fEHVDVj4A/vO7spXnEkdPHm3q0Up8ngbdMCft3pz2utos5MBffCjd2fAOm0lHhvvlllsbp307uQIkCeBVtTHYtK3QwkaTq8HdFtKMhdx0gDG77PWp0AbRqKUfAkkyUWoFkVfkuX/d6y7QI8bTZySLsUVbQbkUS7aBPRwXIhJWJfdRcR+AXZAlbNbWvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2xxbcb68LaceO53kIsqpcw/8YOexoQzd7ii5rDhQk8=;
 b=k2K0vEYaWSpULEB2wTfIaA8HGSQlDaqxV4ZiS3l/0o+qbZbr/KcyS/Gja9gCbM7yHzfdajTVyK/avBMWjN+XgWxIxaMWhGFEwr+9/9gp1JdBB6xlFiCj+g/AkA7vJT8ogmOZn823XnViVkCQF23KNHlTRrySa+F6BuvCip4/qPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 9 Sep 2025 16:24:45 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 16:24:45 +0000
Date: Tue, 9 Sep 2025 12:24:34 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, bp@alien8.de, akpm@linux-foundation.org,
	rppt@kernel.org, dferguson@amperecomputing.com,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org, tony.luck@intel.com,
	lenb@kernel.org, leo.duran@amd.com, mchehab@kernel.org,
	jonathan.cameron@huawei.com, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250909162434.GB11602@yaz-khff2.amd.com>
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902173043.1796-2-shiju.jose@huawei.com>
X-ClientProxiedBy: QB1P288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::46) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 31184d20-a5b5-4cbf-21af-08ddefbd6360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1cnp2JeflL3vlIrZUv2yp9gr2NUk9zeVcuxUO/N7k50SYMtDx31HxB5ll8iB?=
 =?us-ascii?Q?HA1HpBFmG8l/QGb10QJRs1AnTPdLxH17+EtLyp6IKLOl6jTrJyvR1RFNIsCS?=
 =?us-ascii?Q?Yjyrd0IBJDWHE4qmsYb0SgVocCM2whWPjUrCZb31QDgrxF1Cn0xXzFMLvHrc?=
 =?us-ascii?Q?2w1wq7FaAI7B2lFoXR40m49qjkpV8rZ28DOhSYeQtJ3SCSh6k8/HXpC/knP1?=
 =?us-ascii?Q?bWyEEmigAWwFpOJHNl9cdWgcnmTf2KkyCzrgNJWAm1DT5aTJA8V3n8S2gx2c?=
 =?us-ascii?Q?qdrbWEwhIr0rWp4GoWJV34uDBwS3NTnIy7FStLYYI75B8aZJJwhl7z9BRmSL?=
 =?us-ascii?Q?DBr2sE6cxca3RIUgsbmQmcX9/Q7Tp145SfxDP6kyCVGInkF7GQptAqDc34YQ?=
 =?us-ascii?Q?y34MQXKxewVrOpHJMvZKYYiP/c8Q74IvCYfH/PXrqOkuIooJ+zLVHkpJvsrw?=
 =?us-ascii?Q?vU1pyt3WySb7SlxsoLm8eknwQHPbRZXZ4jHmn93TrOKG0KIIsyKphTReh98d?=
 =?us-ascii?Q?u/mVjHPWz+ufPBM4f/HpH2kiNhox2t5RVmgmTN6tYonW6tQed+KjT6xlT2bX?=
 =?us-ascii?Q?pp3FEPidq7CCJaoOn5/xv1/fPMUJWj7zDl2HHZJ75Op+dtrjl35e+11CGnMx?=
 =?us-ascii?Q?sYNspmhG6oTZrNYV/MUvd/cvDp6j0D/DHO+k0/fYZrB/qMnZN6FW+WsWMkJr?=
 =?us-ascii?Q?wDcs+KMS1LDjgvEfSdcX8aptkcDgYhcBHjGcYcnmJbQC2/jCegCcddYbEqUh?=
 =?us-ascii?Q?J6CAHGlAUPQ8WcI/S/NlFwixXTMvzgcpJ7BgldedaZDQGW4JYn5jJT9UVIy8?=
 =?us-ascii?Q?SSIvLhuVHh8wwSJ7j9rx1MxkeWhRBHd8vTM75DfRXnGhIvj3ylRmbM8yQHkP?=
 =?us-ascii?Q?F0MB1Hj325vaPXMEopkiXxn2iH7kgK9mK0WIK0mpjnqN/557tEUP9Zjy6v3U?=
 =?us-ascii?Q?QKKtW8+lyszxYM0L2BdMitL67VMMbACG+/aKxzutUQkUrh3szPhsaroBoH+h?=
 =?us-ascii?Q?eZQfp/PCRrvQgqKLyYLYJLPnYHuE/U6OhC9efS7x04QQ7LcW76LCcyjkpsx4?=
 =?us-ascii?Q?ZUBUuDYH889FMQoZcR5nN9EVZwGl0JZ7vXOgyJ/gGXuPe+GCsSfmEZ6kWANm?=
 =?us-ascii?Q?VdF8oIik2zXkes85gI7bB00GhPPRM6zJ84mPvcrDkJmw12HIQAVfFlNj4Ucb?=
 =?us-ascii?Q?h4pqO4LzbbiQwNmrsX+en3LqHk391+1MZb1jKx+BMaIxn4z5oQxNi3D7zFiH?=
 =?us-ascii?Q?T57vezaAYjYxAX+XQ4YMjxLBqqZvKuv9oOWK4Td882SgEuxkFEKkV/f6NiHy?=
 =?us-ascii?Q?+APxpXBSkVAkmWIIe40q/3aZhE8h5tSvgGlW1ZWoMjoV0AYGZZPzlmceWhVB?=
 =?us-ascii?Q?vEFiCo252fDNgPbbkPSD8gwhUABL+d3YTyuylrmCctv7VOaL5uyYXNiog0sY?=
 =?us-ascii?Q?fmDWLGeqESE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Scuj4S+dGTy/qIV7ldRTLVmSmyjMkAKoG6zcvnHKOOb6IGF6jJEkiwoY9JDv?=
 =?us-ascii?Q?taho7J0wGDsjysci9/7ZihvKgDS+7iqJnkUNJk6GS5TZVTdY6TfBTbMag+ye?=
 =?us-ascii?Q?ShxS5oOjvAuHQ1smDYufpZGPo8uTLqDgxbb6vioEHGm3XWtaESLokFtH55Us?=
 =?us-ascii?Q?/TtuLXcssBgOpGoAnHaI3WM7meL+p8Lj01+bj65viifjUuLU161fzsln6VxB?=
 =?us-ascii?Q?trufsQ+gSfqsU9/cKYYDpCwfSbVZe3LYGNzoZkR6sr7PPVFr942Q6coGX38c?=
 =?us-ascii?Q?ROmksQlBUj5OHJqliZXwI3zqLKsWE5bLSn/UE6cgIVQ+1L9pnBLUn/aw2QpX?=
 =?us-ascii?Q?VWsLB5HpcW0+k2DzCNSBU5As2uiNZUcpW1LmpmCTObvPm3q7zEnWQyJJMmce?=
 =?us-ascii?Q?oOs8EYyOHLLcnhHsZw+Z0BzO7QWfI9lyJRKuGIMzQUGERw2rcFc7ISku1ubQ?=
 =?us-ascii?Q?Ctum8A2KxZxBman5lztaqj7qM2oWtPRYDfqSGGjLzoxW8KliJJ1c52/A4Rd6?=
 =?us-ascii?Q?H2olnS7IOOeBXs07sPipJe5liqWgAaPn99cmbdZloEfdvg1eWA/X9u49U0v1?=
 =?us-ascii?Q?lWFbWhTKLUPAGbK33cbt7WaRlIhGcF9nHX9H2Ysy/42Zxmgj5wjLR73O13B/?=
 =?us-ascii?Q?olR1xsa+YeZCNVlo6n7oKyEagbAcyIEEWjrFO+pdGW35MGmu7OAhpVIyMV+V?=
 =?us-ascii?Q?WfQAw9Xwk9pe5TaiihiH0yjMA96/WWqQOoKy+4znrBXMXSEoNbhuJZ8Dibdc?=
 =?us-ascii?Q?hQsCWloYUIAzX8/SQRNWDyiKRfFBbP1h1McMdUWSlE+HHqNwE7Mee60KAfey?=
 =?us-ascii?Q?pCJ7wvsE2KJtuOslSJl1kxXqkp5IbdhnFERRmx4dgwunvoZAxQwghWARxyCO?=
 =?us-ascii?Q?r8yEuI+wlifxdvC8LY+GVljCIo/kpkSchVPSnINhz+Z7jReOfcMJExsiTfhY?=
 =?us-ascii?Q?3L0D5omTRIKkunE/Z8wmdkG36KZJmFOMehNtVic2GscGXUZ7PDYr66Vr1pkK?=
 =?us-ascii?Q?n0P9h+l1lHe99yVB91HG1mFgbq8+3wocNojXe4FCr75QxrehW7Ivh9zkhIpW?=
 =?us-ascii?Q?AcVOkw8IM+z2gXin8FvgH2XyLzSDqy5Gx9kyOrKp/R9fCDmiunWxvSEFS0yI?=
 =?us-ascii?Q?zbC5rjUJcm74SJpyJU+y2jut7ouX1wny2U2pcDQYQ0OAtzcZ0VDjhOvb2/64?=
 =?us-ascii?Q?JqpuD8LgJQVPZJu2OXcl5Yw5plErCb/WqOimQPa+2W8lWM9ZdaPEQYoDiZB+?=
 =?us-ascii?Q?rit94ghkkvxlF9M/5+FuswoyQaXnQJjWGwZE+lSF7I+1tkWtTcE00TzmemwX?=
 =?us-ascii?Q?ThYgmULLVXTtsmcBTKoj2QTcl2Im65FVMWhQ/4GzU+wcTh9EHiWBfaZK5aIa?=
 =?us-ascii?Q?8BxqPLUZjsEnAyj8tc1/zQgXhBm//GjG+Xdw8Am9BOyOlnI4G4okb+olk4Kh?=
 =?us-ascii?Q?g5z9nE1cBVzZPn39R/gr/VhCI+627iV4XTDa0g5cqkx8ubf1ESomjDqv9Hyp?=
 =?us-ascii?Q?/4gB8MbvTASks85QIePJeqt6019nuQnfclSFVBsrS8dEhsYbbLHdv0+rS501?=
 =?us-ascii?Q?ICunF7ojldFglEYDAR5CekaBVOTYfz/IZv+3sezt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31184d20-a5b5-4cbf-21af-08ddefbd6360
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 16:24:45.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DChgSvNs802DRRLET4aJ6oAecXfzjQ5bmXQjfYHMDh4NLq4AFm9hPsZUZIp3Mat5T9JTUjTnAHcUY9IaU5APeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196

On Tue, Sep 02, 2025 at 06:30:39PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>

[...]

> +static int ras2_add_aux_device(char *name, int channel, u32 pxm_inst)
> +{
> +	unsigned long start_pfn, size_pfn;
> +	struct ras2_mem_ctx *ras2_ctx;
> +	int id, rc;

'rc' is uninitialized, and LLVM gives a warning.

The issue is the "goto ctx_free" paths return 'rc' before it is set.

> +
> +	ras2_ctx = kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
> +	if (!ras2_ctx)
> +		return -ENOMEM;
> +
> +	ras2_ctx->sys_comp_nid = pxm_to_node(pxm_inst);
> +	/*
> +	 * Retrieve the lowest contiguous physical memory address range within
> +	 * the NUMA node.
> +	 */
> +	start_pfn = node_start_pfn(ras2_ctx->sys_comp_nid);
> +	size_pfn = node_spanned_pages(ras2_ctx->sys_comp_nid);
> +	if (!size_pfn) {
> +		pr_debug("Failed to find phy addr range for NUMA node(%u)\n",
> +			 pxm_inst);
> +		goto ctx_free;
> +	}
> +	ras2_ctx->mem_base_addr = __pfn_to_phys(start_pfn);
> +	ras2_ctx->mem_size = __pfn_to_phys(size_pfn);
> +
> +	rc = ras2_register_pcc_channel(ras2_ctx, channel);
> +	if (rc < 0) {
> +		pr_debug("Failed to register pcc channel rc=%d\n", rc);
> +		goto ctx_free;
> +	}
> +
> +	id = ida_alloc(&ras2_ida, GFP_KERNEL);
> +	if (id < 0) {
> +		rc = id;
> +		goto ctx_free;
> +	}
> +
> +	ras2_ctx->adev.id		= id;
> +	ras2_ctx->adev.name		= RAS2_MEM_DEV_ID_NAME;
> +	ras2_ctx->adev.dev.release	= ras2_release;
> +	ras2_ctx->adev.dev.parent	= ras2_ctx->dev;
> +
> +	rc = auxiliary_device_init(&ras2_ctx->adev);
> +	if (rc)
> +		goto ida_free;
> +
> +	rc = auxiliary_device_add(&ras2_ctx->adev);
> +	if (rc) {
> +		auxiliary_device_uninit(&ras2_ctx->adev);
> +		return rc;
> +	}
> +
> +	return 0;
> +
> +ida_free:
> +	ida_free(&ras2_ida, id);
> +ctx_free:
> +	kfree(ras2_ctx);
> +
> +	return rc;
> +}
> +
> +static int acpi_ras2_parse(struct acpi_table_ras2 *ras2_tab)
> +{
> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
> +	int rc;
> +	u16 i;
> +
> +	if (ras2_tab->header.length < sizeof(*ras2_tab)) {
> +		pr_warn(FW_WARN "ACPI RAS2 table present but broken (too short #1)\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!ras2_tab->num_pcc_descs) {
> +		pr_warn(FW_WARN "No PCC descs in ACPI RAS2 table\n");
> +		return -EINVAL;
> +	}
> +
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
> +	for (i = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
> +			continue;
> +
> +		rc = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME,
> +					 pcc_desc_list->channel_id,
> +					 pcc_desc_list->instance);
> +		if (rc)
> +			pr_warn("Failed to add RAS2 auxiliary device rc=%d\n", rc);
> +	}
> +
> +	return 0;

Should this return 'rc' from above? Or is the 'warning' case not a total
failure?

Thanks,
Yazen

