Return-Path: <linux-edac+bounces-4995-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D4EBBEAB5
	for <lists+linux-edac@lfdr.de>; Mon, 06 Oct 2025 18:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9CF1883B34
	for <lists+linux-edac@lfdr.de>; Mon,  6 Oct 2025 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E092DC767;
	Mon,  6 Oct 2025 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f1dbny4f"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151E2D5437;
	Mon,  6 Oct 2025 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768540; cv=fail; b=XbIwUhDoG6l25GrAPCcDxuI9w4+fS+qGQFvjICtSBFIlObIjkhPsfQpA9SQHmbBoBfAONGQcCHC2yFo9SqelUZEbYA8fuZRx5mMkQrD8812bWS3TI7kc3QkvruRXDmbkOcKIcQOmTx0LO+7Snmo5QgPATIS+jzkVIQVy0oImIvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768540; c=relaxed/simple;
	bh=mesLCHAHzlWrP1puqbUU4DfcPjoYLjS4JpC4Q2UbXhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tl68DwjO0zMHbl4htNK8jmzOrbdyRzaRWPc87ag/JhngmUkXryM3twD8AyvsmLzY2jZI/FuKaQv9cqJhv6NkpNzGV1dZLfRQLOuND2UkM0oPJWVFjGWKXM0wIacnHEWAePQwln/2KioHQHh8rEavg/TM8k267rtkEZDzDQxZdrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f1dbny4f; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ekkHPFX1U7bA02OYNmtSdN/7en7o5dvA2f+bTVw/CF9RmlafBmEEF0hsWXmQ6MihHtqw4kClSv+toej3eKxNiKwSg8kxUrwKEGWKm0ortJHgRpSzuCBIkalFPjUUPAMkP7iVV3UI6IT8oMT8692XLk+1td/hkNRh2WX7UfRdTuB6Tg6ljTFdPgbzquv/0Z1t60XRahLux1aT4WIt3oquvMQd2BLQbcud2yP9jHj0iO43ZBCFs7FTRqK6ojQKuTLM9nxhtH9SmCNJIZnkv3K8mEdcQBa3GCrfzZedHgZZ7qQc4KQmeGyI3GJQHST9DovxRJJK+L78ZOimG1h+kbt5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4Gp48KpTyKM9NYTTSnkKdBfRY4ONt/JQHwixKv7ttk=;
 b=b81S/mOO+IV9YWAZFrM3S8aUvySYipSiLibYitQF4Bwq2XDoucOGT8/KSpHcjklnXt0YwMsGjgYbi6S1efKkGdMuM4FalegsXDhaFml8PlH5d2sEMW8cu7/omMzaueMDrNCXtzv13B04JgqC9x9tIOoSZfhfbl7rmKd8tXHw611UiWx59JamrjJHvP47ShP0T7DusgFgk22c5BwPjET8Bi28FjomgHjkNQwAgZs0WJYI3V6XIb3IAt3tsxNGa2in0PyFs46c1abtrtp58mbkpZcHNlTlL7boeigDo4/zBDkkp7jyD7kl7wfarQKQArbmxeHxqgo1nBEfnVoSVZad3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4Gp48KpTyKM9NYTTSnkKdBfRY4ONt/JQHwixKv7ttk=;
 b=f1dbny4f7cKkvMkGNHsJk16C/GeYqjrUWPhX65/xX79L4V5LRhdG1o5iOUQUnEq4yGgnoY2d5c73HOKCgYQx7VvdkcdkyyCyzpvioFVRoRS2CAh4NJ7ODZPK1gtze35Je+AQT53KrG+xistRBJG8rH6GzoKAq446X7YvNUmR70A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 16:35:31 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 16:35:31 +0000
Message-ID: <e3209aea-19cd-4577-b557-842176cbb7b4@amd.com>
Date: Mon, 6 Oct 2025 11:35:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RAS/AMD/FMPM: Add option to ignore CEs
To: Yazen Ghannam <yazen.ghannam@amd.com>, bp@alien8.de, tony.luck@intel.com,
 linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com
References: <20251006151731.1885098-1-yazen.ghannam@amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20251006151731.1885098-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0019.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::13) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ac8c71-499e-49a8-ad1a-08de04f65d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlA5b0FQR2VQcW9MRzdPWHlMRVFCYXcvb3IrTHV3R2lFWmtPL1VNdkpEQ3g2?=
 =?utf-8?B?UzhxWW9pb3MvK2o1WjVXSnE0M3c5YzVMd0NqbmJIZjRiZlVFcnBDeE0wSVVn?=
 =?utf-8?B?WWxNbDY0WmlOazZZTHJsc3o2dndGWCtXQW41VUk0bXJadVJVNHBnTkFyelJw?=
 =?utf-8?B?c0JjUFZmenh0RXI0S0hVaEZlQk04NXN4eXFsUTl6WlRzblNxVGo1Umdsb3Nw?=
 =?utf-8?B?NldXd2N3dWV5VlU0aXhhcHlyYjVYTTlyTTZ3ZDQ4Y2xyMnFiRnRHRndKelp0?=
 =?utf-8?B?aUhWU01yYkd2dVY1emoxZXRNNW13d0hNV2duK1RieXg0N2hId3FsVlhMaGND?=
 =?utf-8?B?b0pQOURndzZ1S0xVckp2d1VCUVg0OFI4Rk9Ja0NwVVEyVnNqZkZhN1NQZW5Y?=
 =?utf-8?B?c05kTitPckNnVXFycmM2dmhWUlcycWRyQVZGUWdnckFnajdxTFptaU9jRE80?=
 =?utf-8?B?RmluU01hOEplQ1p5ZXRGa0l6NXV1K1VBdFFXNW5xV0M1SDF6MVZNallCY00w?=
 =?utf-8?B?MFl2NzF5c0JDWFhQbWloT3FXU3RvelU3Y3NkM1FVQlNQaXR3MFJGM0l4M1Vh?=
 =?utf-8?B?NHdUejlvTWV0eGoyOTlHOE96VTBRZ2tLMExVeHYyNFBMZkFmakxSNHRieTlM?=
 =?utf-8?B?VElmOVFzVUo3RFpzOWhCYlB1SjFpSndrdW5HYUFIMjdiTDR2RnYvWlNYcU5I?=
 =?utf-8?B?bU1RMGprZCtjNkZsbllKa3MzVWQxclkrcWQrMzdSczlPeFlXRm9VUml0ZTV6?=
 =?utf-8?B?MXViVUtsS1hsQ3ZwTjliOFRqTGRMNHVIb2dscnd6VjB3VU82clFjTW9RMWhW?=
 =?utf-8?B?TXhDc01tekM5ajIwTnpHWHoxamhOT1phZXRuVjBYZjdmbVF3bTFDU2dSajVo?=
 =?utf-8?B?bTMxbityVGJWUUhURUx4emdlcHdtQW5Rek5XT3VrMzJ5UFU3Umd0Sy81Y3FG?=
 =?utf-8?B?VGlxaWo2all6VkdnZjdFZzZ0RGFkbFhrVCtyazJNRWVERGJ5VWk5dXdZZmla?=
 =?utf-8?B?dUFFaFNwNXYzTkZpSFpEWThDNnJ6UDl0aVVZck0zOExjVTUxRGFpM0J0UWFM?=
 =?utf-8?B?RDZaeEVTd1JBWHAvMzVla0xQQ1VsVEE5ZXNHYW5XelFibzNtQmlzak5nYkdu?=
 =?utf-8?B?ZHRlQ2I4QnpIUkl6ZVFOWHhtYjFHcmEzY3BReFpUcmFSZjV1M3NHaW1raWJU?=
 =?utf-8?B?alU2L3liTHZsYUtZTDdscmZTY2dmU054dkpuZXNud1dKL3RGQmdwK3BCR3o2?=
 =?utf-8?B?d2R6SmRmQSthWW1pRlNpV2RxdUJ6Y0xrMnAwbVZEZXk3elZUd0FxVk5zQ3R1?=
 =?utf-8?B?ZUtSWU5OYmFSdUJCWVJ1OVgyQ1laK1VUbVgrQ0w3Tng3Y3B4ZW9jWmhtSENr?=
 =?utf-8?B?ZzFXMCtoL0lCS1QzS2JWOGREZnh6c1lJcE02MmRBNkhEdHJET1VqS0VocHdD?=
 =?utf-8?B?bTF1bzVrTHBaUVI1bG1NUEtFd3lMRWhzWlhCVHBqbkVvQ0ZaaW9BbUFtb05v?=
 =?utf-8?B?NldBRGR2eTVVc2J2VUphV2M0Q1ZKaTVxRFk2cUlqWVFYdFNLK0xuai9za2Vo?=
 =?utf-8?B?NzV6MFh4OFlRY0lESUZoWWhXUGRPRzM3UWFYcmZ4RkVPNlRpeHVEcFNwYm1V?=
 =?utf-8?B?S2FNcjlkN2MxaVZITjRqaDhKT3BqVDFodU5mMWJyblhCdytmV1duTDllZnUv?=
 =?utf-8?B?aHNHN3FHZUE4Rm9JT0RIeHVUNzZEWVRXZzhkdk5aMHJPWjV6TXJ6VDEwb1Fi?=
 =?utf-8?B?a3hiTkVINTRDUVFzNkk0bGQwYVI5Nk5JbU1WcEltQk9KUnNoTkQ1Qy90UU9T?=
 =?utf-8?B?djVxcXJyeExBb0tVNDVGOFZTNDd0bkVFaWNLRGJZZjlQTlQ5RWVXaTNEVzBH?=
 =?utf-8?B?cktldE9TUWphZmJCWDh1RERoT3ZKbWVTbU9UTDZvUlBzblM1RkVZWHFubndM?=
 =?utf-8?Q?ucD33LopH6wtw8BODWMOcJVXvn7Sa8IG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnp4ZDI4ZmJyb2VKWk5qalBqSzJXWUFiYUZDWW5Rc0lTNWltV0hJNU5RVVUv?=
 =?utf-8?B?VVUvR0t5ci9JT2QvWHVJTWJ3UW5Yak5vNVNXci9Fd3d1eUNjbVFGTm5Jdm9N?=
 =?utf-8?B?WnRtTlAzSmlZdkNxRXRrMEFMekZCOHZBS2hzUSsxSnVUNzR6K0VCZDVXRjV2?=
 =?utf-8?B?a1BJelhVaEw0RURVOFhJelNzYXNGSGFhenllT1pXWkRxU0ZPMG5iS2lsWDFJ?=
 =?utf-8?B?QWF2SWl5R3l1VWtaais0ZDlSQTRZcndIVHp5cXhYZHNsWmFoOEJkd3YzZFhV?=
 =?utf-8?B?Q05vazdLM251TENGZFRET2ZlS2dPbEdJMUxSUGl4WEhxaDJleUs3d3FMbHI3?=
 =?utf-8?B?ZFJCZXNYS3RZSS9GQWVkcUVCSkcwMWk5bHp2S1E4U3VhUnYvVk11blBIaFhj?=
 =?utf-8?B?Y3pPMnQvQXhGblQvN2pKaGt3Y25jWWFyZllDblNpanNtUVRkTEFPMytnZFBW?=
 =?utf-8?B?M0tnOXg0S0RzWFFCY09lRXB4WWZneHBuUG1ON1pCbTJNRFFuQVM0QW5UU1RE?=
 =?utf-8?B?Vy9zR21YTWp6UU5pN3ZZOTFjYk5iOTREN0d5OXpNcUR5ZDhoNHV6RHdkdmMr?=
 =?utf-8?B?K1hlQlNFTkJ1R1Bmd3J1VlRCYkNoeWdzdkhBdDBwRERYSEdkb0tac3VMUGY3?=
 =?utf-8?B?NG5UZ3JDcHdTdVNLb1R1Y0ZCWEVidmtvb3Q5N2pnb2FtN1l4TUFSK0hZc01n?=
 =?utf-8?B?LzRWNHRZNnRQeWdpelhSM1B6MkJJZjVWdmcyQU1nbGJOM1NVVnVQaUtra3hl?=
 =?utf-8?B?YXpGMEs0ZEhmQUszWkp1OVQxa1MzdEVSenV3WEYydURqdDBZY2JrRncyL29j?=
 =?utf-8?B?aDd5czNDUGoxc1JwbnJPcnlXak9uU3RTQ3JxY2d2UDdudFFHdTZmY29NeFBU?=
 =?utf-8?B?QkRJS2R3U0UyMm1wUTVRN2xubnhIVGpvOG5BQ1ZuQXRZN3FEejdZZ3cyY1dy?=
 =?utf-8?B?YS8zb1ltUEZic3I2S0s2NUFnSERJbG5pN2xicCtMRTByTzIyc3pPdXR1Wk52?=
 =?utf-8?B?THJIVFgrVHVIbnNNUE5aaWVmbjhkTCtIclhUNCs1Z3JsUGR6dTRzQ3NldUxw?=
 =?utf-8?B?WTdmK01MT2FjNFZ2a0dxdXplQitQVVc4bzVNNXZuYS9hU0ZkM3pSZWpuSmwz?=
 =?utf-8?B?TXZZRzFvYTdxM1dNU3hmSkFBQVpDUlpDZStRM2NvUmZ6WXBtaGhjVjdOMFNQ?=
 =?utf-8?B?N0VESDI4MThDbFFvREJSZkZVOXlobDBLU0UvNFpPb0pVWDJHeUs1Y3lOeEYz?=
 =?utf-8?B?MkhnVVBTWnV2UVFYOEY3eFBzN09sbFhnS0Y5UHBaVTRKT1RRdi9MSk5qY3RT?=
 =?utf-8?B?VXkyYnBIcXV5MEhtVEY1YzEzZFhuZ3BYYkczY1lGVFZ6OFkwTmtNMDV0ZnV6?=
 =?utf-8?B?M0tYSzFMZmNnb2p4ckVMdTM0T3QvK0hPNzRTdFRpbFhWdjVYK0FKK014b01K?=
 =?utf-8?B?eTVtM09rOUVvdmFpVVlhZ25qMnVvU3JzZFhvemxQRWk2MUxHS3JiNFZ3Y3RE?=
 =?utf-8?B?TGFqbGpmMmNIazFRclAveVlOakFVY1JmUGxPT05tN0dXa01tWFc5UDlJdWJi?=
 =?utf-8?B?ZGFWazE2TDA4YmxnUS90anR3RHp0ZFYrNW5VOC93Snk1ZS8yUDJ6Q0dTSXN2?=
 =?utf-8?B?UUQ4SWN1eGVWYzlJWnBOWk1TR3ZieHRvY0RrelRZQXpEMk5ORFNXSVZ6Nklp?=
 =?utf-8?B?Z0x1MDFxWU5tNkJJYnk1ZmxoZTVrZ3dWT1hJNXFDWnl2MU80cktLZ2NoNE4r?=
 =?utf-8?B?d0w1cVFMNytqSkhVb0pQRVIzQ3h5c1REVVp5UVpPVDcrYmR3OWJ5ZUpCNGR1?=
 =?utf-8?B?Nm15Q29UZVRwYkdlMExnYStmdXU1K1pTVml1R1pnREtxR0lyZERYTHdTSmo3?=
 =?utf-8?B?WVk4dU5sTElSaUtWaWI0WGtEamg5WFo2RytSY0l2ak5LMVZrZzV1dGQrWGUy?=
 =?utf-8?B?d2RSQVo3MmVhNzRFTVY4cDJYSlZQVTZNK0wybWg5MHcxVEwrSm1la2s0QnZT?=
 =?utf-8?B?c2lPTTkyclZlMTlDV2hzVTZJOTBmbzFPUkdqOENrOHZiWXVCNWVkdzdsM21h?=
 =?utf-8?B?dFdCd0hQRlV4ZExBa1dUS0xhR1pBazIzRVo3aHRCcFNONFgyd29MVDRnY1FV?=
 =?utf-8?Q?wP262Upzob99YHPDh0Xjbydrg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ac8c71-499e-49a8-ad1a-08de04f65d9c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 16:35:31.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exgQTLMOdpPzHCoVkNrf2TTn6HeIULuC6OAOTMLN85YWGshZh8z1vym+qwbt4rP/7rX7GCeOqzJ/EuVVZc23VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086



On 10/6/2025 10:17, Yazen Ghannam wrote:
> Generally, FMPM will handle all memory errors as it is expected that
> "upstream" entities, like hardware thresholding or other Linux notifier
> blocks, will filter out errors.
> 
> However, some users prefer that correctable errors are not filtered out
> but only that FMPM does not take action on them.
> 
> Add a module parameter to ignore correctable errors.
> 
> When set, FMPM will not retire memory nor will it save FRU records for
> correctable errors.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/ras/amd/fmpm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
> index 8877c6ff64c4..08b16a133f20 100644
> --- a/drivers/ras/amd/fmpm.c
> +++ b/drivers/ras/amd/fmpm.c
> @@ -129,6 +129,14 @@ static struct dentry *fmpm_dfs_entries;
>  	GUID_INIT(0x5e4706c1, 0x5356, 0x48c6, 0x93, 0x0b, 0x52, 0xf2,	\
>  		  0x12, 0x0a, 0x44, 0x58)
>  
> +/**
> + * DOC: ignore_ce (bool)
> + * Switch to handle or ignore correctable errors.
> + */
> +static bool ignore_ce;
> +module_param(ignore_ce, bool, 0644);
> +MODULE_PARM_DESC(ignore_ce, "Ignore correctable errors");
> +
>  /**
>   * DOC: max_nr_entries (byte)
>   * Maximum number of descriptor entries possible for each FRU.
> @@ -413,6 +421,9 @@ static int fru_handle_mem_poison(struct notifier_block *nb, unsigned long val, v
>  	if (!mce_is_memory_error(m))
>  		return NOTIFY_DONE;
>  
> +	if (ignore_ce && mce_is_correctable(m))
> +		return NOTIFY_DONE;
> +
>  	retire_dram_row(m->addr, m->ipid, m->extcpu);
>  
>  	/*
> 
> base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07

LGTM!

Reviewed-by: Avadhut Naik <avadhut.naik@amd.com>

-- 
Thanks,
Avadhut Naik


