Return-Path: <linux-edac+bounces-3076-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5239A3501D
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 22:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92DE188C3E2
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B5C266198;
	Thu, 13 Feb 2025 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jXmopVVW"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB882661A8;
	Thu, 13 Feb 2025 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480720; cv=fail; b=VsqAK6KY7gDPLwfyMO6BmJguJ1t5gG0ZNBC7QR89NiqLH9JuUkXxZf8AQrBrJRIQPPTa1cRBZssYiq5kBqMgsW29f/sBe0URW3cxI7DannwLhlb0itk4nIv7puvOOvwFoSSXrvlUgnPVMeex5Y4n20KyKqoG5RvshVxiUrLLieA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480720; c=relaxed/simple;
	bh=WiucsjTr8TKLATnjQGtKSSaDgOFogiAt5Fle+Z6sVVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QXPxqrynEeFRJ9cbnuf/ZwkT0jZIULo4dSQORKdOBLoU07dyV7SbCmDtV72+gYH4OGI55lkORxRZN6UnEALg3bH69nJRnl4pWGg8Z/VMqIWhSFiNHM4B4KmFTzWGaWYU+v9qiXDdMc5flU+JQjkCg3AC5Qg8TANXF5e8yQT4LeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jXmopVVW; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W873ivtqIllCB4zdT77OixSfb72v/SdJcKjyCSfl4YjrpAVqbFSNoGJEv9wneUKxhByuZTswl79zPZ8AeevTJRe6Kk8k/7WdrTcEaMYSNm1O7oQpDmOz/hQ0MUeNrEWqkOoBr4yJzPLr3SbrNaSkr6UdsUlaCN8qOhV+/WLCYxxvpvRepzXuprhb4fi6aqWl6udq3FUqAsGJJmvS1evgqeYYydlNL/KBa9B1DZYbhpGDP/4IRBhsC4SF4VrfezxVNxt7p9Tv2/YUI2w4JgRY6wOSXEFqLH6XwhHrvJR9VPkCOuZFjeIHOH4CYHQ0S11YqG64+b74Aq1O5gb7uIbMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbTSUeLgxn4L4Suhk8HxR3dHwN0UiYmIHFsw+hCD2Jc=;
 b=NnzCLke7Z2I7tjwM8s2KtwJJwKHv6byh2UogS9r7w11cQym+KA3QRtFyBmsf4g9mYK7AtV9nGqG6OX/YEALqRLki7F0PswyNmPBkWkAEQBMojY0/mlvdEG4Bwy6bgMAr+aMgImSQ9PCzppeCqfopZP5+GLn2QoWygrlbHJLj4mbRAiX7eNkEo1EY7TlGBmEr0saKkrgl2RtRgNxFduqYF5K+jG1AAtvuv5uny/gNmESc+oHIIzC7/wI/M3oLIGHBGoVYIiR5a1xQQPkFPKoBNmwnoOKlYjAeRfKQTXaTGDpbF+C2NUpBQv3M6GXL15C7/xcSowo95BDWPze7FPSFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbTSUeLgxn4L4Suhk8HxR3dHwN0UiYmIHFsw+hCD2Jc=;
 b=jXmopVVWWkxFlhoianmHeusVcvcu0QWqZtdizejXZNygqnBFlgHsQJRzmbAkV65tIsAZvSxuQiu7PcUmOv0vv86d/cG0WftyuH95p7wNdrgghak/yDQK5DAUreEaVqL1BopcKuBy9NRhA3RF+97ix2slOVLv1IZJy0RcE7wtA0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Thu, 13 Feb 2025 21:05:15 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 21:05:15 +0000
Date: Thu, 13 Feb 2025 16:05:10 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: Use string choice helper functions
Message-ID: <20250213210510.GA212119@yaz-khff2.amd.com>
References: <20250209215222.52260-2-thorsten.blum@linux.dev>
 <20250213174109.GA126857@yaz-khff2.amd.com>
 <70EC363B-4277-4434-A417-21CBC5345D2D@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70EC363B-4277-4434-A417-21CBC5345D2D@linux.dev>
X-ClientProxiedBy: BN9PR03CA0740.namprd03.prod.outlook.com
 (2603:10b6:408:110::25) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ed869b-20ce-4f97-359d-08dd4c721ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Nq3W7YYDHBAiJHxLi5B/kEc+rE2b/QJCl54fSmbqAm/gv/BGaM63kXm3I5p?=
 =?us-ascii?Q?F1Gg2+AbnSFqc7lwusBQ18UASoOfe+/jI0zVY9txjDtj3jhtaqjD5RpHoiKs?=
 =?us-ascii?Q?q+nJAnyd+VmlZw356+prdgOmpVkjALyTSFhP6YSsb1ZhIP+gSpJGoEJve1p4?=
 =?us-ascii?Q?Bx784/CtaNF5yNCMefQgmOmOsy9J+U227ZG9lCTMM5jYFo664InMiW5GIrl2?=
 =?us-ascii?Q?IxLlm+4NLaGnFpY+lRiOF+Fd+MbIae30jiF1vXVbbOpG6RvlKQh754Ql/IED?=
 =?us-ascii?Q?89WTcaL3BB/1wcB4XN34njeOx1Gnmf6zfw6D1kOzDhXfeFazSQnpsqnUrsot?=
 =?us-ascii?Q?R/q5ekyKByWZ8QrA0hTmw2J+6Str7X0gwe0AZq5QALjVSIM0ZcFiZOcKseM3?=
 =?us-ascii?Q?eBUVusNZQJascs7vilIWgkwer/D3w3zsL0EYFmogpRXwyaxcwkMe7t2OvneK?=
 =?us-ascii?Q?IfZzIAd2S4EzoLUg+BsNw2g0aOnE8drE4z7b8hL8pw+jbEIUM5a4N0zjNtdF?=
 =?us-ascii?Q?Beeen4I7RCG78fMkrJSq86u4aGE0diaYRsaGk7ZKdIPSLVauMUSCaZo0IMKQ?=
 =?us-ascii?Q?0sVCFY1nWv09I/gw5EVgA/gqRKTVYFVjEBN+/TjsrsKtrmyrm4i5J37YeIez?=
 =?us-ascii?Q?XCv728A8l/10E59bgTfDNgfbwGG4/Of/930BcykvI/n3hO67j1VjDAVNDQge?=
 =?us-ascii?Q?phCwhoHd2sOrJkwBkMXGpCQ9HIoZRS9brXwt8Cg/B1i6acew8K2uXbzduTIz?=
 =?us-ascii?Q?Q5pc14ZrV9kj0PX6NMwelBCgxNiYAj3xAz253EmH+/krGlEG1OXFx9rt+v3r?=
 =?us-ascii?Q?o647QJ6/SqugLKEotxJ2v4H4909tQns6MzK85LNxVxE2qg4ZjMx7TRW7aa4c?=
 =?us-ascii?Q?I+fSjVJP7FaxaTtxVsztVpkdYVuRStOPoedeDiw0AshGhEXDDwx/Xq9EsZUB?=
 =?us-ascii?Q?ju/Y9mRm0eO9fBvLV9LyiRPVaYJ/eKf1X00gexi2iyoHZTpiAjKId95vGaif?=
 =?us-ascii?Q?uY6RbeSCNoCHoDjk9UzGFmeQj6J6pl0FlQ4MjsuynPKykusQ40NHlZ8yH9VU?=
 =?us-ascii?Q?mpapKcgf7R2SWUu4iOA55F5awpl3LZPx7enQErfDW3OGg7uFlOUf//TO2C1j?=
 =?us-ascii?Q?55yXzKXkEDaKmKZaN6mbcU60c8U+LMv1v0XIidlaAiwSH4W5bc9nyA7GWl5i?=
 =?us-ascii?Q?TX9XLDtk3BynC4R7TGuTufJ2uvqSe57QD0ihK0FOCHapMW9n5GFhL2ig0Lqw?=
 =?us-ascii?Q?3iAOFfmlkAMZ5Dtr2fe+NfqAAywG1FYVKBw1DkmYURxKFHsvaHwMMelyyT9Z?=
 =?us-ascii?Q?XAhtfeTXHoyKji1vhR9vgfWIe7U4nm8MVtnZ9CWq+vGXQBuGXtWmfadqB9/d?=
 =?us-ascii?Q?ngZ7/QYqrCjpsgjAJ1YTcFekd4b6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9QGA/okbPklHoKiGfaow++/U9H203ZMKwu1/+AedyxsWBI/uZ2hF6uXKhTMm?=
 =?us-ascii?Q?CKCCLVJ6iMP9f+UrCiYqyttvIfiZ7my0pSxBPTUgAEmulmk57pGDytUHgNGC?=
 =?us-ascii?Q?76+Bxu2tec1ndU+1yFphoDcKpj9ZEHyD4hYC2f6zuT0dwLDEi8nVQyWLVkse?=
 =?us-ascii?Q?aFZZFkudfqKdF03DUl4S6mFLhJjP7bQoMmc/lTt9dzzKV37vUbyQ/4lOHWas?=
 =?us-ascii?Q?FgILhwmpWODL+dhV96cHo77qHISwmtnWV2vI+mIyc4qgeA/hirQNud43QZ9h?=
 =?us-ascii?Q?UK7aghQfRyjjxeSo2r1oClN+l/9hUZr1JWIkl9K1ZCl67vCpuhby93Q0cloP?=
 =?us-ascii?Q?Ul4UM+CqmBCVlE4ySm+C449U19Z4CsLapShpTwXnPUtLysGDzaMjQXYFXFha?=
 =?us-ascii?Q?54V0i5C/MGXM5tZO6qp4a5ygIdik4Ye7+cBERAgPVbqpj6WxnJhysTuhvUeW?=
 =?us-ascii?Q?K+AbMRh0AXsflXF1YGkKTbjY95/lqbXfzgKB+tYpw5PSqOuyYlNx2FOT7ok8?=
 =?us-ascii?Q?873LkJdPwnOzMKW8gbwlsl9WQGH5ofCkOYgCcnRwEfaD3qodEmcU8P4GJ8FW?=
 =?us-ascii?Q?I21mh4mbQoQJf8RyGp/nhKkL9iGK/6m/PVqiXXiIyycSeuXIo3ZqIaj/DyBd?=
 =?us-ascii?Q?tn+qW8PqOOHsNQdPCmkvNpWmkKPune4sUqDJGNLkhCkWhS2aFvA65U81n96y?=
 =?us-ascii?Q?2r8fSP327czlgBf2QZQksmhxtSqsHimhHZBLBU2LJb6xfAadLr90aTi5pqc6?=
 =?us-ascii?Q?01Sm4CdSzw10U+hMFlJljjTVjFa6muQHytUhB6wXK7DmePNbi6Nkvh5DIOSo?=
 =?us-ascii?Q?SLceb2FVqZALjPwoJ1tT+payybG59k1sec91QknzmZAudZ8aHZLhQyGXyLkc?=
 =?us-ascii?Q?4fXxYJMBcq5zs4bFEe0LIrYGRsdIpTsX+mY6bzJjDtplqDwbav7v6EESBcCE?=
 =?us-ascii?Q?K9I0Lrd9EID0+vgz/+8e7lpMWHwSKyG3CBEbpc1daXn1EeIr1v+NKrY45cvF?=
 =?us-ascii?Q?hb6qTaRuUprm7kypVkhQvRdDiruR4Ob5jLX6hoza56nRzeg5u/UjoJd9aUqv?=
 =?us-ascii?Q?M7LJfi5lZJuHjw7E5PYjoZqW+Q4NSjePa6CwYL8bjXW8F0P73JPTtAs+dwUK?=
 =?us-ascii?Q?A2+gexLsUdeguXyL9YWAmJ2WKYwOBFX0MCVbL69YfUtVLea5/sf5sO0tZ5Gb?=
 =?us-ascii?Q?OuOaEVrzrWJfWUttJfgwvZB/yLmM0QDY3kfWHd8ArO33sQ7SBkzTwghlPYL4?=
 =?us-ascii?Q?kUkgpA++M2+5auUDc/00SQcyOWBymDBlGApAZINMz2H0YPLPBM9m3d5Gzx+A?=
 =?us-ascii?Q?k/kQxECeOtNe+Pha/ZJaLhRVZ/9lOu+L+h7ql3ak/APSlsUGj6YVch7Sk0Kx?=
 =?us-ascii?Q?eRkEkpAI2Wl7XEzm8XTh2iAVPLsXC2S0EobBEIspTbePnJSwUeKdMTN7qyZz?=
 =?us-ascii?Q?aQB0W/Hz4dJdfArRnqktX4OcXENZ518e2zL5M41vqkj4Giq6T2NHtHFQ+CKi?=
 =?us-ascii?Q?HLzRE/ttXZe4oMdfHkbfLVCLs8mba/IGWSHnhyEjSBiYq2W9hMyKEdxcmr/0?=
 =?us-ascii?Q?TMpH4y5rqpur9qv2N1ujLXIu055/MlgTMO6Iv2Jc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ed869b-20ce-4f97-359d-08dd4c721ce7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 21:05:15.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfOIowavEkveP0qAe86SXwQU9PaxpVAg4AbOD+NA8sR3by+dPP8fZVzHMTB/bO7qsdEwwwHpARQ9Cy2Yy2JzLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413

On Thu, Feb 13, 2025 at 09:10:28PM +0100, Thorsten Blum wrote:
> On 13. Feb 2025, at 18:41, Yazen Ghannam wrote:
> > On Sun, Feb 09, 2025 at 10:52:21PM +0100, Thorsten Blum wrote:
> >> Remove hard-coded strings by using the str_enabled_disabled(),
> >> str_yes_no(), str_write_read(), and str_plural() helper functions.
> >> 
> >> Add a space in "All DIMMs support ECC: yes/no" to improve readability.
> >> 
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
> >> drivers/edac/amd64_edac.c | 47 +++++++++++++++++++--------------------
> >> drivers/edac/debugfs.c    |  5 ++++-
> >> drivers/edac/i5400_edac.c |  3 ++-
> >> drivers/edac/i7300_edac.c |  7 +++---
> >> drivers/edac/xgene_edac.c | 17 +++++++-------
> >> 5 files changed, 42 insertions(+), 37 deletions(-)
> >> 
> > 
> > Please do include a base commit id. This patch doesn't apply to
> > ras/edac-for-next but does apply to mainline/master.
> 
> Ok. Should I rebase and resubmit or just for next time?

Just for next time I think.

> 
> > Is there any effort to make folks aware of these helpers? Maybe an
> > addition to checkpatch (as a CHECK/suggestion)?
> 
> Not that I'm aware of. However, there is a Coccinelle/coccicheck script
> in scripts/coccinelle/api/string_choices.cocci.
> 

Cool, thanks. I'll check it out.

Thanks,
Yazen

