Return-Path: <linux-edac+bounces-5721-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEp1K1p9k2ko5wEAu9opvQ
	(envelope-from <linux-edac+bounces-5721-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 16 Feb 2026 21:26:02 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE8414773D
	for <lists+linux-edac@lfdr.de>; Mon, 16 Feb 2026 21:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D13630000A0
	for <lists+linux-edac@lfdr.de>; Mon, 16 Feb 2026 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820282F2613;
	Mon, 16 Feb 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YADyedwS"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3E28682;
	Mon, 16 Feb 2026 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771273560; cv=fail; b=NqMfuPbErRodmPSev4H+bPhOajYYOEvjxtL4eKymFuU9ew/ngGEDVmbO+rAFprgHcWXQtKkDju5Yd6+g+OWUtTcrfpeSw+tAEj7U469Kj2FXkagFbj1dzatadLgNOnFBu5Z0O2yeQjI/VSuy4DvkNdRhASo7+H+z4wcvFHaFr34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771273560; c=relaxed/simple;
	bh=spDUNlLXMtqMNPd4ELBEnuHcw9wupysYzDleBlefxa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D1ZFg/gzRj/4B919VgAomc0ej3df2t2gaXX9WxndYkiLE0YvCqESW5/oW8MZ3yNNWx7Nr5BBcUZwnuU2AOUYrc93rKlrOkS78aMn1OimIt608mwsESnH3pc+STJFhl3jrYtNNR2dnp4bzD4hsBNgrWTZib41rouoPKSMcg2mGyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YADyedwS; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEZ2jSsf0eDIn7HiZG2hSO1gdZ96kY4Uoj1sHYCNWEEztRd9EBXeKw0+Q0FfqOAgryC0cWo+GF+JEnhgGJnrGiHqnL+3hAHmv3vj6/WdB1+ywlDI9bR4SSQy8+psvK0C7n9sFB4RVf2tncX9EQbgqZ44ykt9P+d6Wb2O5nLYUEQKoUWpMwQp6QzDAua8YG4EFvAcV/4TmvnDQypuWMsl01uyQqFKHphXMHywDDixQuodQJSM/8fUZnLqLlq+xG9URt7mSiPrLphdATg7AyheZapN1HSqkaUffsdC78EYflrJCDvHby13Eo15ugKXs3DcDcsOTx+SV4DPyMLckeqr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSEaHME+QAUY+vf084/VZV0R3rGSFIgBUUt+wPlOUh4=;
 b=pqJRtxyIvOagZsuVVyH7CRwmQFVJaay01nPNYlrSQMVyW8B6NM0rynoy0gyQ/qZ/VTmvJWDtORKe6mNlzlvSnOeg12Z8EdPPYXTcpExl0VWJC/WxuPvMKe7NXhEc9oFbJBC4d7LXffBEw/jCxFz6EJlUvtvzZdsf2p4J2kRx1aInOqfiisjqnEaut0JFIg8n0jUd5HuWV7+VPyyFaZOxLMpmhTOh/QcWRMoDMqyXBYWZM4AFsK8cFAYArGYc1GHCS/Fl4/Fq+xmaZdWShTiB4NCrrL63LddzqwFU/o2DGaA0jnbbFc9JHD4gLwlqRDa/ccIuccGg3NgImv9rKOs/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSEaHME+QAUY+vf084/VZV0R3rGSFIgBUUt+wPlOUh4=;
 b=YADyedwSwtanJH/U7KgV592FlC4z0thDAXYQlcnP2RAwqP8wVfYiwh0up8R5yBDIqPgm145/t/VBfC/XAtU5sSqqXufn6rbLc+DANpGroVe7eSkXavAoNB1VUoicfVvO7TkweRGprV/FBdGlTyxatrkXy4xUNl8JX2JaqXw2sUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.16; Mon, 16 Feb 2026 20:25:56 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 20:25:56 +0000
Date: Mon, 16 Feb 2026 15:25:46 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Nikolay Borisov <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org,
	qiuxu.zhuo@intel.com, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
Message-ID: <20260216202546.GA420258@yaz-khff2.amd.com>
References: <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
 <20250917144148.GA1313380@yaz-khff2.amd.com>
 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
 <20250917192652.GA1610597@yaz-khff2.amd.com>
 <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
 <20250918210005.GA2150610@yaz-khff2.amd.com>
 <67c7de1011ea7b8863051889ee2a41512fb0e044.camel@web.de>
 <20251009132055.GA472268@yaz-khff2.amd.com>
 <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
X-ClientProxiedBy: SN7PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:806:122::23) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c20ce44-7976-46cb-fde0-08de6d999699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XbhfT5bjm7j240GHiuSvoyYpEKfuuSs3ob/i2RVqo+1KYuqrUKVBAaTSSyVM?=
 =?us-ascii?Q?yEtNtlBz8dwLXxyZ53O3gbc7/o6Alof62SnsM+IJUjX1YU2NlVrPHcOFsENC?=
 =?us-ascii?Q?o172PvOn/tKns9WuEVe6+K7zoHJEztI6WpiPoDmr6+p2izJLgh2MSQMnYYLU?=
 =?us-ascii?Q?Qmx8PF157VWeWp8GSSL1gjCkUNFHN/EnRPuhk/Q4s1SXtYPKOG60iK/Jw9G9?=
 =?us-ascii?Q?h07c+vNp94k2nTajSUcfBvuyLaduJyQgyi60gpeDD9FGv2cVPTcBrLHvMdKK?=
 =?us-ascii?Q?JQyzOjSpHNVrKa3weRD+UIhaSLXsVQHq3OYsbEn712guRBUS9Kkflu0PYOuS?=
 =?us-ascii?Q?FWjCRCaT7LuZwsyzNWoFlqQPH+a8o0/thZlDDU7DD7Me693OLucpJ69uTuVs?=
 =?us-ascii?Q?1qC/fqF5G29q8kboR3w0dflSMgLl8gllmCYTY9r2pKV/6+uEKaDpXJQmQmVb?=
 =?us-ascii?Q?wxO1szURFpTUFNfGwDPYdlKUmzIHMQnIIreVqv5ZBozGrqt0w1f4MoCpsogx?=
 =?us-ascii?Q?r8+ieu6fL9xKnUadn5yGuYrqZKfXQnD+k0J7c+/1uSBKxADdFVKGm9iJzMcB?=
 =?us-ascii?Q?yX3mZFWWCAFK/Z1an9GPhcpRfpOoWJGhliH3iyHp7pWHxoVkLaRfIWHhCQNn?=
 =?us-ascii?Q?ea4K6cwCnezQdhL1xUISmTM0b8L5foYumegJurt8IsJZhCUxZ4iqyfaoiJEZ?=
 =?us-ascii?Q?qf7ZyPPZRrdRPkDjpzpamp1N5JGx/IXYCSH4skrqvEx9WiPlVd3J0Ufrp0K7?=
 =?us-ascii?Q?8G43BZwkvPBuYdO71vINTQHuizQBHnGFmfM4TTu5aMKtXlGW9+KQ3DFrl1ct?=
 =?us-ascii?Q?eW+Dj6agJVz2AutLyxOGo5CGGCXFIB/PQe6SizwrYL8zDXezrCMNVCwIinGA?=
 =?us-ascii?Q?loGBEZuJn/xfNKe96vi79Cb24ukeYdb6+TAZAt9oBgDaKyi1nqmw9i6iTyGp?=
 =?us-ascii?Q?6NzBrKtWbBZth90Pmj1WHw0fghu17mKPoJAZKwyvQSAzY+WdJRIAiCltkJz3?=
 =?us-ascii?Q?O151n9IBYGksyplvIcm8X/4AzMRLoA6K0tAefe7Si8l1alfFeEkGOGcR7siE?=
 =?us-ascii?Q?t77VwRamBAPddDX190oROGWnWIU+iBtZjwhbsivR+qIdZz4hM4ggHxEPvkou?=
 =?us-ascii?Q?zCgGbuO3znrAXoxDK6vZJe9dt/sCrpdTy8A53upvJBG363E87Twe29PLxe1P?=
 =?us-ascii?Q?UODqvjVYO9/4gRxPHR0+u1FJZEa8OxmIU6q1B2CzsIdHqcjzZPmtg6qpbMmF?=
 =?us-ascii?Q?SFn8qIGASVdmJ3av8j+jt67i1J7+OGkcu8DFcqP7ea0tQS9yZz1w90h9AK27?=
 =?us-ascii?Q?zWm50yzwIPKMiKiqYNnJxHt8YJj2FfWNK1RSlfcuN2EmzEWCEdbWzkWzOMLV?=
 =?us-ascii?Q?MEvNejXWCIRSwFzGc0ZxoUBpKqP1EDoaF8EYnUcJ6gNiyez5UxrBIH294WK4?=
 =?us-ascii?Q?6YKHqBW54wT+rqKbZPf7pYipXqiJlC99gcUT6pPE3lL62lXa8HPYlY1cTj5e?=
 =?us-ascii?Q?imvm6ZX1gRR7ll48bo5vSBXvwW8t019gPFe891sjVHqbofX/X+x+i7PsHyUa?=
 =?us-ascii?Q?v1iLVzS84lpD10KDmz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ga5pYCcBr5i25dmg4I5GtJobQ5n39D9mS8sw5wowhKFVZ6gBrMMe0B3OddYo?=
 =?us-ascii?Q?ZyRuFInCjtcJil0WjX3b/WPv5O5dzVxcU6em4rF8wxXNot3KrG9GsoLxfkPI?=
 =?us-ascii?Q?2cOMAoSzeV1CGW4PFKH0cPsPYM5ZXi/gD+clr/Gin5ouPebEvM3YCRGOoAA4?=
 =?us-ascii?Q?VgxO32NGIBWQfcHFd+KkwBQ+lJWjM9A7gEuOOhqnJtXeptu3hUtwk+RwSDQy?=
 =?us-ascii?Q?Pv6zBnQsDYxDIkxXyUVi+Ek40VHYqInUBNm/D+pcUdSuhpO7dUpaNrWU4yuK?=
 =?us-ascii?Q?dgMZzvyP6OnOPPgfbaURqH9BuTLNWFSKQqfh9Y1ESJUh5zBLUDy7OyWokNtC?=
 =?us-ascii?Q?bhgcFRu7dty/YNP0mCCoyWb4fcUAdUJ7VnaJjjVRv8ZAC0qsivs/F47Ct2+/?=
 =?us-ascii?Q?S2lT9i1PAsQPh/xI6uw3n7fTOKNPk5G0T/7xrOlshl9+oFajRU2ADNy7GrMP?=
 =?us-ascii?Q?kT2YSJ41B7xiX7s9T1/PrSR6GD2RQ1TqM0m1h6SMZe+y0O0DlobyjRGqpbnb?=
 =?us-ascii?Q?s2BT6iW2qh8j+d31q0jgee0NKMpfqZ/kKnc0qXVi+CyjP077f0Q3k2PZAtMw?=
 =?us-ascii?Q?T3n3cY4Umn87fr+X0AtYXJss0ynZkalIGGLvL3whfymnWyXbXaobISTnzvne?=
 =?us-ascii?Q?63eue+BtDbQrnS7GP8+qF7ehA7/SgOX0eg5thwK9wlGjDVzQuS6FtS8uam+m?=
 =?us-ascii?Q?w3mfo0VhYKFF1SqZCPoyNTLRm2EFBl2vMdh7zL1iq+R971CmRsKCcEBh2vDN?=
 =?us-ascii?Q?m5klmLvxl0ViyWmHcfNcl6WTCMj95rUGNP2b7SkYqPkZ15ALRInIweoSXrnL?=
 =?us-ascii?Q?i0qlTol96thXvOdrXaK2oWbzElmkp2BH9jj61cwasYeQXSira9HapgjNXVCn?=
 =?us-ascii?Q?f3jN+fjdSKxlr5hafL0as0wW+GlSQ3HKND+2AX5/lOwrvG4MgCi0cVcjFKiE?=
 =?us-ascii?Q?iovOjmq5sIrmmWtFpktzEADF9PySMxNHSn/H5T9OMhnDsXdIkoK/t0V850xs?=
 =?us-ascii?Q?4R5jBjsGSctOXSbvt974m0nACNt6a8ykks6fdRAIpKbg10avXvVrry7hs9WI?=
 =?us-ascii?Q?fLv/p4QdQUb1VoPC7WXTXd9dq8aut05WIUhG0V8CZkVZ1wnkVq3XkpjtPWNW?=
 =?us-ascii?Q?JzL/yp/YC3fBH0viSlDQEVAD4fAdHO5lowjvvplgYINF17pWI6jvyIGWsaFb?=
 =?us-ascii?Q?tLFzqoFBGZkk4zDu0B+N722InLiAuwMv+xldbeOQ09JcxX14herNutdISgeX?=
 =?us-ascii?Q?9RNuzaaNxpOUCbhqBMLhZYeSsSZPy//aXiqf4ie1n031Wo7q0vll+EhBbdz9?=
 =?us-ascii?Q?I7T99AgyCA5P3Co0wHMQ1klQjibpqmd7x7hCylXItqSi6E48viiSm7/n5cUt?=
 =?us-ascii?Q?tMwcjsKCRytrACHTaVe9MgZ1aaqvIgrAPP9uHiO5Tdi+oVbFibnSt2biPsZc?=
 =?us-ascii?Q?iYYVwbR3DGZR7B/9TOBHGq+R1+x+0ksNrKIvrO5YtUV9bEYO3mYqudJnUmSy?=
 =?us-ascii?Q?eNTjFzZ7o/vaxpRJI8RAisZUzzNTF3ne2Qke4eHGlXi2Jy3BOx3M91mcyy7K?=
 =?us-ascii?Q?y4LTSgEUu3/NQ3YcRzMI5aBbg8iGPCBWeY7+QHCotWZL+honX1ICornXShzc?=
 =?us-ascii?Q?uGVhirpl7coMrxGik0VzfCAc8rmMEtqmnKO09tIx9HoLGsQvUNuCWEMy8FeJ?=
 =?us-ascii?Q?qqGgWpl65otZrxarJ5lVa58nsly6X8JK0IxMzfJTBJiikE3zsqbLRQAlPLyI?=
 =?us-ascii?Q?G7PmFdKF/A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c20ce44-7976-46cb-fde0-08de6d999699
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 20:25:56.0511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTSEUTj4KzCbJJz3Nwfylqj9rApbdtOfC4QOVr7l8t/0xJmLpp9bu7DrC9Lm9KAJPZnbu3VoAQ+SGcLwOnrYUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5721-lists,linux-edac=lfdr.de];
	FREEMAIL_TO(0.00)[web.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 4CE8414773D
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 01:50:05PM +0100, Bert Karwatzki wrote:
> I couldn't test this patch as I was busy figuring out this:
> 243b467dea17 Revert "drm/amd: Check if ASPM is enabled from PCIe subsystem"
> but with this done I could do some testing on v6.19. The periodic bogus mce
> errors are gone because smca_should_log_poll_error() usually returns false, but
> I still get some error messages for which I'm not sure if they are real errors.
> 
> I monitored smca_should_log_poll_error() like this (in v6.19 (errors do not occur in v6.18)):
> 
> static bool smca_should_log_poll_error(struct mce *m)
> {
> 	if (m->status & MCI_STATUS_VAL) {
> 		printk(KERN_INFO "%s: 0\n", __func__);
> 		return true;
> 	}
> 
> 	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
> 	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED)) {
> 		printk(KERN_INFO "%s: 1\n", __func__);
> 		m->kflags |= MCE_CHECK_DFR_REGS;
> 		return true;
> 	}
> 
> 	printk(KERN_INFO "%s: 2\n", __func__);
> 	return false;
> }
> 
> And get these error messages (usually just once or twice per boot)
> 
> Examples from v6.19:
> $ grep -aE "Hardware Error|smca_should_log_poll_error: 1" /var/log/kern.log
> 
> 2026-02-10T16:15:01.001203+01:00 lisa kernel: [    C0] smca_should_log_poll_error: 1
> 2026-02-10T16:15:01.001815+01:00 lisa kernel: [T45426] mce: [Hardware Error]: Machine check events logged
> 2026-02-10T16:15:01.001818+01:00 lisa kernel: [T45426] [Hardware Error]: Deferred error, no action required.
> 2026-02-10T16:15:01.001819+01:00 lisa kernel: [T45426] [Hardware Error]: CPU:0 (19:50:0) MC14_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700900800000000
> 2026-02-10T16:15:01.001821+01:00 lisa kernel: [T45426] [Hardware Error]: Error Addr: 0x01b3877c00000020
> 2026-02-10T16:15:01.001822+01:00 lisa kernel: [T45426] [Hardware Error]: IPID: 0x000700b040000000
> 2026-02-10T16:15:01.001831+01:00 lisa kernel: [T45426] [Hardware Error]: L3 Cache Ext. Error Code: 0
> 2026-02-10T16:15:01.001832+01:00 lisa kernel: [T45426] [Hardware Error]: cache level: RESV, tx: INSN
> 
> 2026-02-11T14:24:13.358353+01:00 lisa kernel: [    C0] smca_should_log_poll_error: 1
> 2026-02-11T14:24:13.358832+01:00 lisa kernel: [T310371] mce: [Hardware Error]: Machine check events logged
> 2026-02-11T14:24:13.361773+01:00 lisa kernel: [T310371] [Hardware Error]: Deferred error, no action required.
> 2026-02-11T14:24:13.361778+01:00 lisa kernel: [T310371] [Hardware Error]: CPU:0 (19:50:0) MC11_STATUS[-|-|-|AddrV|-|-|SyndV|UECC|Deferred|-|-]:
> 0x8424b0c8009d011e
> 2026-02-11T14:24:13.361781+01:00 lisa kernel: [T310371] [Hardware Error]: Error Addr: 0x01f8a43400000020
> 2026-02-11T14:24:13.361782+01:00 lisa kernel: [T310371] [Hardware Error]: IPID: 0x000700b040000000, Syndrome: 0x0000000000000042
> 2026-02-11T14:24:13.361787+01:00 lisa kernel: [T310371] [Hardware Error]: L3 Cache Ext. Error Code: 29
> 2026-02-11T14:24:13.361788+01:00 lisa kernel: [T310371] [Hardware Error]: cache level: L2, tx: RESV, mem-tx: RD
> 
> 2026-02-12T10:07:28.804529+01:00 lisa kernel: [    C0] smca_should_log_poll_error: 1
> 2026-02-12T10:07:28.805020+01:00 lisa kernel: [T393396] mce: [Hardware Error]: Machine check events logged
> 2026-02-12T10:07:28.805028+01:00 lisa kernel: [T393396] [Hardware Error]: Deferred error, no action required.
> 2026-02-12T10:07:28.805029+01:00 lisa kernel: [T393396] [Hardware Error]: CPU:0 (19:50:0) MC11_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700900800000000
> 2026-02-12T10:07:28.805030+01:00 lisa kernel: [T393396] [Hardware Error]: Error Addr: 0x01300a9d00000020
> 2026-02-12T10:07:28.805031+01:00 lisa kernel: [T393396] [Hardware Error]: IPID: 0x000700b040000000
> 2026-02-12T10:07:28.805033+01:00 lisa kernel: [T393396] [Hardware Error]: L3 Cache Ext. Error Code: 0
> 2026-02-12T10:07:28.805034+01:00 lisa kernel: [T393396] [Hardware Error]: cache level: RESV, tx: INSN

The first one and the third one are definitely bogus.

This is evident because the "PCC" (Processor Context Corrupt) bit is
set. This is would result in a machine check exception and the kernel
would panic.

The second one seems mostly valid. Though a deferred error cause a
deferred error interrupt. In this case, it is found through timer
polling. And the similarity with the others makes it suspect too.

I think we should filter these out. You can ignore these for now, if
they aren't regularly occurring like before.

> 
> Are the "Error Addr" reported here supposed to be physical addresses of memory?
> If they are they don't seem to make sense to me given the following output of
> "cat /proc/iomem":
> 

The "Error Addr" is the value of the MCA_ADDR register. This register is
formatted based on what the bank represents and the error code. In this
case, you have an "L3 cache" error. So the address is some
implementation-specific format with set, way, index, etc. But I wouldn't
give much attention to this, since the errors are bogus.

Thanks for following up on this topic. I'll see about a filtering
mechanism. My first thought is to sanity check the status bits, etc.,
and filter anything that isn't consistent with the architecture. And we
can have an option to remove this filtering for those who want all the
data for doing hardware checkout.

Thanks,
Yazen

