Return-Path: <linux-edac+bounces-3886-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032C9AB3C80
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91AD67A15AD
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C0E23C8B3;
	Mon, 12 May 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ELQHCei"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046BD23C516;
	Mon, 12 May 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747064603; cv=fail; b=JNx4Erk6X8Yryzt43W50EiM7Ga5OpJBu+foYRsdAy+F4RQNp1UA4Ge8hEXWpphruql9Zl8Xp9v+i4eSfhOJOagUXxN3rLYxOWvTcfRkixIEJfUWR4tBg8ELAmmKMIz8A+NYlW0T1WHcmdT3b2yLyQNzXrNCr8acXboTX+3YHXsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747064603; c=relaxed/simple;
	bh=IO0VWVvn/gWUvGZwH87nFf5Ti4yG70iG77fqqet5N6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WKsibV7fNu1wiv5raO6HriHv9qZrx5LHhIaqx33VgIupJnSAjNpBesftglSB/BjRWJLBvL4yeu7e/BfFUnO6UPOq+Wxm7undyfMGSbqbL6YzKeQBqHY5YRl0SSHfWgW6hmksDAw5rfbfiTr2in3+iKQS+sbSPuM04zz66UnKscY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ELQHCei; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTv/5X8Wh7taxXdaQSQfO+cVbwjDxu9FNSostrV9e8VML+lgqXg9HUY5ekPKicd3Wr9mBkMgWcaOqgMddrnMWi38RSETEvdao1I/QTOa2oKConiWFN/fZvppyZf2SmfVqw4Kfl9xGW3NLdiRUpbcM3dRglCh+CE4vVETPJkECLyrliriFmJnwBJNrL5j/QikwTjdF2RHCTE/M/1SwfjIzZ/Z1T9T68EDcidwmp/X+nXykaTaI3GvCxE5H4Aym2gluWYYiLXj4ZSqRFVfBOn+UJ0LzX3Vo8sUwOeFWqivNMAerLWczwRd6grsRspejArkJjEb8HYwv8SPlh6FQUfbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DcGu+oNHHuGqoYZw1J4zpB008+X1f+1nQXmV4fOI70=;
 b=vulL4XltDOs9NT6XV8sZqmXFTgJjh3f45DmLcl8Izprq//MxvGiLTXY9mDK7Zcg2YhcPQ5POfTE0wWDuOHa/MDGzBNbdmea2lZ8YgnGwK8QnemewTX3lWEws1oqiSPod7pdhwyG2MTMQYvIIjWofYpGKbKP7qd/lmCphqysNmU5ssxWiQ60q9ueiPle/LhvrDTJ2bI78fDk6WtcCfZmXzsRzh9D81Jbu/CmA4KBm2nIA+V6v3Q8WCae4jNUlUL1yG3ZgRP5HstoXGNcXo5VSzKz8ciycMck6wT3miOHTXxy/bXMcMCvsLglTgSis3/wmq55SCdvXUow4T2AUDrM0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DcGu+oNHHuGqoYZw1J4zpB008+X1f+1nQXmV4fOI70=;
 b=1ELQHCeiKTOrzhnbfS4/JNABV8iBKBw1hzNyGjvEMhGKokFZpjGhVr6ISK+zDE3JAS1ZoDsHvdWsjWFDXiOSySi5BuQchJ3Gh8NxnEH9/W7IvqjOBSMyczW4rb0DMvCeRfQ8McOQAQbFuFt22ewoHXa9LNffj+mcCtUUNQ7HTeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 15:43:19 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:43:19 +0000
Date: Mon, 12 May 2025 11:43:15 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Message-ID: <20250512154315.GC2355@yaz-khff2.amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
 <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
X-ClientProxiedBy: BN1PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:408:e0::26) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: db24c5a6-dee8-4322-f75f-08dd916bb81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aYQmJAcbEWJLSVwyDPJ3rq+D7ubZFYYwEhp+DqL4O3s48RX5SGXKX6ShnZPc?=
 =?us-ascii?Q?hJOhHaW2JggViM/QvqtTlXGEXFkUhYp/0Jo1SxuHo8Re3K7c/1XOmvBsem6f?=
 =?us-ascii?Q?I3i9yNd9RYWeyAFt2md48cVmSZ4XkToWMDqD7hOu2Gy861ZlwUO7avsup5qQ?=
 =?us-ascii?Q?vriaWlsj0sSAI6J1cRaQGZiJbPiORchHGtdSXUk8SmYQo1ISxR093gWVoNfd?=
 =?us-ascii?Q?N+IWGiBq5C7FZ9kEyXBHBRUShPEa2H2VW/XsErTD5s8iQWe0kCRteFVmz8I7?=
 =?us-ascii?Q?xReUly86Svm59nkhZzNsvhzNcA2CfEPZCFRbhwWWkRJOurtq+ksa2aWrqrM9?=
 =?us-ascii?Q?p/f/cFj1PZOQy9ieZ97bMbMFMRqIgugC5Qyk04T5nuqs+Ks54uutFHDaPFQI?=
 =?us-ascii?Q?SNMSw05rLAxMZ33/+tvVLRAEaAwh3jY8eTjbGBccVhNG1KhNzYPUsPpSBb95?=
 =?us-ascii?Q?oNQD4kct6opInW1NJrcsqdNH95rYUcRqi6mf0Y/ecoMhhperLMueLmFGq4S8?=
 =?us-ascii?Q?xJjD0PV/qmKDC1KiuEwYbBkYTlvz2pP5uti+X9DMZpCH45UiVdcgOD3Fk2tX?=
 =?us-ascii?Q?Jme2+9F39KPFEK5qdIURnNWeyrM0pxam0/N3eoq/eZ8mng+paGRHob8BiN6a?=
 =?us-ascii?Q?x8tEYSxwt/90ARbpsNk9mkw+wxX3yZy6aeo/78twXR0TTXvZAH9fkiqwi1++?=
 =?us-ascii?Q?ibdZKZZmM08OgJTx0wlolrFWwbrskjwiuV5u/U4TiJZ0j/WZGyVHcAiC8Cdr?=
 =?us-ascii?Q?kGfcsr+W2MbB9S1uBkqUTNybccS8v5i9tZlQXD/LqUr7r2CGWUsE3bRLpv5J?=
 =?us-ascii?Q?H8c6Rbl0/cftwxMGIhe03PT/HzG64gP3LBgPfBnHC5uEQ2G+sFu6ZKmupEq4?=
 =?us-ascii?Q?YI5zqLpSIDatO+LBXc5KOsFSISXLeGkHTmKyNfzSdyuGOVGBoacCywzP/9Xe?=
 =?us-ascii?Q?atyHKJFk6dkaIobqSkhNnUO1nlvOw1Uxwr+Wmv7jPYh3EuhsU6sGQcgYyo7F?=
 =?us-ascii?Q?03lL5j22/XrpCVMUcrVYrnDhhPUCZNsyrpg6eAc97zI810YlxSg4fCUQxo6Q?=
 =?us-ascii?Q?Bkgg9n7a+1JF7AJp5LpIddxORULmrsNIB/0AmkrKJyVJNz1UxFiWuWMPW44P?=
 =?us-ascii?Q?Nmm3jwUq0IdjEKL+SKtFLOjczKzYQUAJMnAttKXtgs5BwZHKDD+vU125VAls?=
 =?us-ascii?Q?Gh1L62qq9dgum19dKDW+utBz5gBqk6sgP7TBxAbn6Q8gWo/BHz044kNjOHMI?=
 =?us-ascii?Q?vDEVEoj5Oh7jLsSgGUFz+3L+z3XOsza21wnCYUhPFYS+Cw7kP5rveMJtE4EP?=
 =?us-ascii?Q?2roagswgdP9tLg8PibpUJmWq+RZAy7bgij/3jv7u+sjpkg3DB2rZWzS0IzOo?=
 =?us-ascii?Q?rSBBfC1fdKLuq8yRG/J0jFdbJB35lFAQteC/rhu5e7cXMLIEj51k67SStSBF?=
 =?us-ascii?Q?Ihidfln3iBI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxMpPe/0Evl26YN6y2laqLAU39Or875rvSWyFqwOePOfKZq11XhWlSv1Z8Rc?=
 =?us-ascii?Q?At+AA/M6TazQqIc1ed5u+V5GQP1FCF8C21rSmW/Z9KmEyNYnTCDkgr+B+Dd+?=
 =?us-ascii?Q?5TeoZFmJGNzpanYL/VDqGbIM5i3S4EfdhfwvYQTK1OvTlUT8V6mXErEmiGNd?=
 =?us-ascii?Q?28KKV1wGb5bufZUgq202xw59etv1GROTqQjfepqZN8r2tuxAnwusUSGBzpZ+?=
 =?us-ascii?Q?wHsVRiORISkByx/rN9Cd4nibEkNsZy4rk1L1MmJNBhuMg1kEaLlGe3R0sAnE?=
 =?us-ascii?Q?HCsDRCc+RI0e1qItyi4SDWpngAN7oDTvIu8IENKlWGLJ7sWywx+KDihyT+g/?=
 =?us-ascii?Q?qJP8yr1ap+Q7t2366ufYGYhj8gWyPjjNWsoEEKHOUkoS36Ag259Dk3AZF2xD?=
 =?us-ascii?Q?1LrXCygKzqG2MEOPnR6EAV5ujYRX/vttJfZJt5PJ+XrI+/N5piSA43w29AaF?=
 =?us-ascii?Q?9RSfjqUoloHCyfaSccxEbdHarkgL3jb4i76QFI/XpeIEipHr41eoL8hs05dZ?=
 =?us-ascii?Q?zg24blvojAD/5JijVIQwpjRK8DmMWL46Xw2jzUP667I2O/5H8YpbJA8bszcD?=
 =?us-ascii?Q?0k7fGG5T8P3i/1K7P7k+JSMrt180GeSoQ0oJcxgaKwHAbRRflhkj2Ld0fmHC?=
 =?us-ascii?Q?gP3KyF4GNhQ2fLptl2Z+hv3CNjhMcElndLVKZgzxcwNib+J3/XXaB8gZLHId?=
 =?us-ascii?Q?cCv4C8PLoQEidIxjUvuuku7muLZOzcwwfDvhVkViJklHPL9/FjkJZDZ3wBsc?=
 =?us-ascii?Q?XLJ25L4QOMJUT6zvco2V2G6Km/i1QRSnfzhJx+gmtcDCaehIVKg5zcNsKn2T?=
 =?us-ascii?Q?ovu1v6WdYi85xRuyTGb+fZyw26LtQCNQGN8pPavFLavYoMqkbXVTP2JJlrlY?=
 =?us-ascii?Q?J7gcVPRNZX5rFVtyGJbLTmvfVPgQN+FqXDSOzybZ1HPk3QO1FXvLWIFlugB8?=
 =?us-ascii?Q?5D16+73UFVouG8UKm+MGdj4rNpOvPcZNaNij50Yek6+Q5rr67sxes40B8KIN?=
 =?us-ascii?Q?GyA5pF50roqIdGkVA96tIVLgbssRCjaG1y/W5M2tCiHAyPsFnigYKwZ6Tzx0?=
 =?us-ascii?Q?YYYZ9PbG3VyVWO71u+OwM1w3WGlLd8otOryCcSOZK7wzGNz4TdqF0tyoXRjy?=
 =?us-ascii?Q?7Zi8qsRFmJVohhtiwoGuJxylyQICMQ0MOoXkNuH0bPt30V63Atez6MtB8U3r?=
 =?us-ascii?Q?DKVd9SR7mIrZWC4n9YtyVawj3AMhcLF5TV9BcOBDtToVaGyAmEBgUrEGL5nN?=
 =?us-ascii?Q?4II9BT8I4L3T/p7BZInbfatcPHc3ThVOnWCT/mXriYNh9rc8/Czr6mkS/d8J?=
 =?us-ascii?Q?an0O2dD/ss8wp2LjUo4PzlA1uGWyAyYESYOeyKZEr8/by+uJgtgjgBqcyzn2?=
 =?us-ascii?Q?yLh5uuhPSS6bjL7L+KDqjVnAcmDHC6KIE2Lw0ZqqsQrRRMH8U+T086QRZNg1?=
 =?us-ascii?Q?cIDc/sO+FaBaRsfoq7G0YXccZvQ/ayM/Kh6CB9n8aAaGLXZ4ictlZKaQNSLG?=
 =?us-ascii?Q?GOQkJZ0xi+xYeMxL2VY/Ip26dO0GsNtTiSuHQb0HY9emKK25eF0pTeLicRk4?=
 =?us-ascii?Q?otuL5PjEw19UZzZbB5KndN3Z0LNfVFLLLfTagX/t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db24c5a6-dee8-4322-f75f-08dd916bb81e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:43:19.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmTtis8M+vywACzeFfWv8mvYRFtZUfvjAMPCdZQAY3XzqEbpbhQUcXPYeG9tZzG2ih3dSmatIHs7rpKprpK7Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

On Mon, May 12, 2025 at 09:46:16AM +0200, Borislav Petkov wrote:
> On Tue, Apr 15, 2025 at 02:55:12PM +0000, Yazen Ghannam wrote:
> > Users can disable MCA polling by setting the "ignore_ce" parameter or by
> > setting "check_interval=0". This tells the kernel to *not* start the MCE
> > timer on a CPU.
> > 
> > During a CMCI storm, the MCE timer will be started with a fixed
> > interval.
> 
> Why?
> 
> If a user doesn't want CEs, why are we even bothering with CMCI storms?
> 
> Might as well disable the storm handling code altogether...
> 

The use case is "disable MCA polling". I just gave two examples of how
this can be done.

We can focus on "check_interval=0". The user wants to disable MCA
polling and rely only on interrupts. They still want to see the CEs.

If an interrupt storm happens, the kernel will switch to polling with
our MCE timer.

When the storm ends, the kernel should go back to how things were before
the storm. If there was a timer before, then go back to the old
interval. If there was *not* a timer before, then delete/remove the
timer.

Thanks,
Yazen

