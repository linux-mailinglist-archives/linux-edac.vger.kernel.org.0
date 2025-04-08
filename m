Return-Path: <linux-edac+bounces-3494-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E50A816A4
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 22:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158701B69C04
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC3E2417D4;
	Tue,  8 Apr 2025 20:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lFCZmHo9"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B9158DD8;
	Tue,  8 Apr 2025 20:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143064; cv=fail; b=bSJL3XDDyGZttEvlSQJdw4yeqzacuCRikRkjmoj2qF3PziQ5+PvOxb1UK5le+sSmXgoJEDtskbaw/akV1tITe9UcJ7hYqe/MRcqhk4Jn8ewZ8SXxbx6C1bWcDDXhXef0OMp27nqoRbCNHE9FF72vbgTXns8F/Rb2P5jAIvA5WCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143064; c=relaxed/simple;
	bh=7UH+PesjkLGFu8SSLlaeND+4YM6XngCf67IGONxLr14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jTDGlRNgHOxipvHVrtpTxYxjRyHwsN8GLIluR8lPUKHVYqm59GYH1HYYqLqHqMtR81SC4b+Bq9sIrn8uHlGgragMzPxDhIwUtvrfj1VvkGnTAfnRLpc8D5gKDqUHJGN0Up633nxT7EpRQpCWjcrClSRyRBgtfKIbQyWx/6LPllM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lFCZmHo9; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcxQsMJXyrBkSBv9grmQD/bCwpE8c+WjBvsDzH7vhfxxnFGj70IAVjE3iX34Y3ayv6VYAXfO5Xplkhslz0izjG6P628Wt+N+XFSFESRT2htWMm2zQAWSbBIVQJtImPIeympoAD9xEwWbJn+kD9pFTKDjkDWCIQQvxxws5VwuPBMtBx8GBMt2UQlPi9ZTTG3wgv66HGbmpA/BgSBjvqDFXs+RyWgHr0dcPmjl0LA8KwBaFWuj16BmpVpg7/VseGLVe4315ELT+F8MbQfFOqLK1qgc7rynHM3rm8437YNZmM/Rft2v3zo8jVhaBEBCjsfLz1UFcpAuDhoBS6vu6FmPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5nsupf6veIin5hvVyxITme/AzmpykAjLeH6kIF5BwE=;
 b=tMnZ2ngLlj70urAoCIXiVDFYBt579BKxAmFQm7nJNfknBHu5kaCp29sWAffOK9t0JI1KPslaAdjhOCNgYFpmZ5cymIxxdEtZrD417NDdndgLe8+5TtM5NevXi0zbJTNoR3VP6XOWqvO7yr77nk1oWu5ei1XHhMZZKL2zcDD+S/AupBWUp0LHswiTDVH2hOzj3VXHpDrkmOCmlgZyGCMhSdtcoanlTnbn6UFlTzB25dzRe8mt/aIs2gDxCAKVtKePQls1N5g9vvXZZ1jp2Xymoy4jyuQ3fxVzauRblctZjhAgQZY7y6z9kggLsVdf+/QJ3MKjmSs4j0qkStpgGuvzJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5nsupf6veIin5hvVyxITme/AzmpykAjLeH6kIF5BwE=;
 b=lFCZmHo9AQ4chVXdXML/V6N/QEeiELA/R3LrmeqZDlOgRPsp5Zst0kcnOxOKT3TeAfWUCBnoTWNc4Ag8rfk4VvoNxYFV298qaCTfBsjZPUbxAmnWr12vh0aIcoRYWBvEPSifDPCO25RgT0rnTNFrpzrM9lZfRdhXJjrZ6cXZvYw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 20:10:59 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8583.043; Tue, 8 Apr 2025
 20:10:58 +0000
Date: Tue, 8 Apr 2025 16:10:55 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Muralidhara M K <muralidhara.mk@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RAS/AMD/{ATL,FMPM}: Get masked address
Message-ID: <20250408201055.GA2700280@yaz-khff2.amd.com>
References: <20250401-fix-fmpm-extra-records-v1-0-840bcf7a8ac5@amd.com>
 <20250401-fix-fmpm-extra-records-v1-2-840bcf7a8ac5@amd.com>
 <20250407132415.GCZ_PR_82FKBcsIuGr@fat_crate.local>
 <20250407151657.GA1948540@yaz-khff2.amd.com>
 <20250408101415.GEZ_T29wiuh-_sExlk@fat_crate.local>
 <20250408155242.GA2523543@yaz-khff2.amd.com>
 <20250408173333.GEZ_Vd7V0hqJfBXFRu@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408173333.GEZ_Vd7V0hqJfBXFRu@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:408:f9::33) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de462a6-5558-4eb9-81b4-08dd76d97a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F7o+g7WWbw5IauAk53MvRBprvRdmhiyTZye6K+vxhHkrx1zJcA4z1rKZ8Zob?=
 =?us-ascii?Q?GjHJ7WQeBluNyCAYeu7tNkg4AwEHJV+1tbIqoBfv/wGhkCs3P1p6TGhOV98w?=
 =?us-ascii?Q?KHyq1nNDT9Zxw1kVS+IDWp5qZ7RMIp7vAbtdL7J/+T0rOtdQXDj9lv0uwuj7?=
 =?us-ascii?Q?TJeJSsPK4HMD0Xkt+z7qm+A1gt0ytWNqtk1CkhAVnSAv3NKrdkX/H9ysrnnm?=
 =?us-ascii?Q?SPmxwf8zf9+LfXUHsgMCktMvTdTNtc0eea91teirf0s6QwTiZoIGw1mE067+?=
 =?us-ascii?Q?WR/cf8pxbJObushI0Q5kEJNJ8l6fjP7KTel+kz1NgZqcEpiOMXS7dqHHnWAy?=
 =?us-ascii?Q?6M39SevHmZ9MdypKeMsi7lXISUKt8WeuE8Kb94FQCnvEFWjUe1Z1F1gjGD0N?=
 =?us-ascii?Q?fwdHkXIaH+FQgF4dL6vvKLSZcbVfAsmD2XCSwcWvOHhn+5CDM92bd7hsnxo+?=
 =?us-ascii?Q?SeENoNBxzKTpDGNmGCxTJNJeqLAF2pemc6pR5lT+lHxhxdbpIcmxXyENFfEt?=
 =?us-ascii?Q?UrowYsufY4iOupzksRD6O8F8/c1QZMIe/Pm6ra2zqlL8+PkXz3MTZYdi5Cmr?=
 =?us-ascii?Q?V/XjwynIi8KFu/SK6FDW36jdskGoUS1InHKfpCGnTUm4kRIVyuVM9KIO+ZXx?=
 =?us-ascii?Q?wlM2WoWlio7zgZAtoUZwRzr442smbAu1gLR+8k8uYEe4me7MEHO+XoVATBp/?=
 =?us-ascii?Q?U2je3VU9s9TKPRAIqiGS3L55uwjNL/fyRoGgUwNSsYep3GUWzVXdk8jhacmF?=
 =?us-ascii?Q?hxchUHVZ+eEOHrjVJvMq8GXfXaj8m0URz/S/DP0lDFvWDa9+bzdlap7gHEjB?=
 =?us-ascii?Q?h8+QjParcdspvnfO312BJUTJTawB7ZV4tkCiKzLSWSdKe7UPdtkM7b/2Ncg8?=
 =?us-ascii?Q?2Zy/l2vDCDQ9z0PquEb9tGEBFPYWe6uA6JYy5dWaNgmnNUUcpDWbaJO6U/58?=
 =?us-ascii?Q?ZYdWNJqCzHUxKQ822yuanfSv+TV7NRZt/MwmbsFa+qyXYxQfaSkx+TEWVx2H?=
 =?us-ascii?Q?g/4aGGF1pBt5Qm0biHwtWO2wfquI6yg+xxBIKF1siBjxHF2nNKNmlnPKPB4G?=
 =?us-ascii?Q?t8Q3O4ZeeNleMk321bllc+aDYRwrb+341F7mi6kPPcxKLON7/hbfKdWlgI6L?=
 =?us-ascii?Q?xB7Ak7hZx2AdYaCYFPZ+ZxZf4Bc+BwVVXF9YrUIyhjys/B35YpLiQYI+MLRZ?=
 =?us-ascii?Q?nMHfOCXUrPuubrHiAAuQNm6YC1/qDAUUTQp1tzYmFsjmGFiKKwBIO8FVhbSX?=
 =?us-ascii?Q?SGjvdPNfPj+cW3FNKL5C6fhpoSzBEe4Um80F9474AsLATkU3Q4da9Ncvm+m1?=
 =?us-ascii?Q?4hIcyPJRsXlVErN2tAX0FYR0Oa3Pqjc3Xfwcbo9TYZphqSCgmReey+k+L2Qu?=
 =?us-ascii?Q?ut3SZJDwNgsG9o/8nELf0p+p3cmY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iX7GmfPnEiQy6xtlyTm+LvItgqQ0wOB62Um/THbuDqj/FtIkYrofcUt0E4Qp?=
 =?us-ascii?Q?JjBtQy8yu3Pp+n9Xx9CWN0t98oMgiXTZWGMd0otAouJPiKx61+82b4PznTPY?=
 =?us-ascii?Q?9Zyx+5qV6fWYvntKAIccNadOFTDsGwFyxHJGQAALZs7dSAKw3OYQH3W4Nz2f?=
 =?us-ascii?Q?mC6b/8mNKJx0FsAmiGJUKwWCVmlmWV7lldUbB/4gE3ll6yk+C+pj+F8LLNxj?=
 =?us-ascii?Q?eMB3I2hSVZ+YBvOuP9ApvGxnxugZC0X2n50lOexSxrwKRkf/Efj3TApFWkN3?=
 =?us-ascii?Q?pH4K7b9z6HXqj95JGBTcLY/8aQ1UmwmPY7PRlotJMiUu2pdfXCwuZCiHpq01?=
 =?us-ascii?Q?90TOxqLYmvVJ2sjGpBIQgJGAlgDa+l1ZC7MNKPD8NsfymZerFWd6i7C7ykUv?=
 =?us-ascii?Q?km7osDcO6X1sCzakcBemDUcL+fvzLW1reRqXEuo2PwgCRlVr8WasTCsScCXP?=
 =?us-ascii?Q?w0cmCVEWySRl6cbP+HldtGMvKXwtM0j6Iaf6SivctPLjMTci/nMs1Ize+6sM?=
 =?us-ascii?Q?/Ss8HASKYAXehgDuMbt+1SKLQH3GQFJZaR/5j/hhBIHDs06NCiEXga+KXowP?=
 =?us-ascii?Q?HqYc7bVMFJ4NVV1CNsoy/9IgsGxCXjRrZchCf32ZHPg0RGUQKcQBK5vHQwZb?=
 =?us-ascii?Q?rToQtWfyMyHx0Og75mXqaJ57EFIAFtkKovKUVe/nRYXOVV2CzLyLj3MXNMD3?=
 =?us-ascii?Q?Umvp3Q9LeBHF4hv70jl8jDUNHwv7joP8Wq69P9rVV0BaVmBYrn83ypPw9vcA?=
 =?us-ascii?Q?Vrzs6BE5cyPDVUKu7fC2ExFur+uo/Eh5wJgMDJ71hQZHHXozVZi+ilDivTIt?=
 =?us-ascii?Q?iH/gLLYPW2shu/gZcG8goVfAMn/kFCduz3sJqOlOrwAA7Er5QKa7P06iBAjU?=
 =?us-ascii?Q?JwMsmCPBBl0gW/oLmpqBPo4+jVEfOFPW/c7kA64rAPNqiwrNGJjDHn74a5zp?=
 =?us-ascii?Q?x5cBvcN4+gE456pusmLMIMG8zmpgLmnZ6QigRD/3lKB4FC0LTuRN2mnHHnAc?=
 =?us-ascii?Q?75CzRWW90/4gA6j8uM4RFSozJ7YHqWULWU4wmSY6hgfIWjX+ibzqNcbbVXBY?=
 =?us-ascii?Q?rjlJZ5MHTJaSXJ6lnQmOS5ZL+c657Eep+BkvSyQ8I0W4k26Iiq2e7RslWvR6?=
 =?us-ascii?Q?mMP18kcD0wZBfL5mVRTJMSdOQKJVn+BNKKvANONxGX6BVrWWGX3MdjAn1vNO?=
 =?us-ascii?Q?vqa3SUHXyjYopYinQAUmrttzlcwIcwHsCcohd1+mJ6o9+1XLXEWHJtVV1thx?=
 =?us-ascii?Q?WQVyvmLd0jBmaqmEYzXEQxszzVrBElDgMvHpQgebcGmNkuzaPmFNe8noVybz?=
 =?us-ascii?Q?vlM+Z1PzzbkyEaR7pBr8lQsAXxB3oTK2xK1IoAFB7qul/QhLxkVIs58F19wu?=
 =?us-ascii?Q?8b+Y1Lp9f7shRtrpKpOAKJPluTyTvZ6yVg0gwLDLaaNEfqgCOmPUEzvHsXx2?=
 =?us-ascii?Q?fm+zrZ4JZhIUGgG8EOZI4vT9ycQqqpWFS1r5sBIdRtTmwgxDSfrVnbEiAfjP?=
 =?us-ascii?Q?s82YkESo9OW5xtXcjULF/wAFi+Qe3DisxCW+KT1oIr8V8aDomcsgWEMkVd6a?=
 =?us-ascii?Q?LO42m3k9TzM6+GfpVPLCopbsnIVMjYPDnSD/1X4R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de462a6-5558-4eb9-81b4-08dd76d97a27
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 20:10:58.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e11bCnzTvJh+g9ay01QuVcLkAxsn2P1YCBMuWej/jJE0khjG3X/LQ0maN7K0V9CeKsrIxiiblWN+v3KbuE9lsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

On Tue, Apr 08, 2025 at 07:33:33PM +0200, Borislav Petkov wrote:
> On Tue, Apr 08, 2025 at 11:52:42AM -0400, Yazen Ghannam wrote:
> > At the moment, FMPM only loads on MI300A. We can just have a local
> > function to mask the addresses. I was thinking we can have function
> > pointers to make things generic. But maybe we keep it simple until
> > really necessary by just using the MI300 version by default.
> 
> Now you're talking! :-P
> 
> > Please see patch below.
> 
> ... which I simplified even more.
> 
> I'm thinking whoever is going to test fmpm on something else besides MI300A,
> they will have to extend this address masking thing and then we can cross that
> bridge when we get to it.
> 
> So this is keeping it simple for now.
> 
> Ack?

Yes, looks good to me.

Thanks!

-Yazen

