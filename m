Return-Path: <linux-edac+bounces-1891-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB9A97CA8B
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87EE2B238AC
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BD519E7E2;
	Thu, 19 Sep 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HXAv55xj"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31701DFF0;
	Thu, 19 Sep 2024 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754132; cv=fail; b=eu4T3k4gHDmmO3aQMpFgqJsceyUSMAyrPwSP83hrUUtDhL6u2iWnGCO7WT0ivknWVQhCEsFJwBadt6+Y7JNNRLU8T+9e7vpUf9Ora3a0PMbvlV/P0QK5jebgSq95wnW+Ak1//WME40KyWSFbOmE1iUxU75vyp/oQKBtp/nT5Gl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754132; c=relaxed/simple;
	bh=0RTbYUzoIJMZz8QxkPTI7aNZFInv1hJhp/Pi72IPYiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LntaKhXdf5raoQCiypx0A79AIATWX/iNhzsdSUge7s9hGRf+hUW3XE3QdId/Hw1VsXKh6MyX1hrL9kiX/mMotPeDGNgCJODWyrOOrFF6uZde0ekUiYG+rlWJMaM0lDK8Npuw0Y66re3RT+N1QjqGChzJhb7eeL1ORO/oKqEfC0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HXAv55xj; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYzxhqNkR69KWcRD12H/mQPPwoYtZPL9d4++nD04O3nL8nysjmsshuCZlGm0aBgEr0eWsAFYoNoH4ZjP6aHQ23Y8KL40bJcdesdReyaMwzJ9JMz9gBoTXVGt+84kD5LcPEEQsltR72T6X4z4gjX6GXE79UTclj4+krh0WcVxlWnwdc9dZBcCV6r2WDaErEM+0Q++NogJ/9nWEr84AOeaDIUYLbiM+kddQWMvw8lWiVTqgFWn0fb4zEx07XgM1gHVW/xsksCbSEiq/5ajifpP9Ri440b9HN6bmltjOYHF0cjTqXqGynFgYBYq7zZOARwGDcwrAyxIhbzPAXM7o0BrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWowqGCseE5ye//n96UwOxK2Y5XoBaMy4NK9gCsRdns=;
 b=qg87cMmcGQ48glms+lnalTJQREz+VroNs1BIMxDgQ+33A8wwlHB+CCi2hv80ZrJ6cCv183NJVPC+019EyMKVSPLNCP9KVfwSHYpK+FgNasXmR4MrAfJ3Te8ZKGkVkx33qV39Lo/BC1pXTFzAKX/YBWBx9u7A/nFzUzpbb3NhztzC54ZvDA/BkPZPLfBvplURg7Mfv4q+l/2YKvr1VNO8qOrEHQbm00cEmzAjzY3oHsMCP/XrC7UvrLDfyegY8lOCzOib5jGYKGw2/hzjGHtBInjw3ZemkzXJbbjwJrPPVQaC3DNzB3yQcdSlIKJwrYnNg3injDIbmooEoziqL3Uwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWowqGCseE5ye//n96UwOxK2Y5XoBaMy4NK9gCsRdns=;
 b=HXAv55xjzyFpYQx3O683RmOEYu+um6dbbGz8x3Lg58FvFM8q2PKHKsawOWc40pPbrgaJD6mP6LeDZgZsRfK6FzzrlYj7l4bKVExBanlzHBeR65Mb7UhhuwzEIQ8OMl7NJCcVR0GdH7GAEkK0dObgGQ+feubiRwO0IKp/2e569eU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH8PR12MB7025.namprd12.prod.outlook.com (2603:10b6:510:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 13:55:27 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 13:55:27 +0000
Date: Thu, 19 Sep 2024 09:55:18 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	tony.luck@intel.com, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, CobeChen@zhaoxin.com,
	TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com,
	Lyle Li <LyleLi@zhaoxin.com>
Subject: Re: [PATCH v3 1/3] x86/mce: Add centaur vendor to support Zhaoxin MCA
Message-ID: <20240919135518.GA3717@yaz-khff2.amd.com>
References: <20240910092652.13354-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-1-TonyWWang-oc@zhaoxin.com>
 <20240918055436.15551-2-TonyWWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918055436.15551-2-TonyWWang-oc@zhaoxin.com>
X-ClientProxiedBy: BN9PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:408:fc::27) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH8PR12MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b03eff-8af2-44f3-cc77-08dcd8b2b791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vG2lciyastghj9x74IEfkKtlJMkklflILeZqQY6TMz7rfXtQStFYJPF8mS+c?=
 =?us-ascii?Q?Bvi6bcU1G8pRAigzaoNqOjwIfAR7nqtr3xNp6WIaL2qNY/+SHlR530Ebogi3?=
 =?us-ascii?Q?o/izPYB5GDuslEB6gWrUZesKF9s6kYeU/zZa/emCHMZgdDyc0PEJzlelEqxn?=
 =?us-ascii?Q?oRANcp04Epn0MmVc8ffoZIpTqgqOgYbJQ0PnHUpa+dzcUVAwksIVzstA4lo0?=
 =?us-ascii?Q?SmR+77poXoUnnU9CzvENEzWO/Z2QxNXoyd9KNuGo+MfS1DU93oMQt4mwdLPO?=
 =?us-ascii?Q?YHMQ7CxEvGLUZR9de1VrTvQo7gj9SNT5xWVvpKP7TdoatoB4XyWTQCXGZsks?=
 =?us-ascii?Q?9YiB1jWgNF3oWc0NVxgUImOj9KeNjMYNoN+4StWQuPw4EZ07HaYjR2uqtNkH?=
 =?us-ascii?Q?52X6XCZ1usKKeAqw0ES3ZOFYVXn2kpYWkuTyD5rw5icDiYmWrSparNtfAXv9?=
 =?us-ascii?Q?9wuegvbUyEYC+JOQhttmlk90mELZ91+8UaVplzMb/kEYNXpJ6WJk6WcirQjd?=
 =?us-ascii?Q?FXN8hB9dMjMqs2+q0ZkSdBU4xqV6qnZGBoaucUHpExw05w4glXv+O+EMp64b?=
 =?us-ascii?Q?68JVepK3MuQ98wfJZGZyl3aVyBRF2z/LYNM6adM15MC0FOUrg9Rn+EAEvAo2?=
 =?us-ascii?Q?OH9j1XbgSvU7CCP1ZFRXBR5qqdaUz8S16csEICYW3jYwEJTY7jYvfT9iCVyX?=
 =?us-ascii?Q?P55/zY4upJhBWOJFGi0QctykuLxn3UMAvTiP4mwAbyLbuUm37ppOKRzkr+54?=
 =?us-ascii?Q?quiw/+y63hhbi8l5jyX519y2dCty9/Mk40wQbS+TqesfJXo9Gjtg5HTBP0T8?=
 =?us-ascii?Q?lOfHp4/GNSjTyZcNu+k+ak1NlGS6WLqiFk3txLvO5Ee7Ei9HvmFb/hNJSQiH?=
 =?us-ascii?Q?Ysnc1sp48GLGywCLhNzsFfhEKg9Xry3zhK6JOoIxeOyeaAMtM/iq5x84akll?=
 =?us-ascii?Q?KkHnOA1ANWQFzh1I1McNkjo0CsZdKzNLe5eJB12++XQl4iLmoD+eJ5ihFTu0?=
 =?us-ascii?Q?VwsSV6PbZfkxoMu9h2WA6flfZYiQtA/YTxatQ1sDq++thh5j8jly4OrUIDi8?=
 =?us-ascii?Q?xplfVMTULMCA8M/VrmL6G6g3ec9E8PgAtChAvv0B7sMeD2umq5HHyLs4B7hi?=
 =?us-ascii?Q?ilJ5rsIAPvIC4tKypAPbEfr/PLGhT3aob9w0JaBCTMrabpIqoVhlhe8okxII?=
 =?us-ascii?Q?z814wVBEkXe9NUadhwADinBqgGyZ7FDdmgQjCiRMjyj7jmsYh4t5NKKoE39b?=
 =?us-ascii?Q?EjB3RKBNSPfBel1NxMjwGaCiLXBMDzfk5oPqSs36DR8Op2McuUBpqyr2InRl?=
 =?us-ascii?Q?me2XOS/GLEmcjVR6tyAJtWz67vYn4HNh03/tYSbRQJ3AoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RfV8vlnX7vzQ+wW0KkM1J4jVCGPCrDhG0SGwjXTGRC4Wu0nYo5f41XO2OInA?=
 =?us-ascii?Q?BgN6sC18zmPtNEiglyujpSnLSYI0S0thBEICxOiwvOLGdLQiXuP+/eSJXnYV?=
 =?us-ascii?Q?NBm7Is4ds37nESzxYGzLIYDNx3UqwXM9a5SX3y5+VENpG7HJUwk4Gk/k7Z1E?=
 =?us-ascii?Q?j5rHFBqHwgn4r52oIPze+3s73bLKQEXtfMlnDyV7JGq6o0k9IU/5GuPU9fxE?=
 =?us-ascii?Q?YivbD2/i5io8yOTunnKGFsi4CrRlW6eZ0mdaPquTbQUPq8RxOaQc7w4L+3yZ?=
 =?us-ascii?Q?yRc5xWFfRj04Z1w68OwTLYKwDpKjpmv3kHFywa5KumrtxZTDgYGplVl87AHU?=
 =?us-ascii?Q?7PZY3eas10FsTzYFHOkhpdINuZLXGZN9Lv7aJ8Atl/j23JpDd0wd2DUBlmEb?=
 =?us-ascii?Q?mm+JtTdTyUt2iwr0BbMWEGqrOLBOB6GxQEhWQ3SW00LfQn3t9zyX5jfZuwu2?=
 =?us-ascii?Q?lIuMnZsMBDyIaZ2bScUfLDbC8lTqYxqid3dOb+ONXX1oU2hqar0Yz/pTPq5n?=
 =?us-ascii?Q?KXQdlZ+NIAxXl70kFwKONGkr70mjqPrm4rODAmM/u7eIlgsGlBq3icW7PAef?=
 =?us-ascii?Q?TNYHljEUFYEuWPjpBafUPQpYYhdbcUEXteorGjFl3BAPqlUY4ogV2hqc/Zxl?=
 =?us-ascii?Q?mqicLuvNYhT8cz0Z5W6mSFcwSOQJ1PwZcQ+6EpjKbO+lj6/iQcMuC0s3kfAo?=
 =?us-ascii?Q?sqYjrspQRmDTqGjxvMxeQIUSdKXfKgxajvG6q1I3Xc4zraYTb4YjbE+ifusM?=
 =?us-ascii?Q?POtp84zZL2mpgYLrkr5MhJqV0XvmAKJRULvQPfBGK8YF0MkdcGXMF3mwvpeD?=
 =?us-ascii?Q?v5ynGCwGs23GtgjZoSfbZIgzzubFEiANAASrQT5s+TyMAVqSSrHfU6+FTtkX?=
 =?us-ascii?Q?opwepN8jEZF0/nbOeksGvxH+ukCo4dwC+6v63EDTfFXEsw8xsua5GBkSLlbn?=
 =?us-ascii?Q?yc9rmRVbAEw8jUZijya9BUkIVpxppaX3zpf/LQAeGysoPBFUxSD9U//mwp/Z?=
 =?us-ascii?Q?IiC6wdoSd/BXq9OrWNYmx1VxcWAMvh9UDUlNoHbbxKj1TSMT2oiw5Rlz4xQf?=
 =?us-ascii?Q?5UtMzkUtp5KJKfMNti0QPZfKxRLDS1zOkUj2XJv8OBeWwyBSIKspE47EsuQS?=
 =?us-ascii?Q?Mlfzp2m7E9fnDMY23nCgMqW4ALc+Oehmb0t2QJwG41bomg5fiSD4P9v/gYFo?=
 =?us-ascii?Q?DQuMlTxRFeAypBhYwkeqOS39Pss4lExz/OH/mU+Y7lUMYIby2VUveMoW/QIt?=
 =?us-ascii?Q?A0Y3yEsxKiewAQXGEhw1nYsFH/4Fx4ReNm2Yz1nPi9qvI/Ee0I8jkiFJpO1i?=
 =?us-ascii?Q?8iUN/E8ScWPqTgBOcVeF36wAE01Y4Ty9zJHP3ZgtJU18flNweRRWi7cM/LL5?=
 =?us-ascii?Q?6g1WKR/xLL0rEBMjDNstUDpynjRTL9h6MvOZLE1KWdW3p7dDNdKdezR498FV?=
 =?us-ascii?Q?dC6KFvAkVMKC4/zhcajUXS/YH6DUYRdWjrzoEQ7D61FvtmqNLNs4N8TLL0Vs?=
 =?us-ascii?Q?YCznNPEMdxDWPn1MyveinrjFzfgXY3+D3g3xsTGn/pho0UQ05nF9V9RTm3EX?=
 =?us-ascii?Q?gEhxXwI6QHf/3JKT3pj/fHF5pqDoiV4i9diT6R9S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b03eff-8af2-44f3-cc77-08dcd8b2b791
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 13:55:27.7490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEEaJhaCyqAlLazc7QwzePYVSepcxE1EnVkCvwbkiJaO2C/6yHE0JVwOYaKe/eXL885uTeONCR07sD4XOBDEaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7025

On Wed, Sep 18, 2024 at 01:54:34PM +0800, Tony W Wang-oc wrote:
> From: Lyle Li <LyleLi@zhaoxin.com>
> 
> Zhaoxin consists of two vendors, X86_VENDOR_ZHAOXIN and
> X86_VENDOR_CENTAUR, so add the centaur vendor to support
> Zhaoxin MCA in mce/core.c and mce/intel.c.
> 
> Signed-off-by: Lyle Li <LyleLi@zhaoxin.com>
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c  | 12 +++++++++---
>  arch/x86/kernel/cpu/mce/intel.c |  3 ++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index ad0623b65..7f79d900f 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -496,6 +496,7 @@ bool mce_usable_address(struct mce *m)
>  
>  	case X86_VENDOR_INTEL:
>  	case X86_VENDOR_ZHAOXIN:
> +	case X86_VENDOR_CENTAUR:
>  		return intel_mce_usable_address(m);
>  
>  	default:
> @@ -513,6 +514,7 @@ bool mce_is_memory_error(struct mce *m)
>  
>  	case X86_VENDOR_INTEL:
>  	case X86_VENDOR_ZHAOXIN:
> +	case X86_VENDOR_CENTAUR:
>  		/*
>  		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
>  		 *
> @@ -1247,7 +1249,8 @@ static noinstr bool mce_check_crashing_cpu(void)
>  
>  		mcgstatus = __rdmsr(MSR_IA32_MCG_STATUS);
>  
> -		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN ||
> +		    boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR) {
>  			if (mcgstatus & MCG_STATUS_LMCES)
>  				return false;
>  		}
> @@ -1521,7 +1524,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  	 * on Intel, Zhaoxin only.
>  	 */
>  	if (m.cpuvendor == X86_VENDOR_INTEL ||
> -	    m.cpuvendor == X86_VENDOR_ZHAOXIN)
> +	    m.cpuvendor == X86_VENDOR_ZHAOXIN ||
> +	    m.cpuvendor == X86_VENDOR_CENTAUR)
>  		lmce = m.mcgstatus & MCG_STATUS_LMCES;
>  
>  	/*
> @@ -2092,6 +2096,7 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_x86 *c)
>  		break;
>  
>  	case X86_VENDOR_ZHAOXIN:
> +	case X86_VENDOR_CENTAUR:
>  		mce_zhaoxin_feature_clear(c);
>  		break;
>  
> @@ -2401,7 +2406,8 @@ static void vendor_disable_error_reporting(void)
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
>  	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
>  	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> -	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN)
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR)
>  		return;
>  
>  	mce_disable_error_reporting();

At this point, should we even do this? It seems all major vendors want
to *not* disable MCA_CTL after init.

This, and related functions, can be deleted. Unless there's a compelling
reason to keep them.

Thanks,
Yazen

