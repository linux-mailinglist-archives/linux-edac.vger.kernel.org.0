Return-Path: <linux-edac+bounces-4581-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A086B26B34
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 389847A2805
	for <lists+linux-edac@lfdr.de>; Thu, 14 Aug 2025 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B1F21FF5D;
	Thu, 14 Aug 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jnf7HfUM"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80B32144D;
	Thu, 14 Aug 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185983; cv=fail; b=EB4R3PApdij0ehL3zK+hVt7EMoKUoIif7gEwmnIFepkITA9CmtyU8Atfws/sspU1d8bmvhQhjvDRaHn8w3lZq0H7cxt8Y8jjh7r28jr63QiCdtxblNFBWljIYPArJgkCCCZoPLqvcOWXOS5/T8ezNqPYKQd+ZDCleqlhXlfTCRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185983; c=relaxed/simple;
	bh=J/e9PgzwC0XNr8jtfk+6sb01UTiXClkQ6Ft1lk8ckso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LoaAQsV9tr4TyYpXan5AvuuuWRMqP+J2c5RppXwVid4mrD/if31GIDI/Tb9qurfW3ODNT+AFz9Qc9QmM55ElDxYRVAjip4ib6liBNvd6ejxAdVYS73G1l+4O49XsPN2g1nwWYfIqnd7ItaU4cN1xQb6TkS/hwkF1/t4nxEzx4GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jnf7HfUM; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaZK5crrdiRM1Tz44iRbE5aKIs5uxjRkd78CwN9cGciXkC7EoFzhXvTn61O/AECPknxkEvViErPwzAd7vbQ4DiHFBwaV3qd3o8RKJRovL8o5LeJPAfDeBCx2QnrNmLg2VxdgnlB5gb1q8V7/lhBRT0wtd6kAaiTVHlrwmYeiC4UPQo89nGyUAraAw/ahxR3+nNTpm42Wm5krAQKUnCcrp5b4i28TF+xXbB/EQr+6R+DCLsTZVCsG/SXCGiL68HFWcvg/H2pW40x/npRdmiRajAULs9dBMPFzw7Ab31rBJmwOLhxm8GuLp7EjuY9FSwV4MZCNFH4LgYkmys4bjtjvsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3WFm+wAeH2TNuJrEZ/nj9U6PzSdezH66e9/tXfbALc=;
 b=XDyk+o0KPwbrp1Ca1CSScbZvQJnOhu4RHhCFWsCzvfOmyocXzTknwdGeX7I0YyJc2GTtBM0lgqxb4FF3SFAfMmSSGI0+da8OjttI+3N/vpQRbpbYx0u7ObruJUETrGQXX1xXlSe2QymLptogbDoo6VoSFEnoYQ9wrdZJ1k58ADxKr9sNPcz7jQbdRLq7Qt5NghQx8KHMH0Ed1oklTXJzFK2P3PvAHNQVPM9yzUgurkF0vtr42PvP7V6bd/sWH3P43XtiBqvWx5yr1UMOzhZMDWMD6JdEapq9H7ULc54Omv5QdSbxixk4tIVIfxvHVKa/8eYrgKIFfsK8nzu2n2lCOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3WFm+wAeH2TNuJrEZ/nj9U6PzSdezH66e9/tXfbALc=;
 b=jnf7HfUMWf7loAMd8VFgNyjY/PR37DCAYEK0xkiiRz1Tzz0VaQkX9768eaom/lLWlnqNfxbhiLfNzUm9cWgckfQcbQ3rTPUmRQ3c3x6kPZgtDY96xYeRXMlSUXZ/QoHFOH7u3yefkYuDuu+xdnTHE78p37whtxhWTSu4V4x00xA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Thu, 14 Aug
 2025 15:39:39 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 15:39:38 +0000
Date: Thu, 14 Aug 2025 11:39:33 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, avadhut.naik@amd.com, john.allen@amd.com
Subject: Re: [PATCH] x86/mce: Do away with unnecessary context quirks
Message-ID: <20250814153933.GA148298@yaz-khff2.amd.com>
References: <20250813154455.162489-1-yazen.ghannam@amd.com>
 <aJ0Bmgx7-h1uMFG2@agluck-desk3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ0Bmgx7-h1uMFG2@agluck-desk3>
X-ClientProxiedBy: BN0PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:408:142::8) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b4318d-0449-466f-86c0-08dddb48c710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m4nHiHAuiu3hOVoh2xmDD0oQK7dn5Od7HIzY5X68ElYu5Q1ofB6piO+8f4JV?=
 =?us-ascii?Q?7qxIh1dsiLee1We4YwAjbMl17DJmOBgnlspOgiUmVlORWDbTy90mEEWnxfvq?=
 =?us-ascii?Q?K29rAXKlRBwsowqzTa21f8Fx+BD7vEV91VvyWEiDp82uid7SFkEKSsSQlU4j?=
 =?us-ascii?Q?IcE3n8nSlkyccwzg3UjLfz+FsuwO579NFLvJUc/sga0QV0HGJTHlUb+VIUhr?=
 =?us-ascii?Q?/mV/HHPoMnEWViZOFxgiTdmCVqdi/Qcvi25BrHjSbjTPa3sDwBgFeMbpY3sE?=
 =?us-ascii?Q?MlPxnkIpkJabE2IWQbZyrmnymYqXRjz2tAMuRix+HN/TzHXG2Qx1IdmHQYG+?=
 =?us-ascii?Q?iLKsMPAV2Hui5pHF6UGZCpA6L7OsuA/C2la7ABNLTTfKyHOwgFHhpZTaEW1y?=
 =?us-ascii?Q?ZxZeFbv9nS26YWOJP7hl7w1/XdNA4dV9WHYVDjHSvegHWUPrt/rqjH+CS7C4?=
 =?us-ascii?Q?qg7Th+VRT+K/YFdIV+57I+UuIpo6d94Pb0T4WSBYDznLDrbtQBD2NksABlFs?=
 =?us-ascii?Q?l95tW9lPMf0l/1POq13hg9DfBYc4l/J1RQmIJ81tiJy0qRSWEAKOPBQmqsX4?=
 =?us-ascii?Q?tpx/PjTde6FKgX8fUIA3W7P/AxSDPgjelke10pKuedgc1DKWjmn2HknwAxoo?=
 =?us-ascii?Q?cHss5+gFYlM36sdLqTPqYw4fvoHQt9zYA//69cWhRA7rHAwmtwx1JyV225if?=
 =?us-ascii?Q?1cVrAgFFSF6U7skctn6VM9QOkoCx5XWYCteO49YSWt/FM0AkbtCQd6tivwEK?=
 =?us-ascii?Q?C9liYyioMuoWairyDrgJA8iHiabmtjquOTuzATwN8n0JSEMM6di8uhVYLnSd?=
 =?us-ascii?Q?s09DKgFNer7SfeMAmu+Sz+rC5x+8yKWq6X0Qq93bngowgBisQe6I7V2xnp9W?=
 =?us-ascii?Q?l605H7ZE7nwXGweD8tOwwyMIbHq0uP7OJtW7UgPMXg33x8dgP0kQ0bTb55VC?=
 =?us-ascii?Q?l7i9io4HAcxJbhD4cNq/RLLUJVb03EN050ZeE/3pt2rV13jEgwGRSdiqmqYW?=
 =?us-ascii?Q?BN6jCiUvcI2ZzId3DwZ9FQsXgjb1UdG/H7gYvOVEs1VIJ/8NxxEpvgFO2AbZ?=
 =?us-ascii?Q?s2LauJQtlz4te9nYdTPUqJZD5Kd+hAvl/uaPE9StWEtvOVQNSmWwQehWu3/P?=
 =?us-ascii?Q?pSvZTUAkZfVLYD3q8S/O2AHVNUilBUkngf5y7GchYAhq+yBdjhpJu83N0+Gb?=
 =?us-ascii?Q?XzWEfqM2PkVMvHQsnj/gkt47X7mJvXXV2+dNW5y/Oclo9ihGwQK0ADHiISm+?=
 =?us-ascii?Q?50SgjWX0EaZYqkpelGr60P/plnXXMtM+42T0tzVa/UkMK1Dd3oQwcYg2NeEi?=
 =?us-ascii?Q?mncxYL8JhvzOPORtPka0qLDvPQbPRNg313+eQQwT0FK7SxQUhr4mfFuTwCMs?=
 =?us-ascii?Q?QcwsrGs6xI2lfIRijigYVr92hfm7jsK+wR6j9OLUgdK9dpNdmEQIQ/uIFpP/?=
 =?us-ascii?Q?2cZZihn5l+M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rk9a+eIQf4/yWYJdbLeGthKf768D0C2X2hNIh5MpU3q/XVJFPak17/qkQrf2?=
 =?us-ascii?Q?XWQGjR3bViReMUyqIZ/7KJ3h//Ni+VBlj3G3Bxd3iJuneFHbW7pJ9cebyUH7?=
 =?us-ascii?Q?Pqd6TKwkDBTVPzHrksbN8i7xZQmF+eTjk6cuDxs4DQrp4jldk8Bz6WCLU0gT?=
 =?us-ascii?Q?XyzV7asPSCqmRRj81b1UNdgotOtPllAPH7weWoDTY95Jc1JN9/Agq8tDMWWB?=
 =?us-ascii?Q?kcbk2yvjO8p47RR+FcRBJdPJ7PQZO3Mqbts5MpMxZb8zeShvmrFEHErU+u2J?=
 =?us-ascii?Q?EfVIlTkLAiNzTyLhC4LHihkIcHrpdo/biUrFLu4dhU+dp4X9wqQqS0aHJNHN?=
 =?us-ascii?Q?CQRUdPxUd1CcPlHbjkfUpg3AAMOR6vrhWY4yzNpdbSgp0Ei9vjQwdu2KsfaL?=
 =?us-ascii?Q?eUDMtv+mcY3ij/DHCCyuRL9wkgID9vyIa5eHCl8ffHanqXe3LVjOJ/muAFq2?=
 =?us-ascii?Q?Tk45XmRBY3CfFembvUfmR9e1zZWQBEmU8F3mnGyN15WlZ5ZGK5UNiskD9JyZ?=
 =?us-ascii?Q?fVjV58gNB/vLldWzLfslW8kHYtyJyibSwxOz/V+0PljCVRI7lcAGPfO8PncX?=
 =?us-ascii?Q?K9wxycpu9QkLhvrGidE0gfx/O7yW9njq47dCI4/icBKO/5E6wDWW//6wre7F?=
 =?us-ascii?Q?RCr4b1cVzeJvVQo7SAgh6X3kUwCidOt++UgVfJS78c4mdijWslOvR+T1C70h?=
 =?us-ascii?Q?KOlABhqVhed3aAXPV3q3M0R0Kf+JhdB0i3pcwjgQ4LmBsM4JMbYpz2hUbQME?=
 =?us-ascii?Q?phIq1OZ1jivFd9CA+rOFq3GwmguYTLQyDdKFqrnTNKNw0qoREVQP3I965I4W?=
 =?us-ascii?Q?qg/wi2eZxcdCSeFGvVBTtnc9HSskXslHVU5jvAwMDIx2FWN90aSzWYUvSbgg?=
 =?us-ascii?Q?zNSrSAW/pr7QijZFfGeyJHGNoptxOKxWBx/isoSW3M9z59v6NpBslxl5NNV5?=
 =?us-ascii?Q?iUnn70keyRUQDde4pFLGy6NkTGJlOUf2/BHiXrW+5nS15ylVJ4pjcGhE+u/Q?=
 =?us-ascii?Q?qKFNUxc8HGkOggMZ4iuWA+CJUxkCE56pcu4bmhh8hydRzI3SKsLXcJeccIfY?=
 =?us-ascii?Q?5b85FNeEEEZEw2ia9qR7dBkkEnv6eof3MWavM8VLbIN3yn1q4LL1jgFN/Nw2?=
 =?us-ascii?Q?jy3JQgQ09n00KczBGd8WJlbcQSEoZo6LELpJPAouWTJYOWFH5CzJfGATos5e?=
 =?us-ascii?Q?fx9gqTVzb0a6gnk9Hbu2ed/gXvu7PSIgFqphw60goDvU+6CCxR4Kj2xHZrF1?=
 =?us-ascii?Q?brL8Jv/ehwqiCOcStnqk5hkvWcqD2zLOPfszIpv537bib0cafLnnrxtnUXEH?=
 =?us-ascii?Q?PMaIyTxlUjQBtaS3JmrItlmqZcisxc73bPO3FDO+ntaTCX0BjcZlF2uRubRw?=
 =?us-ascii?Q?7lrFjjtr3bPrzfSi/VvCzmPB19KRwIhWBK92lwI2TrwieuclYURq6NbHkNmJ?=
 =?us-ascii?Q?tB0A5MRIC/Slq+f2WNilfoEY6QbKSw2dy9JmWqFppbQheIwiLoY8gw18DcUP?=
 =?us-ascii?Q?WI37lBsriEaJYmfJ9R+cnUn4faruWgyiyHS4HqSGC/ZvKNN8IUNiFPZpeq2+?=
 =?us-ascii?Q?36cV6w7cLU92uC+UlxBt4Oa2jkTWAqI0CLR+nxpT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b4318d-0449-466f-86c0-08dddb48c710
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:39:38.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAf1XEdWzR/lwv+JdN5it4yehCVySlucya9epiqr8iY6vENnKATE8HQoTHhPw67B5QaEwKfpomk7C1m/i1roQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671

On Wed, Aug 13, 2025 at 02:20:26PM -0700, Luck, Tony wrote:
> On Wed, Aug 13, 2025 at 03:44:55PM +0000, Yazen Ghannam wrote:
> 
> > -static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs)
> > +static noinstr void mce_gather_info(struct mce_hw_err *err)
> >  {
> > -	struct mce *m;
> >  	/*
> >  	 * Enable instrumentation around mce_prep_record() which calls external
> >  	 * facilities.
> > @@ -467,29 +466,7 @@ static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs
> >  	mce_prep_record(err);
> >  	instrumentation_end();
> >  
> > -	m = &err->m;
> > -	m->mcgstatus = mce_rdmsrq(MSR_IA32_MCG_STATUS);
> > -	if (regs) {
> > -		/*
> > -		 * Get the address of the instruction at the time of
> > -		 * the machine check error.
> > -		 */
> > -		if (m->mcgstatus & (MCG_STATUS_RIPV|MCG_STATUS_EIPV)) {
> > -			m->ip = regs->ip;
> > -			m->cs = regs->cs;
> > -
> > -			/*
> > -			 * When in VM86 mode make the cs look like ring 3
> > -			 * always. This is a lie, but it's better than passing
> > -			 * the additional vm86 bit around everywhere.
> > -			 */
> > -			if (v8086_mode(regs))
> > -				m->cs |= 3;
> > -		}
> > -		/* Use accurate RIP reporting if available. */
> > -		if (mca_cfg.rip_msr)
> > -			m->ip = mce_rdmsrq(mca_cfg.rip_msr);
> > -	}
> 
> You moved an abbrevated vesion of this code from mce_gather_info() ...
> 
> >  static noinstr int error_context(struct mce *m, struct pt_regs *regs)
> >  {
> >  	int fixup_type;
> >  	bool copy_user;
> >  
> > -	if ((m->cs & 3) == 3)
> > +	/* Without register info, assume the worst. */
> > +	if (!regs)
> > +		return IN_KERNEL;
> > +
> > +	m->ip = regs->ip;
> > +	m->cs = regs->cs;
> 
> ... to here in error_context().
> 
> Would it work to hoist the error_context() code into mce_gather_info()
> and have it set a new mce::error_context field?

Yes, maybe. I do think we should get the severity once. Maybe this means
splitting context, action, message, etc., into separate helper functions
rather than all done in mce_severity().

> 
> I ask because mce_gather_info() is called once, while error_context()
> is called multiple times (on Intel ... not sure of flow on AMD).
> 

Right, because of each mce_severity() call. Intel has multiple because
of the monarch reign flow. Those additional calls are just to get the
"message" for printing.

I have another revision with a more minimal diff. It'll just cover the
quirks case and leaves out the changes for VM86 and mce_severity() for
now.

Thanks,
Yazen

