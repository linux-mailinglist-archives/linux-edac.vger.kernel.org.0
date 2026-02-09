Return-Path: <linux-edac+bounces-5704-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCNhN0xPimmUJQAAu9opvQ
	(envelope-from <linux-edac+bounces-5704-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 22:19:08 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D846114B6B
	for <lists+linux-edac@lfdr.de>; Mon, 09 Feb 2026 22:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5784300860A
	for <lists+linux-edac@lfdr.de>; Mon,  9 Feb 2026 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414BF30CD8F;
	Mon,  9 Feb 2026 21:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K633ITQX"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D92D9EF0;
	Mon,  9 Feb 2026 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770671937; cv=fail; b=QvSIjJUGwOt9Lg11hMKK8NCyqU8ZTSpgqWanaSmhNtOSCjWEJrvLwrztkEw+2OSrv9JKcUkZlXsyxMDGkcyresgqOQbHbf9gMAE6rTdKdDKdPr2EG18L1ekaS5ToBhQDo3XkwZJAaru6hVvnnT9zq+FSm76Xz11OWYrZuxJDb4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770671937; c=relaxed/simple;
	bh=9CyDGvxlMKAdTa8Q7xA8gBdOLPnzeWgZYN8+hhVp3PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DMjdKHHKzHs+F02WpRqP7FzUA9FZRJk/j7vxvxwYyiRDXLK3ygrZ3qTBDeMvHLJISkPhotPf2J0wyeSIFdE/BfGDVqX4ZBFy2C+TTergZbswdjReLgukuQLmYdAhiskju8U6EDKc+gkQDewPr3FBS+f/n7zIUn+FAtEpvkrkb00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K633ITQX; arc=fail smtp.client-ip=52.101.52.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9BdnL/iYR3up3KfKkyb8dVh26gCreOFxd4YKsmRWz4X8HR3BLqEGnpuUcL8p7ouIJYqe3ldSIKR1rzTnsXGy+zbvKMgjqVn6IeAQ8RFCkYMaaDeTwPbu24k7eS54770zToVBfKuN6RSY97LqUrYm7c1m+eJVy8lYJd69SWx2i5I/Dm/M/B3AhyBtRDXWNpZ8fsG30upkKNOY6aRvjitFtiYo5omzve5NjTeyzbR4U+OWlepJk4Sw7woaMbsmmsxSE1Z6l8TruRnJu8lZDmglqiwJOt1hIRs0RkEvsK9+1fUVj/ZNdBS0rtwxq/KI20NeXG4aNIQTfIO35X1cWWkwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyWV2wrL/vVMVxRoAv4k+Fcg6LyfQXhPw1SbFipJtx8=;
 b=m9tHG/tr7eMN2ctxIlgB4qgIzU0JikOZBwieyOeVkzqPKRjgwgT//0QM4DhTPgOQh3hZp2oG8pT5cxRGldyA4foPoabvHCN2MV/beEOu46rfdSblvtF+31Xp7Pk+7zF9yWnLbmRHRaxParS/0iaEtuodBzmtMvSj47Cvy32cJfBWwom+m415ThHQ6d71o3dJ6ATfDgf3shVHKfBOAmnhyqZC4i73r+EmTEa68P4oO9ZAEN9gRinJlGR/1cZwpOFbmRQHgg4iSxZhttUBS4lUhlqaN4KmsFE6fc7HIcuTRSs1QHxo6eN/VVPRu2gT0kDU8scaNGXBewRR5Pb4eXJfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyWV2wrL/vVMVxRoAv4k+Fcg6LyfQXhPw1SbFipJtx8=;
 b=K633ITQX0bmmUZ+B2Ij7qj/fyPkcDJXkSEVJyMwB3oaMxzb5y8IECevlLT0x+r83u1hiDsVVhQjV8kLV5NfRs4NlFxCSTIaj/Fynv0uDJHdUcb1PNmoO+qWeTEmX1m+Wvv5jjDvxg1Jlzeh3+vWXNBa0r4KHBaaJX4KFGPeTNvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.19; Mon, 9 Feb 2026 21:18:52 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 21:18:52 +0000
Date: Mon, 9 Feb 2026 16:18:43 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: William Roche <william.roche@oracle.com>
Cc: Tony Luck <tony.luck@intel.com>, bp@alien8.de,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	"Allen, John" <John.Allen@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] AMD VM crashing on deferred memory error injection
Message-ID: <20260209211843.GA459737@yaz-khff2.amd.com>
References: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
 <20260209210819.GA445331@yaz-khff2.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209210819.GA445331@yaz-khff2.amd.com>
X-ClientProxiedBy: SA1PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::28) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9771ce-96d9-42a4-1569-08de6820d2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hc3KOGwq0T/rv+IrSkavt34wJJHT6Km7jF4NlR2nu7O3jaCcE29Yy3UT8z7I?=
 =?us-ascii?Q?1sjmaP/AkdnSbfn/I2GD49yveTkCdiH/2A+BeCoTTmciK7jGz1yHiZjIkJTK?=
 =?us-ascii?Q?gYe111AYagWTGKKXbOYBxbfDldmHoZsi/J0orw10JP2QQb/IubdjIWDnkMDj?=
 =?us-ascii?Q?+UzHmucQi1YUNobCT3qtTXx33OtvABEupgzG4uWac9XL+knf8jbIaypb/Hj/?=
 =?us-ascii?Q?nIxF0MUNyW73Hbkea87B90M0F72W02dAE9hhG4+hhhwpItmL/AZ7fEJgT5OR?=
 =?us-ascii?Q?lNo4hedCBkdjjhXtWuZ70NzX7JWd/KRyt4xQLiQkb7k1qZdB05AlTsURNX7D?=
 =?us-ascii?Q?ArNe3cWJkxFrv59PFjHv7Va6H6KzUVtM1s0nIRJHk0v2GnQbZS0qTkxd6tEi?=
 =?us-ascii?Q?Dgg1THA5hJiXY+DG+/gD6ggGrryfkg1biazIn942aMuLVLsTmc84yCsqyxhf?=
 =?us-ascii?Q?jBFaUkPVLzi0sBLuMUrFnaj06AmGBbQx3FAtHFElIGrRYHK5qrt2krsW3lXK?=
 =?us-ascii?Q?LK1/ezZyrFnlohLCQlYM2SEXYZaVmE+c/CQH3Lb3FhXkj2HJou1Aa/0W53Dx?=
 =?us-ascii?Q?ZyLgs9w66sxQAPnYFTwLhOUZ4yJJI+ZMgl6XeKA+LNKv+o/Y9A0Hm4skHbC7?=
 =?us-ascii?Q?XTrWTzmEqtPwRDDXuysYC0bfzUi/pKJED2UdI7cs1NzHisJK1cuIXuwWDp+S?=
 =?us-ascii?Q?BrvTIw/UVwVVTA7jiVIxHv7ua9Fipa1gi4Em8Lz4rVPRinW6Dm1+hPXOpYR6?=
 =?us-ascii?Q?rUhBdKe9houiCgYT8JRcbL0+uGh70BmZmvEMZ1vJvx6mLkfOD8fiZTfEbF0u?=
 =?us-ascii?Q?9rA1dnn6Qs4OLcHrK7H9laZA2r2IeTLjmzsagrAEQ1SiIOLrvTOoZcf3kIh0?=
 =?us-ascii?Q?AQlh8ripTJi27KLchGPHbiDwv48l8olNVIbtAOanRejiSk0RyTf0gykFbmPK?=
 =?us-ascii?Q?2YtuxriOFsmMFOLCv8piwK33aI2aMIMx4iOyiyHQYi+iDWjoJWoPzPWiBOwG?=
 =?us-ascii?Q?Qx4+6j8YxIlRpQ9w1QNg7ItjxhYnPXbilyTWhlT9qQUnz7CuH8PUePFGrbdg?=
 =?us-ascii?Q?tZAKjpHgF+zAGWOyhgPphla/OssxFrPOA0/ZNlRoCQ3vbG4YTj+rNNsux69w?=
 =?us-ascii?Q?coU407iloZEN8qOLK51RZ/AGyieRUUn6qCF6q+dBlQbp/eCn06PYVg07BcbR?=
 =?us-ascii?Q?6VbUxHab7EZWRKrApBksgyYzGX9t7atr21TGZ9WvlmEZ9zWfhuShVGr9ZRVC?=
 =?us-ascii?Q?XmBQj6fk+e8dVgORuz+aY9UJ/WEbzsaDJuLOJQRiFj+b3AJZquF5k6npJ32M?=
 =?us-ascii?Q?x0Y+5Q2uDM4DhFuTidzAvYGDS8HqbmPmX1ISAAkZlGZ72sM6FXzo3lSfaEz0?=
 =?us-ascii?Q?V5vWLKtwQ7v6Citu6pZDGWpgoXmxD3wYOX2v6rikZT+OEA9hdTabQ3J1yucE?=
 =?us-ascii?Q?y/OmVSpuTAWMrU4TN2UaraVd1GzCDvS1kjg9Z+wOOJuz0a4oiMGLcaxiZ4DU?=
 =?us-ascii?Q?ACRpzXzqbWJfMQ/gLcmFJLQsaEOVeeALFVq6wU/UU40QVSKuiFBVVt/KWAxQ?=
 =?us-ascii?Q?ZxsQIYM4uVzLgjOHcJs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FBe+wLYmCl+lyoltOr/9v5rrFeppBldkZj0zc2enpIdVBlgtV1uLdd+eVorR?=
 =?us-ascii?Q?D/rsLu9F3dcwD0nzy49Qb2guqd5AkOW6N1nAY3SRamdRbwTRFwjJe8BPTGPa?=
 =?us-ascii?Q?HEvSBfmoEtWylp5xcx3m6y0yhXkzgEby9KjuqwdjkHyxNbZMfkTPTC6R9F9Y?=
 =?us-ascii?Q?JizreCywGKFgOGSTIGc/YTkzAie0GqdujSU3gnf84WObJDdPvwxPbiIQhlR7?=
 =?us-ascii?Q?wVDTA9C+LDeoYJFvnL25TSztuYuKm6bwz3Dfjm4gc3GEuUXf2Sa7NWm6mWFe?=
 =?us-ascii?Q?mOdZULb7/LQug/qCMRyEGjx8vTUGG/1VSr1AeSK7hOxLF60A7eAyr0iPpJfk?=
 =?us-ascii?Q?Atw0UPF0mLDOTosoELFufZ/N8NeMZ/1eSkMyPtB9CSw4jQ5C8enx0d2sUnha?=
 =?us-ascii?Q?QxAceGXrhNselhFrSwRDGuKmh3G08nWMnnwIlLZmEdUMGhpW+mSj3+fblODL?=
 =?us-ascii?Q?2y+mqeqm5Xb0z2iYcRv/77Hxx1t1nuWzp4V0cmJQ/H7dKN9aTlbU4w2XbjIp?=
 =?us-ascii?Q?4dDdnebj1IIdQQSa29rHK+HwRj70VedtA+S+ZTO+C5tVFXRIhGe8UQNXVrrd?=
 =?us-ascii?Q?lMPE+Oz69SVgPuDJpZcjnh5d/hwkkdbywiUMRzUodJOz5YqtvuhUFPPyd/TB?=
 =?us-ascii?Q?BYO4ncXnB3jbxli5lOMaKzgJLAezvAqNCqj11xUnj9Z9kb4Wc4hO8yBW17B8?=
 =?us-ascii?Q?vgfP2BBT7gvTT+QCyrBdLtjvlF4xArbBNt0Ms/7ewj+/0SFyV6RyLIWAcfl3?=
 =?us-ascii?Q?nI/Tx7x+TM0FlftLw7zptrIJkhJwAn88ii8IIiK5/tMb9mRHz5n8P66xIOmv?=
 =?us-ascii?Q?Mz8tvsPzLgj7w280T/R4DbchxKxfIo3wDikXZLhq0hwVIQl/NeCBldYHR9Ye?=
 =?us-ascii?Q?Uqc/jKl5BMrqbABoZy1L36YNZWFbrjs87rMosSDoLNPAdmFd3ygX8j5qc3j5?=
 =?us-ascii?Q?CAKnuSDfLHjld9yWXvWwnTdoURR23Nj8FJP+HjWFMbXLkEO9/rnipJueXjJ+?=
 =?us-ascii?Q?fkg/FQJfM8J+QszE7MVhKPy2mD2mIU+tvAyYMyH6KtGqlvZnxTKpOPACTKLe?=
 =?us-ascii?Q?fzRZREsTbZBNDERuaMOBFsFsvSDUjfKcGWEGWi/zON5aumn8D01O2qnB+DG5?=
 =?us-ascii?Q?7hxS1iKnQoa+MfPbT+Nhg5glHHci4D1+0ZRKTlGuuwlCEDlontXOMWfU/i7X?=
 =?us-ascii?Q?nd+Tsd/CFryLxNsE8ALDhuey/pLlX1TN+/HqpqgaqGH+c3SGHxQ9HkrwFhrp?=
 =?us-ascii?Q?qKhsWMGM937dLcrvZXRAbsn+4/yZ93QzTLhRFwUGLw9haueRCrofkN1FNdv0?=
 =?us-ascii?Q?K+l//QvFE44jQHiWvuwNciaCC2oCivosdKTgFIO6Y+zDDXklveff7vn4OjCk?=
 =?us-ascii?Q?+hbDHWtIOMUcdC19nH7lfv74bTFQoxsFU4kI9FL/yAq9g2zRqxxwl5ggh6cT?=
 =?us-ascii?Q?fvGwMMMIzn4qdSHhgWIBdz24/0qZOQIpCnMUvjaJ3Qb9WfX3N5u017FWs4TN?=
 =?us-ascii?Q?Q5GFzPaxMz8+sq667j8iuGotT7T7dftZcymNJ5rXVchQvWV54XTH8Z7iT1hl?=
 =?us-ascii?Q?6ZKa1LIEk9nPZdX2vhs0aYgOuhjBQNO6hpllYDH7fTE+Vu8jgYTezE8i8rP7?=
 =?us-ascii?Q?QJCB//ssHyqV7O1aq8Z0AnlcZWlbRJP73cfM61f4YeFXx2zybVaHi66CbN9m?=
 =?us-ascii?Q?gyJQm60Y127a9OBvA+Fi3XnwbBY9pVKDmOhXG1KnEfbbU2c6gjfCR84tfgi5?=
 =?us-ascii?Q?7rYkXGNLnw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9771ce-96d9-42a4-1569-08de6820d2ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 21:18:52.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RotbdPdmkr2jv5Bo9GC9Jo1eBn4patEXySgoKBc1DfSa5FLBzUB4JIZ7kxLuUYBjU0FTrtYaXHhcDKptWwEyXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5704-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,yaz-khff2.amd.com:mid]
X-Rspamd-Queue-Id: 0D846114B6B
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 04:08:19PM -0500, Yazen Ghannam wrote:
> On Mon, Feb 09, 2026 at 05:36:32PM +0100, William Roche wrote:

[...]

> > According to me, this small kernel fix relies too much on a Qemu AMD
> > specific implementation detail.
> > 
> > Would you have a more appropriate fix to suggest please ?
> > 
> > Thanks in advance for your feedback.
> > William.
> 
> Thanks William for the report and details.
> 
> Clearing "STATUS" registers is a normal part of MCA handling.
> 
> We seem to allow clearing the regular "MCi_STATUS" register. I assume
> this gets trapped/ignored by the hypervisor.
> 
> I expect we need to do the same behavior for the "MCA_DESTAT" register.
> 
> I'll do some research here, but please do share any pointers you may
> have.

Sorry for the rapid reply, but I think this is where we need an update.

Linux:
arch/x86/kvm/x86.c : set_msr_mce()

Please note the comment:
"All CPUs allow writing 0 to MCi_STATUS MSRs to clear the MSR."

We should include the MCA_DESTAT register range here.

What do you think?

Thanks,
Yazen

