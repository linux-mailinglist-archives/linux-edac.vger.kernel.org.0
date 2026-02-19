Return-Path: <linux-edac+bounces-5726-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SABPMVsfl2m9uwIAu9opvQ
	(envelope-from <linux-edac+bounces-5726-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 19 Feb 2026 15:34:03 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A4515F89D
	for <lists+linux-edac@lfdr.de>; Thu, 19 Feb 2026 15:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1AF30131F3
	for <lists+linux-edac@lfdr.de>; Thu, 19 Feb 2026 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239E33F8D6;
	Thu, 19 Feb 2026 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AExY/YD2"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA143382E8;
	Thu, 19 Feb 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511641; cv=fail; b=Go+7gMxpeZBKnWwC+uzIQXZv700DLpXJ4skzlIeo6ffvQuIuhFkMX9MyeeDB4Irup8uduuWJJ4nam7Vjph/t//tcUNaJIx1ZFEb9dzDx2oDtty2ZRsU/EEQO1tltWS9/GEobmE1FBBjiJjFdhmzPpDGfVjOBa8BhBxxladI7VQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511641; c=relaxed/simple;
	bh=zBxf+kDXbE/lt4RNZSG1jOtSTjx0be2rYGh/lw0ouAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eWQIybmoJxtUtKg07fuDz31z2jZOh4pfw5l0eDdzcYDEPTmzFjmj5H8NRsEi2HUj8hgcMblZ77mQDhIyLI6iqirzu0ywtRIvE+397i0QF9eOjoQtCNvvaaGk5dZS37g20BBnKyhHpg3UjSA36vls0/qKb5UvuJSseB4yk4dKQoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AExY/YD2; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGVxCpZGRDJ7P9RrGLvzXLSwInzle0ym+TLtfe2KzRFQ0VqRm6d5vzmujEN6UphYoK+mnrlTpXy4EHL6VRcnOSI3yYW0SQwleX/g5BDmNVdWAMjYAM6PjtP5MhKj5HBLbAZjp7SUZuz8E1nJdabiyW8GR8xNYCiGRkeZAJ/uXT7ULNUGDcLRASFwXMbp3IWfd9gjPiJWavqRF+w61XB/SujincKy8UrSllq3b04sqtFYT6jBZPmGLcaQUbV9bsDjrUgvF+qCfo31O7YRHIMjtEveRrK9yEkdO6GXpnRGSXXHyQzaSaqbpNL9gZHlPddG/LHJH2VUoaGrJQ8Cc6ju3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4P5v3UqPttVO4XyMpb7U2fBaFhrUGUzG6UCbnxEbueU=;
 b=rSc6aDAPgd/E0Zjg4TRN1dJTNENqk7SEa+ANU4vECc+8eIY9VbZH0rbd6IdVnfn5a68k34AIyj2y3yITvIu4XgYAVLi4l31Wf3iEYX+RcOLWTVUpFjsPfYX5Iss6NDDO5xsZAQ/ipuHw+8N/SMOHL/IVjfvcBW/m4kFfpQY1ywYt6SpXWg4M+i7s3hXCGd+im/nP8I317e5sGk6MF3GmSF6FvOu4F6BH67V48IU71jJLybbQLY2+ILtRVMDzsPZRZn7zrHjhjXL0mx9W11J9ifAwi07iAEhrCy5vkhQvAVfRh6MRH3JBgbgVCGXLR1FxUfsMlNw9Wv1ZLnACkUbh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4P5v3UqPttVO4XyMpb7U2fBaFhrUGUzG6UCbnxEbueU=;
 b=AExY/YD2vU2tmdu9yGdPl6dpRFL0CQ3qFtTPH4jexS5Tz+hODL0gGwUVJ58aBIS8eC6LN6rdeU+O0r53fLVOlhV53xrrqFtdoapvinh4bP8pqHPblCPBZfCmM4LBD2KvQY6dwp29aL7mUxIVoDBU1zDXooFXfld0paWJws14apY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ1PR12MB6217.namprd12.prod.outlook.com (2603:10b6:a03:458::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Thu, 19 Feb 2026 14:33:55 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 14:33:54 +0000
Date: Thu, 19 Feb 2026 09:33:45 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Nikolay Borisov <nik.borisov@suse.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, x86@kernel.org, rafael@kernel.org,
	qiuxu.zhuo@intel.com, Smita.KoralahalliChannabasappa@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: spurious (?) mce Hardware Error messages in v6.19
Message-ID: <20260219143345.GA5486@yaz-khff2.amd.com>
References: <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
 <20250917144148.GA1313380@yaz-khff2.amd.com>
 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
 <20250917192652.GA1610597@yaz-khff2.amd.com>
 <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
 <20250918210005.GA2150610@yaz-khff2.amd.com>
 <67c7de1011ea7b8863051889ee2a41512fb0e044.camel@web.de>
 <20251009132055.GA472268@yaz-khff2.amd.com>
 <21ba47fa8893b33b94370c2a42e5084cf0d2e975.camel@web.de>
 <20260216202546.GA420258@yaz-khff2.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216202546.GA420258@yaz-khff2.amd.com>
X-ClientProxiedBy: SN7PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:f2::7) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ1PR12MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb37118-5562-48e3-6c4f-08de6fc3e8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Run9KpfJALjgZEFuKXIkpE4TGheIckWv7ywIEy12GxQNvFG6rAThtLte3qiK?=
 =?us-ascii?Q?7gNo6X1bUHOOSi5ve/q14nHcgwqZivFg2WhIbRWYkphV1B9glVMp9udMc0+F?=
 =?us-ascii?Q?J81ZWgTWr1RRSig+GOm+iXs2gjyfgoGxVXwEXKEeLwihzBa+AdUMUWTZsCBd?=
 =?us-ascii?Q?C9aiIQzAY485hlgYffZ4qzk270KQhGxluydG5DoBwxe/2dndfPNRFc0mNUjS?=
 =?us-ascii?Q?jRxMfF7HZUDgCBUZwy4WAutUYSK6UatDh0L3Nih8IbZFgbuZQJPegnXWETUY?=
 =?us-ascii?Q?A2ChqdD+3OJZ5xmUT0WnR04dGlqs1zHkgQqPTeZbVDwM4tYVG3qfblKeOlax?=
 =?us-ascii?Q?gOewUhi00u187dHN9DeuS3KQ4vi0VyMcPgZ4eUnTpvmIEztdxmL0LfUk+RVp?=
 =?us-ascii?Q?hl2trN8R9gM3SD11O18X1L9Gy7h5fmoa5PP5ykUi9Zs/22Idmvu3MtPHNbnc?=
 =?us-ascii?Q?B85+eICKJ3fv/vNakMeGmJAJCMnM8XEik1cV5NHzwhhEeKnNPH+NbaodBzJE?=
 =?us-ascii?Q?iLl1SzvPpc1SbB1FcR2UQvlLxPBHgVJrRUCmGtIR4b+j5LnkNYsqygNl6AVU?=
 =?us-ascii?Q?WLjWbplNh0XCrLo1rilocOtzDZpUuZqrfY1JVVTKxn/wBpxalNZLp4OKl5rt?=
 =?us-ascii?Q?ocDU/tfI3L/VRORq3ujmqsrwifjF7ia3A84RRDOCdCw6ZT8oj9h7b7TdxR0P?=
 =?us-ascii?Q?rFkRtaH7PClKfYrsJewPi9qrBb1grHne9bHRtkQRQoSCZUnEkp4NDqeJl09n?=
 =?us-ascii?Q?LegTTQ9ebDTKmCcuqTC4LdwoYmf+V9B2R9xPpMtY+f7s0wq+LLk4eazc6DIS?=
 =?us-ascii?Q?sMg/0BKA9k7J8tg6a8zEzeyF2rS6ctaF0LeQKWgHviSWkqePibvvXOBfFZrF?=
 =?us-ascii?Q?LdRmm5A1gzYqst28Rqrm/hTUX79gaDHSKqD/1xHCEhKGShbr1Zbuq0NLzVk0?=
 =?us-ascii?Q?ETeG5H4NUY1Bbgdv4ixQ3Yc9kBN34ZKc5mMqB5lC4QjG8uRgm1JwnOLGB3Ai?=
 =?us-ascii?Q?DhiRXQ3/t4MvKnJeTZno77tN4KKcqqx26L1ON+J2JF6jNxGUFgMZ+Mm88WL2?=
 =?us-ascii?Q?EqlAbvzd3LwEtI2oPKeKxgioBul9pg1c7/LBv0uFwVxQrDs/2gsr3X/vPhW1?=
 =?us-ascii?Q?EA2aUp0p0Z8y1fpkjBeAZhsTO6+uQAlH/Jyibtif1AnY8sEY9NOmutI7vd58?=
 =?us-ascii?Q?QSDVdfQSru4vfCJUGEZFcmMd5nMPEcyabKx3BMgDVUrIvXv6YU+U04XXf0r4?=
 =?us-ascii?Q?WFQyF8d1deai8i2wg9Zeg55hoVDPtc4ah1zpaWeEiH1ABhVGW6ktKOhHv7bm?=
 =?us-ascii?Q?KyfmLDrBNLv1SLDfgbTDgQ675qZ9JNzu3a2CUVEAycDFHc2nbOXU81se+vda?=
 =?us-ascii?Q?HuUVaSvsfT5/+DwInVDCV/Km2bwUmKlvgTSmS2eHk6E4Hggwd3m5mieIaA7g?=
 =?us-ascii?Q?qjgj9z3LkVqb0bZmsV1Xivs4HEVsJq/V3KGjg66Z44Ncap2z3cRDV9jN8Du0?=
 =?us-ascii?Q?sxgjBVlisdKqfNHU5tWBTsTZUdLZIK34elUkTTK+/vSXy3SyrdEm4nX1PA5Y?=
 =?us-ascii?Q?XLKuYQWNtsUnff6l0dQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55eRbuCeDitCBg0tetZrGEI6D3mpxZBU5kKW0bgoTountQnKlUynHEILYHwu?=
 =?us-ascii?Q?kZzzcuAkkPOpmrkeQH4aJHEy6IVw6IzJfjfJdO0kP5cdrb7njDVMjOqct32o?=
 =?us-ascii?Q?4wdT/O5x9P8J9fQ3EfungTKL+mz1f0EA6GUjr7W8CD9mEa5U8wgy1d9z+l2Y?=
 =?us-ascii?Q?XuWZLt0X46WbkBhd26k9X2CW392ZyQkcX1OMGlGP6ydWKbCg8aRyM3xnM71q?=
 =?us-ascii?Q?v/cHT0bYDrD522tPR0OK7C8HcTSlIRO3GvjtSF29dNzLH4MGgWyPsL3tyut6?=
 =?us-ascii?Q?OlnSwsDnV311Lw7WGCuNgVkB7bihunxOT9nB+IFrcUTKx/eAuMREkj1Jji14?=
 =?us-ascii?Q?DINNJvH+kMWmpv/vzvyHPh9xxbbxRGlRQoD/pHgeWOD/QNofbKJ9u9bvFJoc?=
 =?us-ascii?Q?M9uuzmGuaUytULgGDCUB5Z9hHpxc2yMuYWbo8W+5pyi9q8T57peNlGixsedp?=
 =?us-ascii?Q?7PnmiYc/u/CgTfIczfonJtCFJmSiM2fmzmP1cMaGrZ+aQRA2BsaWy/X25ekT?=
 =?us-ascii?Q?WrLIvnwd/QICMoim9hLjay+WXe6KwXxpYz1tbGcAbNIAhv24shPjF5TcH06d?=
 =?us-ascii?Q?p91A3Kn8JwtPzQov1bqJNaDBKKPb16CTfK2i2IvutXmERHPyjcUS9H7US/e/?=
 =?us-ascii?Q?64b2HetGGQbxXD3K98WSBwjNrNJ32RO3E31p9aeY2V8n7HSSQvBKkE0ByHv3?=
 =?us-ascii?Q?ZC4lkoE7QoTD3fFm6WQdKK9/ubRriM59U3saZUGOwXzdI8N7FcMt1Oo9qrgP?=
 =?us-ascii?Q?24aoQDgg9qXMa7/knEIzVHn2ZMpXJDWbvVx8bihFSYe+06ED+pqvsGHa2NKq?=
 =?us-ascii?Q?pf7mLmMQbQJAAYqYWl1S5qYpoaeGZo8xCjHSJlF/3SS1Dj/AGszOrkMTg1nj?=
 =?us-ascii?Q?IS/U4h0y15wHVaBTsXu2J2UOeoHXdyxXBStPtWfBbBuO1bO5+reixFBtJrzo?=
 =?us-ascii?Q?aBHPaW2tAp6yP3i+grQ7zznKvqL6oQO8mcf1BXL/28QPGHbhLlxAdZ+Cas2Z?=
 =?us-ascii?Q?RWUf2OUZiXS/nhBoln5+3q6ufmzmqDo2BwcpMfwXsN5Q7fh1qZdQMCjmkmAT?=
 =?us-ascii?Q?NNaRkVjB+Ylb/gsj6uun0nFU5ygQ12CAz+mHa2UzxWVx3sG8LeoNpsTqMD+W?=
 =?us-ascii?Q?1JP0VuzYmQEUUu8vjhKkp83We55DLAvv/Q8R3aipnl9OIT2tQlG3w9kKZ6kW?=
 =?us-ascii?Q?sRtrsVwqN+St5KjlfLNWpa85ulRmKTfph4ErUrD/0FC8idxbtQfL0DrA0hQ0?=
 =?us-ascii?Q?aAZL2ACpYwbGmCv5c8z4oBZlgUo2yjpo8gh0K6agwjcpMxTVj7Blo4aZXMuJ?=
 =?us-ascii?Q?QmJa7ji6RZndIs6s4AF6WbDwUIFt8BygxHQn28rpykQgNdhaU3/o1/u62xd1?=
 =?us-ascii?Q?e1nfeX+hf9lt18zZZ9k3Xcr3ICqWVhjhkuxJghWUAmBpWld8LjBtIchmFquB?=
 =?us-ascii?Q?7Hvdm3+f1PoGzbE1jqVL7wOUdEh546sxv8WWAbxKQYQppJxUarl33R4HjNei?=
 =?us-ascii?Q?UcX01ngk3rvunoua5t95+jUibF5Rk3gegV4GjFEEgW8hWAwVxnA+eJjTisrG?=
 =?us-ascii?Q?kWOcoWvCHIF8bvb5b0XerES1BcUS5rygJFhJZPSNuud2uRsBFPDsScyl22n7?=
 =?us-ascii?Q?8nsHe5LCItlaJxgsR4jNjhju5X2KqN8q7CMVmc9yH3VssXIsRcLI8S7LMsGL?=
 =?us-ascii?Q?Zd+YP7GepNbpCzymu2VqL6MfwKjMzKxkaO7Y9sjV4fWOwtG2sForAtaX2FBr?=
 =?us-ascii?Q?dCtMsYcxKA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb37118-5562-48e3-6c4f-08de6fc3e8ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 14:33:54.9118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeTKWhsar97NthWHhwlVGYyx5gHjoc9kPxFrQO1e/yd5YBZKKQMoLUyk77vI+VUt+f29OJu6h7rb2u3urXg6Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6217
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5726-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 25A4515F89D
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 03:25:46PM -0500, Yazen Ghannam wrote:
> On Thu, Feb 12, 2026 at 01:50:05PM +0100, Bert Karwatzki wrote:

[...]

> > 
> > 2026-02-10T16:15:01.001203+01:00 lisa kernel: [    C0] smca_should_log_poll_error: 1
> > 2026-02-10T16:15:01.001815+01:00 lisa kernel: [T45426] mce: [Hardware Error]: Machine check events logged
> > 2026-02-10T16:15:01.001818+01:00 lisa kernel: [T45426] [Hardware Error]: Deferred error, no action required.
> > 2026-02-10T16:15:01.001819+01:00 lisa kernel: [T45426] [Hardware Error]: CPU:0 (19:50:0) MC14_STATUS[-|-|-|AddrV|PCC|-|-|Deferred|-|-]: 0x8700900800000000

Hi Bert,

The CPU stepping indicates that this isn't a production model.

Can you please share more info on your system? Is it a production laptop
or a pre-production sample?

Thanks,
Yazen

