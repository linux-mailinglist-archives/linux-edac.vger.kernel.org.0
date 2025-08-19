Return-Path: <linux-edac+bounces-4607-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9C8B2C995
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069C61895B57
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1BB254AE7;
	Tue, 19 Aug 2025 16:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dJM1VPhu"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F1B214A6A;
	Tue, 19 Aug 2025 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620685; cv=fail; b=bxBmTAm46W9DjeMC6kCa/8USQ9+h4A2yI0nejfSkncuUyYmjQHoULr6kuXEYPBOLr9xayHrsajuPQaBHMu51FKJb8aynejn2a3+t+Hjjmzx1U4XdcTDM0jvGGZbSSqpA3M/BwYGhiNRe0hbr3AhLakR21xjuPUksfSwoUVnYXTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620685; c=relaxed/simple;
	bh=c0Yls8FOlcaYTxQfhuMXOmTOKZwANyLwqxxfWmpr7PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JgOAOU0ma4r/H6xA7DD+ruMUxggIZZZiefvIFmjDr0bGjnNwI+71PE6OPrHv5Elo+iUwrX+RfHqtJHKKqsVO6qn520QX4dtnhSCVs323b1Mg/xX3OamgHL+fkAlF+uMUz0aQReWmJqyip+0h4S0DYKWzWR2drLCERLa+PohV3xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dJM1VPhu; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rq1nqq99R8t8ql8WJ82vo/oDMsaV9T6W7jKlOycRdHlTlKIg7xzy0cXBQgA+z5dB9KjRt4LaderICanQRaMKwg3Mbu5RmWdusbZYrPVydq45GSLnl4iNg2IU8bIGQBn5aSNXThPE+nQkE70P8Y+4HgajNHUVCpcDO+ficvZm0ojhtYH3ERQYKdJzjyi3+mxAn+XfqJl3mKwFK1b/6/c5ZZ4KFdRkBQC/9j6HYsiYe75F4XDsv5swRvUoHK/CHK+Hwj1BalblxE+sI/kLfShnf/TquJNqjtIGA76qC60Hv9ISFhCrU5GyHQdIoiYaKMBHX8mo/88CWmvFARGSw0VjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdqwxPQHT+S6M95BqJAVS6Mn39rAGLkIqGZURFn7Hfg=;
 b=pBlXri3d8Ws3UCa2Ak78DEc4uxMMNdZlUwfjKoPY0CsmTaSTS9+ZSTeppUB6wFdfwxjGJ/K/Hd5WLOQlS6Ip2h6VeqrtapUNo5d2bjS2CORhlrx0CJakby3/1HHIuTJulHq0HLcNFVHl5l9+4sDjzqHohNJ43g72bF8qfdeuwr9OZUJRVmKBXr3ViXTUKYp5bKIORMfKGPOVyg6nOwg431dpwR8VQLQwcd+5CVhiZ1vWaPFdwusBLy0JtBF1II7Ht3xXW/Bm33BQqq++e+AhBBPDXbAu5hyvdRZa3Wri4OrO2clQTECy52ctxmHyUvi8FRImXJqpjo+cwYadheT+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdqwxPQHT+S6M95BqJAVS6Mn39rAGLkIqGZURFn7Hfg=;
 b=dJM1VPhuBAxeQ6+J/SKPy9MUIe5hz8arF0+SsoMnqYB5vFOu/LpJ+pj0nzDmK5XBiE+lC+3qCn6b8WU9W5GJ99NdVwVMYkJpjh+XlF7wHattKzrgsuziQbiXpB15Bivsz1k2P0X9ETJ+sC6H5vd17U58nSTppcXVSjNYoQneCNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 16:24:41 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 16:24:41 +0000
Date: Tue, 19 Aug 2025 12:24:25 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH -resend] edac: Use dev_fwnode()
Message-ID: <20250819162425.GA491851@yaz-khff2.amd.com>
References: <20250723062631.1830757-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723062631.1830757-1-jirislaby@kernel.org>
X-ClientProxiedBy: MN2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:208:234::13) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad25ac4-0ac0-4094-bf8f-08dddf3ce633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ICkc5eC/t5volRYHcF72uEZvAcwniacFF4aLUrH1hSWQeFhAuMk5xjMqoxsf?=
 =?us-ascii?Q?opAPLoJIKyQUbosvvrU2yXYj0ZEGJYqEZ7aT2mAnZ8y5YZZxtFwy4TB+9uIo?=
 =?us-ascii?Q?ztH4ceEyxjXhbxdYmTmMSMowzC7mZ9effmIa+2j536gc8OvXvYnmuC+MXbpO?=
 =?us-ascii?Q?+b/e0wsp4G8iKm9B6BDP/T98bf6eUF6HZMBRVoAW35hMZkC71Oqng6K02dQ/?=
 =?us-ascii?Q?Y9c7ApyOgjSBzhCYw9pFf1TfcHoIjgedakjdshm9z/klz6faWy366Qf2Ud2H?=
 =?us-ascii?Q?Y9bHiaKkL+MGNK2w25W3oyTvg7HqS+iqaFbnt3Re78aa/WaSPy/WrVsf8lPF?=
 =?us-ascii?Q?2ObhLcEV+jCY3rNOJlJ+c0Y1LrHpXcpRYzTV1zRFYbc82CeX5gCZcNGgKt/g?=
 =?us-ascii?Q?KpR6utR1+FOJuP//9Z1uIm/WqSFpj3OsQmcoXjR5WrmuMvfCpO1NwHeK5qdS?=
 =?us-ascii?Q?DzfEvATR5Xn1EJgZkknwd/6H9ymE4DkMIeY3c5BST7TCQolBkooYvKoV5B/u?=
 =?us-ascii?Q?yUZh8ACx34lg0ZO5679XNOg4w3Kk/wxoN3zDV5T/ygCtFVM2/rdCgqWw7qZD?=
 =?us-ascii?Q?01bs94lPmUxKKivqEzcQVdo79NqZT7i2D2AZYrOVggtJEAyHZfAr9mQiGmJr?=
 =?us-ascii?Q?zx6QE5+MDwqzVNcpKVjbxuvpwOVOk3sAfHvklkI8uK72V0Pu/dTcSdJ6mPAk?=
 =?us-ascii?Q?qcUxZ0SqlOnrFKarcqyXlIZmEmAzxat0P639yRAsSx2PtZI573six8Q91sLW?=
 =?us-ascii?Q?MYTos2Zl9GIcV0miaaW0RAsXNg+fNswVji/AEQ+9wSLHK0swHe64Y/yu5RBn?=
 =?us-ascii?Q?XxfbhYCdTZ6hJhdnHejpJgcTEtjhPQ52vPMg0rb1CfouihA5zRJT1GvEoyrQ?=
 =?us-ascii?Q?pDD0tGrt25/5W4dZKydvBMo8TEo4xstTOYzirGSYL4qYHQttXqexXLrOoS/r?=
 =?us-ascii?Q?GEs4WzmheTaRJoV3eGFQva6jn5rB+tfQTPklo+JDi2myXGA/jenreYRCxqeV?=
 =?us-ascii?Q?ZI1UubOj0mGW9pOmjT/EdKv5blAPE5NLPBbtO9ZbAXgz0zC8E0akwSykfV2B?=
 =?us-ascii?Q?La3o6/yqRzTFCbGe7YE5/AkVqYb25vNpCg4dr0zcViMP0+wga9Jn//irVSbz?=
 =?us-ascii?Q?X73YEsP9IO15+quPJAVJJDoazp2oAYk4XtCi4A441B+MkyMGotHgf92UEQlS?=
 =?us-ascii?Q?6jBkt91geUEm4N6H+R9i+1FLjWv+cHz1DhJtmKwH+MiJg3sSBeJhSjwdszms?=
 =?us-ascii?Q?3+80stLCOxl8JPrZjHBijeXR/ZW8fie4bXuIH5jiL/bdRJuE+4H0282YUJk6?=
 =?us-ascii?Q?u4KibH1LV9/9uR4OcuaBO5Td04vobsy8aWTBEiiKIlz210kUXqyFYn3vgV0G?=
 =?us-ascii?Q?a9NpZpn8C3k/sQu8Jl5prjaQNHS44cxeYPgIwXwziKC1EYi9mlGau4AFdv//?=
 =?us-ascii?Q?FbSNQ7Uru40=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PFNffDx6XJcsgtJ5RQunEPV0HomkQOXb5DIBid5S3KTeMzZ401RBBGKUnpyc?=
 =?us-ascii?Q?NCIEYSC35pQ6FLvME2bjr7MjR/Rkk6zb15GeDKnEe63JuPegCw1axTQ+M8jq?=
 =?us-ascii?Q?4ImlnpXywF5icJW9VC/hF0mREUAbQL/rjJiDhz3lTQF3f8Gf01m2wAW4X6xK?=
 =?us-ascii?Q?Chi5+ILzzaTEYexkjXaZ48yLLJUPmMzGHiWiCEj1xR4sIvyhmCSWdNhP4Z1N?=
 =?us-ascii?Q?qSwuYkYyJi89oPSdDwinx987gQezx0NBTyNgA0oDuB3EbWf7koxfQu4YoBgY?=
 =?us-ascii?Q?pyw9x/83zMfjQGsbut8k5hEwmUMdXnMjj5NRE6WXGS9iPwRN0JxF3fz5FsQj?=
 =?us-ascii?Q?wckNP8JPrufgj6yZ1AWV0RlpNIqkekmtFGRZycYeeOUV4F31CEUDT6d1wD7q?=
 =?us-ascii?Q?Ua5MSwHIRiyuI8bv7K+WKFb1NiqudQXrhdjY1tCFR99ArHHmJzcF+50S34vH?=
 =?us-ascii?Q?7ck22lluDucBqsY4m6Mad85mOK7Lk4J1h3AM/jzabfk7j7QVUuPzlOOuxoLJ?=
 =?us-ascii?Q?MccnQChXSITG8TPtOzha5w1Re1ClLI7iMBH7843dbT9C1kFc2J/80HFA0aQR?=
 =?us-ascii?Q?Ulk1kfSjQGMUrm+xD+otoc9a8gZ9lIpZUJQebYfIWkxMLKfuMxm6XgwvPP6b?=
 =?us-ascii?Q?M9/OT4IEcja5Y4Gq+bi6Yr82gSce2qDNDOwS9VMPbphG+AkYx+NFWOxKHpHe?=
 =?us-ascii?Q?95ceJAlv/7+oEGoyrLhyjP8RoqoLImxE6zxPdMwIUkb3qWooPTjh62508Guc?=
 =?us-ascii?Q?MyGbyOmHprQOhqP1g1s4N9WOHuZYv1o83cJd+l4hxwbv+GCyZVMyWebcdkUo?=
 =?us-ascii?Q?SKgw3qvy9DAlb1bGwqia65Ok54YZCLevwngZUBdvELE2x7GNlg71XWQIxDML?=
 =?us-ascii?Q?BKKZDG0G5ChBwhmJA3fHnSkw1KdCbIBsKhI/8FIpZGdIwmOipwZhfx3Zec/r?=
 =?us-ascii?Q?16yZT5H14eNe6Y0XEbCwSbjx6b7CqnAvxERru6LJ5x8wulHBiumdM+GJSgG7?=
 =?us-ascii?Q?yCuzsJ8FI4TgQHVBADtOTtsi1Ro5EUWHtCPVgzbYFY2XXd/Oz8nYkl58tRXh?=
 =?us-ascii?Q?a4BA9APovQ8ptFXjJAjamHCTyM6Z8VxcI3U3gUb26IE+3gNNuzlyqjd9qjRP?=
 =?us-ascii?Q?Wld3Ezd+MEz7aLvJK8uMOYqWPLnwTA5rZcE7NvGGVazhatNlPo5Dg8hYPsui?=
 =?us-ascii?Q?0YA3gfvpyHA8waY8r+vcIXqYp2iW747gWRhd0jlgmMR4orfRJ/JtaLn9f4rb?=
 =?us-ascii?Q?MW7pZq7OgIL4kJ6vjJSZk3xfg1q0Q/ZfLZpHOMnhggbgzbKglT2EKqA4zbpj?=
 =?us-ascii?Q?D03HahOVyjNF/iMTRcw6HWsD1JqnBxpLHBdu56ARCJ0xEzD8CvVbAq9xdt1N?=
 =?us-ascii?Q?ivtBZrkPOx7Ozr/9eNFiA4yNgTjX+zPlPio8pqksoncC1WGoOsUiX6J4O2us?=
 =?us-ascii?Q?MSH58ehrpzrFt+xXXJJRnSCmjGN6O8dDHouwlJNPOG0QtlDRnZxZoqjDeqo+?=
 =?us-ascii?Q?e5exEW2nJNaMHLeluQHoGgpFq3SffKNgADLwnbpcZgb9E+CK1rGbLDvOYtzy?=
 =?us-ascii?Q?43dLq3YmGpUrboumHs13YJ55DPGhEEmno57yz5In?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad25ac4-0ac0-4094-bf8f-08dddf3ce633
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 16:24:41.4661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4gDBDkeaiVHCubqlwKZqJ4o66xWXPNN7DiChbJ1PDWVZ9b7DYWvWvHKQA7R/zDc1Upr8MMC77xn/zMW1J/WMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

On Wed, Jul 23, 2025 at 08:26:31AM +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Robert Richter <rric@kernel.org>

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Thanks,
Yazen

