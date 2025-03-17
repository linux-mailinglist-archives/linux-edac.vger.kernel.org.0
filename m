Return-Path: <linux-edac+bounces-3361-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5FEA64E03
	for <lists+linux-edac@lfdr.de>; Mon, 17 Mar 2025 13:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E746D175767
	for <lists+linux-edac@lfdr.de>; Mon, 17 Mar 2025 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50B239584;
	Mon, 17 Mar 2025 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MbaoTREa"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9023F296
	for <linux-edac@vger.kernel.org>; Mon, 17 Mar 2025 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213234; cv=fail; b=j+t83s+p/3oglRJ0UQgyROWw4RbuJcY4otbV+2PxdARcMCAmnMVZ+qA5iWXUPWKfNje6kF3/IA3xlROth1kS5pUc8S9Wn2JhPmJAqSexsJ4A0timlFFRf4koQRCFll+nG7H9F97/d/CxvTYK+DjXWss687lPQd5dIhaxvlK6Lu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213234; c=relaxed/simple;
	bh=0n63wRKyFy9sDWFi5eXgb8QjqO78kRdoK0Bdu/TyEtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FA1KyaveePDs8PE7jQd04oY8Om/VljUIU6ruG7u/4ugtfuCmNJEVcXJThL9td4VtIG7NFCgN0LVd4sjAJYs8KzBfHFQigObajFMYiygqWqv/UWs1xcgucmqjfnen0cnU3egOAPsyxk83YszxHWOcGhYCv2xlH/DPvLDa2pzxY2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MbaoTREa reason="signature verification failed"; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFX7uC26C2ZrMtqw4s8INmAkIDuIreI2Xu0c15rNs7AAFheQjvUl6jpt5NLgJdmf7EP+yXT6r9U7JA/jLFeSudAUY5G59MxpDj3ghrjTQUi47+E+VggBQ+fIYKrQrLOED6mNvLvbK9wo5pcwEBNqqMAXP/mPr246FgCODC4A9axHSW3MdMURsynB+T/BXsbr8E4leMQ9QvpxDOy2hTQZ5MTFgPB2aP6j06eIvaJ7M3pvE4JuruAlft9+Ezo7xNtU1gnURKElLNjJx8CmXqg5b4duGtdgm7WZQJOvIw/whHQa6703YcKODh4zipMXdsRpqJhg5Bh3T5nCkrcZLoKb3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mG9ESFOwrD5/RhC3QzWGQxqSyAHHO5Gkplvq1lqqK/A=;
 b=lQpTr3NfbOG8vLZEKaFHwMuzY/7GdRkg6Em+d90fnF7GIkeWeXtRqKrVI5tramysBS9d5Q4QvIJxD1Yh6dIDk08/axNl43OZKiSY6PIf23PFWNxic+ekI1r8lIMLcWrw7njmBEnShGY0GX8B6a9btBsso1wdr9dcN0dSoUbOiho4bT2Z7qRPZgetWR/FCtuxDcyW0iiJS/TTR80x6vEReImUFeYU8MnHmFCRTxQdQ7IpdwmZzJa/WI9RPc+rg2Nc/+xJ7VC02xFpGf4ppx3VpkM0Cj9cXDL69VPsuUpvnS5/zAxtiIRxlkbJIExuMTXfCyyuA6TchuqK6b4hy+XOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mG9ESFOwrD5/RhC3QzWGQxqSyAHHO5Gkplvq1lqqK/A=;
 b=MbaoTREaFBNJ64CmCn31UOhdBqTW4qnmfXoyY69HZqbuOMhMhlXNGw5shNfPIp4GUwbYcJ8EClu+3NIpzhO0NbuQaKTmm0V1cQLmQzciRCrqFOFyW5HTtScw8tNO8PN8O2M2mEszc8ihhODlQY9RhzhfpP3souVsA7GcdgzdX0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 12:07:10 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 12:07:10 +0000
Date: Mon, 17 Mar 2025 08:07:02 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: reox <mailinglist@reox.at>
Cc: Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org
Subject: Re: Memory controller not showing half of the memory?
Message-ID: <20250317120702.GA7066@yaz-khff2.amd.com>
References: <27dc093f-ce27-4c71-9e81-786150a040b6@reox.at>
 <20250313173109.GDZ9MWXTRUHbFh4UJ3@fat_crate.local>
 <84f97663-2bf2-484d-a6f4-22f6efdbc1de@reox.at>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84f97663-2bf2-484d-a6f4-22f6efdbc1de@reox.at>
X-ClientProxiedBy: MN2PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:208:23c::33) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 22db0730-f1ae-4c92-7b8c-08dd654c3ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?bWxH24Naj+QuBEytoujQ/pqRNvbsrxdVkxHq753oOdNDJ+6GR3DIetTbOm?=
 =?iso-8859-1?Q?4/WvXxBkGQppQPeo4OYNJ/Jb/dVnMPqpUmAGf9/5SCNR+s6hmondpCOn0s?=
 =?iso-8859-1?Q?NIkE55YT1XQtE7m6MlpOj5c19y+R6DTXJobAity/dXkft6Rf8w8wDBoDqN?=
 =?iso-8859-1?Q?vfIvhx908BGyqbUK4+xG2uQgAUHTHA7j/Frj/ZGgw7QnnmteOf5NoJ0Jww?=
 =?iso-8859-1?Q?y2jdXUDkt+5EdfN1TynCCqBH1MBMey871Mh8VIRFy+SGA3GVfIqDXkB8Yq?=
 =?iso-8859-1?Q?TLLrmE3yLQKHhI6MY8GfRjzmT50wNwwlilSNpSOCD1F2ofHUdnASAtxYx5?=
 =?iso-8859-1?Q?QT4Tkgx3RA3eDZYonWG22uyGiNoOsasZWsJnTSFWnHdtZmjpx5cKhvVt0b?=
 =?iso-8859-1?Q?9FAiEB7a8E1r1QCky/ish5IGIcDWnQKXDKGrJV7vLvfroo2n0PkWAH6F4W?=
 =?iso-8859-1?Q?Jjb1InTQB5If81W8Af8rc5Q1tGOMPsA6kCgWSCNi948XfoTN+WkDveQwwA?=
 =?iso-8859-1?Q?D52StqSOEUlRVx/6KYbLxjZwIqni3e6BMqROpSJtA9dRZh4E1aWvvznoVh?=
 =?iso-8859-1?Q?dtvSvD+vUVvmRCwAiXVq+NbShFf/21pkg6dJ/TGK8Pfk3shZy1+taxdn2G?=
 =?iso-8859-1?Q?Nf1x8PYYpTmpdwJ8mXUyrb2C8V+L9xpxE2zbkwdvLLsP4w+oI7k+7BLo2A?=
 =?iso-8859-1?Q?lghoygUjhyMOcVV1BYfPqV4jFjmOStqOYK/WaYrE58iic+4zA9fQ8acKWA?=
 =?iso-8859-1?Q?NA33QeqeVUNuOZfNiSRGJyWhwwcEBFbLW53gDE8AEtzDK1Jwxy2N1gSVTT?=
 =?iso-8859-1?Q?yWACPdmxeylEPRdF0KW5fvQH5xQ1zjL2Z4XRFFDEP1n/IHPHkBnK/0BvvG?=
 =?iso-8859-1?Q?c/NrybjsrbKIngTdq3dITe22tAaIOCtAqRzpR8kh2DFWyO0G/F80SHksAb?=
 =?iso-8859-1?Q?acP13ym+rMr3AA6Fy63QGA7sCfv9jhg5PM2kF4O5eh3qtEPcxfDxTIPTA0?=
 =?iso-8859-1?Q?H08yqRhLk0PTvqgdM5IEZEd2oB9joTJmh6tyit+DVyYR22vWRtYNaKdKFC?=
 =?iso-8859-1?Q?6nvNkz2+Fs4/CKvdSNdPzBCIpsfpBaoVKi2AZZgzAQ26urnvc4ndEoHMPk?=
 =?iso-8859-1?Q?tcXFY8bIUC9bQIn0CsqePb8Nn6iIRO/Uds1zAaYoMtoPUXGS091mi8aNGt?=
 =?iso-8859-1?Q?qVAUsYbNl3aa+2cQER3fVouJGvIMs2/DJ8hkuNBSENzABcs9qR+tyFNTeo?=
 =?iso-8859-1?Q?twvFSDu5CWy+y7rrYcy9rdry6gWzxMmovqXuaAjWz3igXZn7a8n4g3fSBJ?=
 =?iso-8859-1?Q?+80fIbW1mCbK1A8y6f/rbTOlSijfO2EpQToIO/Kf1mrABDhO2lmyCifKDu?=
 =?iso-8859-1?Q?9jVTtUoR8yQJJ5xJrlMe3POD4pSsge8XJFQ695+FhuZK1DOS7eGQeRKHDi?=
 =?iso-8859-1?Q?ttOZdy7wQQ3dLMOR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?OM+FgyITbneMUb2JZC3b7CN8i4fjmUXf2ELT5MzVqL0UF/RLsxNyAtHaQ2?=
 =?iso-8859-1?Q?yC/HlWWQDIXGZ52GN4RzlQVrtHhSrIJ7KCHMpdJ9uuGw38gUnMi5h4vl3d?=
 =?iso-8859-1?Q?gloI3p9VRMg1tPZwotn4MrjY8ykGLSeKE2b64hjuS67RmgrosDTXThoSM7?=
 =?iso-8859-1?Q?e6LWm5QWTHgzCGWDnbEv1jOBTGemQZO+m1BSbFjw8z0Fl+L6Eb5rzFG9uI?=
 =?iso-8859-1?Q?z+jKkYeXCRS4GpxMBqJBSMeBxkqNP/07Npbj1wnSjyo7G+BozyzZrO1zWm?=
 =?iso-8859-1?Q?SNf4Cb3SFPP0QsGiC39Gpdq3WypD/3teEDOv7glifaGvY29VRp3wBtwCDg?=
 =?iso-8859-1?Q?2vF1+aia4zLqLiLdNAUw86uIKM1Mmy8sSl2PKaAbThoTCnwfPb8gKEFSOs?=
 =?iso-8859-1?Q?Jv1/ToXC2r/7jq6t2Xou1+WlnM7aMBzedl5waI7zzGNmzY+CTkOvU3UOgB?=
 =?iso-8859-1?Q?kpwUlaeJ9+MHLVH5Jbr1hNnDVtWuJY8o/E+yC9+k0AlbjRo7uUc8Nqzo+f?=
 =?iso-8859-1?Q?GYesUQQ6PI2LWCvLrpLtc9A8iKHjYfGQnrFCf53R74BpSBlZX+kQcPanx1?=
 =?iso-8859-1?Q?L+w/1Y/gCeaX3HJZlilTwLxBOgDgt+Vj/YyZJHbrAnCQ7AAHebvJqGC2cs?=
 =?iso-8859-1?Q?rLNVoBehFK5fKSC62N/3u/JvfLU89+99I/ZVJ18RFVNMKZALZpgh7+fCHr?=
 =?iso-8859-1?Q?N/hHaCSnXfek9x4/+R7n0tzl0xScuHjnCf0Ehy4ttDlajk6dzUhbB+4IAu?=
 =?iso-8859-1?Q?49U1pCZWAPG7e4b7mVuw3+pK1kQs3tAL8WAWlUjfZm3iJ6Yq0tB32llUYf?=
 =?iso-8859-1?Q?axCFAC/gSYyP0I63U5m5J7vBrW6gIX7MfqPrZ8b+TPEEgs7yZTurOeQfgr?=
 =?iso-8859-1?Q?Dm9fv3HNeSs9jru4GJUz5vKnu13DqXdYg5NxZxH0j9vgFnIqvuGBqvloMW?=
 =?iso-8859-1?Q?Bgn7bra7OsalLlTLZvLuJgG0Ltk1NcObzEzosBjHt/IpgcUNfQQjAI/Grb?=
 =?iso-8859-1?Q?pXwLSIN3lJc4l/UgNf/4JyBiKOtFNqOvhPghpPh0dgri2VXN5nsL5BX2ii?=
 =?iso-8859-1?Q?sH7DpoYQz6/z0jNwb3HP88Fc63efIgb6QEbYcGith7+j0ZqJETpl2cLX0v?=
 =?iso-8859-1?Q?Db4ZETm2pDLqt10d+TaMneUv+YA6CW3G93nCcMQYg8xBM8pKdt+7JkI5mU?=
 =?iso-8859-1?Q?RLhtA5Px0SfNmifKKaZOHUjYpW0lGfcJo1sgodB1XuztlFP0JN73iI8Jx4?=
 =?iso-8859-1?Q?INhRHrdvhNObXLKUIPyZrL/9tBf+KJMJRCKuyUCyDMAOG7w4H9ZMAUAYfF?=
 =?iso-8859-1?Q?aumhG5vFUqGvsDugWAwOoB/2R9Q+E6FHOCpTj2J9mLoPa6L0Z2D2MjlzyG?=
 =?iso-8859-1?Q?nVjIImVff7FzTXGzuXTyk0x7pUubDbxYpHpNvQI4VLCqyt5xv1m9J6NkVP?=
 =?iso-8859-1?Q?jJEBv+N+T+fEQMlKcl0U0S0TA+hfh0rRKPYQi3DNN0ZxMDBeiLeBVEAjQY?=
 =?iso-8859-1?Q?VB9X/7n1Oq0QaLIEbZe0KReKNVb7MsITtlMrmD8jiyBQSpZ1/1o5y8FLtK?=
 =?iso-8859-1?Q?KVd0UK5LWiCrUXtr09v7tcgZ/qQsanP3DkyqQYC1MeVDHBa78J11FDVbEl?=
 =?iso-8859-1?Q?oJ/T/Yy3gl9HtGCGFfeHqoQl1iSugYjaEh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22db0730-f1ae-4c92-7b8c-08dd654c3ead
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:07:10.2766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kx51dQ3hzGrV+1ySo9srQNQ+86rt03+vuJ7VINuryF5wZ9UqO3k+GJERL+S0bAcviU2V0Kbz7jO5h2vcaZeN7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501

On Thu, Mar 13, 2025 at 06:48:42PM +0100, reox wrote:
> 
> 
> Am 13.03.2025 um 18:31 schrieb Borislav Petkov:
> > On Thu, Mar 13, 2025 at 06:21:28PM +0100, reox wrote:
> > > Hello,
> > > 
> > > I hope it is okay to ask such a question on this mailinglist, however there
> > > is surprisingly little information on this topic (or I'm not deep enough in
> > > the matter to understand everything correctly...).
> > > 
> > > I have a server with a ASRockRack B665D4U-1L board. I'm running Debian with
> > > bookworm-backports kernel 6.12.9-1~bpo12+1.
> > > In the syslog I see the following output of EDAC:
> > > # dmesg | grep -i EDAC
> > > [    1.340448] EDAC MC: Ver: 3.0.0
> > > [    4.705255] EDAC MC0: Giving out device to module amd64_edac controller
> > > F19h_M70h: DEV 0000:00:18.3 (INTERRUPT)
> > > [    4.705262] EDAC amd64: F19h_M70h detected (node 0).
> > > [    4.705266] EDAC MC: UMC0 chip selects:
> > > [    4.705267] EDAC amd64: MC: 0:     0MB 1:     0MB
> > > [    4.705270] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> > > [    4.705273] EDAC MC: UMC1 chip selects:
> > > [    4.705274] EDAC amd64: MC: 0:     0MB 1:     0MB
> > > [    4.705277] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> > > 
> > > However, compare this to the real amount of memory (2×32GB):
> > > # lshw -c memory  # shorted
> > >    *-memory
> > >         size: 64GiB
> > >         capabilities: ecc
> > >         configuration: errordetection=multi-bit-ecc
> > >       *-bank:0
> > >            description: [empty]
> > >       *-bank:1
> > >            description: DIMM Synchronous Unbuffered (Unregistered) 4800 MHz
> > > (0.2 ns)
> > >            product: HMCG88MEBEA081N
> > >            vendor: SK Hynix
> > >            size: 32GiB
> > >       *-bank:2
> > >            description: [empty]
> > >       *-bank:3
> > >            description: DIMM Synchronous Unbuffered (Unregistered) 4800 MHz
> > > (0.2 ns)
> > >            product: HMCG88MEBEA081N
> > >            vendor: SK Hynix
> > >            size: 32GiB
> > > 
> > > I'm a bit confused here... Does EDAC simply miss half of the memory? Is this
> > > output correct? Or the memory controller not fully implemented / bugged in
> > > that kernel version (with the bookworm kernel it does not load EDAC at all)?
> > 						^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > What does that mean, exactly?
> > 
> > Are you force-loading the module?
> 
> Sorry, that was formulated a bit sloppy... I meant that with the current
> bookworm kernel (6.1.128) there was no memory controller detected. The
> module was loaded fine but reported nothing. As far as I can tell, support
> was added only with 6.5 with commit 6c79e42 (would the expected outcome in
> my case also be 4×16GB?).
> 
> by the way, if it helps, the CPU is a "AMD Ryzen 7 PRO 8700GE w/ Radeon 780M
> Graphics".
> 
> > 
> > You could send a full dmesg...
> 
> from 6.1.128 or 6.12.9?
> 

From the latest, please.

It could be that the memory layout/assignment is slightly different on
this model group compared to others. I'll see what I can find out.

Thanks for reporting this!

Thanks,
Yazen

