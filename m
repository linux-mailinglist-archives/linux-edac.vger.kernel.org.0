Return-Path: <linux-edac+bounces-5257-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407DC1B9AD
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 16:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F5615E43AE
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1663C2E1EE7;
	Wed, 29 Oct 2025 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2XONnZUx"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8232DC76A;
	Wed, 29 Oct 2025 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750563; cv=fail; b=MTXe1saXm4guOJrdqi6vRG74U6x3PmXoaMD6+S3cFEPQb+b/SVDVnoDIhXnQxcMi6a+TNFSBeChwY4BsQdp2Wq2kB6bMDbCUBQASmqZPxLot17G2uJAxTwXXNDKtOmhkpRFokP13fwWa6Utrxn+3jJXSJQd5fzTjWqa6TtSS/ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750563; c=relaxed/simple;
	bh=0lLZ/QxFL+hpG5igz5bhAAmc4iZcPr18cxIlUSA+DG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I6UXWLnSf0RBhRcytD1CaKmDL4dbyoxXDoPbBq3TF8xOy3jSlyv01tsuiY7uWFFIfqgmnI4TvrXcXQGOAbhiD/i2m1mOylhBSNpobMFIKYv1L/jj5Lz7P11FdxObvXTgdzLKXlHgRPfy8Ur2uaoTinZvW5BsaB8tPDcMG9TZRBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2XONnZUx; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXCEqO9t4XiFgtNBgs50o1ovWzrzYs6JLpbvXhpEO3HT7x3/My5hZ4WMmoMVgwTVTNcZLzhW8DXr6vv6++igHIv4/Uqll75wtCFnTtghe3t/SF7BWSdK5KfahL4PxTCnJ+kvbyD9nKp6Z6I8Z4CjOKTttPcYqTrMm9LgV+wZ944A0Tes4b+1wr+U/rEgd1kRp8f3Nm6YAOEK0pkmflAyFs/TO3LySSUWOJzI65oHsvUSzGX0xTIvkc+3puvZ0hw7Ye//3/p0ma75Kdx5D+1YIhLaDz4Ae7ZtT7qchOZq0krX0mU7AEI9xyJJQcLSj/9ahXyN6jr1IOkJSnjFiMJIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e530uwJsw02MgJsiZOJDJSpIwvKvAGjkyqBxlUcN4EM=;
 b=vCq+uUT0TdyXQXsJMLymgp696LOLhYJPafTY3oNLOSsppCHXeIX+QjnvwzgSVpUjb3ZF8DIEYurAzRKbbhtNBC6eJ9EAEhlMT4fFydPh6QIn5f9KsN34Vb43rSWA8OpwnpLxPFcUPKMNoPvub5QzWeXfhM3u9b8OAeqqVqChaJec+nNWOYnRrwj0F7lEfracbAJtxiW+0MNCRAZkxiR79RDA1Lf5XSNRdjwQbcv2gT4m+lzAcVhd7f2+ZnM0AA5q3HzCkjHB5i0k+Io+RMuIIj8uDQy+rK7ybgY5s352bNioAmOKIysABuw521ouOSBaNw9hz8GcQ6plCUyiT1mKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e530uwJsw02MgJsiZOJDJSpIwvKvAGjkyqBxlUcN4EM=;
 b=2XONnZUxRBi7P8duSkhfkaBJUBzioaJt2o87oRwC5JkQkdCqmC36x+rRaV+s7nSHfOsOjxvP7b7nJWYSe+uPaLzLrtAdJcnumIyLXKv9vzjk9tZ0bElbbw8+T+RIEy06y/5xFzEVGTDOOdcPT9pBgAckoMA/cScR968IynNzy5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 15:09:17 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 15:09:17 +0000
Date: Wed, 29 Oct 2025 11:09:12 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Bert Karwatzki <spasswolf@web.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Message-ID: <20251029150912.GA113329@yaz-khff2.amd.com>
References: <20251024203012.GA251815@yaz-khff2.amd.com>
 <20251024212723.GGaPvvO3l2OlUEG7Xn@fat_crate.local>
 <20251025150304.GXaPzmqFawI0NrCC-0@fat_crate.local>
 <20251027133542.GA8279@yaz-khff2.amd.com>
 <20251027141139.GA51741@yaz-khff2.amd.com>
 <20251028152231.GAaQDft32eXtTZBBzg@fat_crate.local>
 <20251028154258.GA526743@yaz-khff2.amd.com>
 <20251028174656.GBaQEBkOErfNAJbJsf@fat_crate.local>
 <20251028203719.GA655216@yaz-khff2.amd.com>
 <20251028231825.GDaQFPQflC7gyVOwMa@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028231825.GDaQFPQflC7gyVOwMa@fat_crate.local>
X-ClientProxiedBy: BL1PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:208:2be::20) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ea14ae-8217-43c7-c413-08de16fd20fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uwwO4NB9GJOrM1ptRVkIjNPF50whvcqB8PaEWgLlI1GYg7qQyH2W8QAPZh9T?=
 =?us-ascii?Q?CgZgqm+1RI8PpTUZ77QJof8yT4l3lcmvZXuohn4nhAV+LW31VtzFCupemmAe?=
 =?us-ascii?Q?s+4PDrxih61wYIjl5ceKS6vKLkqJJ08iaHf00UMG6mp/y1z8mw7rCM/gnaKB?=
 =?us-ascii?Q?jEz/cAslWAzIrC1hHgq1zzUvuuHKJ3QPrewFrjVtEMXISSNqww5bcZP2b3eU?=
 =?us-ascii?Q?GsuKrdi6L30C6ZN212Ek2wzXx5olShtI4y/nFJyOqiVpiohfEr/JBB0zX4/Z?=
 =?us-ascii?Q?GF+sW7opKgtaCC/rIh/A7dcnC/SdeGjzjIkFT9F5JAGjEY4/Kir1Y5Rj4Uug?=
 =?us-ascii?Q?d9e0Mg71+D6M1Vn4jH8Au0oyEnwoAJQTSQ+fVKHXM33G24Ro2jybtdxcpofv?=
 =?us-ascii?Q?t9vbIHRHpWVkmK+6G36AL79YFdTVWtzJZO9XiWK9uvdPuWQuuQi6oibyV0V8?=
 =?us-ascii?Q?XDM4Pt5IqSxFDMe1JDpesE0sYW1QgCI9VH9rTKakyNsSaIMat12W8bUB8bFF?=
 =?us-ascii?Q?XP7Tsgch0QqCofTUsh4yXeJQCfz6c05svBFAZhlWdjhi1oOwUrZAcUWOOP0E?=
 =?us-ascii?Q?m7G0Aw9Gx16c1H38IRdZ4+waORSoC5RCQvh5L50UlDqlLUXXlRlALCwvKTYp?=
 =?us-ascii?Q?tH1t2VGy1yHVlz2uwjJBP7hhTbs1JEkKZYOHEPNASMkSJRTk3UX48WxQ39H7?=
 =?us-ascii?Q?upKblBvuY9u+H/e8akd+jRmzo6yWvyI4aG8e/qIe8Oqc/bcE0P3opOU2O1uq?=
 =?us-ascii?Q?bS/VB6n08CSw8n05uIDWE13M88pXhLhZydOG3JITBd3/+SjPEatQbOGPI47P?=
 =?us-ascii?Q?3dMdcVGZ2nzShKlavdCg07TelTTY6VkrKlA0hGkkNOEBdPAz+56jt5d2GUwn?=
 =?us-ascii?Q?y7bJUxLLAp78cEmL3KyxtX+evINumMdTiQ8m2dXEaIXPUjl2FAywGsVSlFME?=
 =?us-ascii?Q?9fnaJomZJOa1CGGl6zMXy8xO9L/yRav3nqAmaqMpCqudxmiHE8o77iVFJH90?=
 =?us-ascii?Q?HndPZztB1pYk0U5FBndro5z5DLngH1cwBf032BECuZDBKiv6temZi57fa5KA?=
 =?us-ascii?Q?1t4zOki22eXqYl6mnXqWdlKTsbCO15hVATnboMm6Yu7YjUL88QJAGUsSOdcN?=
 =?us-ascii?Q?mkuiIWWU3qu9XbZDvYBfP9VFzMNy80023RkNkkBcAzaqOJ1YUc7VJFqpvvkF?=
 =?us-ascii?Q?lxe7hS4dnFwKu7RE05e3/fhpM9IfxtE7beDh4fTI36LkADwgiE74fDfUhE2f?=
 =?us-ascii?Q?XzS7NP3s59X2f5L8qVwdPI0oOPqrSE90i9MOtbMuiUQ9/UUaK8MggN4+dmOp?=
 =?us-ascii?Q?NOTWyD1uxWMB3+Wym7QR9hQP5WsZ5GlM5qBOWM42w27cY6px131lYuFaXXUO?=
 =?us-ascii?Q?bZXaT7VO6ogiBrxn/zJGAINmEfiVCDoLTTZwICus2VPfs6KA5EqjuwtO0aCD?=
 =?us-ascii?Q?NXOBn9vkd+sdaUEErdXatsYMICHXVWbGuaH2UUuvjXQd1Ui5XzkJIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXDcQkhlEgXVwz/dMULkkozmAYLoznLF5+M07I2aEgF4OxkaGzFtNbUB9j5O?=
 =?us-ascii?Q?2HblxJE/ypct5A2eONNDIwodcEqH7OIBX8z6bhDV2kN3vbclQL6kmRDWjwmK?=
 =?us-ascii?Q?fDoWW2pgxDUsfXo7c7uvc0h/i45hKIT92XrPYefXUcEhBMCtjNQ9RNAzRVXn?=
 =?us-ascii?Q?NQeDOx37zO6c1t78cAYcqkVw9IbjSld8qwmsDaVQzBKio2VH1pNIr/GR5z7V?=
 =?us-ascii?Q?YiHCwhW6NG6FUx+2wN6QFWNftFNtToywra/7AkdZiZyYovC4+y7Rv/culeMo?=
 =?us-ascii?Q?kfzZtnPHi/TIAUIiPEImSNWh/WbSS06p36E8gy8cclvGeri9hUgSZLiKRUdx?=
 =?us-ascii?Q?jrIM1lWucGLYEfOwuALmJLldm5VJCDHYXhoZccb54LobEWX3ws1g33n+q3TL?=
 =?us-ascii?Q?pjiWhcHtSlLMydfwfTF/tU2DZD7frQL6lJ99ygcPjihM97YciPiOWu1MEqHG?=
 =?us-ascii?Q?NgKLHo5r1hlyDvivZK0X0QmkRmcwWbR36GKb5VTfwHPq/SltkLtZe5avqtRN?=
 =?us-ascii?Q?3kXXMV3iCbBa8ky2KdetVK0/hTlo6nlIX6cETdZmPAF0ouh6xn3SNxYBleWi?=
 =?us-ascii?Q?wpYuhoR4TsxrEgiF6i9MxpaQplckJMbVMkZf3CjRh38SkyJ9seQo39kU0bsL?=
 =?us-ascii?Q?YZkDFMZ7wOnAonRm5aCPWqluanhCpKX+Bht+FNrIi+x1k/epc54b+pyiOMkd?=
 =?us-ascii?Q?bpJEd9iug93zh5taebZ2mLUOgEBx7T44XHlbd8+M7bybPq1YVXaUTxev+Z4u?=
 =?us-ascii?Q?bgKuVDEkyENy3bS0qplD1IQvV/2YWNcynZv/NWGLv7NHma0+wMwWu6pXUDGe?=
 =?us-ascii?Q?/cRlPiCtM0cEHu+YP67+7C3k9T9N3mMZDNhyBNghdSbhaFyjIYf73vRdFKbI?=
 =?us-ascii?Q?ZdhmIed2+CPH7lhjkNLli2/w4irGV3dzBiK2OY/r4v21M7rCtHpzxwkTM+7H?=
 =?us-ascii?Q?h56C38f1YgDg9l8NHXtN0Mq5LaRatjKH4bi3MncYYIgpO+33kRtCgJeM/Sey?=
 =?us-ascii?Q?/zvwSjDVoWvZ6Qxc7zUDnKtR9o3KPO01woZU8PlUNIZzl7uyBEUy/CXF0l8D?=
 =?us-ascii?Q?u9/RL7hWdolNB6ZXwAHWdMBFwpLQUSWy934lwOOdV+GegEXq4cUiErYh8Z8w?=
 =?us-ascii?Q?+3JZjmCUJnO6anlwmxPV/0k8fbOZEYTwhcPDoCjjOeVtYkpMWjrp9E5lHhfk?=
 =?us-ascii?Q?kCGXgbU7ZsDnbrXy2lpOpcbSeA/5Oj30ktXeuOPprFbgOyaJXPxGGrcl7k0K?=
 =?us-ascii?Q?t8+8vzI7dDo9NQibSMdpUsfgeF1YG5ne/KS/9WOrFhv55jFq77FHssS8JRJL?=
 =?us-ascii?Q?WJtHipaewV/w3QUaz2+ASQESZHEikPX9+tNbpnwgl9T/y2lp7debLXJ3UMx7?=
 =?us-ascii?Q?QnJNfvKYpVThYMGxBOIdmpdVRdA6BLmcr+En5aK6A/hvS4HRSnJChDnJLo11?=
 =?us-ascii?Q?PBCFvvAwVY6eaFXxhhs1MLiXgyKgKh1uXjCpEVOcAKC3P1yWC2C6BdV4EAKr?=
 =?us-ascii?Q?Xw4aad84tIePfdVCJf87RIinzJ8BEulcrjg6dIBniptj9y0JP9yJAwd4fKGF?=
 =?us-ascii?Q?jd9qJcTcQLk/y4+vhxZRQ3FsD+BB/ovP2Zr0mU7c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ea14ae-8217-43c7-c413-08de16fd20fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:09:17.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: chWWCI9h4kJmEKilT9mqP211jzYRETPE3xHk2ZJ7StZU1DyFBGTU7kBzpb0ninMaoitqx3L6zREUtyWi9pOXmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242

On Wed, Oct 29, 2025 at 12:18:25AM +0100, Borislav Petkov wrote:
> On Tue, Oct 28, 2025 at 04:37:19PM -0400, Yazen Ghannam wrote:
> > Yep, that's it. Much cleaner. :)
> 
> :-)
> 
> Final version:
> 
> From dd705221b2b3fb06fd2dc25dd51a8aaa1b1bd6d5 Mon Sep 17 00:00:00 2001
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> Date: Thu, 16 Oct 2025 16:37:48 +0000
> Subject: [PATCH] x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA
>  systems
> 

^^^ This is the following patch.
https://lore.kernel.org/all/20251016-wip-mca-updates-v7-3-5c139a4062cb@amd.com/

Why apply the fix ups to that?

Thanks,
Yazen

[...]

> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 7be062429ce3..4aff14e04287 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -726,24 +726,11 @@ DEFINE_PER_CPU(unsigned, mce_poll_count);
>   * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
>   *    log it.
>   */
> -static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
> +static bool smca_should_log_poll_error(struct mce *m)
>  {
> -	struct mce *m = &err->m;
> -
> -	/*
> -	 * If the MCA_STATUS register has a deferred error, then continue using it as
> -	 * the status register.
> -	 *
> -	 * MCA_DESTAT will be cleared at the end of the handler.
> -	 */
> -	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED))
> +	if (m->status & MCI_STATUS_VAL)
>  		return true;
>  
> -	/*
> -	 * If the MCA_DESTAT register has a deferred error, then use it instead.
> -	 *
> -	 * MCA_STATUS will not be cleared at the end of the handler.
> -	 */
>  	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
>  	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED)) {
>  		m->kflags |= MCE_CHECK_DFR_REGS;
> @@ -780,7 +767,7 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
>  	struct mce *m = &err->m;
>  
>  	if (mce_flags.smca)
> -		return smca_should_log_poll_error(flags, err);
> +		return smca_should_log_poll_error(m);
>  
>  	/* If this entry is not valid, ignore it. */
>  	if (!(m->status & MCI_STATUS_VAL))
> -- 

