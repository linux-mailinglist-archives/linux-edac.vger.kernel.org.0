Return-Path: <linux-edac+bounces-3474-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0104A7E43C
	for <lists+linux-edac@lfdr.de>; Mon,  7 Apr 2025 17:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425AF441A5F
	for <lists+linux-edac@lfdr.de>; Mon,  7 Apr 2025 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC83E1FBEAA;
	Mon,  7 Apr 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fGBUZKn/"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D51FBE86;
	Mon,  7 Apr 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039024; cv=fail; b=KMDLMWxDDRMiLKoe+S7pBVbAxkVlb7bTPJTA1uYY/0eLbJfZOpcrzM0vXM2U6LqshTPMmeKWADELeJ7vQATM5+ECFd3mGJBJ7ddGrGHLFXqpAeQr6R/YU9VKzJYAfMgFTYasPJs2IkF8r9PWOs+Uuyhod9FvEhuF1Uds1ZHjfpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039024; c=relaxed/simple;
	bh=KRFtB/qusAuDN0MuIYACeNcbRdbw69n3k9mAy09vino=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z4CRfGcwKwRuig/6WlAvKRtHkO6zt7GLjs/F2RRwGDRebmHR+osY8xyKYmiUhvGXpZK9psuLSYWaH/MrvsRpoIbL4iAu0jRz2Uax0Ofv2fmjNcmdO4Y//CJW+nZFj+dujzz1NkWg23R8C8xAQpy7l2w5f3Kh32d/bGJjgBFH5nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fGBUZKn/; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ss3uh/D0n9OqSAhZxhhhyI3S0oTXB7B9WgUOLtsXQoemb0ctxBldq8hfEqUcOhOB9hrk/sD2w2FjkO/r/7ESK39/u8TbM1A5GBocL7OzdmYEYHRCc287nVR+N68j2L7OCziGZCvg52ShdRQm6AjkB598RIP2e2iC0U+UZbzA8SVGK4ajHeYy333QPKLd43QvN8MfJR54J2xIaoX+4K1ygmYKU/mcvkTqaFvCzida1d+sEfLY8wk0P5tBxPJf0ck8jETHbUvphvLfWPMcVldMvTqZ3TPj7/02ERNHgxnvyo8q3ON+ivmaJr1W03nofxZRoGM9dUFFQgU+kHvLdXttKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFxVYHsLt6dUUq5M4FyAlGlw0jyuZItfWSvAzfcj4sw=;
 b=T9pWzhNYwvVFoHC2Pve7jWHlPJ3I9bl3qyg+0qmKrrMkrHIB+QmRqR74pwrZLeB+Z9sfA1EP2dwfsJ91BZb43+88iMDj6HLsgW+Jvud313al324pG3Ux3z2WcXPGQ3zjA9idCCbbdSX/NNqf9T6ADhWNQUcMaytP/YRcYdJz/vN3qZxBnfi0hkMcMOWOl8QdGfSx+mxACicQkBqqZJqCc/LvANt8IBci00UNfQOjvSva5QSAZ6ccgIq14EYvb8P2DkMotCBB0VqAIxDlLkkCA1BqACAaIqKuYgKo0HCZUktANw4BbcpHtyn6XbsuG7wUHhkFiKqLTFaVroZcfU7Q2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFxVYHsLt6dUUq5M4FyAlGlw0jyuZItfWSvAzfcj4sw=;
 b=fGBUZKn/vpa5seNa0highwfRbFcxpx7isc8ewuoDjW3fIEURGzytlZXyRvYqrG1i2AsvgQ/3ZFdA6TZP56i5jkJiyV7k2M5mOmMGRsDqnjsRCykxZIq84CBCZnCsWkvihBTEKDiKfm+j/Q5oFdo4E5a1FvtZOGGA+UTcBzZm+rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.45; Mon, 7 Apr 2025 15:17:01 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8583.043; Mon, 7 Apr 2025
 15:17:00 +0000
Date: Mon, 7 Apr 2025 11:16:57 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RAS/AMD/{ATL,FMPM}: Get masked address
Message-ID: <20250407151657.GA1948540@yaz-khff2.amd.com>
References: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
 <20250401-fix-fmpm-extra-records-v1-2-840bcf7a8ac5@amd.com>
 <20250407132415.GCZ_PR_82FKBcsIuGr@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407132415.GCZ_PR_82FKBcsIuGr@fat_crate.local>
X-ClientProxiedBy: BLAPR03CA0159.namprd03.prod.outlook.com
 (2603:10b6:208:32f::34) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 554124a1-0ab5-495e-fcc7-08dd75e73ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u59R9jP4TcnxA4y7CKPoAZqJP/9Apl/D/5hHW2Cr/wZS15Kie55wpSBIUdtF?=
 =?us-ascii?Q?bSTWCB2rdrGUuBgisPwzOP/c8B1S5hkBnSsYkw1YO3yhK4Syit6F7dKIFnjU?=
 =?us-ascii?Q?FZCR+pviRmbwFx5AXjBPw/yzX1nYMOLrkDKeq1k4+ZKNF3BEZ0Usj39vDm5x?=
 =?us-ascii?Q?M1KusxxNEOTYtz2HnWGUfy5oKx8sYIer/2c8nNu0biTVK81ZGNoANr1L5bLH?=
 =?us-ascii?Q?pman20zMMofEftrCaTD7HANkHhWvNNUwiWw/gtBoXUUEdH0F1s2FpeMBGeMn?=
 =?us-ascii?Q?273ok11HM8azDEsZz7y4pxfpapl+K1hZxGn2ZmIfsNn1L960qrlHvCV7Twde?=
 =?us-ascii?Q?eRYlgFv9CALF0LxcUqPlBqtgf3b2fCtEq0sW0af+V0ds5TE6wGXtGJ056w0m?=
 =?us-ascii?Q?ubnCy0bEQtDZCMIDKURLNkT+Enbi9gytqN54x/p9BZgOcZ3dYfQDU8Amo9J+?=
 =?us-ascii?Q?Zk3S9umw+Utsh8mXXs3XU7YBNElQyWG+w4NJV5BXlmcBXEcSLzS7T0rqRQM7?=
 =?us-ascii?Q?A/mTFrPkCeuy4dKv7yjEA2MDh+Z2iLk7WfTDAqCkm2OjrpY1BsuWBaGSCDLj?=
 =?us-ascii?Q?rzTOi4puotE0eP40WlvgPMxRoBmzEp+u8xU+dixphyRbJ90CRWsnRIA6FWq7?=
 =?us-ascii?Q?oMgsiLmgXByyz+1ADrgmwiKYdRfWipjysjCxkx1S4yRQPdJZ78TAmFfI9sA5?=
 =?us-ascii?Q?YyYxSGsg2C+p77gUiOBTAPF3ErTd6l6UeezXPFKALgR1C0ZeEPwDtBQRfvf1?=
 =?us-ascii?Q?aWxBmQaRhKZUvoY/UEbAA2bLxb4WtqADpdU18IkSfr0tzWz5INerOt4eqjTv?=
 =?us-ascii?Q?rUBbwCS71PCBNihsiL3Mh0cMQRq8TQKVdaJcMcH1MTvu2CKe5svVGjx/UCT8?=
 =?us-ascii?Q?cdpW3yJdlMeLwffCY6Fa5FZRFVo9zD5DzTZBszE8tKRsrjHUGervT98fcHSz?=
 =?us-ascii?Q?Dbl2VIHutod9IjOWDYhHWHxa+OZ2Vx2oHpCrAcdE4EyD2fx3+fu0hVXMaJ/2?=
 =?us-ascii?Q?R/4B484rAOsSmY561ukjsfRwOz9UIL742Fdu7kGMisJAE7V1hyrgh/XxlPO+?=
 =?us-ascii?Q?WyjOeQS5thesJoj8J4I12SKOAn9NoU9jsy10nZq7gtswZ8h/RkBZ0VOHwwuD?=
 =?us-ascii?Q?3nd9vOMYMDnUqy6xTMdoBG70wkcnbQIInicDfuArMwf63WSJR4FFNYowaNoV?=
 =?us-ascii?Q?8mckeISAWj0vcnAa9yWAkPjrKf/9wSQyOpGYkYqb4916zQkYTBtV+we4oHvy?=
 =?us-ascii?Q?mJ/AKziD9Te0dh8oiqLx9gfEDxWzz0hGWRg5gmKRQNzkyv9NL6wYnW11JaS3?=
 =?us-ascii?Q?ImuHplmjiF+sD7bQfz7FdGaYLRkuYbXXA1GJq2rE0t5fJIHfy7t/LNjJWmxa?=
 =?us-ascii?Q?6UkBqS6/09ZfDGdE9EbyeoW7KH1X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1haDwPKz0QMXFzwVsm602dXBWIh3ooZFYmz5Apx6VLbruOMVmJOBTV3wEq2?=
 =?us-ascii?Q?m0STTjz2a3lfED5MnEEAflzuK8bL7rhbnnDhXf55alLAcHeHYYXkFepzXoTd?=
 =?us-ascii?Q?Jav6JvGjuvZ6qM1H4Q4Zs5Zqv6rnM0yEs3dPR/lC44le56FzTy8eyRbcAoBb?=
 =?us-ascii?Q?TjmZrmJ+7ytNaCuv85P7559t2lkrEquA0Zh+74m9ncSmsco4pDZJ6S6o7PCH?=
 =?us-ascii?Q?amHSgCCa7JsXNVMb7v7S5+6+Ry+K7w/wZ2VD5Q16mjdKOGrKBYTEBXhaxj59?=
 =?us-ascii?Q?L35KwmQpozou/LF8m2kqOutEtzdjzvqXTWMGZN2J6HGAkQWJTM8cQVBO/74b?=
 =?us-ascii?Q?oLZkMd84OVKuUwhZdI4BEodt/mF6S6DtpIihbvpAndhspDvm1fNvCaj0Eun2?=
 =?us-ascii?Q?2P6eJY6q9T6zKvaA5+2qnYkmayewMQ0IzxaNKq5IPiBp5GplB+8UUevD92U0?=
 =?us-ascii?Q?asLFH7TbfHcqpYdr/56JaxZelPAhjcmA1SXGT3jfB5B8XSwrQ107QM5uiaQ8?=
 =?us-ascii?Q?ijPc8+pOUBPBmxcp+2D/brsb3CyB2u0kMjR6s/F8amojso3qcJjuY8+PtPCo?=
 =?us-ascii?Q?HFMPHh9fuFsLIWeZU1f1Q7DADcetamt4unTkthsNdX8XBoQtGxWRBSwSxOLm?=
 =?us-ascii?Q?if/QWvruElVeMaEYNkBhcolG4Ju9kbI6Em6v1aAQ7YhNSDU8zBiBDvxp3n+k?=
 =?us-ascii?Q?8YXCZhm8Or15guaSo0WCAyszbNgeiUVOEv7uIfi7yk3ZaLVn0ILw8CiM/OX0?=
 =?us-ascii?Q?mK35+Ktj1zPDRhui4s60kqlLvNU6rTypOcS3Ox1XMJM+doiX1a8R4nmkYpzp?=
 =?us-ascii?Q?8KNsMHZEOpMrhNQ2ZXvKL0TjIWPPlS1MG7M+9wBoWiE1YB5VbvlxhNKkBDyv?=
 =?us-ascii?Q?8qsjJyBbynFoJ5ZwQf327okNmNUJHhNDu6vp0WDBzrLRmTQdkS/GXycYFhtS?=
 =?us-ascii?Q?23teP+BoEyLZymu+NN8MUtyV/OLv1IXMV01g17rEp93/Z45Lyer4pr/tQOYt?=
 =?us-ascii?Q?c/XcOVcoTAMfhlOrSPqcTVaLBkEp8BTLcHHYL1aWYtNc/v+r0+UemYHh9vnB?=
 =?us-ascii?Q?xt1OvY+q5fwEHUkFq4TbIKAgbbdmWhHjvRyY5oP4aR58Q6FKJpM5amoh6xif?=
 =?us-ascii?Q?qO+um24KOF1wqsFbBhwBBeVTzaXAFfv0Mcc9JiwF7vAYQtsmxSx/C8WzzCnL?=
 =?us-ascii?Q?tMirfldTHNrCmjTgY3Lb0E6QDD7HlNJtrcjevBvvUScxyGIuU2xvxvWweaFR?=
 =?us-ascii?Q?5AxN4Yj+ggj6G83U7il4DsCooNnnPvwNfvyjdZCh4RKzIgQZoTGqV3iwpeqK?=
 =?us-ascii?Q?vAkZYRvtR8THJLpGGsI/3aKaP6LigADAeBRq8BrVdCcVV+Kinn5Pc1Mq43DL?=
 =?us-ascii?Q?ZFX/03ZC+wA/nsui5wGoHhiwru+ziysY8AXkeGzGAgLVp8FtmqRkAHqMGnXv?=
 =?us-ascii?Q?tAlkXvA0JHwuhnqCjIjd1A6jDMc4V1+C6uxQnCUXt26jgAql6gsDDasZinv8?=
 =?us-ascii?Q?TWVMz7kAjlqdc+9MLTnHeyMjk2MYlxJZKcmRK9GHrdxxRIx5Eh+NqS7bPKo7?=
 =?us-ascii?Q?d6hFtUGm3tOuC6L2rvgEjkUR3oVN43sgD/EOBlr8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554124a1-0ab5-495e-fcc7-08dd75e73ea0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:17:00.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVcBVd618JHLm714vnYVsHiaapBMETJ3UilbZqnCJjp9zGOZ8S3I4QD9ep7+QuJzi+nixhuvfwaGzss7MkuUhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875

On Mon, Apr 07, 2025 at 03:24:15PM +0200, Borislav Petkov wrote:
> On Tue, Apr 01, 2025 at 08:49:01PM +0000, Yazen Ghannam wrote:
> > +u64 amd_atl_masked_addr(u64 addr)
> > +{
> > +	/*
> > +	 * Row retirement is done on MI300 systems, and some bits are 'don't care'
> > +	 * for comparing addresses with unique physical rows.
> > +	 * This includes all column bits and the row[13] bit.
> > +	 */
> > +	if (df_cfg.rev == DF4p5 && df_cfg.flags.heterogeneous)
> > +		return addr & ~(MI300_UMC_MCA_ROW13 | MI300_UMC_MCA_COL);
> > +
> > +	return addr;
> > +}
> > +EXPORT_SYMBOL_GPL(amd_atl_masked_addr);
> 
> Uff, an exported silly helper.
> 
> Make that static inline and stick into a header so that compiler can inline
> and optimize.
> 
> And that header should be drivers/ras/amd/atl/internal.h
> 
> Also, the helper should be called "atl_mask_address()" or so as all our
> functions have verbs in imperative tone.
> 
> > diff --git a/include/linux/ras.h b/include/linux/ras.h
> > index a64182bc72ad..e822275bed6a 100644
> > --- a/include/linux/ras.h
> > +++ b/include/linux/ras.h
> 
> Internal helpers go into the internal header, not here.
> 
> Thx.
> 

Okay, will do.

Thanks,
Yazen

