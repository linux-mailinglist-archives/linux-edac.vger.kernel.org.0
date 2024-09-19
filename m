Return-Path: <linux-edac+bounces-1892-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B8697CABE
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 16:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D2EB23103
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CD019F438;
	Thu, 19 Sep 2024 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h627rFY7"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40D19F466;
	Thu, 19 Sep 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754799; cv=fail; b=XQG5h2Uzj4WAw7lNPgbjCp6u0GRo9RC3YmWEjhq9elHtpVFccx5CNJQjlWXco/pLlJHZ0s/CY5YeM7jKtMUUlVaLH9EhLiMA2O2OPOfliQ0SEVhHLzgjHQXOWoBVrSfom8/v5qPl711qaATqEAh5luiv/8XPzJUVyNFp0pgdk5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754799; c=relaxed/simple;
	bh=0HorSNVjWkTX9O73QR/q4LyNcpNHqM1NygLPE+1cWsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l7C/lRvAvHz1CcA0XXFmUh9fddXuv98dNmIqUE4t4LxuJqZ7r89Nnk7c5edATNx1WWkJZhHnwvmwnaYw8T0kWdLMWzOuMYpP3pyJPC2TlVePwu6REKjPdeN3yZeBXsaMFCn8Kc7S/hmMUYHcdWBU742Il39xG9xxZ83V9Be8EUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h627rFY7; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCrXDEWwZXdSwDpiAw+9L03JJ6Ga7A2EkXI/apYSt36o9l01ms30blY503mRsTY4unmF8tnVRoW0ykQ9Ah8nZqo9PnGWMSqRltW2sQ6IRCGhBWQrXcYDfcYfFKGJh4oieJ+iM5QytMIDXJCKKEn5ENLxotuvfhMBdy88OKWvxjSn06Jml8IXDbE8zLCn03l3djn6Z/oxwFVjU3CCa2CPuUhnTjlyh0Gn7rWVoNw/p7JpQb9C897AgYTI9yUFFLczY13U7CjVrSp3AfJfW2UxnxWLb+7oHZtIRvFAozYg2lpefzzGIBR3j0IQvfjYceR9KuiegleOGNDA512YpXSrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHMcChA6yWCqU3eJArNk860BZoJsM+fWEzFsm08HEkg=;
 b=RmaLC7UE2+wTk1BooMG5NjdDCmZjn+JmrkAgB9fYpNxu2gSAhkzdiWY/Y0bkAgjhOg6Gol39FmD6dbgwDLDQVjXGaCI+myNsvAoe3UrZVSix5L4c+j3UC3z1bDDRhSyk+VRwzVsRRNfRyyYpQ2fa/EuOkDkVwt2CETLTesrtu9PNuS2VJM1zENmwhPj70b3vcBRcEuBmnU7QxbvxjJQQ2V2TEESloPnujCvc+3OUfc5dbCugOpAP/EPRddiOd0alAPBG/4eAGc1KDTjsTfpE5LP0lagx67MCNpqEyv58nN2K/2eU9V+O/vUl/lpC6KjsOdPeLDROGdEeQsW4ZuK04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHMcChA6yWCqU3eJArNk860BZoJsM+fWEzFsm08HEkg=;
 b=h627rFY7Msp9N0oKfqDahhLq9NdQQQREStAXW/Iqa1QjiRI6AuIJD68QDq6dZT5wFG/olpng04Ig4YwXSNRj94We9TJym4b8qvbRJ/yen7fu+SzM7xot8oaUeBhjyJ2ap1YF5znmzLtQSFo5JpDnbhE1eCq0WRbEIHB/3LpRxw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.17; Thu, 19 Sep 2024 14:06:34 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 14:06:34 +0000
Date: Thu, 19 Sep 2024 10:06:23 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	tony.luck@intel.com, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, CobeChen@zhaoxin.com,
	TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: Re: [PATCH v3 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Message-ID: <20240919140623.GB3717@yaz-khff2.amd.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-4-TonyWWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918055436.15551-4-TonyWWang-oc@zhaoxin.com>
X-ClientProxiedBy: BN9PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:408:ff::17) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH2PR12MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: 685db032-b543-453c-42e9-08dcd8b44510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xWrKuDO6iSUDc59vncSLMJekyzicCnyRebBkZ2tVvwXmSl4yByZvjqsojOPJ?=
 =?us-ascii?Q?VhbzVnmYiTFauwa8cqDHwKj1sd0AInQuaeukNYFKb3Rx1VTLypT4safRUSeS?=
 =?us-ascii?Q?JYiNv7cRgUt/D1Xs+wRCTEnFVL3fClqx2jc/PwmMXQeFQpPEV8+P8/ohD+wv?=
 =?us-ascii?Q?Qq8IEnXxouW08pC+aQ7rxrD0v6f2tAZE4ESTKWJQ8T5JunfCM8++g7ZQi4jX?=
 =?us-ascii?Q?23mF3p19Ueyqn6zMr36FfapKB8r9pKIycalkfw/Golj1RN/BozITj9oYS/V8?=
 =?us-ascii?Q?MnfqhF3tvM8p+jw7A6lsHp0zDFOmeikDyTm0Xpmk8B9LXesSMdZR1+MWWRU8?=
 =?us-ascii?Q?0tKXS9/tG4VQENGINRzOrpf1iqlx05iH/ztZc4JJuH3qn40zS09nU0/oOuAu?=
 =?us-ascii?Q?lRejo/RhqrCk4F6I6EorbIOOsUXHnKyj9z0fwXNipfdr+K6Zt4+ZTTuQF1Q9?=
 =?us-ascii?Q?ddNzVn2i5vBVjV+RjtZp5isZUEUHK/m3MKVAXA152r6d7xEJfg6eT9VhWZ7A?=
 =?us-ascii?Q?4s3Mlve0IgS+gDeSrzPqK1KzIwU+BE+6u+vGbTQLa6DBHv88iunMynV+dxbR?=
 =?us-ascii?Q?AB2Veg/GWEC3NGUTzK4P+tgda4mNbkzQpfY7OKAl/E+ZWWOqORE4OV2pI9p3?=
 =?us-ascii?Q?7F/hxR34UERxTWorLGIxoADOwcA16VknMEp1b36Ps03zQwHyPnHl7C2uNgZj?=
 =?us-ascii?Q?QThsz5dmzHqjJ+mIyH+PIM2X/cDrjF1GY2PLOKuzrX+AE8skxrHhKutVYfvG?=
 =?us-ascii?Q?H6ptGIlf6vu1iND1VBhfx4pogXG9oavr8jocnD3yr9LNSrluzCz2G0S+c+5Y?=
 =?us-ascii?Q?DYfF8/k5AFZP1S6vftkRenbNpeHNIvDhyT29V4vQs2wiBMYCWugPegeDg4H7?=
 =?us-ascii?Q?h0y9f5tmSkPqb4bJX0tpNjRzIZCN5wfHclABhzDEPEh/SryvfkvsJ/6p5jNY?=
 =?us-ascii?Q?G1e2pyB5aGX5NP8PkTQQ/N7htH/3DvjqKJSEWF5JKQBVaEzvyDr2DI550fv7?=
 =?us-ascii?Q?xYL70vxoXmZ3XD8YtTiIhu47YF123fr6vE612iF3DWpvvgM9dSo5dX95jziU?=
 =?us-ascii?Q?wZ3Hi37R4JAp0KNuJO0HcBeoH4XySQriha2F8d7cmz6p5m/ahE1QHifSqzAu?=
 =?us-ascii?Q?FfBayNQI4UkbZ9V5JLUR5qZarHj3YgBziJy6s9v5NPmuMG9rjzQ9kFCivHKL?=
 =?us-ascii?Q?ffwF74cSVdMmvXUyAuDl6fcvfDCiGg/zsBtytdVgnAuaxMTI+RHS1GdHYdhN?=
 =?us-ascii?Q?ON+svM2OGPjU4u68mi2ZgBAxZDEAQSnZZlBV0WiniMbrxm2ChbKvmv+QVYy4?=
 =?us-ascii?Q?PbLKk9T3iI6voh7jx631OYF2CJ/f5BqGKsJc6v4ykAG7UQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQbQhzkh+xGH4tnYpTQbJ8TR+bch3Lpx5m9csuVUXFW8ob1eJx7EkHpwSqQN?=
 =?us-ascii?Q?HmvuEDnvrK0LycO1BvmDQViCsIBJDr0zmIRWNhd+/FJVXzxDzqxgp9kpPFHh?=
 =?us-ascii?Q?WkrXhJfbwrEfjPFeGzZ8a9s4mpMNiP9GO7+jidfFyCoHyTEapcViqm0qonS5?=
 =?us-ascii?Q?ekVIAfUfwgPHsyLtrMx3CtkylL3AVzJOs7i4KqkZfkrhN49pW8AAsl/UfN/+?=
 =?us-ascii?Q?jHPtVKfNulaiV94/Vd01lDEEgXg4Dbqu/8ZNpoAv4vJPkxFQgtsfgXukm3vv?=
 =?us-ascii?Q?ie8Bb8KwxZ4/02DEnoaG3FjglHKx7pUpePZEA8XOWiXGAIjQZBmhV5ejt7a8?=
 =?us-ascii?Q?u0h1jbqmCnaD9CYU46br+rJ7z1w5kW/RVyy3gl3m767ISykr7Z8VkILEgxrr?=
 =?us-ascii?Q?vMXft2SZrJx24mVOGj8X6sxiBk/EXWaQYeI6mDe2MmEXa+6V2U2ZuVYKqwnk?=
 =?us-ascii?Q?56VkEye1VwGoQop+WCcmXl4btcRTPmqVghNOgBM1lCP1FHEzKDHGdRwAVyw7?=
 =?us-ascii?Q?zii8PJCTjKaPKsghN+Uq0SZX8i4m0A6rRM16zuQ58qqnq3fwKSakb41wVO8h?=
 =?us-ascii?Q?cL6pFZgAr2V7yuNDn3lrArH043aWk7kOlj8pYFs8r0gXyFsalbw3KWYVul0E?=
 =?us-ascii?Q?G8Sp1yidR66X453EkyK3uSUe1vLxqgftBBUpuj/5aHiZcKpiAFOtKsx45hiW?=
 =?us-ascii?Q?SbZCqq10MROKbygtERQkYu8Ppoge96gbXYxNfatoPjwNX4ZwspPA0q5ogJjx?=
 =?us-ascii?Q?MfnF35UK0XBiiQT4YVyuuWRf5iHgV7w4DXyaAuAmUkfX1W5qdUGdTE6stm9n?=
 =?us-ascii?Q?Sp64OLiBQvi9PkVAlvcQNiNZZsMF2DskXRrjSAZzIycxxyiKceeML+bLQCzN?=
 =?us-ascii?Q?VkXjiRousv7YajJJgrXzkvob7csNi5Ht3KqIlLYhr7Vog+9FJcrS+iSFmbp4?=
 =?us-ascii?Q?8ALilZHQQYNrGAx9jIiSbm02gFMCXiI36xsw/zVXqEaXFZ1E7HHZdFMNlaFd?=
 =?us-ascii?Q?aJ9nGAmL2KmYpCh3AGcz+40ZzwzO/f2Q3viFICam50JJ0HZbOzgl2fXKVTaF?=
 =?us-ascii?Q?osXQsdOq19Z5WO7QdZNfYcLOiC529yG8zXjYOzr8/oLjn5QwVX0KzR6xtUt/?=
 =?us-ascii?Q?FmmWUdRbf6hIzez3NtCmjIni6Emag/xH7Sn7WLibHr0IlCJI16cUjQ15Lgva?=
 =?us-ascii?Q?SFzD0ek1XCyd11V+6Hi95bTxdWY6kRHwes9oI5fgtLW0FlfljM7B8kpFV4gG?=
 =?us-ascii?Q?FDgFR6T8zspsZRtXQ7GPsDM7c9F1ad5cI1vrRKUAD6pjurLfZ5UuEjvNyE1E?=
 =?us-ascii?Q?fc5RUsTxsyr+LY0jtEzjQ4/ZJp6i0kjrzkFmRwbmTV5f/BxkS7u+Wpuvk955?=
 =?us-ascii?Q?ZQcS64K9f37xba2SbSFSTpAKMbcS8Pu9+XpZoGNkSuqmWrSvRkOsHOfgXh3m?=
 =?us-ascii?Q?DrJA4pmGBS89/k7SpYDRkC3I7gMJqJ9OWvlEx1XFOCjtXasEmO3GcMTRlCjV?=
 =?us-ascii?Q?4rlJu33RFkUiLt55mLVL+Wb/uP62eQNCBioPnDvfh2xBphPFifWrpiB5c1Jt?=
 =?us-ascii?Q?W3R1r9iBnX89uofehpqYzOfvt/AwiVrhcmVP+ZZg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 685db032-b543-453c-42e9-08dcd8b44510
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 14:06:34.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUq94aiteRQrXeo++d3VPSZKR1pJHBkL+vqwm02p9AyNJqMKp8dP2ILWxQ2ZafAJSYTHlBvgiL5eFe9sIbMXNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279

On Wed, Sep 18, 2024 at 01:54:36PM +0800, Tony W Wang-oc wrote:
> From: Lyle Li <LyleLi@zhaoxin.com>
> 
> Zhaoxin CPUs support CMCI compatible with Intel, because
> Zhaoxin's UCR error is not reported through CMCI, and in
> order to be compatible with intel's CMCI code, so add Zhaoxin
> CMCI storm toggle to support the new CMCI storm switching
> in mce/intel.c, mce/zhaoxin.c, mce/threshold.c, and mce/internal.h.
> 
> Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/mce/intel.c     |  5 ++---
>  arch/x86/kernel/cpu/mce/internal.h  |  7 ++++++-
>  arch/x86/kernel/cpu/mce/threshold.c |  4 ++++
>  arch/x86/kernel/cpu/mce/zhaoxin.c   | 18 ++++++++++++++++++
>  4 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index b7e67f4f7..aa75e2848 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -45,7 +45,7 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
>   * cmci_discover_lock protects against parallel discovery attempts
>   * which could race against each other.
>   */
> -static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
> +DEFINE_RAW_SPINLOCK(cmci_discover_lock);
>  
>  /*
>   * On systems that do support CMCI but it's disabled, polling for MCEs can
> @@ -61,7 +61,7 @@ static DEFINE_SPINLOCK(cmci_poll_lock);
>   * MCi_CTL2 threshold for each bank when there is no storm.
>   * Default value for each bank may have been set by BIOS.
>   */
> -static u16 cmci_threshold[MAX_NR_BANKS];
> +u16 cmci_threshold[MAX_NR_BANKS];
>  
>  /*
>   * High threshold to limit CMCI rate during storms. Max supported is
> @@ -73,7 +73,6 @@ static u16 cmci_threshold[MAX_NR_BANKS];
>   * to corrected errors, so keeping CMCI enabled means that uncorrected
>   * errors will still be processed in a timely fashion.
>   */
> -#define CMCI_STORM_THRESHOLD	32749
>  
>  static int cmci_supported(int *banks)
>  {
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index 836e56027..086b833c5 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -7,7 +7,7 @@
>  
>  #include <linux/device.h>
>  #include <asm/mce.h>
> -
> +#include <linux/spinlock.h>
>  enum severity_level {
>  	MCE_NO_SEVERITY,
>  	MCE_DEFERRED_SEVERITY,
> @@ -334,11 +334,16 @@ static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
>  }
>  
>  extern void (*mc_poll_banks)(void);
> +#define CMCI_STORM_THRESHOLD    32749
> +extern raw_spinlock_t cmci_discover_lock;
> +extern u16 cmci_threshold[MAX_NR_BANKS];
>  #ifdef CONFIG_X86_MCE_ZHAOXIN
>  void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c);
>  void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c);
> +void mce_zhaoxin_handle_storm(int bank, bool on);
>  #else
>  static inline void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c) { }
>  static inline void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c) { }
> +static inline void mce_zhaoxin_handle_storm(int bank, bool on) { }
>  #endif
>  #endif /* __X86_MCE_INTERNAL_H__ */
> diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
> index 89e31e1e5..200280387 100644
> --- a/arch/x86/kernel/cpu/mce/threshold.c
> +++ b/arch/x86/kernel/cpu/mce/threshold.c
> @@ -63,6 +63,10 @@ static void mce_handle_storm(unsigned int bank, bool on)
>  	case X86_VENDOR_INTEL:
>  		mce_intel_handle_storm(bank, on);
>  		break;
> +	case X86_VENDOR_ZHAOXIN:
> +	case X86_VENDOR_CENTAUR:
> +		mce_zhaoxin_handle_storm(bank, on);
> +		break;
>  	}
>  }
>  
> diff --git a/arch/x86/kernel/cpu/mce/zhaoxin.c b/arch/x86/kernel/cpu/mce/zhaoxin.c
> index de69c560f..994b8520a 100644
> --- a/arch/x86/kernel/cpu/mce/zhaoxin.c
> +++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
> @@ -63,3 +63,21 @@ void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
>  {
>  	intel_clear_lmce();
>  }
> +
> +void mce_zhaoxin_handle_storm(int bank, bool on)
> +{
> +	unsigned long flags;
> +	u64 val;
> +
> +	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
> +	rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
> +	if (on) {
> +		val &= ~(MCI_CTL2_CMCI_EN | MCI_CTL2_CMCI_THRESHOLD_MASK);
> +		val |= CMCI_STORM_THRESHOLD;
> +	} else {
> +		val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
> +		val |= (MCI_CTL2_CMCI_EN | cmci_threshold[bank]);
> +	}
> +	wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
> +	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
> +}

Why does this need to be different than mce_intel_handle_storm()?

Thanks,
Yazen

