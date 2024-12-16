Return-Path: <linux-edac+bounces-2722-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0019A9F34DB
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2024 16:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C22160898
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2024 15:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD00145B39;
	Mon, 16 Dec 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pLnnpX+1"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32153E23;
	Mon, 16 Dec 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363853; cv=fail; b=UXGf5GGOfVLODujSIMRMp4TNyMzhFIKQ/fTJr+ty5adXHGGjmYvItLGQk8kObYpPMwuB2XDqFaKNBQS48Nmepyk/tbpn7GaKg4tfVSdgOkWCXDoC4Bkdsgz+uhXq1SviGtZe90zCiDMYZ0K55w7yH850uaeKaN3kJr2zJNppZAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363853; c=relaxed/simple;
	bh=5jXZ+vUmvU7RNDQvg9o/XVUk29LNBTVUwziN5LiNNoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YukxvKS2QU6YvNQm0UWQx/PcIUPSVbonTEeh3iZIfbIyjux9RjL+m1DuHVhIgkD8886T0CZWotr58Z+MMEHT8OjbwCUlSKoSTUZmvRdFlu3p94IPjYC/F1eM/wLTOBAa0ARNezaNGIKqM49/QUdfPXTHQ4HnFGJgu23quNgTNj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pLnnpX+1; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFkbso7lbvkqAsl5WiHCzVi3raixTNKQPM6KyYBSdGn5RTAB3pxNOITsl0NcbZbS7TQZXaOIaB/S842YQ56klQdyIWPXZ+DqL+ds4CbGq1aQ656j7rJDrjz8Kb3RA/M2Bgz6OiHAHS/DedrfvbWzVKeigUXtUzzgFFuIBrkgKkzWd/6/4/LIuBzt2J7434lybV4Fr9X8RnPetGrmQ83m3QN07scZRe4vvDYt9jWS8yPkdJ5SgFQ3GdiHvfxNqajMqga3cBTGWuPnZDuRig8eAfypnwivkhjOw5Btp6b/tgOK2zwn4wZfzV13lq8XpPUY95GlXwj6rxGjqyDOb3vnYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzdlhT/1OumRaLniwwoJHRc8npqcYc7ZTItAgLYkPwI=;
 b=qXmRfykTcEa3/wg91FvKCimd8T91zjzF1djjME2QHSqDkmAqZSOLoBfN+98b/oWO5XgxUlkplx1vCoj1nqbhOL7OXuJSjEu13TLNJVCatGizSQlg8/mWYIlfvXAVDhr4KstRkPxAxwf8Fec/PLUrE1fA4ko3qkdzuU8wFVMxR9hw8YWlqyW9YUXpUUPmhumBPoguj1PCVZ8OEIAKjEG3wKjvhqB55CkM6TSXAguyUEtbkeNXIhZ6V0F2piv4kE5qyq6uTfVKClykCP7pPD+7T18dDMQ1/coqC6Vj/KjTwim/GKG84XXcwuVHkY96+sapKRHUlzeitpb126gZvj6gXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzdlhT/1OumRaLniwwoJHRc8npqcYc7ZTItAgLYkPwI=;
 b=pLnnpX+16Ta7AGr0yA9sMTE8OGrHOci7O7+h+RjsdYGwLA6W1aLXIfKhFWZMNS9KpIw1GlaS9C5LrYe5tC0NFtaRlGfDm5tFZCW6ni+OCncKH3yfzwe6/kx/MiJI6fB5nCLw+/B0aZKuIafYrmJHNn2Vox5zCWorDyf2KNKphec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 15:44:07 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:44:06 +0000
Date: Mon, 16 Dec 2024 10:43:58 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Karan Sanghavi <karansanghvi98@gmail.com>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Message-ID: <20241216154358.GA460991@yaz-khff2.amd.com>
References: <20241127-coverity1593397signextension-v3-1-60dd0c4287ff@gmail.com>
 <20241211160113.GB1923270@yaz-khff2.amd.com>
 <20241215181557.GBZ18c3QJw8-7HWeSD@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215181557.GBZ18c3QJw8-7HWeSD@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0867.namprd03.prod.outlook.com
 (2603:10b6:408:13d::32) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 120abb07-0dc6-4606-9f3b-08dd1de87979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nwR/BSMPFwkFr8BhKr240XkdgcNdwFPfW89lm40YiprVkkl3RMCmgOJQ0QfW?=
 =?us-ascii?Q?V02tKioWSg4BlTo7poOmLKVl8iu8mTKWw3P0aq7pvsvXncBDzZ/xKmbzQdd7?=
 =?us-ascii?Q?lCjJt68PK1CTRZ7HX9QFOAzS+0OpvirejY5zAaroOTGL88ZXGvyH98LumH6F?=
 =?us-ascii?Q?UoPvWv6HEUoTRMFH1i8dAILBAb40bokxYO/A7TcIJhI5d9FnkrLI9TMDsESy?=
 =?us-ascii?Q?a+G6bFyMbacXF6iBZL/9kHUGin078+hQXr05VfsnU/3JQBvHnR4vSH1uQva6?=
 =?us-ascii?Q?d7U/e3nk9/ySRxnXDVsy1PWJiAydRsB7IPbFJQoLDp3GB5SWlkYALeP/R9WS?=
 =?us-ascii?Q?088NPua5k+CbcwJsmRr41pOGbzuItIWCEK/U4TcW/I095FSvyEvRVilYcN6K?=
 =?us-ascii?Q?A7y7DFvKbyXvfJaxJKb8FfzZlQ5d+E6k7MeTuEO8xRgc+4n+JGYNJvc1Rsah?=
 =?us-ascii?Q?0HIL36R8FSgzku43ZhMmZuoApJfEwssVrCGGSygNB45HTbktYVtERN9AONsX?=
 =?us-ascii?Q?3cIuZXWu4rUbk4iUyBDWlPAQAqzhlPxYaNybuOa7AqP6OF19YqjoXfT7TdCx?=
 =?us-ascii?Q?j69yF1QZ4miILf6QZOu62mvpD4CKt8ch9IThiUAm9XnpTFWQuJBAET5QaQ9v?=
 =?us-ascii?Q?V9QWTAqbQZu51abBPwP+nJyjpn+T7i9e9WSjBrl99nwl0Q+12wGiMUUJnQrU?=
 =?us-ascii?Q?UhemNohD9O1PefXJatTBYgn+Ir1E2Er9r3Jt4qHBM0txQIJoeWe+RADbVTyH?=
 =?us-ascii?Q?EcZ4gMNbJ8J9RMv4T4oogICFPgJEfHwkTt+9v2IeJahyuoHqHjGNcY5MNOyt?=
 =?us-ascii?Q?6oA2Zsl1z8F3AzAQUXe9h+ubXJUU7caO75Qdt5oruJ7JAQZypT2iGUaj7NUe?=
 =?us-ascii?Q?Kda/50EbJuV2frLogISQrcFs0A/+o33hUuRsgzpgubCkMXu+dBdQB/rtphgT?=
 =?us-ascii?Q?CFnH8qyU9jKHLVEqmAeiC915H7iFUzbwJ3XoCmebApcNOZNu8PuYZVAO/YuS?=
 =?us-ascii?Q?t//umPdb//t2YdZWtpgHY/3nfMPsEVLuOvfpG4a812VTNUuNBYttpQlqwgkc?=
 =?us-ascii?Q?uzkNbyvNttOj0gLwrZAqefniBNKpodvCiIgMBzt6nwywu3a3YeANQVmXLKB9?=
 =?us-ascii?Q?U/MEaZ80W+Mst0MfQVt45jU49oqJM1e/17NQPEVi3z6qqNcsmsERZyx/rJZ3?=
 =?us-ascii?Q?bsVif/YysvCvhEsUbbSOLayPnLuu5Dh6yav0gQ1mlWN00Ifil+hncbtwfbnB?=
 =?us-ascii?Q?PV50Flzv6tBFX/M75ef2iuzaObOWEDD22w3qWUS6RrJXrz5Pv5edFoDMbiBw?=
 =?us-ascii?Q?H0uDYR53XaC+hobDisJ1ubhmhYKW+pXeoCYUC0RW4s2y8esVIOlGFYIhCrZS?=
 =?us-ascii?Q?y6xH5z0rjgLP6Xl9lmE1tqR4J0wp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HKtSE0m8X8Mgq8rGmXetZ6JrN5dND+GRGcJczsCFIu62XeY6jNE/ku2vZ0XP?=
 =?us-ascii?Q?0FC0g529biLoDE/0iFuR/EYrTheabcjRplhD68gO99APmFHbuyYWW8NJTlDF?=
 =?us-ascii?Q?aT5cOLg7jNlneqvHpOGaE9xukTA683arNaKpoU+KfyL5kJTFSBuosAGYu7dr?=
 =?us-ascii?Q?+Q1Z7znVL2V0hoGKYricEqcLDjURgrc2xSZIZDCaiu0gEAFniCS6ZptCMZj8?=
 =?us-ascii?Q?OF/rwbdGPHXpeCjSsE6xEWb5e8sIHlZ81kFawo/ZWP3TI7sYafJLkIu8iIDM?=
 =?us-ascii?Q?GftF56Fwq0gFcmUa8l5Hmm0j0VNSdWHfHWdhYzDY7WCN0cqGKK2eOoXKg8ra?=
 =?us-ascii?Q?D6C/v2vyTxiRFdmSkz8pQ7nQ7X+/gzMInF9Ifyjxbmyr/P8gOUPLv8jQfyYu?=
 =?us-ascii?Q?H31YqPS5lkVQSSonMMxzbR59O2vC2ec0cFZ2mU6a+4x1d/hVZiF4mnmztdYx?=
 =?us-ascii?Q?x7XsfR0t9WEJpZDHkYBp+Zg2KSwV7Tr0rLahITzhaUZfgEYsVAHNmkZqgAJP?=
 =?us-ascii?Q?MgONSEm7/3SIqewmRziMk6QO/kopvZv1VcmsO4UVBwkHUQUbiIBsv1K5aLcx?=
 =?us-ascii?Q?6fQrIlyvhVLMDXuYfuRCdCbYCEcaMdJtyDL7EQyc+G1tg6Lqmdkp6u0B9WpQ?=
 =?us-ascii?Q?cx5yn0blAq0d5YWGPO5inHWJI3lpDnQQjD0xkugD1usYW8SCjCsdRx6xVE2C?=
 =?us-ascii?Q?Hh29/GB2ER0dxuUrO57ax7jSE0Un3c2D7Vhs9TqWrVUInUXF0XLUZlsIan+a?=
 =?us-ascii?Q?LeCKH7LoCSCfoiZ+s6z1739ii/aCl40oOFlkFWwvZsuy042lWm4AIZMfY1K+?=
 =?us-ascii?Q?qHlrnK0xcNSZC0ZVfvF1Hy4dwvX87X+hk9oJ/JTrlsuuT++K9d8/gFR3AGy/?=
 =?us-ascii?Q?GmAAGNnDbSNgvBS9ocBdcCO6Oq3KxGlqGx9hknMJ1tWmPvSaGRBT2BL8fUsN?=
 =?us-ascii?Q?9TQR82FN4QjhKnWUarkt1Xj5hQWCqCbSIcFzPAkRMFTlh7abucfrv0vSUmR3?=
 =?us-ascii?Q?WEB76TFQZi+Mw7q3jGvnF/Y+gw2rARioVwWXUzKWzZREYjQ2LAlrCeR1/1CH?=
 =?us-ascii?Q?Uvtfm765zXI2plSXAqpIUqz7fV9GtKC4TPUR2zsVZn0GpNBZaPiQ0Kd4x7Xb?=
 =?us-ascii?Q?ueLLZcZlVyB8thS/ncM3uPm8x+TYk0EaZsBGUxT65AKv/3yXb9O9OjD4n302?=
 =?us-ascii?Q?r0KRjRpNBJJjD3qQ2RfQMOEUQAKkAdyXWsSqUsnoNyKjVRGjh2N0OJ066Fik?=
 =?us-ascii?Q?MjnDuYfMPwNZaZN0DJIwM4Cf5xhDtxTy+KU3KSzVHAkIUYTVmX0S+8nq/Kcx?=
 =?us-ascii?Q?9lNCdGB58eEpqgs2ptrZYW1/vSzQVoeb6pwzA8lcO7vSRUkqMinMbLI6mcfn?=
 =?us-ascii?Q?ic8iIxJ43rLn8oqw9J5HClbh+RGNSOU8cr8jUulXbuYuaQa9Ymqih//G2Jqo?=
 =?us-ascii?Q?p2mpgZmAdH1rmuazxn/o/Hyqhm2T1Zm6UYewcohzS8K9MgNPaC4EzKkg+8ta?=
 =?us-ascii?Q?djXkc+eynNNRihjIr5alEWA6O7PBANkBcXPdrhU/nqgL+80Wro0O7qvhzuQm?=
 =?us-ascii?Q?uj2WYbh5n1vTrqRu1+HfexPyOjIKQ7sCoHn+tBlf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120abb07-0dc6-4606-9f3b-08dd1de87979
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:44:06.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cMBCN1yHcm4CstcTmz0uh9JIcjo+VOlKYRvfEjIkTle9e79m9N0FFG0FzGG6mFdOOmwaoQVMjifWuIRUVwqSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

On Sun, Dec 15, 2024 at 07:15:57PM +0100, Borislav Petkov wrote:
> On Wed, Dec 11, 2024 at 11:01:13AM -0500, Yazen Ghannam wrote:
> > On Wed, Nov 27, 2024 at 06:23:48PM +0000, Karan Sanghavi wrote:
> > > This error is reported by coverity scan stating as
> > > 
> > > CID 1593397: (#1 of 1): Unintended sign extension (SIGN_EXTENSION)
> > > sign_extension: Suspicious implicit sign extension: pc
> > > with type u16 (16 bits, unsigned) is promoted in
> > > pc << bit_shifts.pc to type int (32 bits, signed),
> > > then sign-extended to type unsigned long (64 bits, unsigned).
> > > If pc << bit_shifts.pc is greater than 0x7FFFFFFF,
> > > the upper bits of the result will all be 1.
> > > 
> > > Use u32 for bitwise operations to prevent unintentional
> > > sign extension by assigning the u16 value to a u32
> > > variable before performing the bitwise operation to
> > > avoid unintended sign extension and maintain
> > > consistency with the existing code style.
> > > 
> > > Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> 
> > Boris, can you please take this patch if no objections?
> 
> Lemme see:
> 
> bit_shifts.pc     = 5 + FIELD_GET(ADDR_SEL_2_CHAN, temp);
> 
> #define ADDR_SEL_2_CHAN         GENMASK(15, 12)
> 
> that register field is 4 bits, so 0xf is the highest value it can contain.
> 
> Thus, bit_shifts.pc can have 20 as its max value.
> 
> So all that coverity OMG OMG sign-extension overflow above cannot actually
> really happen, can it?
> 
> Because pc is promoted to an int, as the text rightfully points out.
> 
> Or am I way off here?
> 

Right, the warning is highlighting the implicit sign-extension, and it
doesn't seem to be a functional bug.

The 'temp' variable in this function is there to avoid these types of
warnings. But the 'pc' case was missed.

What do you recommend? Should we adjust the code to be more explicit and
avoid the warning? Or just ignore it?

Thanks,
Yazen

