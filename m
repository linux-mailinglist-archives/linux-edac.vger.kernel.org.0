Return-Path: <linux-edac+bounces-3073-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB83A34C2E
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 18:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9141694F3
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E54A211A36;
	Thu, 13 Feb 2025 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UxxXBvjl"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23B202F97;
	Thu, 13 Feb 2025 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468481; cv=fail; b=cZcnQkCH8IXg2qgCtAqsS0+T446u3xXVTfmYGuoA9FpyZ3AOlXFF5aVaIaVcSrx57v5fsaYFc8oX+AOa97jH9tntWaNCAPm21rf26sOf7aiZqaeR7tN/BmpaaEhnDEyJ1MI/0jVwDwbxcgBElt5TH0oB1g72jw0bmwgxGYNCTx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468481; c=relaxed/simple;
	bh=ju2lSq5t0Dmfvd/RJu4HHM4fZ8da6vCi47ENk//Kf14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D5rmjRZHlp6cjWA2MWv5BjPF4Uk4O7mO6EIY3zJCxPh95tuXP5i1qtws3IYCfDr9DyWb/AvH6A1X+OouF4b2ESQSTgUQfLgSDmE+75jPBfAHb+3s/4h8oZ0W6S1R4BLVxzae2mQOuxz4hPnLw3Gyo9wA1nxin8kkO0r8iWJzyQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UxxXBvjl; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGWfvYUUOwFNW9R/91xDo+syoVQtCBc83d+bLv/NaYxKYLi9BLb0M3Fe4upmHLFLWIFyrcLvMT8wKm9LN/nQcGq31OX7lpPlVTCHgpuJF36Ath9V7AgEM76T0aUx+hGiIUZDVEgIWRvnHSB3NbfSt0LN4YUTacURSpGb2Dy5ZmGD3RXixuDX0t27Anc80M9rt3273MMkJvgSACRAmmyq7UYK+IMUQkJfPafUc72mqI60ed4rvCJd3kwHtjVefETnWxJxon26sLQv2Go+oauCnLLl+UXiTxvcPhLUL2e5Gt3l4cjiuo0gH6qdXy21pOPxwNjq0K/S6HkcIYKXHVWT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8Yy9MgB8lagjZCqFflsTL1/bbXofT/dJ0EQqMCoa5c=;
 b=o6rOqMQXBKmJPU8tHm4wxLaaoobOooAv1Dahm/56fUZKVgxsZwe8YRkASuWklu11jTidWwq6QM1FlkEZKYguQ+lJubfzIJ4Oz6SxMqdfmlrQ/aOnXlS0kNfq78uS4xOb170Akn9/m02K9Y5dfrCC2OTQ0rh4qmCF5Nf3DnB5skQc2F8zbOXxNeWn0Vs0gREM5zfBsxjg0IT0YV9dOhc/pIBqKIgBsn9rYZvgYCElG/l0RzVwBX6KDbTuHnqN/mZEc3eOUSTjgZYJfKENOYgQLnGa+OUVoIp5tAuBApCaQxMDZlsfniavvryqCUrTCVvp8kN2+gwCSWPtYfugX4fgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Yy9MgB8lagjZCqFflsTL1/bbXofT/dJ0EQqMCoa5c=;
 b=UxxXBvjlyhZ+xsHkZ17Zsg7fbkoag8cnbRSQMYwApcjuoiVy4VtWc+HAa8T+D/hgfsKuB75iQJJ8sFBMb1EeJXvc/GMSijPskONdHqEsIVOWbPG0Bx7s29KJcBKPNiKsBPce2F2wEo3/7DUMwV89s6hnrbmlxuk1eHEx768SHlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH3PR12MB8726.namprd12.prod.outlook.com (2603:10b6:610:17b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 17:41:16 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 17:41:16 +0000
Date: Thu, 13 Feb 2025 12:41:09 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: Use string choice helper functions
Message-ID: <20250213174109.GA126857@yaz-khff2.amd.com>
References: <20250209215222.52260-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209215222.52260-2-thorsten.blum@linux.dev>
X-ClientProxiedBy: BN7PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:408:20::17) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH3PR12MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fe970a-e340-4bff-518b-08dd4c559dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hebdJDwTlmDXRmS/R2K60gv2dJcDxNa7EVN2Fksq5otCr+kg154dzDBjcfhc?=
 =?us-ascii?Q?Fdn2VScwGNCw8slM8MgaMQ8GTjp6riFVHphtmVaMn5yLpVpqswhFo50LZs7n?=
 =?us-ascii?Q?iGF9RKp/wnCKqir3P/eDI6jCesO+TFUmpRMMPCcF9Ln/QN6oTG61Ge0aaMMn?=
 =?us-ascii?Q?hZbqxLdUXnTen7fdIjz2MpCjySIaAlD8yOPtEi+paHGHZKcY7IF/+eqBEqO6?=
 =?us-ascii?Q?w3HE0g8M9MAyDCQopQSkRyD5e1T9CpxsYpq6ewPw9HEVNPxAgSpiV6Edil09?=
 =?us-ascii?Q?TDrXQU7xkdgvmJty7+Qeq28GIzFD5EMOYYc8+I5PuQvWastqBV44KLPboG2m?=
 =?us-ascii?Q?imrIFfuQLrv81P5/8uYx6H+PDgseaLYFDlKScwfCc/hqjSs1/ADL8OZVqTVL?=
 =?us-ascii?Q?pvhn3Qm7cyWCNPElHU3rtolPRUPf48Mfl2eUrFKOHvOHsmQ20tmFIzJZHz/9?=
 =?us-ascii?Q?Pbsk/gVxwFyE0pQQgKAlqTJRaKO6l8HakmQxGl9n3J5HwGtwebwiNSKAp+1n?=
 =?us-ascii?Q?xuAmJcUbNsfgsgcPk/9SxigUva7LLkQHP46P/QcFXZqTRem9LOWOBg1BPfGt?=
 =?us-ascii?Q?JVjYLWNxwRoUOLCAu0ddp0JnON8qNa4Lm0FTJpM0qbWrqBLrS04U0Y53/BDV?=
 =?us-ascii?Q?xyffyqKB1HPfYewlCtnY6xSV4uqRd21nGEpxtQJy8Posxg8drmEdSnIN6y5V?=
 =?us-ascii?Q?keZo6GzPGrnh7xl7/x3thlFo9eywuI57DkmVMFVU3wJqMgobKJa6A6ysWgnc?=
 =?us-ascii?Q?YPDWL1aFNDf7UuHWf7rO0NgYkpvpWJ5jNeVzNmv4hKTKM691JUspQ8n8cWIJ?=
 =?us-ascii?Q?kHnjVR/jb3Rav0G4OqyMb6nx8YuGv79NchXs6vNzCnPR35Lgy+LS2foShYwL?=
 =?us-ascii?Q?/S0eMrc1xJdZwacs2VTrtcxuR4Yg4A4VpFmRjAUHRTVdS8U8GaxbYWY7bvoN?=
 =?us-ascii?Q?tGEnde78cogDklHntrmYf6Yt0wvLuMVNwZG2pYlvTTd789jCUoN28E78EyJL?=
 =?us-ascii?Q?FlBTa7hJ1Di/rvJv3sIufiL262teERCbTNgidiAkYJ5x49yxpgkwkJ7gx4ye?=
 =?us-ascii?Q?pePuf7nDeRrZy3BmHFLo2RmwnPLiiherxZ2KRHwlyT2WV1vJ/uR3nuBkm3Sv?=
 =?us-ascii?Q?f9g8jPO0QjbjqYBjMdvzl0m3vdgpHkt912oZqUFZ8N2TQjdXTFpnujUBi9ue?=
 =?us-ascii?Q?y+uCqmT86fQDb2VS2v+cCl/GrefGfji0Cfvt8R0ijFdEkcZK4TovRwwNPUxw?=
 =?us-ascii?Q?4XLCOsKOoAjaokGLjC563m9zyWETmzGoB/joQ4v16IzvnS11YgJ6ezRNlWeP?=
 =?us-ascii?Q?XrEQ9385lwaPIA1gP7uptlepxqUcKNarniJSgDps1PCgXnjUIIWZr+t2p9+r?=
 =?us-ascii?Q?PaeYo+L0IyUdYqGNeODe+NHLJDiK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3jC/e49ulaO3MNX5sWVWW0zUnoxNfP0IxYHWJ7iTwz6Az+V3UJDkkv/9Km3Z?=
 =?us-ascii?Q?3HR27KhYEmZ5dl3sysq7ghljWQn+DAzfyhTNNARH442WwOy9qVYD8s1Kc7wF?=
 =?us-ascii?Q?KwCJYdseFNlPPYX49rahPTAhABCeshsuDQOyARmv7MMUPujkr/xGhn/I9g74?=
 =?us-ascii?Q?H8H2ZaLs4L+K6BcX6OGmuiX8gJQvt50nLz9REXhXbZ9ZBDwPzRXYq3IoGtPh?=
 =?us-ascii?Q?uZwQLSaKsGno0LWqaJ0O34xbNXJoOQulgkbkj1HIFAaYk38GOW/WP72LDzvy?=
 =?us-ascii?Q?LPW8UNkGHNI/jvYAPUwoI2jsox+aIE2gAmk4fv3CRixbapJt6MYi4CyTkpQ5?=
 =?us-ascii?Q?EpUcYsJOGI77EbVhdxuA9QAVFrMCSeemPlLP6qg72MWgmaSLtlJkRQjd+QZT?=
 =?us-ascii?Q?f3fxQ+mTJ3JrmLsp9qsIbA8mSSGVH+EqHXHNs3w1TL0/l7CoLWP6nE+XtKS8?=
 =?us-ascii?Q?8N22p2J4h9zzCc6ZNY6xTqK4aAWbVZv7m5KDIc+4mK0obm0P0BZ2eU52G2UV?=
 =?us-ascii?Q?29CyCutbxpDUQvFXQn6R3bl1yC7pemM9HOo37BWPAI8UyP0Gc2//ZEQSjGto?=
 =?us-ascii?Q?mA8Hissv6z0tJHLEOBPjAFQHusMtL0irm3Wv7w/GSXaodOw05n+hblTCuB22?=
 =?us-ascii?Q?whHdcR9sAZrHuB9J0Wwg5n8H3B8NhIwte9EMuLdoR70FrvQSxFsLkmavxj3v?=
 =?us-ascii?Q?FJxzTX65u8Kqlqblv1cWyk+0y1eur0wkPZLks8Va7CMW1IO/6uwJFOKFIHg7?=
 =?us-ascii?Q?ydP3Fq6o/o6KjfGyjMWo/pnkq3Kq+KsVW6Fzb3kpns5G6o+2dhZ87bul9Vr2?=
 =?us-ascii?Q?reqE77hLootsSujoSpfL4ZNxRuqx098of8TvHsMFqAbOU+GLqmV9MiYul1uW?=
 =?us-ascii?Q?Se5Rb4vvIuArVDo6FiA8Uawogk87lreecXr+Of4ICYHDSOuAjwXJHkrrVGGG?=
 =?us-ascii?Q?twXQ3A4PRVZTauO6R18CWWx5+K16QwNNbFEnDCaa2Ze3wAcghHpgrwRCypcG?=
 =?us-ascii?Q?vRZW58cO5Almcb2A6Tzzzgotdjr38KXRpCnUJnLE8Lg7mGjW9rWKwwROClMT?=
 =?us-ascii?Q?ITGGduxPlkdM+rE7T9TrpjjJQ4qyvosrXQaXqEILpqzXxgebp1fBAdq4bLYQ?=
 =?us-ascii?Q?7jQW5DKvpWpu8p29q7GSGkpcB85+EFNXIpOlP5IE5f/0FpPvAnhAeNM7FL+n?=
 =?us-ascii?Q?57/s7LcbODx/oO6kgW7MoUD0qtumf3BYwfm73etjDJG4QpId+nn+Ng8TePTC?=
 =?us-ascii?Q?VgbPdqrzIQG+/mmj5S8TDj1k8ktsGZYFcdX1z5TvfNC0AuqxVTM7tRX34Q0O?=
 =?us-ascii?Q?H0TgSMY6HH7pCvof32BHppCKthFRGoohTQfprPu7SYxuiKD+TzrIlDCkt0kP?=
 =?us-ascii?Q?GBteKcCrLL/ioVoglxPL8bmxl2K+SpWy3EZOluZnkMB6w5y/zBI+zyuc+Wso?=
 =?us-ascii?Q?tLUd6A9Wnim372z6H9fapj8uUeZ4fMaM7lSNBZAnclv3qwqxeEjeCXM0Yp+Z?=
 =?us-ascii?Q?9q5UQibT6r+UnDpLsLgP8yUkfKUs3w68TzxDgocvW1lN2Judkl3Pg9kU8nVQ?=
 =?us-ascii?Q?pLFkP6zZQQUJxcYXJL1AjEMhVtdQYgRbj9D47S98?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fe970a-e340-4bff-518b-08dd4c559dc1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 17:41:16.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VMW9Z/wzEE3kYVKsUOMPdnZmFQPlA/Oi41+DRk2JveegC4PxPEWHeYQlyJE6Cf7YiD8CtTlfXLqdtAq1I/HAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8726

On Sun, Feb 09, 2025 at 10:52:21PM +0100, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enabled_disabled(),
> str_yes_no(), str_write_read(), and str_plural() helper functions.
> 
> Add a space in "All DIMMs support ECC: yes/no" to improve readability.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/edac/amd64_edac.c | 47 +++++++++++++++++++--------------------
>  drivers/edac/debugfs.c    |  5 ++++-
>  drivers/edac/i5400_edac.c |  3 ++-
>  drivers/edac/i7300_edac.c |  7 +++---
>  drivers/edac/xgene_edac.c | 17 +++++++-------
>  5 files changed, 42 insertions(+), 37 deletions(-)
> 

Please do include a base commit id. This patch doesn't apply to
ras/edac-for-next but does apply to mainline/master.

In any case, looks good to me.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Is there any effort to make folks aware of these helpers? Maybe an
addition to checkpatch (as a CHECK/suggestion)?

Thanks,
Yazen

