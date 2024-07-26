Return-Path: <linux-edac+bounces-1568-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CB193D4B1
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2024 16:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8AE1C236AE
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2024 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2717E9;
	Fri, 26 Jul 2024 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DjVPC6t+"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D0A812;
	Fri, 26 Jul 2024 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722002446; cv=fail; b=BSA9GuGbm2p/uwpBzBSlFIF8a1bkkPMrnAhyZZQE+B9x05V9g4v2CIAeNHBjCYwkzXANIb+fK9Z5JD9eZMnc0IElOZEXSn2tqkqdti1zHMkWRD6Q7LvR1ykhDT73HfcVzctP0pAjZPq1xybizM7gNBtUjkqF3FCll5wW447Zvs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722002446; c=relaxed/simple;
	bh=vBfxJL/8Y7LtkhoSY3wZ+l/KeimagLDc1YeAkq2NQ2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uyubCro5jd1WgSA5q4ZaXtUwYoRkmbfjQIgDwAZCg4NVHPhlRDqLO5JrwtC/e3EMNiYLNLbGuZ7czohuY/gi3jl2TnMTH2GrFpPqb56HB1bYqt/PLhm/mdh+xabdmAe/jlDNih3ep3giP0dGA3cmP195/TSJ7pqGFDO6AcUJf4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DjVPC6t+; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NT3oYHYuuRvPkHvrrUa7VAh/1vjij+6mHnH+il7XGZd8n7n49GT6QoNR6mv7yuie/GUfdOlsvrjRRLPJDnye1YMiyveRhmsqA0vzMnAPpH366er1Kz0hHYhTevdNIs3ZIps3CPX5CIg+7HwRJpXbh2birNIKG8xEriKx32HuZOVFfggTZIsBbiGXCu8qQOMh/vKUt1VDlfTggDUzCtR3GH+QnaBOfTSVQ9MA8q4Gm+PlsP3qCgGy83qJ7/037k5JUukWjuhI0k1O/55WS8myr/e8RlnP1xskPo1nlGe9AFrjNM+NPi5rRtm9qIGvqKHacD4dRol67/F3PBygx+E5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7qalojOFv2KIiSD56fx/NnxhMbo4+6A/fSLFIF7uk0=;
 b=TqEgx/zyl8/lgXya8Mg8iRaD7kNW/Txdu12p+hP4vvFLgHJXu26KvOm/aLwNIzUeQZkyMqMHzojLRsvJRdDu6aywVClbzIGI+fvuesfnxfSXVSqdiG5gdN8+nnaOxEHAGumSkvmaCNP4NPd7J9mu8IIbCCn9nQ4n/eTzBu9VI9nhVSH/B/fpFj7msyurZhfjhsanRmSmDn7O9Lnm1K4F8xOvIm5bD2sbMRkHgEEEn28Ruf22YKXqMQKu0lDrIHp2Ttm5NC2EXG1ZwVii0M1sL0HdcBaBu7yOs7GrRqceRSgKae6aik/UBcuzkDCSXR9UCctB1yeFb+Ayvm0dzICuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7qalojOFv2KIiSD56fx/NnxhMbo4+6A/fSLFIF7uk0=;
 b=DjVPC6t+GGI3Ioc7aW4/ZuKbjBejlB90AlQY0PC60GHt6AZvm+Emf+QezXu7odjjU81ROk9axK0D14UovRuB0PfDUHz49R6vpv3Hv2WhGmCYNLsAuxXCRkU5tIRVma2Blf4cMP8F1NzYBo7naFaMlSvVRT5UxTE0h+DUgmS/mko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 14:00:41 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%6]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 14:00:38 +0000
Date: Fri, 26 Jul 2024 10:00:30 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 4/9] x86/mce: Move machine_check_poll() status checks to
 helper functions
Message-ID: <20240726140030.GA193170@yaz-khff2.amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-5-yazen.ghannam@amd.com>
 <20240603173727.GOZl3_V9eVbm0184Wi@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603173727.GOZl3_V9eVbm0184Wi@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0524.namprd03.prod.outlook.com
 (2603:10b6:408:131::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: b35ef19e-6c0f-40a7-b20d-08dcad7b53e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8XDUM1oxaEagClL43aSEAVGX+YNm8D21tPMojppxOFlVfy6pl1ALXrMwXKMZ?=
 =?us-ascii?Q?55hozk0yUCSHSlorVBePesIz3ka4ObeyRPaQ9vjR7dv6O29meOuLR7p2hOZJ?=
 =?us-ascii?Q?JoiCuVKIIuwuouhVwR8czTpQN/BVeHOq5wljZUfWodS3QwpFfKdv1GVXz4GS?=
 =?us-ascii?Q?2+pgIO+qUaab+8H9iHFIiZmLwvaXDFSrIGaJHedHLhEu26ta9+S6SCECnwRj?=
 =?us-ascii?Q?j8LB+taykdWgPE36nylaAxH21tS1Wx8Oy5qHo0TJJW7cmzbP7BcROpG/NjNP?=
 =?us-ascii?Q?wqG8I/uSqm1nlClmnUbR1vTbLX6fMQ8SdORxzRXCN/6RVjrnTzbJNxftUJvB?=
 =?us-ascii?Q?q5Z9hoDqOO9NR+bwPtnY4kNJWndbiifH8UTeMDSGEKWvVSqDZzzhDv9e63mk?=
 =?us-ascii?Q?LZazx8F6LHa2hKFxFibnKX+q7CXJQxcL16YihFjv95dgf2nTqTKTnjbDPFk1?=
 =?us-ascii?Q?V+QoUWkSnN1YpFdKEfJBy+5MSoDbdcXD1WYeSfRA3IJS/oJKKWkMPbugEOiW?=
 =?us-ascii?Q?2eKOir+OSS8ByHo9T/t08BbZxg/BndhARJ6NfaOwOCOUFeIgWuYY5m+5HJVY?=
 =?us-ascii?Q?yTog8iO5OxY2jSwwSc7fk/Z5vqLz4yOS2iZKA8M7WJPr0iW58dePdzTrXY/K?=
 =?us-ascii?Q?qwwQ/DS0mOIm6a5kpd9/BKTlflcw7XQh+8LDlvFwRS8DWnyywnEiXgaQPpcv?=
 =?us-ascii?Q?C6ofhw4pZEoRf1CxItD3OsSVfPPQKwNrK/P08mm8rzgV4cbM/pfeqGTYW3L5?=
 =?us-ascii?Q?Na6NrLznm5TtaG7Fc3VAh8+MLIe/PoUUaawWCarIEoOh7tEnn7htxGgOx/lw?=
 =?us-ascii?Q?IQYmR8WKu6oGOqZb/8+bSrx2cLCi9d2HDPs8cvjhLsO7y2xToFsbWIj5TnxK?=
 =?us-ascii?Q?Ta1srWEnBVuyHZga5IsjHfxJmfZ7l+ASxnZulOTLC37XOS0VzeVt3nDPUQu9?=
 =?us-ascii?Q?oMuRqGLJoIeP1eLpIs/0uvpRY58oIiBvOfjgYtg4K0XtPtFgxRX0shnCDNP/?=
 =?us-ascii?Q?Mxgcl35MlmTGwvL39d4a1dvZKeDjjI8vhWiZuBdMoPxqiGwIx09hJW/A41Tf?=
 =?us-ascii?Q?Zv/q5UEDQ1d7JqdGwgl7+YH9jyLXs3J+ISdCKDtOYtUvKFlgBiTBy3xEOc5H?=
 =?us-ascii?Q?fwKCRIogIX/4cL6nlCwgXbel6TeF32tX4LcC5uvqirK2xfpNC/v2HIxffKPO?=
 =?us-ascii?Q?XqxvCQsmaEOK//y9ftpfO0W2D2RTTQR8TAIoTTehdFGLUL/cMgl9BEwggNvz?=
 =?us-ascii?Q?VrwvTSBBNmsI6DIQGh5N1vwPvZn0Az/cY5Db09Tn8pJaASUXeZodprvjfKtq?=
 =?us-ascii?Q?oe5M8I8kC+TOhLkl0uQWWttHiv8ATK3W1JSQW/bpK6QjUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+iGVD3xwtGL8B8ixtGh1NWdSXYOcgdDIP/ch1OzbDqN7Hb+iEimCVMmfX2s?=
 =?us-ascii?Q?C/Y0PvkTJVIU/SpWzQqvZ4OTrbYXuJCS5m5guzsSGqy17asAiH/hHAEqAo+9?=
 =?us-ascii?Q?NiqIZQGWMIG+c6VKC40+tgRrkuLfE5UliiFKv4IQUzzZBqVFCimClahabuFX?=
 =?us-ascii?Q?wOwuDqSdI804/PO3JfcuXNU8QthhUmipNV1URq8aNXOFTcw5blgFabdC/8ih?=
 =?us-ascii?Q?fA3bvCIDNuGrEdUiHlByhl5CYLdWikQkc9517f2QOqNScFqRd0holvKAzlG/?=
 =?us-ascii?Q?EXtFiILuCDa5RGy7E72MFbjlkyvFubmwRjpv2i52jriqsAhadbU3C1UkZcB2?=
 =?us-ascii?Q?uAIJLLHv4mZDdVuNyNS24yjssSEMJbreFN8WHrvRyFLsxs7BD5/e9+aWrzGw?=
 =?us-ascii?Q?OTWv2H5w8kN9SIwf/UR/izBnF3cTN0heakpifi60zoCsZtnfAngEHn5tK+DZ?=
 =?us-ascii?Q?1zUjUdB0T3E227iX7uHTVEH0c4djnK2SVXpcLhToDlPi+DC3NjcFuTrXcBqc?=
 =?us-ascii?Q?exzP6eHdakP9klh0HR18N71P9ip/SBiVObltwBCVRzdUsvOESMrLm+OxJjCR?=
 =?us-ascii?Q?TxctUjAoAvcZNRhv9z/riZHg6JvqK0qmlDoLj2HU0fXGglmNGVOknFVd9a/H?=
 =?us-ascii?Q?siwd7fPr2kPF3Yg01MYviyjSF2yQ4KRZE68VdFiu9JuJEwfo4Er0SqgFLkIj?=
 =?us-ascii?Q?uz5v4FfF43el5NrP3LXIiMzeXfQzXoWBhEoGIQocqiC+5H/32v9EqyoQcEh0?=
 =?us-ascii?Q?rAnhRHluSd7WJZJRV1R/rjjlDIDqlC8E3Wd/Psiql5R6Va1v3vKzx2orrD93?=
 =?us-ascii?Q?Dx+KTdP6hcspY5j7Z3PLOgO+3qck+e6e7XxoW06d2SG7UuthhuCE4wZ9Hcbi?=
 =?us-ascii?Q?hQAOQNTnJCA2I70KZTCJkUi9Rqv43tdbFg1PsVwBp+EKIn+nZ5hz4GFBzUi3?=
 =?us-ascii?Q?NDDncMZrC4ACHTZpAHfgYLoo/1XW6/GxKwwAX2r8bgthBAn1f7i+tYQdc/9l?=
 =?us-ascii?Q?p/i8ELea4Z+7ewB/oOOOmcJgI+qq9jCJEFWBhzzcoKcqsxASDJMuwS8VqLXl?=
 =?us-ascii?Q?NPyR8KtGtbqVsAGXyVj/on2tFI+MH7AqDvQ4edSt9mDsjhGtUDJVNn1mRyat?=
 =?us-ascii?Q?UBrGATeqcjkeuV//3R74uZ1DKN+0bs9+zNTOTQXMnG9EjaXm6wUiysx4HQGP?=
 =?us-ascii?Q?Y0mxPAI3i6ncLLCk59Xoq7UCA7pi5FqnVKb6e8ZYylXqN5yJid9YUeqJW277?=
 =?us-ascii?Q?5oUhalLzuGals1jUAkErDVfaGlfefr5v5bAm6B/FqJp55GcQqAUNbEVKgJBG?=
 =?us-ascii?Q?LqFfsxHgRzP5q4vjyvVH6sHeRJV5ckyRWRSJt9TgS4o3E0Gzxyv/PCKZsHvr?=
 =?us-ascii?Q?HSaVAeScICEAC98gjFdCbHB2fwIXOLskjk6QLppbXM3Y1S/eevUYNI7nSLZB?=
 =?us-ascii?Q?vPYOlu9Z6rJvPRaE7Z7f1iSJuxd85mKrgVpGIcuc68IRusHIa9aClWH5RYNJ?=
 =?us-ascii?Q?rdwJU56apryIkNZATfcE/zoRxysBo+VftZGJ1c9rEkrS7SWUieiO/NmZZG4b?=
 =?us-ascii?Q?LuY4T7hCvs5f0s05BiB5nJtIFJtkfxlHtqJ2aE4C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35ef19e-6c0f-40a7-b20d-08dcad7b53e0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 14:00:38.1511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aprOvQu+FW5m2jcqzMdQ1QyK9tGzR8fC8HZYm/fAG/ZWacL9ti8CWWc1zLsXKUP9r3QBMdbyc1xKQHodhCnkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651

On Mon, Jun 03, 2024 at 07:37:27PM +0200, Borislav Petkov wrote:
> On Thu, May 23, 2024 at 10:56:36AM -0500, Yazen Ghannam wrote:
> > @@ -709,48 +747,9 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
> >  		if (!mca_cfg.cmci_disabled)
> >  			mce_track_storm(&m);
> >  
> > -		/* If this entry is not valid, ignore it */
> > -		if (!(m.status & MCI_STATUS_VAL))
> > +		if (!log_poll_error(flags, &m))
> >  			continue;
> >  
> > -		/*
> > -		 * If we are logging everything (at CPU online) or this
> > -		 * is a corrected error, then we must log it.
> > -		 */
> > -		if ((flags & MCP_UC) || !(m.status & MCI_STATUS_UC))
> > -			goto log_it;
> > -
> > -		/*
> > -		 * Newer Intel systems that support software error
> > -		 * recovery need to make additional checks. Other
> > -		 * CPUs should skip over uncorrected errors, but log
> > -		 * everything else.
> > -		 */
> 
> You lost that comment.
> 

Sorry, will keep it.

> > -		if (!mca_cfg.ser) {
> > -			if (m.status & MCI_STATUS_UC)
> > -				continue;
> > -			goto log_it;
> > -		}
> > -
> > -		/* Log "not enabled" (speculative) errors */
> > -		if (!(m.status & MCI_STATUS_EN))
> > -			goto log_it;
> > -
> > -		/*
> > -		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
> > -		 * UC == 1 && PCC == 0 && S == 0
> > -		 */
> > -		if (!(m.status & MCI_STATUS_PCC) && !(m.status & MCI_STATUS_S))
> > -			goto log_it;
> > -
> > -		/*
> > -		 * Skip anything else. Presumption is that our read of this
> > -		 * bank is racing with a machine check. Leave the log alone
> > -		 * for do_machine_check() to deal with it.
> > -		 */
> > -		continue;
> > -
> > -log_it:
> >  		if (flags & MCP_DONTLOG)
> >  			goto clear_it;
> 
> Btw, the code looks really weird now:
> 
>                 if (!log_poll_error(flags, &m))
>                         continue;
> 
>                 if (flags & MCP_DONTLOG)
>                         goto clear_it;
> 
> i.e.,
> 
> 1. Should I log it?
> 
> 2. Should I not log it?
> 
> Oh well, it was like that before logically so...
>

We can rename the new function and add comments. What do you think of
the change below?

Thanks,
Yazen

@@ -797,9 +797,11 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
		if (!mca_cfg.cmci_disabled)
			mce_track_storm(&m);

-               if (!log_poll_error(flags, &m, &status_reg))
+               /* Verify that the error should be logged based on hardware conditions. */
+               if (!loggable_poll_error(flags, &m, &status_reg))
			continue;

+               /* Clear a loggable error, e.g., one leftover from boot time. */
		if (flags & MCP_DONTLOG)
			goto clear_it;



