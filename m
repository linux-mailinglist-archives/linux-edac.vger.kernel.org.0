Return-Path: <linux-edac+bounces-3992-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1B6AC10CD
	for <lists+linux-edac@lfdr.de>; Thu, 22 May 2025 18:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45C79E25BD
	for <lists+linux-edac@lfdr.de>; Thu, 22 May 2025 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E7029A317;
	Thu, 22 May 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W7oKgRZ8"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CCB2620FC;
	Thu, 22 May 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930372; cv=fail; b=mUmRgGJ4ULaylGypGl6xwpt+TfWhw9Z5gLFkd1+aVl+Eq900l8U/WDI+sWCKFXc50Cs4N6gI1jhlunKQCuPS0GhRRqcIRsr0GcMAFsNYWQ4R/xqWIt0CXztAl54Dc3LxFhAxUG7VATFfmxyGHUtHjd03pSakhltHvuMWD/478Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930372; c=relaxed/simple;
	bh=k37fC9w1umGm/elZS6lvfe+trmYsLtxxON6YvG6C3ow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SvFrC6ZpX0VBCYvnnx5mMIdBGcigDUgTUUEkJ+zexHCnLAgTdWh92OR/LaCgv11eKwTKbojJrKXPc2hgNRL8HOXr07AyIiHHI8AnzWbTxmIVYdmByk5638hQmMnJoU+6Drj+5e9t94fQ0SjXntX8KYIRx5WEPbiH6fAMlgmdpCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W7oKgRZ8; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2qvhgeTKnV5MvqZGn+fzFdGpTKzPw+gbZR9CuodzpKABI0a6NSB4Uz5wxGmVD2uCK6oKzrqxgESjgdkboznQbbEh4xpLHR0gGKNBR6AiH6p+Y+FQPB91SgQ+2MNhXNVvq+Xwuqj2m1ZBPTegwAnfTznGskyPHZapGgLaslHqvRtsLh67D5yGqdStLjdJNBNFU3stqDhesRV2/mJuNB4lpLqSZO5JKba32riwupCTdbxTBIp4ZrllK7GvwroEmNkx8DurVBnGNZOlUjDr0IAPZZJWa5p0blEySvIiVnLhrooMFIl9689SPdqHB0qf0kd1UpwXpcEMCPeqD9xRLoDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m7hbV6p5U7xf1BCR7RKyFbBpYMN9k6F+L5gvrDXkZk=;
 b=Z7xVmZAhQAQZsj/be5j5LuT1mGk8D4RweqrvpnWA08cfprdxwJHFKA5fKj9ZAL9SE+qa//gygKqJGbI0N1Rf4BuCduKvWOVUsQG/i3HC1YaCNS322Jzus6NXDm9tmac83qwhlafys5Yh4lUqhjVbnP9nyuXCaluIuW7bgPy1/Tgtzru2GbC81Yx3SBxlyyiSfTz0jbZ50VUn17ScGH2ypNBVTFdWSv9jvB9auTeI5BqLO/az9uvtB+DwhaI2knArhycWYblObGDMylGmCXcM9bXBpckBb6Ggx0+158gYzQnUfhxoehxdNA3ovZFzlMFCOeCJScM5j6FuJ7viKBg8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m7hbV6p5U7xf1BCR7RKyFbBpYMN9k6F+L5gvrDXkZk=;
 b=W7oKgRZ80vs3ceWGQhRy9nOU2dt2pWJdEtBy1HYIHnWeDBMsFj9eQK/xznXUp2oCJLlg0WompxJ/8gpztiz/wD6o8+QNBte1wgPHT/jym8FoFA3K52u0M16YknvHiqHqsdYwXd22d4n4k8YA0A05+04eS4RE1leQ73FgdTd+vrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 16:12:47 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%2]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 16:12:47 +0000
Message-ID: <6a0c12e2-08c4-4df1-b1f6-8db8b0029b5f@amd.com>
Date: Thu, 22 May 2025 11:12:45 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: bp@alien8.de, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>,
 Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org
References: <20250513192221.784445-1-avadhut.naik@amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250513192221.784445-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0031.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::7) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de30d9a-31e8-4e0a-9fc1-08dd994b7de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnBvQUV6dFZNTmd5blRNV0pNTE5PN3ZiWGxBVEUxaXpKaERUU1JUSDBIbDVY?=
 =?utf-8?B?ak9ZdktMMmhYaUEyNDgwcWdKUWIvbUdxbnAyYnZiQndGUUUxREpmKzVBTlEv?=
 =?utf-8?B?Uk9QaHRvbzM4ZHU4dW01T0FKcDhuckJmbDVuempZcktoUWpwQ0VjRGVrSXVB?=
 =?utf-8?B?SmVwZUJlNzZKOGNhdFlQNFZWU2ExKzg0NXQ1MGVWYXoyU3cvQ3Q1MHROd09J?=
 =?utf-8?B?a0RzSnJjdkc1TjNoWmhsU01qZk54NDF3c2psSXpoWDZGeEVYdm5DNEFJYXEw?=
 =?utf-8?B?Q0ZtZHdjaHZqTjNUWkhCcG1yZ1BHeEpsRitFMDFoOUpnRzlON0M4cXNTUHVj?=
 =?utf-8?B?N1QrVDlXVUFXY1hmMHBIeFRZUUZSWlNBbERZOUI1cjFnNjdIOWx5bHVzb3hB?=
 =?utf-8?B?OU1BZituTkY4ckdtYzZqakJrb01VTzhwdEFHVnhMSEdHbnZJMjlWbDJrRGRD?=
 =?utf-8?B?NzZNSGN2Z0lKRHQxaTRKQWdpbkh0WnVnRVhhb3Z1QTdma3NaS0VmWmMzS0xp?=
 =?utf-8?B?czMwRzhZYzRVNE8zS0tmYmp4eHRLa29Gd0Q0VWhoZHk3OE1oODJ5V0x0Zi8v?=
 =?utf-8?B?WFB3VllDZng0UlhzbDJPbEhVUUsyOTQvWGI0eUhucHJaN2ozVjJTNFRTblJC?=
 =?utf-8?B?Q0NYbFo2YVlBSkZMMWxyc0grT1ZQb0Nqa1NGd013UHIvcmNjMWIvVnRIbnhM?=
 =?utf-8?B?Z1FOeHZUTnFnMWdhWTVZOUc3Z1lmbHRzcHJPSmNtZjZHdEt2Q21mRzdnSXNW?=
 =?utf-8?B?MGRwZUVZZ3QvU2Rka1AwMUpuQXJleGxuOXpzQlhlTW5XS0Z2bndhVVYyU0VU?=
 =?utf-8?B?NXJRUmtBb3gzUzlBRzdDSXpRYi9uWDlyTHdIQ2wxLzRsVDhyMDhBUnc1YWRL?=
 =?utf-8?B?SW9adXppTUQvNXNnWGNydElnSHlGSXU5ektsMjB3bWRybnZWbE1WbTVXTTUz?=
 =?utf-8?B?Z2xLcWRVQ2RiVEJHeDhVMFViWVAyQnR3NnVqU0tFdExVRlJxeXlnTUxzdGZp?=
 =?utf-8?B?aGFkT0FSTDRuSzF0RmsxSzlaKzBNaXNTNTU3VFVHWlZmMHBZVEgxWUxEdDlP?=
 =?utf-8?B?UFBEUkJ3U2tMYjBOaDZGRHNBT0VnUUQrVHU0bVN1dmZBZzFpQTgvVEVvU2hn?=
 =?utf-8?B?eWp3aGlMRURWRVVoTnNCVjVaMUFzNUswdU1PTjZqODB4R3dXR3JRaWJpZFR6?=
 =?utf-8?B?U3o3SlNUdURxMWNzYTJEbWRiT24yNlZMYndKUkcxNTBkMDZxeEF6N2FnNmtJ?=
 =?utf-8?B?Q01wcmhnK2J4MS8yWHpxZ1RzMVhZbHZVV1V3c0hKUEpUc2NJcXhyeHROVjZP?=
 =?utf-8?B?SUIzbDBFdmswTE1id3ZNM2VqV2twNWZXdU1Hc2g3VmM0N1RyTHN2dEZLc3Mx?=
 =?utf-8?B?YmRUb3FWZG9HVXlKR1c5VmJVanp6dU52N3NjWDg3WENJckM5RmN0VCszVXhX?=
 =?utf-8?B?c1RjTEkzQ0Y5L2R5cEM0YzFiSUtjK1M0VDdNOTJ6TTNqS2pILzk0cUd6UkRT?=
 =?utf-8?B?ZzAzcFZZSXNlYzNrNEYwVXV5R25TL21BSmZkemV5V29zenVjZnEzVHNmMmxW?=
 =?utf-8?B?VlFCempTQVFjSEdIM3pFRlBXMUZ2ZjJpZytOb3lHWFBKUzI3bFQwb3lIa1oy?=
 =?utf-8?B?VjhDYVpGR3ZnQjFSbHdhVXkvVWlwUzhINGZrdW9YU0VDbzFvd2xjaWZtRHJM?=
 =?utf-8?B?bkgwR3JGZTNvbThoYUNoc2tkRktQeG1WWFNza29UdFRVN0J5MG9MaFVGOE5C?=
 =?utf-8?B?MHJIUmpJVGhTT1VKTzV3QkVzV0p3TlkveUVsUmtndVpZYzUwZjVlMStpclhw?=
 =?utf-8?B?emRmbzMxUURtTlJORHpWcW84Q0dCZUw4N2RQcHBKUUhRdTcrWVdpRlJTZ3Mw?=
 =?utf-8?B?TWZUWHZ3QlJDQnVHc0tSRzQ0RkNRdUlhTzRQbGtGTXYzTm5HRTh1R3FEYjM5?=
 =?utf-8?Q?IAlCA8dEIiM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFhCZitxak5DejNQNUIrT2MwVVdGKzFEbUZFbTYxWEtkaFdVQkVXWUxpU2o2?=
 =?utf-8?B?dVZROGxSU1ExdzJGNGJ5Mzd3UVJBK085b2RndGYyRy9EVk5UcFQ2enBQOS9W?=
 =?utf-8?B?aDM2Y0JwS0RHNUhTRUhFQkNZZ0phek5kRTB0cGQ4YlArRWxPZ2tTUFF6ZHRu?=
 =?utf-8?B?RitVTFd3cG1kblBjNHBGclhJbFdKdUU5ekxyd0lsT2xjdytIZmNmaElvc2xy?=
 =?utf-8?B?azV1dlU4QTVzY3N1VHVSeGRRYTBXNGxYZWF5NXoyK0wrMFZzQjRjT2hKblAx?=
 =?utf-8?B?S0srblBNSllQaDVCbFFRYTJvVlo0aEpaY1lnSllRWTQ4ckZTYnVSalNSaU5Q?=
 =?utf-8?B?UDFCVkhlWWlWdjdrSzhTZ09mQ2h3VGpIMEVYMHB3VUIrUVl0cE1MSEF2WnVP?=
 =?utf-8?B?TXVpSnBQeGozeTNJVHdRSXFEVTI4MVhJdXBxMjRJQWVGMDVPb0Roc29MYU5Y?=
 =?utf-8?B?b2Nld002cHkrY0lsaktEYTQxdENSQjFqeGxvbXNJWE1CbFdZQjN2elc2dTJF?=
 =?utf-8?B?MU0weWFKL2lleWpUQ1QxSUhLRjRvQVZ3SzhZczY5WS9LQlBqM2QvWjVFSzB2?=
 =?utf-8?B?RnlaUHdpR3I3UERpbUNCb3kzRnVKUG9wYlluRlZTUWhMSDhUSUdkME1UaUJ3?=
 =?utf-8?B?Q2kzNXNuaVFGTTA4MDJzYTBiekNuS29ZS3dMVDV6dDFlRXdMMTNOTDByNXgv?=
 =?utf-8?B?UzZGaVhOdnJGaEJVaFJDSVBHeTNRYmxQUWtVL2VmWGlEbk12V013dFdNNWg4?=
 =?utf-8?B?RmlINWluTVFCeXRBazZoUnF3NGY5N3llUHM2R3BIYklYYklXZjM0WnFleVNk?=
 =?utf-8?B?dnVhdkloOVZ5YWdhZGR5M3E5N1QwWDJ6QWY5UWRRVjgzSkUrSFlvbUJoLyta?=
 =?utf-8?B?UzgvMDNQZzNqWExDa1VBTUVUMWZoUXpNd2pZYVBDZ1NxcERyM1NKMzdxaXFS?=
 =?utf-8?B?cUdveWVRMlpXSzNNYTZ5cWQ1KzBkQmU2aEh3R0pxNjRBWm1pdlN6bUhrYm5C?=
 =?utf-8?B?a2J5bjdORVQ2U3JoZlhraE1ZZ0JleGVzbUZJcjVMZUlwaTJzR3JqVFdkSXJ4?=
 =?utf-8?B?dGs4WmxzanVrT0NleG9MOVY1MThQdEZWQU9JV0dKVnpsbmhSZWFFV29vOTY0?=
 =?utf-8?B?WWtaRXNOdEhKUlk0dXgzcjk5UHVEN3ZJT3c1QndHbC9CSjNubDdPT0ZPWm8w?=
 =?utf-8?B?U2JvcWpFWGxuNDZ0a29qZVhCdE85YWNYSWx4VXBOY0Q5RkNtZkFaZ1N6Mkx0?=
 =?utf-8?B?SkRNSFhGVkI3aEFaR0JHc3ZFY1JUbjNxdTdzZkR0akJiZmg0dThBdXl0V3ZW?=
 =?utf-8?B?VVZleDd4MHVXaGZqL1h1OC9TZm9RSk9SN1RxNTNtbDdjcGVxZVRIS0hzZTVt?=
 =?utf-8?B?Q000Z1Eva3FjR1MyYmpLWWFOS1lIMnFjcVNjTzhsKzR3c2s0WEdtT0pibFhG?=
 =?utf-8?B?a0c2czZpdnZ0S2dnRmwxT3Zpd2RtMDN5OC9MdHh1S3pKRDVWVE55d3MxS2F5?=
 =?utf-8?B?cFhPcXA1MWNmWjZIWmQ4NjVQTjBDV3BGZFNyL01PNnJxa0pMMWFIaEs5NVNP?=
 =?utf-8?B?cXpJOEhQaUowK3E5ZVdQWnJJSDlHSkJReUZEMnpiMS9oVTExNk1uazROV09O?=
 =?utf-8?B?V3lYZjg2UFUxNWRrd3l6RFNlY3J4SDBlV1pyVk5EMXd6bHpmWDB5ZXZnSEQ0?=
 =?utf-8?B?bEYweFBadFEyZGpldWhEanFYQ1NhdG1Sbm5tcmU0bGpkZGtWNUdXRDZNK1FW?=
 =?utf-8?B?ZnNkby94bmI3U1hVWk5ua3pPcW96RUJNUFp1ZDBmRmxLMXhSczNLKzJXb0xz?=
 =?utf-8?B?ZEhqZ2l4N2hVUUZkRDFBOEVmUTV5c2dLd3BaNFBmUnY3bVBnY2ZXNXBMY01L?=
 =?utf-8?B?MStVeThPSFFueER6Q2RQYXg4SWdyNnl3NmdWdGIrWUc3b1FCYVI2WVI5MHlP?=
 =?utf-8?B?K2E5aUZmVlFYaHJXUDBiTnArOWFzQjVWcHl2YTdjNFE4Ty94WW1ZWkNUOUtL?=
 =?utf-8?B?RXZ4bndrSG1xWk1JQVJOZ2VtVVBSMjIzbzhmcnZYT3ZjVmFFS1paNmNkeVdV?=
 =?utf-8?B?UzJvL0NRRldtYXh4cm5XMU9vckUrVkRnbERnU0pTMW9vSGtpTnRDUWtoaFkr?=
 =?utf-8?Q?OuNMqFbOrox+5Y5S7+qO7DaB9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de30d9a-31e8-4e0a-9fc1-08dd994b7de3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 16:12:47.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqGTgado5OMW1TIK1Tye/7laS6Pyb5dOvOn58GAIV8Kirmq/7tsxM5JRfMEz/0DuzXbZdGW5YeH7RGnWnYPiBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319

Hi,

Any further feedback on this patch?

-- 
Thanks,
Avadhut Naik

On 5/13/2025 14:20, Avadhut Naik wrote:
> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD's
> modern Zen-based SOCs has an Address Mask and a Secondary Address Mask
> register associated with it. The amd64_edac module logs DIMM sizes on a
> per-UMC per-CS granularity during init using these two registers.
>

