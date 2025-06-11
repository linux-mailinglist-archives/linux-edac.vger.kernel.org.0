Return-Path: <linux-edac+bounces-4112-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CED0CAD5EBF
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jun 2025 21:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EACB1BC3114
	for <lists+linux-edac@lfdr.de>; Wed, 11 Jun 2025 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3F3283151;
	Wed, 11 Jun 2025 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nuzoQiAK"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29E25F7A8;
	Wed, 11 Jun 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668515; cv=fail; b=sj2uV5M+gt/L8nexD/3D2X+VQ2Eyp3MQT0X0+3a8lmrm179VFiqQOq0CmdL/1aogr+mkDmeSrPzLtx/zsDNkOzS/0/bV/TVgDRNiWSVv3NGCfeSglCsKO1dtBomGq9hceUJ1KhHkrwUIz9FuOeVEG6X3cs1qq9YtbemwMP8kMMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668515; c=relaxed/simple;
	bh=7pZ+3xOj5CVnuK/h1gLrOAWIwg3VlgfBW51NDLlmQ1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T+JdLp9cBfAmxWxShPBsQd5u8E0tAOfVMI318HoSUXvF5SqiqgXhu82QzbREZqsfK79w98+qnORy0O9fYUBKdrzMstp95cOgQnLuzxciZBXXUtctSq9izaBLt5gz1QEndGVSkg6SCM2wJCAAy7/k0b8QpR8GgTmYMfTmG1ndTTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nuzoQiAK; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUOH8tzJF4DVE3NBI/ymMsTjh3humeEH++jy+MbVzo5XLCRDjYL4WDDDRF4zLv0t74N1Bp9oYwp0LGcahHbO+RVCi5J2NLm7lgXBsHA7n+PSr3/ZC9PqyT+QVfutZXMxTt96RrBB5CfA5aiwV+9cWh/LGi3f0Q7w2IyRvUOuBsAwETnAOBB9memw6zMv2NhwOXUKK9tDCNX46OK5RLQvbL+hIpXHJuaatyjIYCULRY2HNoPfZRpouLE6NbvpmGfYJ/KfuPxfPfHq44Y/ZBwMg/NE9Yqs8hgASsCByp02kJ0Y3Y+uFWGadkWd6HpSc+TurBB78h1Jx+QzKpsVw2r1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VA2qjjNIgVUUQ51GNcC8LzzNL4EQJSro75VWRtzZzos=;
 b=tj6/DAFKb0J9NMrDkxth8L3EQv19DTscsm/9AqIVzrpVuUECa4O7TqvcqwZGRdqTEW9MDWeftEPokacOjFAwEvCrgV5Au03qBHuWE5lUDk7B80g+gTBRgQl7+4Jcyid+HCgsBt1ZfPFnTsFMMOa0gBeJMNgHUXABH8eiKchmSCBTx/wLS0gfwWd1UbLRL4kCBH+GlFQY1TPI/mIYOfJeH9CemVRUF8Ixb61Pu/0PJ8qhRBAeg63WIrmUcgns4wf3VleDUFJPB09LexNW+O/lLo8UE9CrANnyZjexXA+uBcRIKOQ9f5hwWQyXp65NYk3XUiJBsoHs7Q9h6s7U0R+gCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA2qjjNIgVUUQ51GNcC8LzzNL4EQJSro75VWRtzZzos=;
 b=nuzoQiAKzwn+VhIYJy7qUcobiBmpUTtOVU6ZdliKJpYOQSCFs6+RoazPaiAtguVYF/GaY1wr3Vo+CFVQifNES22Z6d0r1dBWisnNBZQZEvJMXU/wsTMmVwLp0SPPkrE0jReMViqhxLPqlfR4IeQsPTHiuKnxojRXspYH4zsV9/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Wed, 11 Jun
 2025 19:01:49 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8792.038; Wed, 11 Jun 2025
 19:01:48 +0000
Date: Wed, 11 Jun 2025 15:01:36 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, bp@alien8.de,
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
Subject: Re: [PATCH v8 1/2] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <20250611190136.GB288240@yaz-khff2.amd.com>
References: <20250610123725.1652-1-shiju.jose@huawei.com>
 <20250610123725.1652-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610123725.1652-2-shiju.jose@huawei.com>
X-ClientProxiedBy: BN0PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:408:e5::8) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ed4a31-41ce-4b4a-45f0-08dda91a6aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJcujcV7C5+L6By9d9pBBajeiAMR2ox4kOGdFLhV4jHdSRtHb6GGluyVryIA?=
 =?us-ascii?Q?OyF6pCriwpKoGW5dJ97XEV1zwTK5x+0Opc5GgM2/uaKlufvgighx87esvVIK?=
 =?us-ascii?Q?KmzykYCr6mGz5Sw01HnnILUHexCYkt4lwu4V58FFFq8/fOZG2DMBMFbOwMoH?=
 =?us-ascii?Q?PDHdQ1fA0EETneO8n8lSyNV/AFr1EdnR2GdEr9YwQ2sVXF/w1Ou60PkiT1qj?=
 =?us-ascii?Q?UnTwXZEPKe/5LnvBDKqBA4ryYczwqTMQfnZ7pZxOTkr2mMfMWQN5rhyZ5O3u?=
 =?us-ascii?Q?f80pup5GsDlhYJpIF51c8QwDeG1KOeiF4O1u0b4PGLyW6+vXzNamevvGq2kI?=
 =?us-ascii?Q?lNRTj2tI3oSP2Xhl/j+aiT/eyEQlNF/+0ksPMu+lOvyc1i/TJiAfN82A+rCk?=
 =?us-ascii?Q?65M/iyT8/dSFKAyzXMnnSlcaUXyeoVf8sIOQxnvkgibPZihSLITSptcN7NWz?=
 =?us-ascii?Q?QXK1IcS32RzSLQkZAvanaWMleXWbzPXp4CMigNC/sbR9ba/ly3JeuyBvtxNr?=
 =?us-ascii?Q?Lok42cT/ch/p0vLr3JF6aAojQoJi2XNqcQ5I0XU3Fbqrnd28YP7CeiN/xi+s?=
 =?us-ascii?Q?Nt7cH4GwRR/edFA9IC4leCWg+SdWG0OBl9XxG7hamQUGFmK0lfFxLs3ivphM?=
 =?us-ascii?Q?fuAlA51Q6L1C3lhRZQ+QoyAkG/S2z2fl1B9hTD42iZeIkxpsq7WTs5qIs9sb?=
 =?us-ascii?Q?RjHULDrVjk9X4fR6nI1dVGk+5NE7ZLMc+cUnls4haoQLtUtsbFrW4fYFUoMi?=
 =?us-ascii?Q?KbD+EqTe5gYcJOLVPnEdkP3HVmxrA7kVQ75WjUokkSx9aKchqFy2SFYL2+OU?=
 =?us-ascii?Q?MFx2EH3Lwce2EeXOJiRZdycS65jU+7t8ZXfWGcDYyJtJ853j/e9+w8OtJlZE?=
 =?us-ascii?Q?kJ81jQC3GsnBjiXmqs61UXDIPhE1H3mDEAYWSI/sFJ+pVHCjIaw0yns+11MW?=
 =?us-ascii?Q?dKFjltgEmCJBX/07CuAYASEflSDRgLS3XRWZX5ZJWLWlE0mpBdrV+iYYHeCl?=
 =?us-ascii?Q?txUYiI0UEoZ8DYdxidp/ld86r2Xzc0MTdPm6gZR4sutDsA3hTgJKqI2eu5vG?=
 =?us-ascii?Q?rJwDnT4kl6X+BIxcYBSlulBAoLpNjyB9yiixk7pFvzI0/X5a8K8TEnMF92H4?=
 =?us-ascii?Q?QC9Vo0IbSPwR0v1S3LjTaRXeCbVwXJ1Z9bqnrQi/biaqO4g4gpayJJ7qUSj+?=
 =?us-ascii?Q?UTtAnkRUR4+e/wbu1mfiGDXRTpziU1Bjq3siW89jy+oNwU3fsyM+KdAjh3Nf?=
 =?us-ascii?Q?a0olIisuN4HN134vlqwL6kFcqqnZpPz+ma1J3/BPIUTS4CvmL8k7MbreJ/Wn?=
 =?us-ascii?Q?besE6a05fHihIAdxbaB53v+mNBGoJIqP8S5d4vjMbYQXcaiXc4JZFD2zr7mF?=
 =?us-ascii?Q?lK15Lm9OsnFCqUSnoMrDxQmXUK+A+4hoZ9h5enf+gRkRQ9lJks5B6YGxyxYO?=
 =?us-ascii?Q?Pz87AJ8uDbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yp139k03T+D/9coRLpeN6uOX+zxmwroX4mOsnOv//yO0FkOuW5cdn00j5ff6?=
 =?us-ascii?Q?y+DldW6e4SMmzE8KfJqVjNcZYFunoGIQC+RNakUtYnP4rS/WfZQ7Up5r9NIZ?=
 =?us-ascii?Q?Oz8XG4KYtmJVgI/fRJRB6q8WaXZY6BJ5NAGIXtryRQy+g5V3GpQqXry0Zs4B?=
 =?us-ascii?Q?dRO7P5OG8ekFCjeV+A+bzj4wMefm0dsx3pqWwH1aEKgTtPMIdQVVEJpyPuw7?=
 =?us-ascii?Q?yBTg862rN/k3CsKjvxc360ep5bH/I1wubN7vShHURwrO4y3ONPtg7wZso6B7?=
 =?us-ascii?Q?ybMUV6DoDNt3HmLzLd7ZNJlOe7znwad1e0AT2N7RXmmavZ3hjmNGpHGACuVI?=
 =?us-ascii?Q?cLIcXGtaAu7q/Jij+xk8O3NT7EXIUIRlKHZK8TN15HIOBZumvriGcyITZjzv?=
 =?us-ascii?Q?3FevrhBZ9CI4z1iqoyMGXF69adLIzlVWU8IINgQliaYZpsc4V7eqfHtWExD2?=
 =?us-ascii?Q?Lf/viMPk7pYByBJkMPov4L6EEiVSFFNk2sCAR73ooyyXhlVearljZT9gJ5If?=
 =?us-ascii?Q?ZyRFGIslxhK1NUnMCCP2iZPTQodYnMyeNqyL7cla4gUN/whF7/5wCXStZ5Lx?=
 =?us-ascii?Q?8ltX1jhYRy7M+rAHPrc1af0PPCBhBY0U6howl29SXvgEUNHaBzakIvF0CTnW?=
 =?us-ascii?Q?ZwgazVAtHsql17L2nabIhkBEYl6vRI1EI/I24wGwOM2UkyLHvSIYqfIUzEsg?=
 =?us-ascii?Q?AtnSv5BCBo7VYdQaxQqjDAmb0lassLMhwY+BQNUX/hYAEKS+JERMOCxNeyCa?=
 =?us-ascii?Q?EH1NYrtjpoJt/uPhZztdfXWvJJt36/nF22tXO49G4q0QTcmbS/jiG8DfFOax?=
 =?us-ascii?Q?LHo/OGo2kOxCjHvLxBnE9hZ4pQHipZWVkdlEYp4K7hhHyOTis5LfRNlIwCKj?=
 =?us-ascii?Q?dP6f4FST/mu66vYeOx0psG24IeumMeIXzzaP+fzhhVoqRqrJxcgHs2OZCzqe?=
 =?us-ascii?Q?RxI4luleRjdhJOtSc0jO/yEg8UgqAwTWeCXsOU2gkfPRQPMba9gh0k79arqM?=
 =?us-ascii?Q?/pDPvftilNc2Y1OndP22+1adQL+ZNftIy4ZIUAEFN8ZtBA0aiCPPyeTU1B6F?=
 =?us-ascii?Q?wty90wifkrWJWyj0ugpq6/vZkXQjgyGOHxA0kPfdJlASlHCtFUdPA24sWfPm?=
 =?us-ascii?Q?xgMbblcR347sC6Up6fiPndSUO9sRv4Cc+/YWPixtDBNmrbWE0pnvzItGXUik?=
 =?us-ascii?Q?+oBtwuRMgPHtlg6vJrUB6JVnOaxxSLFtgqvI1Uo3LqKAjmWoQx3BUJz8Pe7C?=
 =?us-ascii?Q?NyHB/OM6e3UkrAWz7luSeVSIg311yhCSZ8T1/wq+/Si1HaaIWNzIOB3WhmSm?=
 =?us-ascii?Q?5B6re+BGMGQmJw3ejIu7MMvf0VgUC4MqYJ356d57GmTzymYaPDzXX+z+l3xd?=
 =?us-ascii?Q?+upRl9zBIRhzbQwzmeK2g3U3J9m8192AWAropx3IUn9MCWDJqdRhPHG+wSq9?=
 =?us-ascii?Q?c8W0xGf/GIuLp3vOxrKjmnAs+j9fO/hhEZNyuoQeAkB0ugGaFEmiBQzIt0fD?=
 =?us-ascii?Q?9QmwQhj9UneGeqgJPOqQ0qHvQWKIKP19aPC6mo0Iv9zUnTD2UL26QyeuOVIK?=
 =?us-ascii?Q?BexyMKEY0pWT7rgyuFMZJMfSWwBCLGgAqIchruDW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ed4a31-41ce-4b4a-45f0-08dda91a6aef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 19:01:48.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adLo3loDqwmLyZb1rf5zY9PU1Q/C5Hz29iIdGAAGffrrcdwzP0pWBU63xtumPKyMu57u4u3wzie3eDuo2yWAng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950

On Tue, Jun 10, 2025 at 01:37:23PM +0100, shiju.jose@huawei.com wrote:
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
>  drivers/acpi/ras2.c   | 450 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/ras2.h   |  54 +++++
>  5 files changed, 519 insertions(+)
>  create mode 100644 drivers/acpi/ras2.c
>  create mode 100644 include/acpi/ras2.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7bc40c2735ac..846b27b49024 100644
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
> index d1b0affb844f..abfec6745724 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -105,6 +105,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
> +obj-$(CONFIG_ACPI_RAS2)		+= ras2.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>  obj-$(CONFIG_ACPI_PFRUT)	+= pfr_update.o pfr_telemetry.o
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index c2ab2783303f..5b4f04a4611c 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -31,6 +31,7 @@
>  #include <acpi/apei.h>
>  #include <linux/suspend.h>
>  #include <linux/prmt.h>
> +#include <acpi/ras2.h>
>  
>  #include "internal.h"
>  
> @@ -1474,6 +1475,8 @@ static int __init acpi_init(void)
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
> index 000000000000..97ca3feac2fe
> --- /dev/null
> +++ b/drivers/acpi/ras2.c
> @@ -0,0 +1,450 @@
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
> + * HW platform which supports ACPI RAS2. Driver adds auxiliary devices
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
> +/**
> + * struct ras2_pcc_subspace - Data structure for PCC communication
> + * @mbox_client:	struct mbox_client object
> + * @pcc_chan:		Pointer to struct pcc_mbox_chan
> + * @comm_addr:		Pointer to RAS2 PCC shared memory region
> + * @elem:		List for registered RAS2 PCC channel subspaces
> + * @pcc_lock:		PCC lock to provide mutually exclusive access
> + *			to PCC channel subspace
> + * @deadline_us:	Poll PCC status register timeout in micro secs
> + *			for PCC command complete
> + * @pcc_mpar:		Maximum Periodic Access Rate(MPAR) for PCC channel
> + * @pcc_mrtt:		Minimum Request Turnaround Time(MRTT) in micro secs
> + *			OS must wait after completion of a PCC command before
> + *			issue next command
> + * @last_cmd_cmpl_time:	completion time of last PCC command
> + * @last_mpar_reset:	Time of last MPAR count reset.
> + * @mpar_count:		MPAR count
> + * @pcc_id:		Identifier of the RAS2 platform communication channel
> + * @pcc_chnl_acq:	Status of PCC channel acquired.
> + * @kref:		kref object
> + */
> +struct ras2_pcc_subspace {
> +	struct mbox_client		mbox_client;
> +	struct pcc_mbox_chan		*pcc_chan;
> +	struct acpi_ras2_shmem __iomem	*comm_addr;
> +	struct list_head		elem;
> +	struct mutex			pcc_lock;
> +	unsigned int			deadline_us;
> +	unsigned int			pcc_mpar;
> +	unsigned int			pcc_mrtt;
> +	ktime_t				last_cmd_cmpl_time;
> +	ktime_t				last_mpar_reset;
> +	int				mpar_count;
> +	int				pcc_id;
> +	bool				pcc_chnl_acq;
> +	struct kref			kref;
> +};
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

The u32 variables can be on the same line.

> +
> +	/*
> +	 * As per ACPI spec, the PCC space will be initialized by
> +	 * platform and should have set the command completion bit when
> +	 * PCC can be used by OSPM.
> +	 *
> +	 * Poll PCC status register every 3us(delay_us) for maximum of
> +	 * deadline_us(timeout_us) until PCC command complete bit is set(cond).
> +	 */
> +	rc = readw_relaxed_poll_timeout(&gen_comm_base->status, status,
> +					status & PCC_STATUS_CMD_COMPLETE, 3,
> +					pcc_subspace->deadline_us);
> +	if (rc) {
> +		pr_warn("PCC check channel failed for : %d rc=%d\n",

The first "%d" will look like just a random number to the user. So the
message should include something like "pcc_id %d".

Also, the only failure here (I think) would be a timeout. So the message
could state that explicitly.

> +			pcc_subspace->pcc_id, rc);
> +		return rc;
> +	}
> +
> +	if (status & PCC_STATUS_ERROR) {

The spec says
"If set, an error occurred executing the last command."

So this sounds like a feedback for the last command rather than
indicating a communication channel error.

Maybe the PCC driver can save the "last command", and then this error
condition can have a message to the user.

> +		status &= ~PCC_STATUS_ERROR;
> +		writew_relaxed(status, &gen_comm_base->status);
> +		return -EIO;
> +	}
> +
> +	if (!(status & PCC_STATUS_CMD_COMPLETE))
> +		return -EIO;

This condition is impossible. Either this bit is set or we timed out
earlier.

> +
> +	cap_status = readw_relaxed(&gen_comm_base->set_caps_status);
> +	writew_relaxed(0x0, &gen_comm_base->set_caps_status);
> +	return ras2_report_cap_error(cap_status);
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
> +	struct acpi_ras2_shmem __iomem *gen_comm_base = pcc_subspace->comm_addr;
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
> +	 * Handle the Minimum Request Turnaround Time(MRTT).
> +	 * "The minimum amount of time that OSPM must wait after the completion
> +	 * of a command before issuing the next command, in microseconds."
> +	 */
> +	if (pcc_subspace->pcc_mrtt) {
> +		time_delta = ktime_us_delta(ktime_get(),
> +					    pcc_subspace->last_cmd_cmpl_time);
> +		if (pcc_subspace->pcc_mrtt > time_delta)
> +			udelay(pcc_subspace->pcc_mrtt - time_delta);
> +	}
> +
> +	/*
> +	 * Handle the non-zero Maximum Periodic Access Rate(MPAR).
> +	 * "The maximum number of periodic requests that the subspace channel can
> +	 * support, reported in commands per minute. 0 indicates no limitation."
> +	 *
> +	 * This parameter should be ideally zero or large enough so that it can
> +	 * handle maximum number of requests that all the cores in the system can
> +	 * collectively generate. If it is not, we will follow the spec and just
> +	 * not send the request to the platform after hitting the MPAR limit in
> +	 * any 60s window.
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
> +	/* Write to the shared comm region */
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
> +	 * for pcc_mrtt in addition to CMD_READ.
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
> +static void ras2_list_pcc_release(struct kref *kref)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace =
> +		container_of(kref, struct ras2_pcc_subspace, kref);
> +
> +	guard(mutex)(&ras2_pcc_list_lock);
> +	list_del(&pcc_subspace->elem);
> +	pcc_mbox_free_channel(pcc_subspace->pcc_chan);
> +	kfree(pcc_subspace);
> +}
> +
> +static void ras2_pcc_get(struct ras2_pcc_subspace *pcc_subspace)
> +{
> +	kref_get(&pcc_subspace->kref);
> +}
> +
> +static void ras2_pcc_put(struct ras2_pcc_subspace *pcc_subspace)
> +{
> +	kref_put(&pcc_subspace->kref,  &ras2_list_pcc_release);
> +}
> +
> +static struct ras2_pcc_subspace *ras2_get_pcc_subspace(int pcc_id)
> +{
> +	struct ras2_pcc_subspace *pcc_subspace;
> +
> +	mutex_lock(&ras2_pcc_list_lock);

Use "guard" here?

> +	list_for_each_entry(pcc_subspace, &ras2_pcc_subspaces, elem) {
> +		if (pcc_subspace->pcc_id != pcc_id)
> +			continue;
> +		ras2_pcc_get(pcc_subspace);
> +		mutex_unlock(&ras2_pcc_list_lock);
> +		return pcc_subspace;
> +	}
> +	mutex_unlock(&ras2_pcc_list_lock);
> +
> +	return NULL;
> +}
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
> +	pcc_subspace = ras2_get_pcc_subspace(pcc_id);
> +	if (pcc_subspace) {
> +		ras2_ctx->pcc_subspace	= pcc_subspace;
> +		ras2_ctx->comm_addr	= pcc_subspace->comm_addr;
> +		ras2_ctx->dev		= pcc_subspace->pcc_chan->mchan->mbox->dev;
> +		ras2_ctx->pcc_lock	= &pcc_subspace->pcc_lock;
> +		return 0;
> +	}
> +
> +	pcc_subspace = kzalloc(sizeof(*pcc_subspace), GFP_KERNEL);
> +	if (!pcc_subspace)
> +		return -ENOMEM;
> +
> +	mbox_cl			= &pcc_subspace->mbox_client;
> +	mbox_cl->knows_txdone	= true;
> +
> +	pcc_chan = pcc_mbox_request_channel(mbox_cl, pcc_id);
> +	if (IS_ERR(pcc_chan)) {
> +		kfree(pcc_subspace);
> +		return PTR_ERR(pcc_chan);
> +	}
> +
> +	pcc_subspace->pcc_id		= pcc_id;
> +	pcc_subspace->pcc_chan		= pcc_chan;
> +	pcc_subspace->comm_addr		= acpi_os_ioremap(pcc_chan->shmem_base_addr,
> +							  pcc_chan->shmem_size);
> +	pcc_subspace->deadline_us	= RAS2_NUM_RETRIES * pcc_chan->latency;
> +	pcc_subspace->pcc_mrtt		= pcc_chan->min_turnaround_time;
> +	pcc_subspace->pcc_mpar		= pcc_chan->max_access_rate;
> +	pcc_subspace->mbox_client.knows_txdone	= true;
> +	pcc_subspace->pcc_chnl_acq	= true;
> +
> +	kref_init(&pcc_subspace->kref);
> +
> +	mutex_lock(&ras2_pcc_list_lock);
> +	list_add(&pcc_subspace->elem, &ras2_pcc_subspaces);
> +	ras2_pcc_get(pcc_subspace);
> +	mutex_unlock(&ras2_pcc_list_lock);
> +
> +	ras2_ctx->pcc_subspace	= pcc_subspace;
> +	ras2_ctx->comm_addr	= pcc_subspace->comm_addr;
> +	ras2_ctx->dev		= pcc_chan->mchan->mbox->dev;
> +
> +	mutex_init(&pcc_subspace->pcc_lock);
> +	ras2_ctx->pcc_lock	= &pcc_subspace->pcc_lock;
> +
> +	return 0;
> +}
> +
> +static DEFINE_IDA(ras2_ida);
> +static void ras2_release(struct device *device)
> +{
> +	struct auxiliary_device *auxdev = container_of(device, struct auxiliary_device, dev);
> +	struct ras2_mem_ctx *ras2_ctx = container_of(auxdev, struct ras2_mem_ctx, adev);
> +
> +	ida_free(&ras2_ida, auxdev->id);
> +	ras2_pcc_put(ras2_ctx->pcc_subspace);
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
> +
> +	ras2_ctx->id			= id;
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
> +pcc_free:
> +	ras2_pcc_put(ras2_ctx->pcc_subspace);
> +ctx_free:
> +	kfree(ras2_ctx);
> +
> +	return rc;
> +}

Just curious, would the new "faux" bus work for this use case?

Thanks,
Yazen

