Return-Path: <linux-edac+bounces-5002-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF09BC1D30
	for <lists+linux-edac@lfdr.de>; Tue, 07 Oct 2025 16:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EDBC4E274E
	for <lists+linux-edac@lfdr.de>; Tue,  7 Oct 2025 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F582E264C;
	Tue,  7 Oct 2025 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e/UsEWNW"
X-Original-To: linux-edac@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB82E22AA;
	Tue,  7 Oct 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759849016; cv=fail; b=uduls5pe0TVP7aKwZj5HoODke7jfOXHInzp0Goxl2LAlum4KXJ2PyeUPVPaMrs3jbZlY5tAP41/2H368M7jw6b5aPYyISBnWkRzCG+KAm0j1uK9P8m+LjL/b3EkR+TpgRzSvTosu2qxXYgtebFXeDfC8F4xQ7Pbt3rORbOfO1oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759849016; c=relaxed/simple;
	bh=Ed76kk5R731pREMpXa6VVF/VRZY8TRblEznjGEO7PaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UbM2nxoBj0RnMFhVjzGZYhow+djW4EXgUkKAQZaueEy8anZEQETIStJids1y0THtNq12bojZ7q69SRo9FQZUA0S/fs6neR3hMI4+8rUYjxxVXWcjpRKKP+0/ZCCLKYaOJPbP5e259NNNN/bcGydCgfAi7SYivZ/D3RPplaONjbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e/UsEWNW; arc=fail smtp.client-ip=52.101.85.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJ81VTErVa8tuZXlhc71qqEqU7M1cF/kfcYWiY7KKatonnvvbEzVCFoJ9qTwNtw2z9ZlvvS/19Lgsf4GouvwUrg4AYFrO0rKUm+QpKf7LGfHUNQQLzIyFkvl1NBT8nMP6Nq3IvUubHSHaPXBHOh/lCDL7DcihQatUEkpn8o//ppvfJKWnLXFgFg9k8xF97HNw6XhtDpHpXMT2bnM/VeSLYKXQsxy1TZfkzZ/izSgUTIMnHc3YW5urot4nAj+7BfbXvlQClwwWnhrhCi+E2dEkPgVtP1xXsu8ofZ9kMO7ISFDONQfs4RUdXKkULaib/GaGhaSFpQixApoQwves5CaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLVPWAeuI5Nyg17ntsYp6Twb0NjMMjTkyneNmYj4Qj0=;
 b=NnHiwu6c+Rc9NUhy2gD6gRH0H8wOIJDWekxBPOLaZWioJKThxwMoh7ZH8H4a/eGMM/1po/PJMUJ+9ZrcmpO70PRNAxtDJ6JZVTseFXTHdEinN43LCEYJmiGxtSYP1Cyxnwih4Xrkq21Fh1bivT3lHLhpNNuvQv9usfiGVrfIR639fN45/Y+b+iBe+5+rNTXrQTaQQUN75GslqnFAjYx6P/4f07eAet2Mt3e934FobcwVVit48bwJDQ1TXfTw/O72abaORKgA80h0xsYd9OL7/YTxz0XnL9Pk0vKM0JgfZa2SYqann55OLyFNBiSBnCms0dAEq0wXzWz3d6cnsoDe3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLVPWAeuI5Nyg17ntsYp6Twb0NjMMjTkyneNmYj4Qj0=;
 b=e/UsEWNWCVEYoZOnRPOw3vtjUQoTlsgGHbsOg0lFOyXE6pe7eKYLWSEo6hShmotMV+gMyZjK0UsJTVMTKTKLb9qjqUPwrTpwEDjlmgGuKCD3C7mbut2lBmQRVZF/5AmwxAPb/ykvmAo1VD1zGeHRJnWOhQjntVFElRJFxDf1kyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 14:56:48 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 14:56:48 +0000
Date: Tue, 7 Oct 2025 10:56:44 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH] RAS/AMD/FMPM: Add option to ignore CEs
Message-ID: <20251007145644.GB11984@yaz-khff2.amd.com>
References: <20251006151731.1885098-1-yazen.ghannam@amd.com>
 <20251006213406.GJaOQ1zoXUKEk-7eCn@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006213406.GJaOQ1zoXUKEk-7eCn@fat_crate.local>
X-ClientProxiedBy: BN9PR03CA0555.namprd03.prod.outlook.com
 (2603:10b6:408:138::20) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 12db3e60-8fbd-4a91-fa1a-08de05b1bd8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMGQxXOoCGmu3+xg4reUiM6MQiieWW0WP58Rftm4ir5qGDBURAOkQSk3Ny3M?=
 =?us-ascii?Q?qm/OilojHzMJL4b2nNh8sEHR2TEon++xiFp0pvRBlUnfKLoEZgqdHJNeaTGG?=
 =?us-ascii?Q?W6KEHsc8vS/VO5Yj3wuVtZ/oI+ZUo1wTGzoQhoHhez65gvbPMCh/1OCDAVWr?=
 =?us-ascii?Q?woqKuGy4yXzN0eX0T/8hhQEPiuuYKNShpjyeGyye+5EQ0aQyAs93L0GMKdOv?=
 =?us-ascii?Q?bLw9dSwVZ48YBPgz8apMuy33T4v4CH9iPncalZnzxqkpHRvgZFNqjqTDZHF1?=
 =?us-ascii?Q?ByiZCtxz/P4cKzIfEY6HsJ0Aest42PW9dVW/990+FIgOZAcBvRIQ+zDbWKal?=
 =?us-ascii?Q?/NVCU9756qSc0OSxdGpBmvWU3Xb4C5AtoiTrmvlvEQwm2vHqfv5/XuUZtvAQ?=
 =?us-ascii?Q?0ALMyMWoqqMlVCOwp2WHQ/+TOcFA5LitmiEsEfdJtXEx+bxog0tg3sTMKh4C?=
 =?us-ascii?Q?vg3ve3R776lFv8PnfKOLGcE5KT1BcoHz2s89Kc+IHrT86aEWJD9NEnrIGMZT?=
 =?us-ascii?Q?QyG3be1Z3+WPnz9lYUZwREi48TuKpl3gNnxUPXAdwQagwB1/D1Q71hEX8cTr?=
 =?us-ascii?Q?a44QKTSTF7ulFnOjDQnq8jJo5MjKzYBif5W7EvD6ebwHM3a+JHRk5Z/zpsZj?=
 =?us-ascii?Q?1YNjFDTjrsRK/nplMJfdTTcAW8bnA2mqCfA8KvaQwpQ2RJ85U8DHqwrGEoBL?=
 =?us-ascii?Q?qZ0BRqRgWAF7abR2Z66LpplcQd58M0vJibu+yJ/RTFeEaMc46ht3AOq06sYS?=
 =?us-ascii?Q?PGMPx4u4URE8w/X/k58Hmf+MYeQqVduordaI2jw0Gmx+D5u0SDr/vy8uR87Q?=
 =?us-ascii?Q?L2HD/AwK0LM1kx82A2AqdCir+YaUmjDMGV07coxmEMW0tSreQIcVesyyMzzy?=
 =?us-ascii?Q?EOkwmhFGvSJB5ux1WYPELoPq76YhbMK97YV9SR2o4qn3/Fe2s6sD2AAv/kS4?=
 =?us-ascii?Q?AuqQvkPfoKquZ8TGJ1WqZSTL5izkaQgyNjLHgemzk0j3kHBxU2BayW3cKN4h?=
 =?us-ascii?Q?TTFMQdmXn08yim1TL87luAouWILYBBBf/Jf1T5GE6k14FncBWXvR1/Vt5wj0?=
 =?us-ascii?Q?5rIHT6WpouUKnhpSakI8sPJprnG8sRGzm2xFyc8scAwHE/0nZ9e9y/00/CvX?=
 =?us-ascii?Q?WqpiEc0oTaVj+gSdyb15zEYfQMHJglH3K5xx3FodXAR/6ZRBTpnjdvvv5NFK?=
 =?us-ascii?Q?WfY4+2Qc0dKYPP3VMaY0wJQT7hdEkNIdB2qTgp86I3ZapixNL9FTchrn49pw?=
 =?us-ascii?Q?gR7svQCfdJfsThratciBqvFLN2GYT5n0wwn1rOOsifqmCJyX0Rut/HStNKWE?=
 =?us-ascii?Q?fo641x03TomYcEfWouey0f9bAMJA/MS3kNSOSejhDwHilcXh4bDHxVOBplMc?=
 =?us-ascii?Q?Q5llvEgbLUbQLk4Ca8Rn9H+s3Urs7/q0jOEzC9PPYIVLA3RzTfZ+f+M3or7h?=
 =?us-ascii?Q?PrfBXDa2PgiRL84asn6PGUYF6BlRvPjk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6iA9wQBHtE+Q71FMdzD1G2A52YNJFtbFbIP3v3g2j5RtAXBAXJCwhTItlqwb?=
 =?us-ascii?Q?nYXZ7Fu/Sr+t3Vu259CtVK5wodWiXFdxEFFTH6RX20jTQDtLUfl4ZIwnDfsc?=
 =?us-ascii?Q?iSVUvRxz4LbJ3bSTOzUy5hJL2aJWOPfE8LBzlvLWdjEG8QCO/Uw16P5dQHNT?=
 =?us-ascii?Q?cYL/x8TMttxSHQK2c2ver3ExlTy18U2AFq5PI1oIu/qN3Kayn0WDc8ECX1WS?=
 =?us-ascii?Q?X8+T/J2zE9XDbx59agJkvzL7tfS7OkIjGdZ8qUDLBmySh+2y4ul9hTbeonnc?=
 =?us-ascii?Q?23wcqGzvnjkzbe2ulfEMZmTm6dvEBJFM+qjV8EAEMwM4s9G43NBsoYaVZDZ4?=
 =?us-ascii?Q?2LZN4njNaWMfR+8UJ4Wd7WPSdKLjU0HoCsd9t1FS+Zwymg6orBKDq/nSqIMG?=
 =?us-ascii?Q?YiIEuo638nL3XVKX5m9uzw3PQ02IfYyfFp5E43b8+5BL7KoJu5oHkICXNixK?=
 =?us-ascii?Q?DgGlgbdZ7QzRb3gRBRQS906mKdK10EfNNx6iV4nxqSQQLddzeaN0yx1Q1/0g?=
 =?us-ascii?Q?6K+e3lvgrdnAwayEp66Fe9mZRLGbVXpAqtYUg1v0K/RPh4fkSGgKu5XKn2w2?=
 =?us-ascii?Q?Tz85lvjiV9rvC1paI6zUfmEUb0QiDkSDlcvp6gHTy0zwsSbatVs/rIr9JD6z?=
 =?us-ascii?Q?5rE6DvIamsTpNQRyuFDjHAO6rZKZZFceOmnMWWoXlnYNBMkG5vWMjPiiEzXT?=
 =?us-ascii?Q?xlc2cxISWucolZoeTiHo5EN/uomZ5+LqupT+1dRzjzKMga0Ne6qR9iU79Zwy?=
 =?us-ascii?Q?c/N35gFomZJz0M7/5sZMZxVUWNoAoR4IJEM2AUWl+ixk+LUolbFIYbCk/4xJ?=
 =?us-ascii?Q?TD5innTZQAprgJhOy5hlPYt9eE75/eoFNU2YP5jgwF7ZuJTE9TDJmXk4rF9s?=
 =?us-ascii?Q?MuL4E51qvNGihF8It7u9QMt3CRFbPtbfdoA/ejA3apU6Mn/sKsYptgg+PJdy?=
 =?us-ascii?Q?/RBDrduZFkUqj5L5xWkeolEIBm7MY6fVY3qeF7L4dP7hi3sC8VlwpP9HtyKw?=
 =?us-ascii?Q?8KMAYAn7irbOiQefcRdmdAYn76azB83hZ5JgvWHr9YKYyYlnzt/GYc7KBdQW?=
 =?us-ascii?Q?7zWVprLZEbCR7c9mgoYC6Lk4JTs2zrd+mJlFMxLHQlFCcnhVnucMlbSgqNQR?=
 =?us-ascii?Q?pPqkg4mkxq6QWMupfvAdjj+Ydw1VUMRod8l5uorO8eLpmn6gh6EYMrSXRhia?=
 =?us-ascii?Q?yBMTfO0XiA54lc8Te7D2L5BLd27SEO3s+agDOvPw+VlwG6dLsrjJyWiA9Bz9?=
 =?us-ascii?Q?fNpS8ma8tgTP4uGVAHMKvbbuSSkck3Bu3O8iGBih5tA95ixZDPEHb8dEwc23?=
 =?us-ascii?Q?/hYFcdpnjO0bto9g3lQZU2XHipNBiUTN9VUHWo0Ppl4I0+Df2j6clmVEJGAT?=
 =?us-ascii?Q?O7/zU04J4XmySbb46l7rt+O1T/tIOtHNV/y/o+SA3izklQJY75/3NdNy6Sdk?=
 =?us-ascii?Q?mIDwQEKyzZ7NFgsg+vxWp3rKHlEZ0wsi+sCoYwwdGRBzHqw+b3sxgaOZWhwV?=
 =?us-ascii?Q?ZbHig9SkV1s0H4jvTGgmsMelgS72zvMdUYeuIpr/T49dSCIEap1TUq9NQwWn?=
 =?us-ascii?Q?wZN5RR3iD+5D9d1dIrRDf4G1EDBPALsQAKZ0Ithf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12db3e60-8fbd-4a91-fa1a-08de05b1bd8d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 14:56:48.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyFnP28Q5YPauT/xT3KLyrFutzG3plvg5QdM3ym7t9Ip9749GWglSDt1wHq0r4jJpKDwt1wu5/pUsscY3D1A0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863

On Mon, Oct 06, 2025 at 11:34:06PM +0200, Borislav Petkov wrote:
> On Mon, Oct 06, 2025 at 03:17:31PM +0000, Yazen Ghannam wrote:
> > Generally, FMPM will handle all memory errors as it is expected that
> > "upstream" entities, like hardware thresholding or other Linux notifier
> > blocks, will filter out errors.
> > 
> > However, some users prefer that correctable errors are not filtered out
> > but only that FMPM does not take action on them.
> 
> That's a pretty shallow use case if you ask me...
> 
> -- 

I think it's a common use case without FMPM.

IOW, log correctable errors but don't offline memory because of them.

Does that sounds better or about the same?

Thanks,
Yazen

