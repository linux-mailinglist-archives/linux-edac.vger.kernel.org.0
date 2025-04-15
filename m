Return-Path: <linux-edac+bounces-3563-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F063A8A9D3
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 23:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B0A19022F5
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A3256C8C;
	Tue, 15 Apr 2025 21:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZMUtiX45"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32F257425;
	Tue, 15 Apr 2025 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744751125; cv=fail; b=XzYZzc4fU9Gi1nZdRpQeROLgG+EUNlVrAAwjIrjs9SxL1tJs//Ax24FoZsr6fYu3hvaZ098xrGnojfOx3qlXgkvveatexHLCe4BFFAef2Ix9hQJioomDzcEdrm+DmNHx25w5ohoDBKzd1GQj86cKVGS9bRa0/OG7SnJiFP/OG/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744751125; c=relaxed/simple;
	bh=WBGMIZ39PK6Wy8TvryfaMoTFamWVFBcZAXIszomQ4DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qVUXmBsixeBgjBeaPKt6PbgsyctOKXiLzW+iFPgnooFv6n8sCwV8bg4W+6LeBBpKInAx4tff8FVcyaTZ6/kDXd5eFSF+wHCiBOU5JaKCiWZvu7bz2Yl/AGvGctyA5iWVnstDnU0Ht15ERUd3H+Z2a+X1D+b5SYl4lRth4YewNn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZMUtiX45; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BE2+5ilsR2bIwtYQXtrzDXnCD394+TltC6Lv4fOrb3iJEMvmC/DYw7LO+kVC5CUUxk8I6ryLeCBDWgfQXpi+OPtVs42mk8kIqRkq+Eg+xLAqb6ApgD2Gu96YIxDI+ntcHWtGlQa5ycWgPnIM6HUpe6MAqRgo7yt+s6cv+9/QNRBvTTf1VwvPyW1hlM8Z60HOEt2BGWindYQOqF0jOCNDiyzlZxMm9U3yJWx8aNraKr780hxp04cgvwLrYEDZc9TZNUJS+CKTAeljH1wgi8QAt9i9b6x5Y4mkUeLAsDBSrLy9JGdOoHvbSVpzOQtaZMIA9NawMqL9QLKcqE2gCQIniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QbCzVhu89s6Ka7PYPoe2qAUkdVG7Gev63ijiYFXDXM=;
 b=WY7jdfJc8Z2WOMxUkW12loav/eS+VIaWZxPkU6jFNIcd1ovN/79d/MfXMyyiQYJz13pCOwt8kFd/fZbADnPWQhSGHaLaIoKTjKaDl2oIgVVcpUGleIjNFRvhQFctsjJJz+epzynjV6E2RdS4VCgeck8MSD+O1fSX4OdaxIlVs3dOSSjwn1ULwXtIjil/oc55Q7Ol+bB41BlXdqz20uKZLHJcO7Cj4r+LT3uwtFXvBBtOysc7chYeBigwlCT9aYq9DqJb0cbS+MjpjGKRpx7uHLAR5jaZmEY9R9Piv5f5H+0HKMb7gGnvwXRrB+iwRln82IkEsYGjLMUwW2vzND5oRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QbCzVhu89s6Ka7PYPoe2qAUkdVG7Gev63ijiYFXDXM=;
 b=ZMUtiX45Isf17MGjcuaVBkuvGa/2oqdqdA7kXMsaz2jf4PtiJMN92ifToO8DSa0VzzlAfNFPm5xWj5y14Tom71lAI7WKKEhCQx57apsVQSr0p0gKQXCU1MVr3y6VIB5fxh8B3MAHjRFbreOK35i5O0uskJ7Rir8AW8gRnVa0Ug4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ1PR12MB6291.namprd12.prod.outlook.com (2603:10b6:a03:456::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:05:14 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:05:14 +0000
Date: Tue, 15 Apr 2025 17:05:04 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: shiju.jose@huawei.com
Cc: linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, bp@alien8.de, rafael@kernel.org,
	tony.luck@intel.com, lenb@kernel.org, leo.duran@amd.com,
	mchehab@kernel.org, jonathan.cameron@huawei.com, linux-mm@kvack.org,
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v3 2/3] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250415210504.GA854098@yaz-khff2.amd.com>
References: <20250402120230.596-1-shiju.jose@huawei.com>
 <20250402120230.596-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402120230.596-3-shiju.jose@huawei.com>
X-ClientProxiedBy: BN9PR03CA0508.namprd03.prod.outlook.com
 (2603:10b6:408:130::33) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ1PR12MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dae052f-8064-4062-9f12-08dd7c61375d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MoAVr2scc5raoo3u71fljBUvDoDInl6Scg7ed79s0QfpDXg+5H3YLPcX+yd?=
 =?us-ascii?Q?wp0LlviHQfcEK/sErMEfHcYI7FCWoeuVjfRQr7luIyYdUbv/O3/96Ig1Vrev?=
 =?us-ascii?Q?v//KUNeGK11hPMXF4l5aq8Xcb05yODlITY+5VG345zoRj/na6iTWkxTiYziA?=
 =?us-ascii?Q?ry/DWxSovkeNGvyVRILOU0iLLXgbLkC1mArv0pO1Ou2fGZbgZz1HqCj5xsPo?=
 =?us-ascii?Q?OYk8OEuOPaStd3y3V6jdW11BGNGkoOqv0pDVakXxBMHqHzUY8PQ8B2gjQVwx?=
 =?us-ascii?Q?5psBxmgnd52KTfODKA92bQ/63c7GQMkrvHDdTObfh8cHbY2lT14QJidbQ7FY?=
 =?us-ascii?Q?WSpLBmF6w57euFKHsyrNUCJhhT1fIVs+cW3ttEAiZ4itR/+umdZOb53hCMe+?=
 =?us-ascii?Q?N9xogWCjtk0PzOMaqUFIyWbSqo7cz8fxsT1jocM0cX9w6ODh2Po+aHLpiKsn?=
 =?us-ascii?Q?9yyUzxJMKSYPbjGjQLaa1VoSiIousTs62uQWbsqS6HWnYpFj5PpnE1Kio7FX?=
 =?us-ascii?Q?3ZPkSr1LUUUw6yODo06GV5w6NdxNGt+ZW4TNsRXWgDUbFrB8ymoCiOzphfF/?=
 =?us-ascii?Q?3/GRJkoDv5sAe3ABkvNoS5BhJoo9v63NcRQFMceswRgVpZzAfGbeNJrQ+YwY?=
 =?us-ascii?Q?oSMJDjmnLG4FO52QQx3hEjoAgKNUM+mShAhPCS7XY8GjMpMH3VQn0Cspzks7?=
 =?us-ascii?Q?pmlp0jG1KsBS8urYAulEn2r5y3t+kj4fgsZEdgkgcJIDFt2/BkAV6eXkZQUx?=
 =?us-ascii?Q?w8Om1k6nGD9bH3Ijpn9yLWE9DVMeZdjR05IF+GNUkfT7WDQdnnQALYG4DFel?=
 =?us-ascii?Q?EABs49giL1FAO9iomywEQn+daVlsEkV5OOCRqsPJj5FNeJ7uFjZnQGQ4wO/w?=
 =?us-ascii?Q?TuwMMkiBRvGhz1dq6anVU9qXoKC6/A2fofpr4d5x9Wf3UEZ7McM0eSJFnWsZ?=
 =?us-ascii?Q?5d+SnY9egzLkdjWE4yG+gK3Pbt90VfxnrjS6BDE4LuRJtIHVl7rkP1wTnxVP?=
 =?us-ascii?Q?FzFRZwyTfPEzp/QRklGBRIP/QCwg6vjWlcXHIEOWtvYFI7Frm8KYaWq1IGGZ?=
 =?us-ascii?Q?MNzS0DksiLaGAMM2JNsXQQqo/rDKcPsqmtEFKrsqbl5VXRynSu2gzBkzckZf?=
 =?us-ascii?Q?OvNO6xVdE8VtQN0abahl1RCGBmU/CaQxrQC25JJlO3nmGxukxZtWyeAPoHKY?=
 =?us-ascii?Q?eIFlMm4gA9xZ3H+idcnNhnGqxSuTmHC7ei0NiYYxusU/d2BQEPZe53g1Y1Wd?=
 =?us-ascii?Q?2XQawFh9rIgRMI0Im28ai9jQayHT/Om+0zwuaswX2BH03BQbgR1N9tYAaGgR?=
 =?us-ascii?Q?ZzcItDcaGduiKluTUzqpLDL3ZCrH+jqC60nn5TSyKoCjnjO2DXqnrBpvuu5m?=
 =?us-ascii?Q?cckh3NA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0XAMMCE6xQsCAtwIBtVZ94rKuqNZUH1ctA5LbCnU3SXYXNmLANey+a64j5uR?=
 =?us-ascii?Q?Io2P+tBrhPcPA6sUPBN6QXSeQoKKU4zpdnSdY32qmX3wYoa4FLTRCIP/mCwQ?=
 =?us-ascii?Q?RzSpUZjLoIXkf/UiGydGPabtY5eVRG4zNTezDS5zls5lLyfMmVhEccvAozri?=
 =?us-ascii?Q?dTv6qoiATDrxeA3KAqgTMdiBCnIYpYz0WdeHy4/2CozsP4W2didS7MEqwiQ8?=
 =?us-ascii?Q?Tf0gbY/+CU6+m5l+0gY+bMADqe6QjbeXxv/5BlmkHDg3UlX4cAHwGZUFAu4n?=
 =?us-ascii?Q?JfeClclC4m8xk9KzaUweqCQhBzv5U5mZfaj9R38Fh+hiWTdxE04M8mfyCBNv?=
 =?us-ascii?Q?nRDkU8bycxI16lchpgCwu3BMI0lFw+wkpSy1JTxH1SHaMD/6ra6b+gnc80MS?=
 =?us-ascii?Q?/UZNXZt/JdNhDEGG6SNN4LB2SOQmTxSIJs+kt9KKnmDvPBG73HPPu86DbO7+?=
 =?us-ascii?Q?yAY/3gNhKOP/ir2wouXudaQzIKETjoycpsahC7ux7ltZrXbBFFqYLlz6+fkr?=
 =?us-ascii?Q?Nujj2GiZEMGLWEX0w//oc+ojRl6mdWQ3iTwKdV/LIkDs7gKbQ42EP6CFyqa1?=
 =?us-ascii?Q?4TkCVpWv9j5JpMzlFPh2M0U1rE27ZtPNkV6QSnHzWP5+cMRROPCk3b7V2ftz?=
 =?us-ascii?Q?+3XTSTsrlobNTaq0U6ytGuutUPox4rqYhufVtEGZrryjRPWUmGiPRhjy2V6S?=
 =?us-ascii?Q?pJ8NQerFcnDKRvOPp62cdNDNz2gNJ4PyP/imD/RpkVXiyDu5ofBskXjGL4GN?=
 =?us-ascii?Q?0Xi2tdhWjCLgFSyNRHCbzWdAbLcJvLAUJykZQqRsf2hf4VmzSHyusYPndiT6?=
 =?us-ascii?Q?tQh+utLsdjNTC5f/afDtSx3DA2N5CNvkNXJpjNk9iVKQzXB60xFkTwezJxBy?=
 =?us-ascii?Q?2yql64/PxshFrIEzz6FvY5ISPhCsgQzUo9ZR3PIygLKGEduBAZgsar5VSksp?=
 =?us-ascii?Q?DMSq3jLH3OLGd9G2swK7Th8t7Xq0VOs3agYd6oJ2QgU5OQK9+fLaXsqKa9uJ?=
 =?us-ascii?Q?uG+ZEko1Me2KiUJhdM3egsi7E8eSBrvpPYl1N9B6HgEMvLJaxWZgqJ5QLmCh?=
 =?us-ascii?Q?5UNBoQXTB644EhGfDzLxFKUZAcUKQ95iGmKYbWOFkmtuxhz6tCmHmwEAtOti?=
 =?us-ascii?Q?PXq8GbClrt2hC5tq0MhjzjpaBd1shDau9PLTO9JDPqzFIPzDuZoMw/WW4cpP?=
 =?us-ascii?Q?knilPrynMrPNbzTqJ9JaKHMZ6jOh9lzuTpt5I3i/h94uVMszj1kMZnAHJ/p3?=
 =?us-ascii?Q?Gi+KxA+Y5GmniUcp297SEKWa7rGCHvWcqTLAMbN9g6FXXS82SH9rtZCOPvP4?=
 =?us-ascii?Q?9QHIjnIEf62ekuyzBy9kgNl5oK0rKEJzVSN8hBHxzoenCAzL3jdIIYkjbZjx?=
 =?us-ascii?Q?jpJjJYmpvvuKj8OmXMg8HF8r+gEbf9NwyCyWCvniSFG2lUfsgZ+oSv9HGdqG?=
 =?us-ascii?Q?TMM13kXRM1ua7slVSTPecQNyeOM40nA10GxYGqhPhluFIS0gTE+kKP80rDH4?=
 =?us-ascii?Q?DXn8szpQomsO+NOuUuUd/6NAZKddSjCkBuEa/ZLxo9j8QFUbhGOu6T+DW1WG?=
 =?us-ascii?Q?asFE2e01KHyNyvwL443dvqNh+WXunXcOyYN1VWii?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dae052f-8064-4062-9f12-08dd7c61375d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:05:14.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2R8ZUX1nKxqxMyoXVBb95V59r3H7oFPp+rdyLAPAHMgZL9h+gYaOBhozuaJwDBx9IRY37nTQg7RZfAywSs8u0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6291

On Wed, Apr 02, 2025 at 01:02:28PM +0100, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for ACPI RAS2 feature table (RAS2) defined in the
> ACPI 6.5 Specification, section 5.2.21.
> Driver defines RAS2 Init, which extracts the RAS2 table and driver
> adds auxiliary device for each memory feature which binds to the
> RAS2 memory driver.
> 
> Driver uses PCC mailbox to communicate with the ACPI HW and the
> driver adds OSPM interfaces to send RAS2 commands.
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Co-developed-by: A Somasundaram <somasundaram.a@hpe.com>
> Signed-off-by: A Somasundaram <somasundaram.a@hpe.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/acpi/Kconfig  |  11 ++
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/bus.c    |   3 +
>  drivers/acpi/ras2.c   | 420 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2.h   |  44 +++++
>  5 files changed, 479 insertions(+)
>  create mode 100644 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index d81b55f5068c..bae9a47c829d 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -293,6 +293,17 @@ config ACPI_CPPC_LIB
>  	  If your platform does not support CPPC in firmware,
>  	  leave this option disabled.
>  
> +config ACPI_RAS2
> +	bool "ACPI RAS2 driver"
> +	select AUXILIARY_BUS
> +	select MAILBOX
> +	select PCC
> +	help
> +	  The driver adds support for ACPI RAS2 feature table(extracts RAS2
> +	  table from OS system table) and OSPM interfaces to send RAS2
> +	  commands via PCC mailbox subspace. Driver adds platform device for
> +	  the RAS2 memory features which binds to the RAS2 memory driver.
> +
>  config ACPI_PROCESSOR
>  	tristate "Processor"
>  	depends on X86 || ARM64 || LOONGARCH || RISCV
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 40208a0f5dfb..797b38cdc2f3 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
> +obj-$(CONFIG_ACPI_RAS2)		+= ras2.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>  obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 058910af82bc..9a0a1582b8c3 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -29,6 +29,7 @@
>  #include <linux/acpi_viot.h>
>  #include <linux/pci.h>
>  #include <acpi/apei.h>
> +#include <acpi/ras2.h>
>  #include <linux/suspend.h>
>  #include <linux/prmt.h>

Is this order intentional?

I believe it's desirable to order them from general to specific, i.e.
linux -> subsystem -> arch, etc., IIUC.

>  
> @@ -1472,6 +1473,8 @@ static int __init acpi_init(void)
>  	acpi_debugger_init();
>  	acpi_setup_sb_notify_handler();
>  	acpi_viot_init();
> +	acpi_ras2_init();
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/acpi/ras2.c b/drivers/acpi/ras2.c
> new file mode 100644
> index 000000000000..69d8afe99b6e
> --- /dev/null
> +++ b/drivers/acpi/ras2.c
> @@ -0,0 +1,420 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Implementation of ACPI RAS2 driver.
> + *
> + * Copyright (c) 2024-2025 HiSilicon Limited.
> + *
> + * Support for RAS2 - ACPI 6.5 Specification, section 5.2.21
> + *
> + * Driver contains ACPI RAS2 init, which extracts the ACPI RAS2 table and
> + * get the PCC channel subspace for communicating with the ACPI compliant
> + * HW platform which supports ACPI RAS2. Driver adds platform devices
> + * for each RAS2 memory feature which binds to the memory ACPI RAS2 driver.
> + */
> +
> +#define pr_fmt(fmt) "ACPI RAS2: " fmt
> +
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/iopoll.h>
> +#include <linux/ktime.h>
> +#include <acpi/pcc.h>
> +#include <acpi/ras2.h>
> +
> +static struct acpi_table_ras2 *__read_mostly ras2_tab;
> +
> +/* Data structure for PCC communication */
> +struct ras2_pcc_subspace {
> +	struct mbox_client mbox_client;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct acpi_ras2_shmem __iomem *comm_addr;
> +	struct list_head elem;
> +	/* Lock to provide mutually exclusive access to PCC channel */
> +	struct mutex pcc_lock;
> +	unsigned int deadline_us;
> +	unsigned int pcc_mpar;
> +	unsigned int pcc_mrtt;
> +	ktime_t last_cmd_cmpl_time;
> +	ktime_t last_mpar_reset;
> +	int mpar_count;
> +	int pcc_id;
> +	u16 ref_count;
> +	bool pcc_chnl_acq;
> +};

I believe the following style would help readability:
https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

> +
> +/*
> + * Arbitrary retries for PCC commands because the remote processor
> + * could be much slower to reply. Keeping it high enough to cover
> + * emulators where the processors run painfully slow.
> + */
> +#define RAS2_NUM_RETRIES 600ULL
> +
> +#define RAS2_FEAT_TYPE_MEMORY 0x00
> +
> +/* Static variables for the RAS2 PCC subspaces */
> +static DEFINE_MUTEX(ras2_pcc_list_lock);
> +static LIST_HEAD(ras2_pcc_subspaces);
> +
> +static int ras2_report_cap_error(u32 cap_status)

This return value is not used in this patch.

> +{
> +	switch (cap_status) {
> +	case ACPI_RAS2_NOT_VALID:
> +	case ACPI_RAS2_NOT_SUPPORTED:
> +		return -EPERM;
> +	case ACPI_RAS2_BUSY:
> +		return -EBUSY;
> +	case ACPI_RAS2_FAILED:
> +	case ACPI_RAS2_ABORTED:
> +	case ACPI_RAS2_INVALID_DATA:
> +		return -EINVAL;
> +	default: /* 0 or other, Success */
> +		return 0;
> +	}
> +}
> +
> +static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)
> +{
> +	struct acpi_ras2_shmem __iomem *gen_comm_base = pcc_subspace->comm_addr;
> +	u32 cap_status;
> +	u16 status;
> +	u32 rc;
> +
> +	/*
> +	 * As per ACPI spec, the PCC space will be initialized by
> +	 * platform and should have set the command completion bit when
> +	 * PCC can be used by OSPM
> +	 *
> +	 * Poll PCC status register every 3us(delay_us) for maximum of
> +	 * deadline_us(timeout_us) until PCC command complete bit is set(cond)
> +	 */
> +	rc = readw_relaxed_poll_timeout(&gen_comm_base->status, status,
> +					status & PCC_STATUS_CMD_COMPLETE, 3,
> +					pcc_subspace->deadline_us);
> +	if (rc) {
> +		pr_warn("PCC check channel failed for : %d rc=%d\n",
> +			pcc_subspace->pcc_id, rc);
> +		return rc;
> +	}
> +
> +	if (status & PCC_STATUS_ERROR) {
> +		cap_status = readw_relaxed(&gen_comm_base->set_caps_status);
> +		ras2_report_cap_error(cap_status);
> +
> +		status &= ~PCC_STATUS_ERROR;
> +		writew_relaxed(status, &gen_comm_base->status);
> +		return -EIO;
> +	}
> +
> +	if (status & PCC_STATUS_CMD_COMPLETE)
> +		return 0;
> +
> +	return -EIO;
> +}
> +
> +/**
> + * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
> + * @ras2_ctx:	pointer to the RAS2 context structure
> + * @cmd:	command to send
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
> +	struct acpi_ras2_shmem *gen_comm_base = pcc_subspace->comm_addr;
> +	struct mbox_chan *pcc_channel;
> +	unsigned int time_delta;
> +	int rc;
> +
> +	rc = ras2_check_pcc_chan(pcc_subspace);
> +	if (rc < 0)
> +		return rc;
> +
> +	pcc_channel = pcc_subspace->pcc_chan->mchan;
> +
> +	/*
> +	 * Handle the Minimum Request Turnaround Time(MRTT)
> +	 * "The minimum amount of time that OSPM must wait after the completion
> +	 * of a command before issuing the next command, in microseconds"
> +	 */
> +	if (pcc_subspace->pcc_mrtt) {
> +		time_delta = ktime_us_delta(ktime_get(),
> +					    pcc_subspace->last_cmd_cmpl_time);
> +		if (pcc_subspace->pcc_mrtt > time_delta)
> +			udelay(pcc_subspace->pcc_mrtt - time_delta);
> +	}
> +
> +	/*
> +	 * Handle the non-zero Maximum Periodic Access Rate(MPAR)
> +	 * "The maximum number of periodic requests that the subspace channel can
> +	 * support, reported in commands per minute. 0 indicates no limitation."
> +	 *
> +	 * This parameter should be ideally zero or large enough so that it can
> +	 * handle maximum number of requests that all the cores in the system can
> +	 * collectively generate. If it is not, we will follow the spec and just
> +	 * not send the request to the platform after hitting the MPAR limit in
> +	 * any 60s window

A number of code comments are missing punctuation.

> +	 */
> +	if (pcc_subspace->pcc_mpar) {
> +		if (pcc_subspace->mpar_count == 0) {
> +			time_delta = ktime_ms_delta(ktime_get(),
> +						    pcc_subspace->last_mpar_reset);
> +			if (time_delta < 60 * MSEC_PER_SEC) {
> +				dev_dbg(ras2_ctx->dev,
> +					"PCC cmd not sent due to MPAR limit");
> +				return -EIO;
> +			}
> +			pcc_subspace->last_mpar_reset = ktime_get();
> +			pcc_subspace->mpar_count = pcc_subspace->pcc_mpar;
> +		}
> +		pcc_subspace->mpar_count--;
> +	}
> +
> +	/* Write to the shared comm region. */
> +	writew_relaxed(cmd, &gen_comm_base->command);
> +
> +	/* Flip CMD COMPLETE bit */
> +	writew_relaxed(0, &gen_comm_base->status);
> +
> +	/* Ring doorbell */
> +	rc = mbox_send_message(pcc_channel, &cmd);
> +	if (rc < 0) {
> +		dev_warn(ras2_ctx->dev,
> +			 "Err sending PCC mbox message. cmd:%d, rc:%d\n", cmd, rc);
> +		return rc;
> +	}
> +
> +	/*
> +	 * If Minimum Request Turnaround Time is non-zero, we need
> +	 * to record the completion time of both READ and WRITE
> +	 * command for proper handling of MRTT, so we need to check
> +	 * for pcc_mrtt in addition to CMD_READ
> +	 */
> +	if (cmd == PCC_CMD_EXEC_RAS2 || pcc_subspace->pcc_mrtt) {
> +		rc = ras2_check_pcc_chan(pcc_subspace);
> +		if (pcc_subspace->pcc_mrtt)
> +			pcc_subspace->last_cmd_cmpl_time = ktime_get();
> +	}
> +
> +	if (pcc_channel->mbox->txdone_irq)
> +		mbox_chan_txdone(pcc_channel, rc);
> +	else
> +		mbox_client_txdone(pcc_channel, rc);
> +
> +	return rc >= 0 ? 0 : rc;
> +}
> +EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
> +
> +static int ras2_register_pcc_channel(struct ras2_mem_ctx *ras2_ctx, int pcc_id)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct mbox_client *mbox_cl;
> +
> +	if (pcc_id < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&ras2_pcc_list_lock);
> +	list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
> +		if (pcc_subspace->pcc_id != pcc_id)
> +			continue;
> +		ras2_ctx->pcc_subspace = pcc_subspace;
> +		ras2_ctx->comm_addr = pcc_subspace->comm_addr;
> +		ras2_ctx->dev = pcc_subspace->pcc_chan->mchan->mbox->dev;
> +		ras2_ctx->pcc_lock = &pcc_subspace->pcc_lock;

Please align these lines on the "=".

> +		pcc_subspace->ref_count++;
> +		mutex_unlock(&ras2_pcc_list_lock);
> +		return 0;

Why does this return early if we find the target 'pcc_id'?

Should we not continue on and set up the subspace?

After writing that ^^^, I thought maybe this is trying to find an
existing pcc_subspace and reuse it for this specific ras2_ctx.

If so, please move this into a helper function. Something like
'get_pcc_subspace()'. If that succeeds, then return early. If that
fails, then continue on to set up a new subspace.

> +	}
> +	mutex_unlock(&ras2_pcc_list_lock);
> +
> +	pcc_subspace = kzalloc(sizeof(*pcc_subspace), GFP_KERNEL);
> +	if (!pcc_subspace)
> +		return -ENOMEM;
> +
> +	mbox_cl = &pcc_subspace->mbox_client;
> +	mbox_cl->knows_txdone = true;

Align on '=', please.

This one, in particular, gave my eyes whiplash.

They did this: <_< , >_> , <_<

:P

> +
> +	pcc_chan = pcc_mbox_request_channel(mbox_cl, pcc_id);
> +	if (IS_ERR(pcc_chan)) {
> +		kfree(pcc_subspace);
> +		return PTR_ERR(pcc_chan);
> +	}
> +
> +	*pcc_subspace = (struct ras2_pcc_subspace) {

Why is the cast needed?

Why not 'pcc_subspace->X' for all these fields?

> +		.pcc_id = pcc_id,
> +		.pcc_chan = pcc_chan,
> +		.comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
> +					     pcc_chan->shmem_size),
> +		.deadline_us = RAS2_NUM_RETRIES * pcc_chan->latency,
> +		.pcc_mrtt = pcc_chan->min_turnaround_time,
> +		.pcc_mpar = pcc_chan->max_access_rate,
> +		.mbox_client = {
> +			.knows_txdone = true,
> +		},
> +		.pcc_chnl_acq = true,
> +	};
> +
> +	mutex_lock(&ras2_pcc_list_lock);
> +	list_add(&pcc_subspace->elem, &ras2_pcc_subspaces);
> +	pcc_subspace->ref_count++;
> +	mutex_unlock(&ras2_pcc_list_lock);

Newline, please.

> +	ras2_ctx->pcc_subspace = pcc_subspace;
> +	ras2_ctx->comm_addr = pcc_subspace->comm_addr;
> +	ras2_ctx->dev = pcc_chan->mchan->mbox->dev;

Align on '=', please.

Newline here also.

> +	mutex_init(&pcc_subspace->pcc_lock);
> +	ras2_ctx->pcc_lock = &pcc_subspace->pcc_lock;
> +
> +	return 0;
> +}
> +
> +static DEFINE_IDA(ras2_ida);
> +static void ras2_remove_pcc(struct ras2_mem_ctx *ras2_ctx)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
> +
> +	guard(mutex)(&ras2_pcc_list_lock);
> +	if (pcc_subspace->ref_count > 0)
> +		pcc_subspace->ref_count--;
> +

Would 'struct kref' be useful in this case (counting references and
freeing)?

> +	if (!pcc_subspace->ref_count) {
> +		list_del(&pcc_subspace->elem);
> +		pcc_mbox_free_channel(pcc_subspace->pcc_chan);
> +		kfree(pcc_subspace);
> +	}
> +}
> +
> +static void ras2_release(struct device *device)
> +{
> +	struct auxiliary_device *auxdev = container_of(device, struct auxiliary_device, dev);
> +	struct ras2_mem_ctx *ras2_ctx = container_of(auxdev, struct ras2_mem_ctx, adev);
> +
> +	ida_free(&ras2_ida, auxdev->id);
> +	ras2_remove_pcc(ras2_ctx);
> +	kfree(ras2_ctx);
> +}
> +
> +static int ras2_add_aux_device(char *name, int channel)
> +{
> +	struct ras2_mem_ctx *ras2_ctx;
> +	int id, rc;
> +
> +	ras2_ctx = kzalloc(sizeof(*ras2_ctx), GFP_KERNEL);
> +	if (!ras2_ctx)
> +		return -ENOMEM;
> +
> +	rc = ras2_register_pcc_channel(ras2_ctx, channel);
> +	if (rc < 0) {
> +		pr_debug("failed to register pcc channel rc=%d\n", rc);
> +		goto ctx_free;
> +	}
> +
> +	id = ida_alloc(&ras2_ida, GFP_KERNEL);
> +	if (id < 0) {
> +		rc = id;
> +		goto pcc_free;
> +	}

This function may benefit from the helpers in <linux/cleanup.h>.

> +
> +	ras2_ctx->id = id;
> +	ras2_ctx->adev.id = id;
> +	ras2_ctx->adev.name = RAS2_MEM_DEV_ID_NAME;
> +	ras2_ctx->adev.dev.release = ras2_release;
> +	ras2_ctx->adev.dev.parent = ras2_ctx->dev;

Align on '='.

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
> +pcc_free:
> +	ras2_remove_pcc(ras2_ctx);
> +ctx_free:
> +	kfree(ras2_ctx);
> +
> +	return rc;
> +}
> +
> +static int acpi_ras2_parse(void)
> +{
> +	struct acpi_ras2_pcc_desc *pcc_desc_list;
> +	u16 i, count;
> +	int pcc_id;
> +	int rc;
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
> +	/* Double scan for the case of only one actual controller */
> +	pcc_id = -1;
> +	for (i = 0, count = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
> +			continue;
> +		if (pcc_id == -1) {
> +			pcc_id = pcc_desc_list->channel_id;
> +			count++;
> +		}
> +		if (pcc_desc_list->channel_id != pcc_id)
> +			count++;
> +	}
> +
> +	/*
> +	 * Workaround for the client platform with multiple scrub devices
> +	 * but uses single PCC subspace for communication.
> +	 */
> +	if (count == 1) {
> +		/* Add auxiliary device and bind ACPI RAS2 memory driver */
> +		rc = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_id);
> +		if (rc)
> +			return rc;
> +
> +		return 0;

Just 'return ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_id);'

> +	}
> +
> +	pcc_desc_list = (struct acpi_ras2_pcc_desc *)(ras2_tab + 1);
> +	for (i = 0; i < ras2_tab->num_pcc_descs; i++, pcc_desc_list++) {
> +		if (pcc_desc_list->feature_type != RAS2_FEAT_TYPE_MEMORY)
> +			continue;
> +
> +		rc = ras2_add_aux_device(RAS2_MEM_DEV_ID_NAME, pcc_desc_list->channel_id);
> +		if (rc)
> +			return rc;

This returns error on the first failure.

What if there was a success before? Does that aux_device need to be
removed?

If not, then why return failure at all? Why not just try to add all
devices? Some may fail and some may succeed.

> +	}
> +
> +	return 0;
> +}
> +
> +void __init acpi_ras2_init(void)
> +{
> +	acpi_status status;
> +	int rc;
> +
> +	status = acpi_get_table(ACPI_SIG_RAS2, 0,
> +				(struct acpi_table_header **)&ras2_tab);
> +	if (ACPI_FAILURE(status) || !ras2_tab) {

I expect the '!ras2_tab' check is redundant.

> +		pr_err("Failed to get table, %s\n", acpi_format_exception(status));
> +		return;
> +	}
> +
> +	rc = acpi_ras2_parse();
> +	if (rc) {

'rc' variable is not used anywhere else.

Just do 'if (acpi_ras2_parse()) {'.

> +		acpi_put_table((struct acpi_table_header *)ras2_tab);
> +		pr_err("Failed to parse RAS2 table\n");
> +	}
> +}
> diff --git a/include/acpi/ras2.h b/include/acpi/ras2.h
> new file mode 100644
> index 000000000000..50530b7cbca2
> --- /dev/null
> +++ b/include/acpi/ras2.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * ACPI RAS2 driver header file
> + *
> + * Copyright (c) 2024-2025 HiSilicon Limited
> + */
> +
> +#ifndef _ACPI_RAS2_H
> +#define _ACPI_RAS2_H
> +
> +#include <linux/acpi.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +struct device;
> +
> +/* ACPI spec 6.5 Table 5.82: PCC command codes used by

Need '/*' on its own line.

> + * RAS2 platform communication channel.
> + */
> +#define PCC_CMD_EXEC_RAS2 0x01
> +
> +#define RAS2_AUX_DEV_NAME "ras2"
> +#define RAS2_MEM_DEV_ID_NAME "acpi_ras2_mem"
> +
> +/* Data structure RAS2 table */
> +struct ras2_mem_ctx {
> +	struct auxiliary_device adev;
> +	/* Lock to provide mutually exclusive access to PCC channel */
> +	struct mutex *pcc_lock;
> +	struct device *dev;
> +	struct acpi_ras2_shmem __iomem *comm_addr;
> +	void *pcc_subspace;
> +	int id;
> +};

This struct can also benefit from the TIP maintainers style guide.

> +
> +#ifdef CONFIG_ACPI_RAS2
> +void __init acpi_ras2_init(void);
> +int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd);
> +#else
> +static inline void acpi_ras2_init(void) { }
> +#endif

Newline here.

> +#endif /* _ACPI_RAS2_H */
> -- 

Thanks,
Yazen

