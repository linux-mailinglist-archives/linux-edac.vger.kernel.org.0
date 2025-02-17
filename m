Return-Path: <linux-edac+bounces-3107-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6546BA3852F
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 14:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E665188B4D6
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60F121C16F;
	Mon, 17 Feb 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ph8zF2tS"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334B179BC;
	Mon, 17 Feb 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800542; cv=fail; b=VjgliQvYcSACFJKVgSwIShkt3vXMil6CzGX2bpYf32rKNYJoWBiFwH+JmJjQMx4vCX1FNJwX7FBttj3pFVfAZiyU2146ERwW+pFECL3xIf8LZUdhifjHeNDx8psbLfeQQcdnqoKRR4B4BE5Jjg4KzQyYzkvbQfGbQ0f+o0Jrjno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800542; c=relaxed/simple;
	bh=FFt4URnI14VX76G9bvf9zLb0gLFeLJigHDrsQeaqFcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L7q2jx9cxpSwpSnSfv1ayWi4AdmQhgzAzZlPLqIMw26XgPXQ9NW+zSzDBjH9t8TkTDa3JHRpM+57piomuqDxrxP5l6TD0Qn2FjuomjhrVcp1xP8PRpHzfPK+ISXDcp9RYAFF71Ijsh17HUQsYa0Uhz5RdlBrClR8qnqtuw00rbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ph8zF2tS; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx5GUEdHzYdd9Zfo+YZI99DEGCzElF9pN0tbxVihZEsnFwu6J89lt5saz2L7ogYENwpzMgm4t5Qwjr3+4qwbDescdlxqSuQebkcW8secoam9tqbwPyQdSmN/rHg1KQEX1fUhJXhWWEXaIQZnD2aKItNtmhatelY+cr7A70VMDuTlhPj0+b5xQz/xY6qWYOVvKrDXbADDS4o6IsGcqikf/sahP6LoQrS3zk7V6Uw8MXYLapCMgc9mM7RHvIsLmhG9rKR0jzPrcTvlY0H5xBvdSHBW45HLqNR0zlNTg6atzX5wumWHUKXhAhcgtGVCI7O56blce+uXqbIZ7GBxYjwIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ0snLLuE5LNWonaCh7xhG2R9JpwLNij0PgAtKrAmU0=;
 b=f50u9vlzdS42JxTJS2ky/NMWAQqNC0AMRPQUrO7auCu03gZwns62tEoCCyJBHlFjk+hNH4RIv/SmUi5TUO7dQJIZ4bF1SyQU7eDGlSv8u85vQUVFGzYVAFQXkIB5gFT595AmHseqkcCdW98l/6W/yKD9eimGPFrSVWFJ1tZV7Fr4cv4wAp4euO2JvjmHhzUHHZHkpqCgstJvmbOpDcLR3ZOszUMrAtEvRQ5Tb+BR12ZENm+FNbLJ00AgwLONnMbLXf3QgWM/FOvMiCXH8G/DD4DSZFRWByNr32FEIbfuBxN5ZYJa/vwW1frkzfkU1Z7Wi5UCkKm2rMcJqGBp/acbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ0snLLuE5LNWonaCh7xhG2R9JpwLNij0PgAtKrAmU0=;
 b=ph8zF2tSxaN+CpHcCZd8/35AXFPXt/t0OQGf4dxzBGFhSv69LwcCq0rsxiArSl4QCHs8SgzNe8swiPRcp7SsmOCcEyAqne9F5HWG+lVmtB3HpZ58GZ2+0ZiK4RaUccG7SkJGeDQ7GISW0+hRLxDf0lW9SoCJIaXltg8pQyzEm7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.20; Mon, 17 Feb 2025 13:55:38 +0000
Received: from IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514]) by IA1PR12MB6354.namprd12.prod.outlook.com
 ([fe80::baf9:26a2:9fab:4514%4]) with mapi id 15.20.8445.019; Mon, 17 Feb 2025
 13:55:38 +0000
Date: Mon, 17 Feb 2025 08:55:34 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 05/16] x86/mce: Cleanup bank processing on init
Message-ID: <20250217135534.GA591070@yaz-khff2.amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-5-3636547fe05f@amd.com>
 <Z65y-1IQKmCLOhXu@agluck-desk3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z65y-1IQKmCLOhXu@agluck-desk3>
X-ClientProxiedBy: BN9PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:408:f6::7) To IA1PR12MB6354.namprd12.prod.outlook.com
 (2603:10b6:208:3e2::11)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6354:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: d58d903c-4fc9-47f1-a1a4-08dd4f5ac1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3alVsUX9YbknIixMKhL7kXEuyaic6Q/zha+bI4fV6fUkQCu4uPydy22ai3b/?=
 =?us-ascii?Q?2VQq257eT4S5LDOPcd7YF6EGRR2e4GVNgKtLD0EqPGGpDVfo/DZfzu3YsqgU?=
 =?us-ascii?Q?vRstuIjj/ut9qclJx1jds4PBfAmLHp5hPFa7L+Cg4QiSLg4a2iHp3pLeHd+R?=
 =?us-ascii?Q?9zcnEL3OjtVqVOH31oTOXHrtfq0FQ76T9fytv1Nm/g/48fNtkeoD8CT695U/?=
 =?us-ascii?Q?qxZHwPy+p4HTbNYpTNW4jy3SuL+AVnMIFhA8mcshQvf2BZnvIAnHVkqR+F8Q?=
 =?us-ascii?Q?qqIzvv1lCmHAPlTRwuu9UrlotnTwdhqQVvV6EXTL7iYdAr10gIUrqL5kb5bL?=
 =?us-ascii?Q?2DeQzFtA7geBqi9qm9GcwjLcZqU6/A5oO3LS/90tL+OAj5OP3+lgpUlD994t?=
 =?us-ascii?Q?UiEaNmeGOh2Iwk6DFI+eIQVw3b05N3VyDFXnpTnzhSP/ty1ZYxfAnqgoZMcH?=
 =?us-ascii?Q?XFCwFuuHHoxUtOdqpBiR6q3lr/fupihbPjVdPuRdYyDKQAxZpQ7MGMzVKG7m?=
 =?us-ascii?Q?DCIkyFiW4r3eHYVrZdm+WfkPVPn/uAngIq6a+2K+gKhkYkHu/w/PQSknVb+m?=
 =?us-ascii?Q?v1+Zl6aTdmdHrzHGS+TZ3j8mVtCW4K7SJ8FSKHPpfNN8TDmj7f6ZEJubt60Z?=
 =?us-ascii?Q?H1gqfzVkhy8pQelnUxLUeikrdQseFheK+h3IJkZnxg35AamzkesyzG+lO4dJ?=
 =?us-ascii?Q?X/7OuNKkM3R1QzS4Y2hhaSYIXqCdEofJj720x8L0hnyOgHunbqSp6l4p9f/s?=
 =?us-ascii?Q?g37F54rQY8HNgQtE7oqYGJI6JtXePa7z99AaRFPoH43O5Ik3KbsJI5X6ZIdE?=
 =?us-ascii?Q?3ibzA1m6LW6CYV2sENG88cvTQ68xMQQesM/2gnjcbil67VgZ1hLLYnGcohOd?=
 =?us-ascii?Q?eCiO1tTfWjCHW0ocNBq3UI4gHTuAi5+JJKCxf/29Yab9EQ7bQ6dA1l75kkDu?=
 =?us-ascii?Q?mEE8X8YpkD2ouLbbkwGsDQgNx4Owo4fg+bRjda11NxJtc8TcKpdg3YNYN//J?=
 =?us-ascii?Q?r0CJhhgglejVXCvvUbXh5aurRuh9x0tPG61OG9RY9/NLX2wpFngYHaazR0nE?=
 =?us-ascii?Q?HbV3QmMCsoc18N7c276ocmroexCMHCTjCiTHXW5JWVs7M62VB80gvvHZTC3K?=
 =?us-ascii?Q?bCosRwzhVbeFgp/VWUzU+selwKTMcvUVfrAwjtYemt5/tnF2SBNVKgP7GCDC?=
 =?us-ascii?Q?6FRqvr8vv4pjJlDyOAWdRy5DrUP2IEobnqAoOXiVecntW8mdwtybbnT1y27A?=
 =?us-ascii?Q?XpNORGBBW52rEkvHWgsgkaFY7+nk8xKOGdFrlM9uAhSvm+uy9pjWQbH7rFHt?=
 =?us-ascii?Q?+wHkQXloLgy/960rHWNyYONsZGg4HL19rZHxyymP6l8588xXCh4GEXX/0eQi?=
 =?us-ascii?Q?8Lu6Vh14PgsvwsXVz9UBFA66wYiD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6354.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hLvaiCmlzhjlSIs/wf2H9LqdT1H1iI3IMy/U1e38np5Z13DwWRwPBMAI4x8i?=
 =?us-ascii?Q?0o1XYo7e5l0hRxmNXCV0qVqMP3DcF8hvXzmYrBlLKy/lWq9XmevWRloKmtmP?=
 =?us-ascii?Q?hSWBzyVYlRlz0xEm0rEEzrT9grhKYkItaYlFtoSYGPjMUP2c0e2vOMjlZQyB?=
 =?us-ascii?Q?Z0ckFGO8bOA8M+G+ypwGADPmPO9omA+knJ5yUHUe3E0jsO42tZIVkr1ehgD7?=
 =?us-ascii?Q?V8Ea66tdKmQp0r62szYGCxMVMvaMU7oz3OQagslWqD+XwZBlMBKxEu1X6MYL?=
 =?us-ascii?Q?+WsnITuFfTMvbgU5v23UV0D5tOSw9unFrJ/Zzbn//fFnO9J8t7xWlPLG0Rkz?=
 =?us-ascii?Q?2M9yPSGbgIhGGMYJ6HPKb2/x65W3+RtX2zEi7OWoGQIuQNbzaMy2nrKi52io?=
 =?us-ascii?Q?9/iQr97mbpGBzvpIDP7VjC7lVGxHXY+PrUnKt+93lrGPPkV1rxOp/uNl1aLf?=
 =?us-ascii?Q?NPKxgeHiRIBTiwQ2irAtei0QuQI6ZAagQjal1oMYdvU0vL+Ssm524YyNAcyi?=
 =?us-ascii?Q?u0lNM05rMKbnNyCtG97jCiW0RMnWfbhPWa7yvILRTV4O47ZvPUESDxrpysbw?=
 =?us-ascii?Q?hEzlvcvi9zwrMK3IDGVLkz9kJNXPaVjYbTXk93M7Yj93PQklPqaygaJZlT4p?=
 =?us-ascii?Q?H6UrFrnI+bWUx4VX0o3HzoAiD4Z7CAdj0KOSffOzTQPZrZfnapMmIYXYdI4n?=
 =?us-ascii?Q?8lOLkwarwMtXe5ns/3BioLa/8Z2ZObj8mU2iKDkUOIng/mSKynt5wiJocnh6?=
 =?us-ascii?Q?9zedyVZXi+rSt1fCKSXC9+16Jsq4b8E02YCwBGvZxUMX/Yx141Y6eYZEDMKm?=
 =?us-ascii?Q?+aTAcazta8YjGdZP1/LMvQLTvajpoG1HWQZnOTftwoBk2HXCK1uAKsB9uN8O?=
 =?us-ascii?Q?3xJtlUDyWOPBGP7PbWc9EoMrmmW6O0RlJcsw1J9C2rYSlZAkPr8rzymFsjA0?=
 =?us-ascii?Q?NQ46UPH+QzahLdkfWqL7TK6tbjB+znkMvon/8sgI0lMPilsqlJD/w0Gd6AWG?=
 =?us-ascii?Q?E4pMI8FTETlLnx2IucGbwc5k7ZPN95Bdt4uBvQ0fpcn5xac6X8IWAQl6nC8s?=
 =?us-ascii?Q?BYVSasSJpdVY/SSNDKiBgWpzd0eKKEc1zLW5hcTn7nFZ8rqaK6+hwbqnsX0W?=
 =?us-ascii?Q?eAuEDmhY4KkJ7cHMhmdGcy8PT71uzqtTGeZVoH75IDq21GzJEtVKv+2ph7iE?=
 =?us-ascii?Q?OiczXJDrIDJkLj+ni45XdfHuz1caN/KQXVmkncKgxRAoGwmkqzFqPUFAjIqB?=
 =?us-ascii?Q?aJ7c3NnVKJSG4fTGHLO3Xb+srEhaSi+S29PnoN6Ae4eZ+vlQ3/VQTut8gIen?=
 =?us-ascii?Q?lMTnYKfd5DpNbrTN0rscn6EV659WLXZtSRf3Wy6OB8UZFXMpz9taBBCeVl4n?=
 =?us-ascii?Q?b3DHdSSxINWjJahc32xuebIXUvic0/zI9RgYVtrwwCxYa/p4x6ghutW7/sv+?=
 =?us-ascii?Q?xN6qZ8RIxj6I3PrwQeybCwVn/FKHY8nOjAk3DK+593RHNqOkT72Xaqm2Mx3e?=
 =?us-ascii?Q?+3Yzd4J1bdVaVx8SZiIJcamkLVCZnSiQn8dKrrHUe2BRCYhyiAVHmlu/EWli?=
 =?us-ascii?Q?Rn7iGHpWcc8u6I0VD8vSDoXB8u05IQ/LKXJ47/us?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58d903c-4fc9-47f1-a1a4-08dd4f5ac1fa
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6354.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:55:37.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V38qOzRz5Cmm/k3ZFrNJmquiayS7/uBeDPM2VAKwB6BCpP0+sl0a+p6kPB//tLhtNjlibr3WAf/J1lWM3fMe8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

On Thu, Feb 13, 2025 at 02:32:27PM -0800, Luck, Tony wrote:
> On Thu, Feb 13, 2025 at 04:45:54PM +0000, Yazen Ghannam wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Unify the bank preparation into __mcheck_cpu_init_clear_banks(), rename
> > that function to what it does now - prepares banks. Do this so that
> > generic and vendor banks init goes first so that settings done during
> > that init can take effect before the first bank polling takes place.
> > 
> > Move __mcheck_cpu_check_banks() into __mcheck_cpu_init_prepare_banks()
> > as it already loops over the banks.
> > 
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > 
> > Notes:
> >     Link:
> >     https://lore.kernel.org/r/20221206173607.1185907-2-yazen.ghannam@amd.com
> >     
> >     v1->v2:
> >     * New in v2, but based on old patch (see link).
> >     * Kept old tags for reference.
> > 
> >  arch/x86/include/asm/mce.h     |  3 +-
> >  arch/x86/kernel/cpu/mce/core.c | 63 ++++++++++++------------------------------
> >  2 files changed, 19 insertions(+), 47 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> > index 2701aca04aec..36ff81c1b3b1 100644
> > --- a/arch/x86/include/asm/mce.h
> > +++ b/arch/x86/include/asm/mce.h
> > @@ -290,8 +290,7 @@ DECLARE_PER_CPU(mce_banks_t, mce_poll_banks);
> >  enum mcp_flags {
> >  	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
> >  	MCP_UC		= BIT(1),	/* log uncorrected errors */
> > -	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
> 
> MCP_DONTLOG is removed in this patch. But no mention of this change in
> the commit description.
> 

Yes, good point. How about this?

"The MCP_DONTLOG flag is no longer needed, since the MCA polling
function is now called only if boot-time logging should be done."

Thanks,
Yazen

