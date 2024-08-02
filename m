Return-Path: <linux-edac+bounces-1610-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2E09457DD
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 08:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8EF1F22C8A
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2024 06:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9111C2BD;
	Fri,  2 Aug 2024 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V3o20lmk"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD62C9D;
	Fri,  2 Aug 2024 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578480; cv=fail; b=rx7sLYRBPm1yL9bpKOIFrjDr6Qp/BwBbDI+p/bzBkJ6L/YtRxYrTnafQ3HOTC+tZk+MfZ5kkGy/SYDXtsCWoJT/bENGji9X59U2FxJpd8ewQr6qQ4YNI5C045CtOsmwMEz6eBZhjGvVxBsce/7xOLsrrFdWct/yxfF7WDH9iYYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578480; c=relaxed/simple;
	bh=q1tWSPR5Jad5GwGmmXy4hVIOrWs6weTdKoUK6nf2oa0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GfoBLl2L13l0jcm0mOkN43hJ/R9Q/Z/BEx5Rbn9PVmgFkTjkDaiOJoS6bzCFL4KYj4yF3Q6I+uinypZpxS4VEot9JhrBlzJLudYEJ1rX/rqodSm4xcNq4s7CF8vMk0mHYcx/gBUBY8k2u/Rf366VtLhRDVVLqjk+cIV5TgaB0sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V3o20lmk; arc=fail smtp.client-ip=40.107.101.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5C0Zli31atKcOq1bAJ4StmJAiQgl91r1zY9mmyNVhKb+dDdSaItb0RxfKaxpMV17cBs/ib1ixU7uRJUYXSXCkkjREWyafc/DzOLbB7i+qnK5VqCEIQ3q8QM5uvMaHgW4un7C6pc205RAtOBxd8Mrv1C1rWRXgBnezGih+g1txGCMGp+Jn2rYcHC5Bcrhn0dcXfVxstykUvtak33ikDWzwqTitWvHFxJwdJYcFmXc/1F5nRlfUbeKFM2BesOrcUMOqM5buQiOKS230Zq9mrh47o46a892LCsGPCRqZ5v/KMuGPjyPscFUFKaehYuewEw5fZkfAMALatQJd99Qo/g1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jjs6HIFLyOb5poJ5d/6oXI9gHxGKHlhZICzW6z5EPes=;
 b=o80KY58fI92j4zffe+wBxJfnZ2cZZyalTPxY2q6OdY3tUYCkZ9CDEFGdmSP1LYihYRz5ZQBmFh4H+UShc9VurwvOOasrgqMJc5DdspOxVrILTA8EHgLPqxIkXDEQWB72U0e6yNS1gB9Xo5UTR7AEyybn1uWJx8ka5uOuXCd/cwAl0cPPwlN1/gFZKANnyfvQ9al0gLyKWqRox5bs0LP9jb+9wlGVl5LOq91H9z5pXNo5ZSFa1zcbbdp6t0CPaDXwXkOdgcQwdsJ5vHTv85Z65P+ON8WxJa7W5fz7SkRaHDwI2z2Igj6J4bGlEZRDtkBo5sYE+39DF4o+ur6sH0j5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jjs6HIFLyOb5poJ5d/6oXI9gHxGKHlhZICzW6z5EPes=;
 b=V3o20lmkZ+cUBT2Y86JDJ8hiOk9b1mZYVpS6U0RoIq9Ms2I1gO1EZ/Kg/2OQ0t2YSC0+8dyURpxw/N2JD8Vy3szuDuOujdqvoc3EKZo/W6G8gL7hieGYa5CXfq/Q6UKyTEfH8JVaqPIBIbYL+l8R07chrX8UScHjKoCtPuo/W78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Fri, 2 Aug
 2024 06:01:15 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.7828.024; Fri, 2 Aug 2024
 06:01:15 +0000
Message-ID: <7021a08b-ba75-4d16-a71f-b38e48df5af3@amd.com>
Date: Fri, 2 Aug 2024 01:01:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] EDAC/altera: Fix possible null pointer dereference
Content-Language: en-US
To: Ma Ke <make24@iscas.ac.cn>, dinguyen@kernel.org, bp@alien8.de,
 tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, niravkumar.l.rabara@intel.com
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240802033849.1560017-1-make24@iscas.ac.cn>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240802033849.1560017-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0156.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::19) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 7209e06a-ae8c-4a33-f836-08dcb2b8822f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXNkQ1hVZ0dPMnI0bWs4dC9YWDB2VW5vUFR5VlFHYWk0TnJ2S3JLdFQwZ3hu?=
 =?utf-8?B?UEtidzhmYW1zL2o3MUljdzRhWXVBWnpJTGZXcm9rMWxBWGV3R0V0ZEtTTTFE?=
 =?utf-8?B?ZVhCTC9DRm1TRURVS043YXlJNVAzVCtKTnZWalR5aVZiVXBKM2ZwVzd5Smw1?=
 =?utf-8?B?cmo3VUpRTHJZeHlQR0M5QmlDdEpsdTA0Q3hTK3ZkUW9ONzROUm54WGVQOWFE?=
 =?utf-8?B?WXQybG8wRUt2L1dQSzBabnF1R29tYWJWbnh5eGxlOEtEa2QyQlJrT0xkTTFQ?=
 =?utf-8?B?VVBwbzNpSFFSdGxUNDNIY3lSMFRUeDNoMXRkTDRsM3NLOEVaVzRWaUZBQTIw?=
 =?utf-8?B?M0lrbWp4OHpnNmhhcWhKdzByNWw5VWZFd3JTNWsyQUxzditMM0t5U2NIM1Bw?=
 =?utf-8?B?Z1BUeno4TXhBYlRlcExwdS80M254Q1FuUVdXZmZRMndtMDhPMzBPUGxybUJE?=
 =?utf-8?B?SkFKcjh3cHpzNzZFbmV3TzNTdHYwdENBOFg5SnhrVWJCWXhqQ2s5enN0eUdK?=
 =?utf-8?B?K2VxYWh3MEpMRHg2WnlYQTUzYlhLeUQ2ZFJLY1ZYdHhnUnRFQnhwMldxMEJT?=
 =?utf-8?B?K0tMeXJ5Y0pwN0tKaWZDdStzSHBqcWtycEl0VEZaVE5HQml5czhWR3pTUlYy?=
 =?utf-8?B?K0ZLWEdnRXRUdWlXQ0dnSmNOM2UwdnBPdkY5U3ZBK29vclE0UTRaaVVZMG8x?=
 =?utf-8?B?amM5K0xVb1gvemgvaXN5Kzh5K0F4cHNoVGlRWWVuWmxhWXZ3U0ZkOEp1cTZK?=
 =?utf-8?B?bW10NVM3OHY2bC9qaWdLZzc3bnNIeUdRcHBXcWNXOTltTWExSkI0V0xqQTZ2?=
 =?utf-8?B?NnkrakZPRTlma08wS1h1ZUh0WVVsMk5oUnE4c0wveGJYeFhlUERNNW1LbHJm?=
 =?utf-8?B?UGQvQTZIK1NWZGFJNEhybXVBRkJOMmJhRERsYkkra2sxRk1vcjRKTlg0aGg2?=
 =?utf-8?B?c28vWm82US94UHBBOG5HYklKWjd1dVhHRUdMdlIxQjVKYktaeEFxaytSWXpB?=
 =?utf-8?B?N3BQS3U5bDAxMWQvNFFGanllQzhlTUFybHo3Y1E2ZitOMlo5UGxQNzY0NjdJ?=
 =?utf-8?B?bThyeVFrOFVqMmdqZHFvc2NsZmN3dkNrMmhUcXBWVDhyS1Q1eEpqQW1hZ3k5?=
 =?utf-8?B?dlNoSVpuRzFZQjdkQ0FmbWx0RUdGZGU0Sml0elB1a3RjZFZVQVFNdlFpamU0?=
 =?utf-8?B?MGlJRjNBU3gxNXZhYWdENVgrdWNRSFRYRmNkNmZjQllLd0dDVThSaFJtbW5S?=
 =?utf-8?B?NVcrdUgvZTFpK09Ja0N5Sk1PNGZUTm1KeTg1RzdSZEEreE5WODg1SHVRTGtN?=
 =?utf-8?B?RTlmS3ptaXFvRytobjlUQmRVMjJJUTJaaVRpMDJEcUVtdHFUSDFXd0lDdStC?=
 =?utf-8?B?VTVrYngxZmlYaTdpdnhoNFJEWHBNdGZjbEV3M2oxTTJhQzR2YTRhMHhDWXdl?=
 =?utf-8?B?MzBHZmNXTUlzSzdpQnRlWVZuUHh0a1FCOTRhS2doMlE5NExkcjd2TVhGRytZ?=
 =?utf-8?B?emx3bGN6ZGh6WnlUYWx5V2xJTEFmalF3Uml6UHF1NUhXcFpoR1ltenNEVDRO?=
 =?utf-8?B?aHdUeEtraFBDdWVHOTNPWFFxTk9xTC9SNG5YRm5ldEpaNjc0ZWs2NGNzUURs?=
 =?utf-8?B?b2trYlNVZVFTL3V1OWczSFU0Y1BrSlptTDN0elVtblBDd0JNeE5WbHhkUUI4?=
 =?utf-8?B?Ym5YYnU3ZnBha3drdHpDVHZHcE5teTdaZFdDamhjbmxUVWtVRy96NFp2VmRx?=
 =?utf-8?B?aTBwN3RsNksrazdNNDlVYStubnFod25PZm95UGNOQ2NQU3JUVmJqRFM4ME4x?=
 =?utf-8?B?MXFoaElhM0xhK0QvdFhhUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2FnUkdNMWNGSWhTUGY4NGN3Z24zYkF4alJBTTZMQVhQdkU4SklOWm1UeVFs?=
 =?utf-8?B?OGd5cmlnVTdTa2NPTk1nZnpKRytjaWR1alIrUEJrWTVCV3ltZmc3cVVGaVNv?=
 =?utf-8?B?V251SVZrSWhoTHgzVFNBWUNyK3hRTGViNEREVzc0aXFKNVl3VWRCZTVqUWRU?=
 =?utf-8?B?ejgxR3NSTHJodTlOZHR0dkQxYS9LdE5ncC9Ed2VWMTM5ekYvcUR1MThUaUFS?=
 =?utf-8?B?bFdSdDdZbGhqckQwRkJLSFRpdmNGazlBM2czOTUxNEQrYW1sVS9nVXI0dUJr?=
 =?utf-8?B?SGRubVhYekUvamI5Y2dXd2trcXFtdnIrbm5FdTNESFdRZU1CWWs4YlFGbm1Z?=
 =?utf-8?B?ZUhJcEpvaVRJZXM3UHhuR1pjSm5XTTUxSWVyZk9TTUp4WjNWUFBaM0V3UTV3?=
 =?utf-8?B?MkcxRUpDSEtraXFPMEJQdXF0UHcvMGhWNGMrQnA5MjAyZVdMOEh0aFJncVlZ?=
 =?utf-8?B?VVB6YVRKdDRyQnp1N214OUYvNFNoL2RsaE5WZUhqejRmWVc0RHY3NHU2S1pK?=
 =?utf-8?B?K2E0YmJ6VGwzUXFnVCt0UVhHYnNKMWhMYzlwRmRVanQ4VVlCemdvZm9HY0Ry?=
 =?utf-8?B?eTFvV1JJOGN4MFdOcUhkZmVXay9SUTNoai9HbFhVZ3Ayc3k4bm16N0JYMmpY?=
 =?utf-8?B?OVZoQnE1Y2JuQThtcWVCbXpZNVZrazZBeXB5OWgvbnQzOUhZbVR5TXpvYnVR?=
 =?utf-8?B?NzNLUGJ2K2hlYThHS1BZRG9OVFNNUmxhcFNuTXFFMndGQlE4SC8yNEkyRGJo?=
 =?utf-8?B?bnZLRENCNFpzK1ZvT0c5U1lQNEF6b0NrSDNCVVl2MS9LK2V0ZlQ1YmZRRWV5?=
 =?utf-8?B?dkRzWnk3dEZzMFk4ZjVZVG1BRnhlaU5RUWc0NEZ6dXNLVlQvZTgyYkJoM1RT?=
 =?utf-8?B?ZWhUVzFFdjgrcUUzNWJ3a1VpU29vNE9KM0NNSFpBUE1mMEM4bWQ0bGdJZTVr?=
 =?utf-8?B?VGlpbGlQUG9BUzJSTmtIa2FOK1NEeFFUNTVvMTBQc3VwVTJMM25NYTJjTC9K?=
 =?utf-8?B?dDN2UmxUWjE5NUFzNGpuOXJsbmRmUGh1SnlhcHVNSXVUcm4yWmVZdGNVQlJH?=
 =?utf-8?B?Qm1Ca2RMekRKbVhhWjNtZmJTVFhoaXlTOHh3R2lQcU5QeUFVMjJLUUF6ZnFj?=
 =?utf-8?B?aFR5ellUaEh1NGJSMTdkM1h3Mm9jWHZpcGl2VmVYMmhMd3NTSzFmOVNpcURC?=
 =?utf-8?B?cGFyM2Z3aWdpbE9nblB3WjRleWpHK1ZGRFFUK3liVGxZc2xYc052SkU1cWl0?=
 =?utf-8?B?bllmb3Y0Nnptc2dqMVdMN3JTYVJUVmlYK0lZYWs1Rm1nVDcwT1JEUG5ERkgr?=
 =?utf-8?B?NWd4ZmI2b1BxNHJyUUhuMmQ1elFRRmpsd2NHNFJJaGZhOE8yVjVpN1RXMm5j?=
 =?utf-8?B?Sit2MFptL2hiU1lzOXhza3pWN3Y5eUZyMFhPV2xKeTUvbW9lNWJQZWZRK0cy?=
 =?utf-8?B?TTFwcStMOUVCbllwQm1hQXd2bDV4bFU5ZDBFR3RHZ2E2MGhlam1Cb2tqN0N2?=
 =?utf-8?B?Z0pmYkNkOVBDdnJNUnBSeEVBaTg1Z2VPMldmV0xDTEJUUWVwTkNuYVJpVVBt?=
 =?utf-8?B?Rit4OXplNVVVNnQ4U1JNYlVFLzlGM1N3UDRzbmhaTTg4aFBSNzUyRDhpdzJY?=
 =?utf-8?B?U082WW5RN0R2c2h1VVZHSHhlR1hVTlVHd3dIVVJjM1RNR3E0bWdPd25SSXdT?=
 =?utf-8?B?ZWRBSTdnOEg5dDFsRXREOVdRMitRVk5ibkZvbmdSSXlJdk5KZWYzY1RNeDhy?=
 =?utf-8?B?YzBQSTl2Yzc0cG80WWQ4VFUyUEJvM2h0YWZ5RTJHT29IY3dhZ2EyZEtNb0dr?=
 =?utf-8?B?elJJVWJhMDZJOS9kbGtibWk2R1ZhZVorZEtaZXJ6M0pmSTNPMTI2bktvQ2t1?=
 =?utf-8?B?TGpTVUszRjZoK0tSODF2ZGdFNU15RzY3RnFMODRuc21kZ2JpcHE0YklsRkJw?=
 =?utf-8?B?OW9KRTVyWHFZRU00djVhZGdWWTRwZlg4OGNKY2pvZGZFN1ViUW9XMEtoUU5J?=
 =?utf-8?B?VHZVNDhCcm9ETENubjlQcmNwYjZLcDVna2hRSFBwUmUvaGpRcWU5ZW5PWmht?=
 =?utf-8?B?M2pEL0J6Qkxua1FJckFvYTljY3NTcnZhbkgxM3lwSzBvVm82MnRINlVQRStP?=
 =?utf-8?Q?pVJ1s+I6SBb6oCqCGFHn9Wrlx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7209e06a-ae8c-4a33-f836-08dcb2b8822f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 06:01:15.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Sb0oZ9C1d/PgkO5AB/PEKxcxonUVSVF8j1jPgewXc4nmzSoJRCP7B6oqrGbk6qIHCD/lbjZUK86XVyLsW/loA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

On 8/1/2024 22:38, Ma Ke wrote:
> In altr_s10_sdram_check_ecc_deps(), of_get_address() may return NULL which
> is later dereferenced. Fix this bug by adding NULL check.
> 
Only of_get_address() has been mentioned here but the patch also tries to
fix a possible NULL pointer dereference arising from of_translate_address().
Also, a some context on how this was discovered might be helpful.

> Cc: stable@vger.kernel.org
> Fixes: e1bca853dddc ("EDAC/altera: Add SDRAM ECC check for U-Boot")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/edac/altera_edac.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index fe89f5c4837f..d6bf0eebeb41 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -1086,6 +1086,7 @@ static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
>  	struct arm_smccc_res result;
>  	struct device_node *np;
>  	phys_addr_t sdram_addr;
> +	const __be32 *sdram_addrp;
>  	u32 read_reg;
>  	int ret;
>  
> @@ -1093,8 +1094,14 @@ static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
>  	if (!np)
>  		goto sdram_err;
>  
> -	sdram_addr = of_translate_address(np, of_get_address(np, 0,
> -							     NULL, NULL));
> +	sdram_addrp = of_get_address(np, 0, NULL, NULL);
> +	if (!sdram_addrp)
> +		return -EINVAL;
> +
> +	sdram_addr = of_translate_address(np, sdram_addrp);
> +	if (!sdram_addr)
> +		return -EINVAL;
> +
Will sdram_addr here ever be NULL?
IIUC, of_translate_address() will return OF_BAD_ADDR in case the translation fails.
Perhaps, a more prudent check here, if required, would be

	if (sdram_addr == OF_BAD_ADDR)

-- 
Thanks,
Avadhut Naik


