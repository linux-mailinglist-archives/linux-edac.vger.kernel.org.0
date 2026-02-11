Return-Path: <linux-edac+bounces-5709-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K01BbCvjGl/sAAAu9opvQ
	(envelope-from <linux-edac+bounces-5709-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 17:34:56 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 279A91262CD
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 17:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5A783003BE0
	for <lists+linux-edac@lfdr.de>; Wed, 11 Feb 2026 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68275341063;
	Wed, 11 Feb 2026 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HgifyPTf"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACE207A32;
	Wed, 11 Feb 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827689; cv=fail; b=e+HlBQf5dJ0kbjYBBlsYpjjus806DDY9ND8hZdxsAzCMr7UpfhA7Qii7HpWOIQnQf1VjAu/aaHzu9epKgqeYhb8CxtydypCVMHhSiJ1SzEFyR3nrNilneiH3zpIYTGa5zovoPs8ckM3c3pqUx6abYdy+SEWRe/zqV+R6UyPzVGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827689; c=relaxed/simple;
	bh=tz32ui55LrBid7GpjyTDfjHEnkdizmVtqDZWmW40bC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aP1CStYeJgK6Y3MzWPc49XVPS5fUrFh477Ez6FQ0vwi3JXvOwMC/E1mtNYKSB7Pqmc++yin0MjJWYHWQY+r9e8AtzIDpi2u48iQI5Y8x04k8a/yiHmMZYErm+w9Qf8nILQslfgX4UfH8O+7sO6xobpmMxXu/Uuye+MuIPUG069k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HgifyPTf; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAmzUvPJvzw6wfpXK9Sf+Yxt5nfz+owl6U1Edez7Hf4qEC1RpkU1n2wJX4IGRQANr+NkcPz7VCY6huoWjLOR6pvqO5cfFIh8zacCMtHigXMiQk1cpHN1CI18gLFBwYojfUTdQkGc2KMaPoisNL0VddGqaDGvAtHEKGDSxBP+Iv0gWAeS1drf6ND2XAXHTtKzksSk4tNPJAsvGZtzl2EsaTmi2dv9IlY/bkxOwv/mL/uPzxtl6ioqEFGdcXsKp9lUF/jAWhJB1080KzTG75/0qNPR7e7G83QmOMDfC0YvsvbyibjyuXwXme53q5TLqfcjaL08XJvsXkDiFfneiUcEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFt/rE2SL+8L3U1EA+KndxpkXhfidUno02jQHTO9WtA=;
 b=UrfECo1a17q7xpkHgmws9HRwxRFXClbc1FhgCJ+JHWVXYZaX6X+qfwF9TycS4iA+enFEJbh3uIWXJxxdtPWrvQUeVGI+KlcDrt2MqAj8YGt4ywvc6Rsho9HFGyYNuzUhTKEMNv54WVgB276aU5xNw+PHD6teXPwnWVIYkLnTb8XpucR1XjBN4r2fAsIMxlYC9pe8nxe8yJe/JAsDrKw1ms6yrh+y5Y8XB9ah+gsVMnvV5X/VYwTos9BbKEjsISuQKhpek8gZA9VUqJWQrVsgd/gt3Dc/vLkscSEIyTd7RRFZoV663fjXx8gnAiAKdZLS0lsx3GBaDbiK3OKMX1Oi2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFt/rE2SL+8L3U1EA+KndxpkXhfidUno02jQHTO9WtA=;
 b=HgifyPTf2Dxwqu13iE8WZvtq5NG0Kp1+lgLy+bftdgAV4lJDkndNfip81i/2iYMU88h88Q2lkVeavLkjhCJmb3bU4L2Mjg7lTRLtwm1wfeSxYFAO7HmoASVx0ii9yH9wjzu5atkpS936QCAumpzlGmjT0l8IcxX4diFKcBzq5Lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 16:34:44 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::7da:cc3:cf2e:8ebf%4]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 16:34:44 +0000
Date: Wed, 11 Feb 2026 11:34:38 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: William Roche <william.roche@oracle.com>
Cc: Tony Luck <tony.luck@intel.com>, bp@alien8.de,
	Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	"Allen, John" <John.Allen@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC] AMD VM crashing on deferred memory error injection
Message-ID: <20260211163438.GA1637@yaz-khff2.amd.com>
References: <48d8e1c8-1eb9-49cc-8de8-78077f29c203@oracle.com>
 <20260209210819.GA445331@yaz-khff2.amd.com>
 <20260209211843.GA459737@yaz-khff2.amd.com>
 <6f87d29b-c30a-47f8-a519-0e1fba36f1a7@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f87d29b-c30a-47f8-a519-0e1fba36f1a7@oracle.com>
X-ClientProxiedBy: SA1P222CA0182.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::20) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: d91a7899-dba1-44f9-9f1c-08de698b7640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sm9LVus8m6QppBfnS5LkSalN6I4AdH0/khgD0W0Afv9+26/+qnbZoTC+hfZr?=
 =?us-ascii?Q?naOP2z5ITBQJjDopiEGNwMIfFhdwneHBjBixkQO83ue+gXgqQTcrJhar9VDC?=
 =?us-ascii?Q?MVRNjNjlQlMjxBm1Dn9B3igAPB8C8H0pde2w+hb7Mv+jZgRb6VxDC5SedPRT?=
 =?us-ascii?Q?IOE5OMzXL8EnSq6ctai9LHeo5fFt9nOWA3tIK57Fo90F7r0M/DURngrm+y04?=
 =?us-ascii?Q?jphPPPWcb5Wo6kyhabXljidLs+DvsW5PeLVFIgqK+sULUm7zZ+UFfah2WW3I?=
 =?us-ascii?Q?c183Xh8JekDOXdC1FBb8mO8PivSiMNo0ObW9UFqL9jYgHz6scx+8UiLCgudE?=
 =?us-ascii?Q?fZENdpeKp+kuzNKYl9n2eczPRpvsgTfLkAl+D5yw/sbOV2JPvf5A08/MpjRt?=
 =?us-ascii?Q?vnaE9+5kBek87+BG6ierUkOgKEqbwGONeGyusSlYKDAS8qD8JJQ8Taw5CSVy?=
 =?us-ascii?Q?5JEzVfu247eNYdPtUWF9hUMZxHlqMou2IGioCH2+wsiO/rh1/o1uEcww5r/J?=
 =?us-ascii?Q?WSQ6rrAfipFEVDPjyIgGzRKoC0nJDnfFt9KCqvgIJ+hz2+6p35V1Ltq7Wcpj?=
 =?us-ascii?Q?fO8oO4UbnvChJHGScNUAI0wCYweK9pSWCJX8CjDfz+VaB6lNYgMQ4fbSV7ZK?=
 =?us-ascii?Q?RTlDJUmPgpJV74npjGemam0Zwt8c92oeU5u92fu2nxx01vfTmBm6/UhVfi8n?=
 =?us-ascii?Q?Ds7QdHvlix40TPYKJm7HF8IRbwULOcleyHO4QZRreDGLN8vi98K9ZGVnVgis?=
 =?us-ascii?Q?vKCCyf0r9pqf21ZDJmLER9SP82M9n2PfFWAD4ZzWcTZwjXSGYQARa286Y3NS?=
 =?us-ascii?Q?I7t9hBlTBq8b5C3faMhtX/l6gEoxQex0ixGpENyEKiWd0d/arzp81y+Dcdqy?=
 =?us-ascii?Q?7/DPdOl5dd8dToCpU5HzqPCnVLFXJGVjjie86aCaQBrEmQUWbP9X0Phvpv3O?=
 =?us-ascii?Q?bl5wYSxmill1WcemYPmmzcHKy/Au5rWjD8F/bsRZHQ7P7mET4KHFEW1ujjZD?=
 =?us-ascii?Q?yBriFDwtI1WVaYsvZSEVSsnkjLYNDOgvJdXctnZS+MzyvXk30FcisYlJcMaO?=
 =?us-ascii?Q?Zi+ng0f3RSiFoXc/9rVxBrCk3bgfbNwErtfgW6PssOEkgghpx1kSPqdW20sF?=
 =?us-ascii?Q?8eaOxHUHe0UzMhwPvoW7lYCJ/aMY/NzQUb3bakU9S9eObF6zgdo7fo8pGiZf?=
 =?us-ascii?Q?WqrFode58foPVs/gye+n8GByTHPUycmaeHxVcVFm50zR42o7PaQM5we76fJb?=
 =?us-ascii?Q?dleJOv1+nphbF7qHIWpvw9jlhhyN8KhZgR73YjDYQPvkoPlXU1DbJIILeWi0?=
 =?us-ascii?Q?9MUfvBg3nua6Gl8iAqKjlqjQXGVMzp3CarrxRgeG4NOhJv/PImfs7qjnkVyD?=
 =?us-ascii?Q?h0jW+3XVJw2n9H2JMNh8zapz8cIXEGTJ+mnOBUE5PT1pZ59029Pizi7xlca2?=
 =?us-ascii?Q?s+V/KYWjAW/AvmMUq3OuxNLpWT8BvkbGSVx78mayoqhX+u/mfMN5LIEaIApb?=
 =?us-ascii?Q?9tNKBk4DwVoXcK+b0vSMQ9i83SZYy+4Dx/ZuB7Atyx4cq9tVvc14Vs3DfmWu?=
 =?us-ascii?Q?TJC3X5saTe2ON3jiutQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KutYchvECRKkfKSGVxUnbS+LmzCe3eVn3/RGgDv1iMyDM3S0zNRk0GlLPAUw?=
 =?us-ascii?Q?FxrThVK2vsJkKAC+z+m3Clnb8eD2jRs/pRXAXg+0ifFPDO2tlnnkTBJueLw9?=
 =?us-ascii?Q?HnJ/6mEtgwQNb++3Y4/c7wKAOpqd0JWDzvmofbXNZjRKSZT0GJrhplW27bsU?=
 =?us-ascii?Q?qSNVriWQAISYN7RUifMWliGjT+nK/wXiOyjO67IizmPuMcm2nWqYNO44WQbe?=
 =?us-ascii?Q?x1WuYGTK11Gw3hWCx0+NV8OaU8eoZfroCinHFdHuTD0we9z0E0pKqj0B4y1M?=
 =?us-ascii?Q?FFWkDfv4XatZq+QUgxolLMT/jxgJuYip7EAwFWKYVu5alwuy1zzvrsB/vC5y?=
 =?us-ascii?Q?j4RIjaC4GdszVDzO7LDPZutXxyoLcV/fUTK2XuflmqfXsvtJ6/kdhs5IE5KQ?=
 =?us-ascii?Q?61tcN6yt1IBODXwwO4mWzTfsryw8RoxdceWKzOFVk6sCHxLzfbJX3xTp5jNc?=
 =?us-ascii?Q?AzukEQlI43LnJ05PygMg/Ws2Ns5SRlJ0NZN/VjWS+OYdqFivcpP56Y+dgzy+?=
 =?us-ascii?Q?7N+541AEpRwXvrTJNIFB36n2IYCCEGTp7QKtR6s7dIUN+q/pepAQXV/gJUHf?=
 =?us-ascii?Q?CDsGNm9v9bOMH70C8fBUUyt4/cpa2IPGoqojSTeg1Kxalt1rBCejDtMKBDdX?=
 =?us-ascii?Q?E8NWL8mS5mxOBWT+wa1dnng9Ni5PoGFfiBtSXxRNsPwjE/nsvJUTXLbkpUsQ?=
 =?us-ascii?Q?5m1RPpMPjCMjp+FJ7Uj4mJ/TbTY0FILwZ8+5jsIdu1mPzWZAl6C3j3QBGb34?=
 =?us-ascii?Q?1eTN831JrPr5kP0YID95Z4icYzutpFJU1DxXNhlHneR9jJGhQFOhY5nSlyXc?=
 =?us-ascii?Q?0tTPH9EMxe+QTdgV+IFe4JKQCcMzwhKdl8QfKVv9VRUIQr/bsatFwSSODopV?=
 =?us-ascii?Q?RzNQsvZkwKPgI/nPV140Nxt0JTxTTpNbKpOgTtMVy0cMkTtSUJoNVwbXQgM1?=
 =?us-ascii?Q?1CtlNnhK6+nzvWs7UYR3WFemxo7pcanaIf5eEKBEf3OYp9PFiwcIV0yRVFox?=
 =?us-ascii?Q?IsJ31bMidmBK0WKk4M/X7qsGwbRpMQgXRxEaGBZJEoANWd+EriE79F1orvZ1?=
 =?us-ascii?Q?Wenc0EkWpYhbNjuDSLQeLBBDhj0aroSuLD1x19S3AdoVGvDQQwOErG/R+gUl?=
 =?us-ascii?Q?7XG60oIUAwL6AC4rk3wHRgu68cq+0+KhmtVx6q7wldHpsR8WTq9j/hwVUStG?=
 =?us-ascii?Q?jqgnkB0Q72sx9bWMb/qRsf8LUs0SXRdu4LL0GnL60LlxQqehO+qFuL6vL8rp?=
 =?us-ascii?Q?+9Ji0WJhlgDngG3xMkGPJp1BaI4mAW9vSwdxWFNgrnnKIjuelFKbTfHo+71b?=
 =?us-ascii?Q?LdIQW1qKa5ga0TwR55BQsPAYxcW85RO83neuXKEx+T76MBTgLSrTQMcFxFXm?=
 =?us-ascii?Q?65lI3sP59aiErnQEzmsaEfeHC9CIsoY2oe+rel8PbOV+c1DMRMZZ/ETIJimm?=
 =?us-ascii?Q?tcXJXOQfJvrJbrnNyj8KZpsJ1ByaunQOmpavrMvoV83s6mbjGkzCLfYnECM8?=
 =?us-ascii?Q?QVa4EN5X+yV6H9qCukNsstY+cCWFC5dJE+whWeNT8AMXQliO7NHyPC8M4ggd?=
 =?us-ascii?Q?RQZEbIuvTvYxf0lUFwiXRm9LvIrPePq89v4uJ+RiwMc9S+8nXkG5WsmUwRgr?=
 =?us-ascii?Q?P0O9ndeXn9wGhvDLIootBd6Z1l1eDe0x+DnU40S1TtNmZ8SPfYXDaKjQYqfL?=
 =?us-ascii?Q?dEQaXHge/aIvQSUDBtPPaKUjuPPzDp1H2TZ4/r4QWj6ep57bUeya4Y9pHZPK?=
 =?us-ascii?Q?/yWdtML88A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91a7899-dba1-44f9-9f1c-08de698b7640
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 16:34:44.4150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0EFiT2W1Atxcfk++GkPi037CFGHgYOr3rAUfk40fQml/JDtaCaZ6Rz+cn0WbeIRFXWzgMMXr1L6MYf5+W/a4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5709-lists,linux-edac=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:dkim]
X-Rspamd-Queue-Id: 279A91262CD
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 02:42:07AM +0100, William Roche wrote:
> On 2/9/26 22:18, Yazen Ghannam wrote:
> > On Mon, Feb 09, 2026 at 04:08:19PM -0500, Yazen Ghannam wrote:
> > > On Mon, Feb 09, 2026 at 05:36:32PM +0100, William Roche wrote:
> > 
> > [...]
> > 
> > > > According to me, this small kernel fix relies too much on a Qemu AMD
> > > > specific implementation detail.
> > > > 
> > > > Would you have a more appropriate fix to suggest please ?
> > > > 
> > > > Thanks in advance for your feedback.
> > > > William.
> > > 
> > > Thanks William for the report and details.
> > > 
> > > Clearing "STATUS" registers is a normal part of MCA handling.
> > > 
> > > We seem to allow clearing the regular "MCi_STATUS" register. I assume
> > > this gets trapped/ignored by the hypervisor.
> > > 
> > > I expect we need to do the same behavior for the "MCA_DESTAT" register.
> > > 
> > > I'll do some research here, but please do share any pointers you may
> > > have.
> 
> Yazen, I'm simply trying to find an answer in the AMD64 Architecture
> Programmer's Manual, Volume 2: System Programming, 24593
> 
> This documents indicates (In chapter 9.3.3.4 MCA Deferred Error Status
> Register) that:
> "When the deferred error has been processed by the deferred error handler,
> MCA_DESTAT should be
> cleared. If MCA_STATUS also contains a deferred error, MCA_STATUS should be
> cleared."
> 
> So I would imagine that allowing the reset of MCA_DESTAT the same way as
> MCA_STATUS should be what the platform has to allow (or ignore).
> 

Yes, that's what I gathered too.

> > 
> > Sorry for the rapid reply, but I think this is where we need an update.
> > 
> > Linux:
> > arch/x86/kvm/x86.c : set_msr_mce()
> > 
> > Please note the comment:
> > "All CPUs allow writing 0 to MCi_STATUS MSRs to clear the MSR."
> > 
> > We should include the MCA_DESTAT register range here.
> > 
> > What do you think?
> 
> But before trying to update the set_msr_mce() function, I don't think
> that KVM keeps track of an MSR_AMD64_SMCA_MCx_DESTAT set of registers.
> I can see mce_banks (for ctl, status, addr and misc) and mci_ctl2_banks
> locations in struct kvm_vcpu_arch, but I don't see a location for SMCA
> banks like MCA_DESTAT MSRs.
> 
> So if we make kvm ignore this update instead of raising a #GP error,
> would it be a valid solution ?
> 

Yes, I think so. And the details depend on how much of the platform
needs to be emulated.

Some ideas in increasing order of complexity:

1) Ignore this register write.

2) Do a basic validity check.
   Allow "write 0 to MCA_DESTAT" and #GP for any other value.
   Don't need to save MCA_DESTAT values.

3) Replicate the full platform behavior akin to MCi_STATUS.
   Would need to save MCA_DESTAT values and do a "HWCR" bit check.

I really don't think we want #3. This would useful for "register-based
error injection/simulation"r. But that use case wouldn't do much with the
MCA_DESTAT register without all the related Deferred error interrupt
infrastructure.

So I say the choice is between #1 and #2.

Thanks,
Yazen

