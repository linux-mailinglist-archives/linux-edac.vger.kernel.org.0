Return-Path: <linux-edac+bounces-4285-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2610FAEDDA5
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 14:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C75B18930A3
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422EA286D49;
	Mon, 30 Jun 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BD2P0WuL"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7534F27726;
	Mon, 30 Jun 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288256; cv=fail; b=f+P2wLzX3yQDDe5oxd+nKUoOy+YDlNd9RDx/sAvggMpMUEg9dnitw9DMkZYDW43zBF0ZjJACdJ8MV3iWi3dYWGNphMfI8yanCB1qG/VoPWKOTY+3qO1UOpL34uYqdMrxQaOsVzLhkBTgqdtR7m5kGlDpOXJSWLNxz0vXJytgLjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288256; c=relaxed/simple;
	bh=fTHNIR7lkRHCp5FxvAeSG+N6XOAWg1gRZ8WU7cljuRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jqoWi0kHa+02ZSKQwlk3txI/Mz29pitbauA+nueZV5C0GkgweVLMmwj251WsB21EPHNa7vbwQf5B6LZxD+5xiBSe0AXdQXGGucRhHWkzm6oFLNZbxiC5Bdy6VLKyn1oDKzUEZNE13QhJLvn7gEYeAOXw1IxJWLoBay9hS7j6oI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BD2P0WuL reason="signature verification failed"; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DW9odpWWe6IERinr2Y8PUw1eTh5xwWV935s1Ix2nZ+x1oTcwKFHS9ogOup2dM7ExpzUCENUcbpDNp6faKIWPDMVHUKvxAVUXMlU1KSbR57b0sdUmH8MyTnPN3E9hjn505MHQZROtO7M9UtQ6K2GBFUfhLXZ2acUv5sobK/lkK2kMLtQKkUTaYmaY8IMijO3CoLgDaCVVOn1GuLnVig6y+vYQ9uiviSQk87XmjznVnrj9trtvclKN81V95HOPSjd8IWVGxJejl5Z24VJGbaccPcOlbLCE03O25cSguFyHOoqTnnpUpe78TCuHc0uEOX7ye1qeCKZLEINBF0m2mk39Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfrZpcBXjFgJWNUfOOSS8PBp0OBh+1D5NWgzVkDfeWc=;
 b=or2DI3nD9JGyL/9IlxcuBL6rNNMo8cZH40VIrcOmZtIn4+MvVUtsDFN+4n2UpuogMMYtamoBtrTWo/+QwOyYYbdLXuUVe3DzwTIz07YsxCW1+Fp7Iv2wI93dQnATXbYXGTJPFsReikhKb3aC3VNNe/J0FQ770jtsmPGvELne2JbSaAbS6wzNUbca8evQyVRViP+iE4MxRHGT8uRzvUwNpUYD5b908V4BPXJfvfPoHbWDyX+ty2AOC8ISZanNBsUyAIH07rSAWEKh4c/7+EeEskKYXMS5/r91VgH67nnc0005oV4F/0Bvzn1Hko5YuPE01RXLdWGtxy4FmJI1sZdf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfrZpcBXjFgJWNUfOOSS8PBp0OBh+1D5NWgzVkDfeWc=;
 b=BD2P0WuLAwlN0k88lWdF7zIMNXDKi+52v5bB/YXZavUezyFRexq0vbt5kFusj6MwsOdYP2A35I79hqDIQTD6Z7iaSjCwdRJBUkDZIG9A4nprDdEdJG8aRb1s+GpXo6npwXH4bDyZkY6WpMSuJp/Gg0kddzdk8tHVzMvToZba24c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 12:57:32 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8880.023; Mon, 30 Jun 2025
 12:57:31 +0000
Date: Mon, 30 Jun 2025 08:57:26 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 08/22] x86/mce/amd: Put list_head in threshold_bank
Message-ID: <20250630125726.GA5995@yaz-khff2.amd.com>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-8-236dd74f645f@amd.com>
 <68039ee2-5407-4bd4-9735-62674805eaad@suse.com>
 <fda62d41-ad87-4e33-9662-11d397a26f7c@suse.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fda62d41-ad87-4e33-9662-11d397a26f7c@suse.com>
X-ClientProxiedBy: BN9P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::30) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 31467194-76a8-42e9-6fb1-08ddb7d5acc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?GQXkdBpBDigALSFQn9SErC9jBzCjGlfJbzaQXLSyuD1vlgOyg6mlrj7OBR?=
 =?iso-8859-1?Q?QuC/snEBiyamDio5JUBdDHEjD4jDzQTfBKUw9rCpN1UCCDIxXNDWiEafyU?=
 =?iso-8859-1?Q?spRmFkI6vVtqc4WELTCLH6nO728K2YSkPCDc9A/TX7pkVSltDpaQP0Ldt2?=
 =?iso-8859-1?Q?VU9GVhd4Zf5DiMZRAsXsW5YLKM/1EdF020ynruEkjftRHVFaaDcreNwKR3?=
 =?iso-8859-1?Q?EdzN0XaHdWiebJ0Fa3y/y7Q1ZNbSpuooqo3IKP++27S8SN8PKgJPRzZ+wM?=
 =?iso-8859-1?Q?WhYR552Z3h3yCvGFUJpgBQLp8TnBZ28LS4BZ6eL5KLWwWuwNJnwLfYUuZr?=
 =?iso-8859-1?Q?aIywE1suqiUTfGL0HH6k7iNMcAiEDqUWGZXpy6NYpB+wRYEa22PjCok/FC?=
 =?iso-8859-1?Q?w8sNY2RSVjmmLuBJl1Xus9StBYm4rxHoGdx/V8b2l0cfgu9W6/N/PZAZEX?=
 =?iso-8859-1?Q?HtJ8rPlwMbTiTRFad22pHFrbaABYebsvLf8UeI0a5yz+ZmMdhzg9ASzKMb?=
 =?iso-8859-1?Q?RYXT+V+m+kO2TABKiZ02MermEIhuobkjYeqqh48ziw65Dg/T8OxTMAv2B9?=
 =?iso-8859-1?Q?XS9cMczCVRokwEj49Ld/r7SuCarkzOxC3Iu1WJ0KfrCqtb6HVUBFfTOef9?=
 =?iso-8859-1?Q?XMXgPx8o3j3jqeRROdsBoik0eR1eECNjO4r9p8MgbuH1cPmxuwuMGl2Zdy?=
 =?iso-8859-1?Q?ZEIYwIe4LQdQ7kHA+zk2Sup/1A7suCHjgnsftDp/rkjaSQNTRlLIgxK8GH?=
 =?iso-8859-1?Q?S7cAvIIjXC/9ifPvSU2Ra+/LJ9IQXNsOrh3DZT2i9qNMwoAbDX5q7OoXO8?=
 =?iso-8859-1?Q?mAvULSwWEHYfzEiHNcZTJvO0aKwyP1l2nRgoD+J+qijCs/ATQMINzP1LQU?=
 =?iso-8859-1?Q?9WJJcU0E3+qMR9mCgWw+AIpKih+581Ysvlyy5ziT4nUuDdY5Aj6bguPzyl?=
 =?iso-8859-1?Q?8e9VOU8duI8DEaoheqbDYFIUUTuFH5VjufpIkOQqw/+ghnwROMZ2GDeIGn?=
 =?iso-8859-1?Q?qU6deQKx6nFkpMnAfaQgyImtpqRpW7PPvnWUi4n2SZnUAsh6vKOoxynn8f?=
 =?iso-8859-1?Q?dm9Au174gGudHEu7xyClhlzAvvRvjLN8phg42IMYkMAtyWSTtsQEfQo80S?=
 =?iso-8859-1?Q?2v5Cj4Qr7/8ea0TP8rRWCcESixBQtiLnYAs7dOS9Gk805sTx2S0l1Qzg09?=
 =?iso-8859-1?Q?RzHNA4FXQu3dDWOTFcNbV+POotN1ipQYHf+3Tu2DqmNRBxBLFYPmQNXvtb?=
 =?iso-8859-1?Q?aRkb80Ubh5pKs5YCMQzsvDRT6StdTi5565x8pKu6iTwd5X1VuBjgeE2Nzv?=
 =?iso-8859-1?Q?nUSKx2u9dfK/8T0FrawStekbWGbSZjVN5pZn0md4EBrwF+fCqqzniS8GJ5?=
 =?iso-8859-1?Q?G3lNZWi5ptD/ug3q7+a33mAOoRNJ9yZ3277KNlBB2pl/uUvKMfVkarSEo0?=
 =?iso-8859-1?Q?kS3G0ZCqYabTNoKyZGyRSqzhaoRpv2fURyJRxuSBqajQtKKP2lQYJOeMov?=
 =?iso-8859-1?Q?0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?C3YIfcG4ydvW0b9FaAD2wkr0s+QkKt0n//5kP9ym9VnCnNpInyQusnOfX0?=
 =?iso-8859-1?Q?MUL2vPD4v40xzJl/A1gliw137pMwtgUV0AgRJ8wryxB2z8fMTB/A6i/OKY?=
 =?iso-8859-1?Q?6DeRKKmVMzMt1UMC+9reICyqjn+5SqnB1ndNFmYlLROAqV9Exn2ZAAHzx1?=
 =?iso-8859-1?Q?mEF+Awza8EdZCXY7Gxglu/EfW9PcZt/h4lhLPNRnU4R9bUAlAJSB43QMQC?=
 =?iso-8859-1?Q?BZxiKB6xzHjxkhoS3L80zVzYnEoOBZP+AlGZcfK6iSqk1ZUICtNyRFuffI?=
 =?iso-8859-1?Q?gJkopqLJ1Q7uRuyB08Q4t9Qzwlh3w7IaXx1uXUNahud5ncYN4ReN2kjMDw?=
 =?iso-8859-1?Q?cIzoOElDl3THZVLLf7c4MHHjSg5Vhr2bDAfui7kgiq66dDub7jcHoze7Up?=
 =?iso-8859-1?Q?ASDlbvJDZu63DqI4vv/5jZhrt/65aX3aGrozF8MuzDL2PmSffbFSIrqK/y?=
 =?iso-8859-1?Q?FKmBDHOwj7FTA+y5p+pFE0vh77MGTEt8Y0Hoo+DuoDqwUiWbzEM9syGfMp?=
 =?iso-8859-1?Q?8vXOSuWYcCX9WR8HqLSLdyf69fs/RYqHbzqIcoZkZgvzHpn5FU8v93VGXc?=
 =?iso-8859-1?Q?mLx5f8OJXzTM3s/yJAZkMMFUDtu++gFlNtfbSk/6R/aVO2Gx54anH5E1cq?=
 =?iso-8859-1?Q?9gu4mtVwj77vxRRpEwqLEHsvDJSUt34xdaqG27kCzpV611yKkkxATUNBn3?=
 =?iso-8859-1?Q?sQM1vCsVL/1Pkhq0gO3MXN449W51UhKe7DoNKT3p5DzdULAqXyL4euwWl3?=
 =?iso-8859-1?Q?zAC8rjU8PHTLFtEjtbjdi6UfOCA0/V+j/HUWctk0ZET3+IEhyvVRI3hUhG?=
 =?iso-8859-1?Q?Ri6P5u0qt3wKqDep6n7UW1wUlW2pkQAWhT8K/mbYYx749YiGXb7YYn9PdU?=
 =?iso-8859-1?Q?SilwSxp1IOJmb9XBcVtOJUAOdfN9kWPFY2i0Li+QEjGqXKfxObDQdKDl/I?=
 =?iso-8859-1?Q?Mmi4oxiR2vqLgeCmLrer/veMYa96EvIxajhAYqQDkfH2FtkqKG+03N9DZr?=
 =?iso-8859-1?Q?GY4h68wWpqumyLQtjgRr4olEaJkiim/LIJumzguiwXQvRdY6Q0nblODM3X?=
 =?iso-8859-1?Q?FhlphQQP4XX5vZgR7AFuhR26FMZWYuUsFD+K6ywVj6wH7mrCP2C8jP84bT?=
 =?iso-8859-1?Q?BdV8Xq/+KdV/NBTdETyw4Z706ngAcgqWy71qi2e6wRk0vBCvmQMPGd7D0l?=
 =?iso-8859-1?Q?dZWyEEw4pNAvA8EFzw7XlkRXwMXsKpSCPKbD5nQNG20sFnOtoyP3K2lvFd?=
 =?iso-8859-1?Q?5+hYxZYsSgYkGHQBu4JxWgvoGKAZqqrfe+P1GD2J+KPV11Q37eVXOVWbYK?=
 =?iso-8859-1?Q?utsiY8CDW+eTluOoUwsF8Ml3tQSqMn5iYUugkVSfQdPw+NPINeNsx+Rh9U?=
 =?iso-8859-1?Q?86uIcG2cQknf2AFZx+p9IsdobCu3JKBaKgS5ffTNCD79CPcREzIFlFf3s5?=
 =?iso-8859-1?Q?pWIi/mtHVZLyjN4yUCOS5M/qfQB6mDIL6bnzzBtKkft79wRXWjdl+lTlrv?=
 =?iso-8859-1?Q?7HP71KFdNXhXXF7+vfs0LG8fg8rZOraCsUwZgXD/agqILduUfHxKEQH173?=
 =?iso-8859-1?Q?4IB0QC02JibmVOoAtWSjAToPTHA5zTwn3+xoQPQ2mcqorTvCkEOavFjKwK?=
 =?iso-8859-1?Q?11Odjmqcvl4jhvslQcv7yIfAt/y6YZs4bU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31467194-76a8-42e9-6fb1-08ddb7d5acc9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:57:31.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTOBNbL3SRJuBEg7V50snBULqHlt6MzKdxRDAw992TrxxsTdbm156Ah3eyaA9dgK5D48hgMMKl5ZBzrsEK5BUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206

On Fri, Jun 27, 2025 at 02:14:40PM +0300, Nikolay Borisov wrote:
> 
> 
> On 6/25/25 19:52, Nikolay Borisov wrote:
> > 
> > 
> > On 6/24/25 17:16, Yazen Ghannam wrote:
> > > The threshold_bank structure is a container for one or more
> > > threshold_block structures. Currently, the container has a single
> > > pointer to the 'first' threshold_block structure which then has a linked
> > > list of the remaining threshold_block structures.
> > > 
> > > This results in an extra level of indirection where the 'first' block is
> > > checked before iterating over the remaining blocks.
> > > 
> > > Remove the indirection by including the head of the block list in the
> > > threshold_bank structure which already acts as a container for all the
> > > bank's thresholding blocks.
> > > 
> > > Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > Tested-by: Tony Luck <tony.luck@intel.com>
> > > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > ---
> > > 
> > > Notes:
> > >      Link:
> > >      https://lore.kernel.org/r/20250415-wip-mca-updates-
> > > v3-4-8ffd9eb4aa56@amd.com
> > >      v3->v4:
> > >      * No change.
> > >      v2->v3:
> > >      * Added tags from Qiuxu and Tony.
> > >      v1->v2:
> > >      * New in v2.
> > > 
> > >   arch/x86/kernel/cpu/mce/amd.c | 43 +++++++++++
> > > +-------------------------------
> > >   1 file changed, 12 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/mce/amd.c
> > > b/arch/x86/kernel/cpu/mce/ amd.c
> > > index 0ffbee329a8c..5d351ec863cd 100644
> > > --- a/arch/x86/kernel/cpu/mce/amd.c
> > > +++ b/arch/x86/kernel/cpu/mce/amd.c
> > > @@ -241,7 +241,8 @@ struct threshold_block {
> > >   struct threshold_bank {
> > >       struct kobject        *kobj;
> > > -    struct threshold_block    *blocks;
> > > +    /* List of threshold blocks within this MCA bank. */
> > > +    struct list_head    miscj;
> > >   };
> > >   static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
> > > @@ -900,9 +901,9 @@ static void log_and_reset_block(struct
> > > threshold_block *block)
> > >    */
> > >   static void amd_threshold_interrupt(void)
> > >   {
> > > -    struct threshold_block *first_block = NULL, *block = NULL, *tmp
> > > = NULL;
> > > -    struct threshold_bank **bp = this_cpu_read(threshold_banks);
> > > +    struct threshold_bank **bp = this_cpu_read(threshold_banks),
> > > *thr_bank;
> > >       unsigned int bank, cpu = smp_processor_id();
> > > +    struct threshold_block *block, *tmp;
> > >       /*
> > >        * Validate that the threshold bank has been initialized
> > > already. The
> > > @@ -916,16 +917,11 @@ static void amd_threshold_interrupt(void)
> > >           if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
> > >               continue;
> > 
> > <slight off topic>
> > 
> > nit: I wonder if instead of using per_cpu and manual bit testing can't a
> > direct
> > call to x86_this_cpu_test_bit be a better solution. The assembly looks
> > like:
> > 
> > [OLD]
> > 
> > xorl    %r14d, %r14d    # ivtmp.245
> > movq    %rax, 8(%rsp)   # cpu, %sfp
> > # arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu)
> > & BIT_ULL(bank)))
> > movq    $bank_map, %rax #, __ptr
> > movq    %rax, (%rsp)    # __ptr, %sfp
> > .L236:
> > movq    8(%rsp), %rax   # %sfp, cpu
> > # arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu)
> > & BIT_ULL(bank)))
> > movq    (%rsp), %rsi    # %sfp, __ptr
> > # arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu)
> > & BIT_ULL(bank)))
> > movq    __per_cpu_offset(,%rax,8), %rax # __per_cpu_offset[cpu_23],
> > __per_cpu_offset[cpu_23]
> > # arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu)
> > & BIT_ULL(bank)))
> > movq    (%rax,%rsi), %rax
> > # arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu)
> > & BIT_ULL(bank)))
> > btq %r14, %rax
> > 
> > [NEW]
> > 
> > xorl    %r15d, %r15d    # ivtmp.246
> > .L236:
> > # 917 "arch/x86/kernel/cpu/mce/amd.c" 1
> > btl %r15d, %gs:bank_map(%rip)   # ivtmp.246, *_9
> > 
> > 
> > That way you end up with a single btl (but I guess a version that uses
> > btq should be added as well)
> > inside the loop rather than a bunch of instructions moving data around
> > for per_cpu.
> > 
> > Alternatively, since this is running in interrupt context can't you use
> > directly this_cpu_read(bank_map) and eliminate the smp_processor_id
> > invocation?
> 
> 
> Actually the total number of banks are at most 128 as per the layout of
> MCG_CAP register, so using btl is fine. Also I'm not sure why the original
> code uses BIT_ULL vs just BIT since we can't have a 64bit value.
> 
> 

Hi Nikolay,

MCG_CAP[Count] is an 8-bit field, so we can (potentially) have up to 255
MCA banks.

"bank_map" is a bitmask, and current systems can have up to 64 MCA banks.
That is why BIT_ULL is needed.

Thanks,
Yazen

