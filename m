Return-Path: <linux-edac+bounces-5047-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDE4BDABF1
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 19:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8906619240DF
	for <lists+linux-edac@lfdr.de>; Tue, 14 Oct 2025 17:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB753009F7;
	Tue, 14 Oct 2025 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0eyP7rm6"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAAB23D7D3;
	Tue, 14 Oct 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462023; cv=fail; b=F3B27kxes6q3Yq9yFSk4g6XKRDbX2ha2f+2ARZmzky40IjJhmCj6Ba7V3A3829KZCkyOv4Kuhi7FAaeHuLcuHhZqen3lxDWoA32ZFNNI55idgmoFid3ZxkfrZUhJtDxMNyooPAnwCcWSihhsQLVP7zTE5e2gSWce4O0qIdQPqoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462023; c=relaxed/simple;
	bh=149aufJ14pXuxoLK9kqVfmg3schf/pucGrn0yuk4D9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Md1S0NOjuxGzQML5vkUJn20bF82xvb4Kc+h4MSoU7Q6nAadumq56pPvVs/BXAQBMOGZnX8s3gPY9ushecLH9WpjIBN1I+MlP1XrNZpFpLQpeqG3reHpDFrpi5BRttYLcExgrGpY159SJ4/8d4sI6STCnv15GxGL8MaaEb22uDrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0eyP7rm6; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkwN4M+jHQbiIKutco+Zv1x0/bhEDb8Yx65qqXkyY8NgwsUP+iioFu3o5Vaf5BW9h7sMtO8FV5DP6Bwm0LP9ZWsPBYf/pznEDFZ/lAizAslY+LBTffxBLUoGt4JKWsOtYV5osgj5DL+3zE8yAG+tPprWQabjOI7+dHZjRGlBYVH8ZH9F+JtouH5r6ripk+M3YweD+85M8Tg157X+xmtTNPyoZ1EyM+ny1rq/XcB4v73L+wWvOPpIeokbXPTTM62WrO05xpgUOHz4xCoOHznkuPIJjSVD2tEQnx2v6xSrs65I8ExebQDaFEmNTy4W9VPwteiPQuQOJeXEWNEDxtnwww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbwI/zoZgPgweWNX5QXTyyII8pCpxj/stFMO8M+mQgE=;
 b=mPR8y5In0tVZ3czKf2z7Oyvd8rqufz4DAg82vUX9rrwDc4zn6ki4gVyIPH2F9MhNhICXbIJzzRvGNkpoAOz9US1MvSI2sVgrd+muRz13xuPNB4FnU2EDxhmojdHy2BiIiwcOX+rVxOKKcp9sGJFTxh6fEW2mm+EFb1vQucnc14USruJdH+3WYz7/aZeGFuoRIc2vaSIJxh55tFyFSigrXump9QtO3ChLQnpIJVX5/8PFj0X7C4mQPB9XdHxwpwqDoBeNlmFwU6HxB1jxlEy5eiThA5S7RfTm7Fr34ZOglMe48rOVuqMBEHh6uwcv7L6+XC4RBe5dUb/MM+A+0FSGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbwI/zoZgPgweWNX5QXTyyII8pCpxj/stFMO8M+mQgE=;
 b=0eyP7rm66Xn65eS648a3BlSOGp0IYYrlXB9YRhihwepv4xo5EPd/Em2EsjtSWc8xtbNq+1cHLOW5jmnoqyB114A0tdiSUpRSmEMK/71hGI5IIMW0qKGku09MNXxJ87/EnqGVyjECOvebQyAaWiNsJYBiZPJt9ZkVaJ3rpjfquXo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 17:13:39 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 17:13:38 +0000
Message-ID: <e78b6556-24c0-469b-81d5-98380aee1f6b@amd.com>
Date: Tue, 14 Oct 2025 12:13:36 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 0/2] Incorporate DRAM address in EDAC messages
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-edac@vger.kernel.org,
 john.allen@amd.com, linux-kernel@vger.kernel.org,
 Yazen Ghannam <yazen.ghannam@amd.com>
References: <20251013193726.2221539-1-avadhut.naik@amd.com>
 <20251013220019.GFaO12cwSvbedQwGr6@fat_crate.local>
 <20251014135206.GA361227@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20251014135206.GA361227@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0116.namprd07.prod.outlook.com
 (2603:10b6:4:ae::45) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 054113ca-2dff-4433-e91b-08de0b45041d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3N4L2k4d1VjMVIvK2dobDY4eTFEQzJ1WEFWUzdLSmt0MzlwbDlKekwwa3F3?=
 =?utf-8?B?L2tmOXZlMlBQWW9aRFhyaWxkWDBpY3RSeTlXNFpWL3RFeWt6ZGZodTFGbnRI?=
 =?utf-8?B?RkZPWlBhb2FNRmNpVmo0UFVQNWhMMVJ1a29IUnV4K0xNOXh4dEhHM0xvS1pI?=
 =?utf-8?B?OVMzVnJqTnpHcFAwRVBVbXIzSFlkeDBlZm9scjN6OVd6bm84S29BNU5aSmx0?=
 =?utf-8?B?TTJNZGVuTFBXSjhyREdpYXVTT1lQeEVVaWtCVVlQWXA2ZExZbUtra0pxTUIw?=
 =?utf-8?B?WU9YKzNudWp3ek81em5sTUxKWGpvUm0wMS8vNjlNdDlWSlY0TGhrMmFUOCtF?=
 =?utf-8?B?a3NjaE0zaWszZ3dwVmNqWlQwZVdISDdIdFpsOVZDMnZkQUZsUE1jcE81YlMx?=
 =?utf-8?B?V01VR3pJeGxFRzFZcXlTc3VWeEVydXVCak5FdjhBd1gxUzg3aDRxcUtnMUd6?=
 =?utf-8?B?bUZ6MitYeHYvOWMwOTA2RHRXbVNqQThZSXJxcE5pZzkxRm1sLzM5aEZLdjV1?=
 =?utf-8?B?b3F1MS9LRW9vVUJBeTkvRER3c3pacFhKR1lieHF5U0oveDg2QUNCN05NSHBW?=
 =?utf-8?B?NHhPSE5sTk8yNFBIYXFTWnRBeUUzTEMyY3cxZUJWcVgxOVZUL0I3MEZEVjhX?=
 =?utf-8?B?V004Q2xzVDBPUWFFYnZFeE5ZMFFaT2x2bC9Ybm9QeHRYd1pBa2RZTHJsTWk0?=
 =?utf-8?B?K2dpUmZLSHEwcUJuTlNCbEpRL0xqcFJkdUNrZldDbFJTUVhvT2hzMUptQjFa?=
 =?utf-8?B?WGdTL0tsN0Z6T3ZGdWRyZVR3SWRDZW1Xa3VHcVZZY3ByMDAzOUlnWW9kYmJ5?=
 =?utf-8?B?Q1djeGdFNFJvRnJ5N3pSdkQ1N3ArdXdnRlYwVnJEdm9JbXQ5UWVrYTlXQmlj?=
 =?utf-8?B?OFliekZWRGYwS3MzWmlWV29wVzNiTjFub1AvajRNMzlYNjlRVEdNd3pYaDY3?=
 =?utf-8?B?MS9sVWJpSmljSzg5UEdTKzhZOUZtK0tzdXhHM3lWcGJWNmtaSlhpRTlJWm9p?=
 =?utf-8?B?bGRWaVVzNTJ0Ump1UmJUVjZtdGlobmNVbzZxMllqUlJlZGlLMWo5a3B5Mjkz?=
 =?utf-8?B?VmNhQnV2MEFkMFpyZVA1a1Y0QmtSTkF1SXhyVHRsV0hZMFVUcElYd0gxRSsr?=
 =?utf-8?B?bVRBUysrYWpRVzFxZWhvb0UydkpScmJjcEpFR0doeVNEazY4Z3hIVmZEMURB?=
 =?utf-8?B?WktiNThzY3RVL2tvU1NvMVVuaUpBYlJHcldtNlBRRXB0YXRzNkI2Wmx5S2hD?=
 =?utf-8?B?SUdMOHVlaFY2eFY4V0l0ajlzcTB4dXk2YWIrQnMvRTkyQjFZZGdGSDNWR3gw?=
 =?utf-8?B?VGRuU1hhTTR3VWFnVkt1US92a0VYOFdhWnkvL0J2dkpkN3VlZkJOMkZlR3ov?=
 =?utf-8?B?TitFWnlEOTFieVM4QnRDd3dwR294VHRjbkYxMkR2MXFlMU9OaGhvQnYrSVA4?=
 =?utf-8?B?elFRVFZXOGxnZ3hFbWZZbFdTNWloWFRJWmxBOHNHNmROVGJHc3ZoOG4xR3Ri?=
 =?utf-8?B?SkVaOWZ4eWpzY0ZaQjZXbmc2UWF4MXY0a1NYRlgvcXFsUHR1S3NLSFRFYkRi?=
 =?utf-8?B?VkUxRStTMWU2QU4xRTRSSGxuQ3VUVnhHOTBqYWQxb2d6YVFZYVdxSXh1bnpV?=
 =?utf-8?B?bWdhSlFGdEM5dEhROW0xaTgxTnhoNmZVOGVjbWlwWEk3WWlvaWFwOC9zZmZT?=
 =?utf-8?B?TjdrZFdmeVJFMnRlVU9RT0NQWkJ3eFhJdUIwcUgvRk90bGM4UEtoYnk1MUg5?=
 =?utf-8?B?SGxMWEdmZnlYa2RuVmRhMmYycW10RU96dlZnOXhFMkJnYWFaYmZBOFpyOWVz?=
 =?utf-8?B?bjg0WU5iZ1FFUjljekZRd0lEUjRlT3FWbyswdVBiQ0RvUVdrcXd1WE54ZWh2?=
 =?utf-8?B?R3Zlc2dyVEdlbnNWTXNZZ2dvNThnNGdiNmZSaklaaTJWQXc0Njg3UHZPS3NK?=
 =?utf-8?Q?b/qMDx2ub+vjUNwajo4iCgBFKEwzAyur?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGxsalRvVHQ1QnpXMnEwTmlLc3hXbFRBRGpGSFRxektxM2NTcURGTVE0NjhQ?=
 =?utf-8?B?N3NmYWFzT2VkQ3hNcUttOE9CTEFUTWJnNU9nb2xBV05xaUZyT1N4ODhjcnZq?=
 =?utf-8?B?MmhRSDllVEVPV1JQVW9qcmdrK3dsMmoxSklVN2QxWHIrVzEwTUpubldGWmZQ?=
 =?utf-8?B?L0VGeGtjbkxILzAyT1pYU1VnMUFhK1NYVHVPZ1JQTTU1c2FzQU5xcGVqQjdD?=
 =?utf-8?B?VEVqOGphWTZySE4vZEwzK3Q0d2xzZ0ZqOVNodHNlNmdlOHV6cU5aWU9lKzRk?=
 =?utf-8?B?UDJybFVXK3ZFODFpU2xkVFZnR0JnODRsRXpkeEM4eWp4UjVMVUVUQlZtUlRw?=
 =?utf-8?B?K2NQL2VoTDY2UGJLUmFvTDNDTmNRN2hkVDBrNGdRS0FaVzJSc3IwcE0vbWQ0?=
 =?utf-8?B?V3ZqaGpxUlFuRUVXWGZUQU1xTnU4RUREVVRJVXJxeDJ2WGJVTEZ5ZFVZVlpW?=
 =?utf-8?B?aFVJaSthaWtlK08zYytzSjdVQmVWWDFHR3FrTUhDRHZCOXhxWGIwTVN2ZUQx?=
 =?utf-8?B?Z2tIQXN5eitGRURuTXRIQnJZNm5FR1JwVFRWMEd6UGdVTzZTRjRrVEp6ekJN?=
 =?utf-8?B?bm84Q1FXUUhFTE5HMDM2YUYxL1YyZUZOM0RyYXN0SWpnNWVEMFg0TDIyd3F1?=
 =?utf-8?B?ZkVROE1HV040ZDJBdmV1R3RpOTJQa01QUVJLcDdQenRLejRGU3o4c0Vpa0ZZ?=
 =?utf-8?B?UFplR2F4cWNWcDdQclQ4VkFBRE9OOUdMQkVNTlpIMHFURVY1dEJ3SkJ5bXo1?=
 =?utf-8?B?TG1jUnFqbWVuNHBqVUwyMWovbWl2WDliVUo1ci9SbGtYL0QxV1dtRk4zS3hS?=
 =?utf-8?B?anVDNXp4K0E1MXV0Q094QUw4enBHRmxaYUJLSU5qVmFSRHg5S1czTEJuZHFy?=
 =?utf-8?B?VUxzMkx2azdFR3loNk9GQjJKd0I2YnFlUDgxcDB2Tlh4TTNwaEVwQUVUWEdu?=
 =?utf-8?B?b3lGaUNrbldxc2Z4bW9mckFBVUl0MVJFZFFORjJXeHdjcm0rRUxBOEJ2NEFx?=
 =?utf-8?B?bWs4SCsyNENZZ2txbGhqM096SDA2MjlHVEM5Vk9PQytoMWNMdThuS0RFUVNP?=
 =?utf-8?B?Nnk1aVJrbjdyZldwS04vOWF4eDR5OUIyWkJMeEJ2RGZtQlJQTnphVDNGNC9k?=
 =?utf-8?B?emJCM2VOeldNS3pMZmpOeVZvTDREV28vdk9QczlBTElEdG80M3BiVnRkTnRl?=
 =?utf-8?B?VVkxbE9lOUhTQkJiaVVYQU9RbzlTdEJoeUUwd0pWL21xWWZqOEJ6OStGeWFL?=
 =?utf-8?B?SHgzaTVkZFZCTHFmVHo3eDcvY2FEUWw5K0hVOGdqbkdYWHJ3c2JxZVZoV1l0?=
 =?utf-8?B?WVIwSHI0ZGtLREFZSWFiTXVoY2V4RkpyazN5eTJZbDdZeGNOeHFGaTZqaFZB?=
 =?utf-8?B?dWdlaFQycWVCbXNrQjNMOFZPMTJsdG5VSDM3Z3owSFBRU3NGZG16MCs4VWFL?=
 =?utf-8?B?L2xNbkhkMmZwSlRtcXJyQ0xMWlhnWXBjOHZPOGpHTXZrMzNXRE96RHM0RWJp?=
 =?utf-8?B?N0ZEeElMQlgyWUxRaXpGWXdtN3N5dFpsKzdXcmttWFFtcGpJdFJSdmtCZUhO?=
 =?utf-8?B?UGREUWFITEtBbis1cXZ4VVg4WUdGQ00vbVZqMmZpU2FMMStkK0hycVlrbm9O?=
 =?utf-8?B?L2tSMXNsK200S0pjeDhxaURjOG1tRmJCOVJNYkUwOUpTSGxMRnVab2dOVXdJ?=
 =?utf-8?B?aUVKTEZoeGFJKzNQRC9oQ01jN1lIK2l0Q0RoWGdMNFZZSE15TWRaUTdwRVJm?=
 =?utf-8?B?Zmdza3Bhdk9ESXJDMjVEYzZyanQ1VC9XeWRScmlWeU5KRUtSakpKa1YzbXI5?=
 =?utf-8?B?WEUwM2RxRUdzengyWXE4NDIrbWxUNEhLYWxZbjdDWDFDQ2ZoNGpyUFZZZ3E0?=
 =?utf-8?B?Z2tDZkVFSUxzNFI3M2dZeWhZcEFJeGR0TTczeHl2UnlvUnVkZDNNNzZyMTFW?=
 =?utf-8?B?NWwxd3JkSEtQaE5ZaUxka3BpRFUxV25FVkNYMnRwclpqWERXMTNEMG5iOEJG?=
 =?utf-8?B?VmIxb284ZzV0MWx1MWY0dm81MVhXUUU4Q0FrM0pLc3pyam1qK3crdVlNak9u?=
 =?utf-8?B?VkJEL3lXTHhLVDY3MEEvK1BVdlovM2tIakRwY1ZzdVFUNXIvbFRyU0VtSVJM?=
 =?utf-8?Q?EEeytfjb3nXrrx22Uk4r2SLzP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054113ca-2dff-4433-e91b-08de0b45041d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 17:13:38.5622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3fbmRy0QxbBUQ6qKnbtuzlEp87WAtIDlEJgDFjjliMCuieYTPTPYr8CMhLET9tJWOwYZBp8GYoVi56GVb8rDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817



On 10/14/2025 08:52, Yazen Ghannam wrote:
> On Tue, Oct 14, 2025 at 12:00:19AM +0200, Borislav Petkov wrote:
>> On Mon, Oct 13, 2025 at 07:34:47PM +0000, Avadhut Naik wrote:
>>> Currently, the amd64_edac module only provides UMC normalized and system
>>> physical address when a DRAM ECC error occurs. DRAM Address is neither
>>> logged nor exported through tracepoint.
>>>
>>> Modern AMD SOCs provide UEFI PRM module that implements various address
>>> translation PRM handlers. These PRM handlers can be leveraged to convert
>>> UMC normalized address into DRAM address at runtime on occurrence of a
>>> DRAM ECC error. This translated DRAM address can then be logged and
>>> exported through tracepoints.
>>
>> And?
>>
>> I read all three commit messages to figure out *why* those DRAM addresses want
>> to be logged. But it seems they don't want to be logged. Because there's not
>> a single reason why they should be, AFAICT. Without a proper justification,
>> this looks like a bunch of unnecessary code to me...
>>
> 
> Good point. I overlooked this myself.
> 
> The "DRAM address" helps memory vendors analyze failures. System
> builders want to collect this data and pass it along to the memory
> vendors. The DRAM address is not contained in architectural data like
> MCA info, and getting the address from MCA requires using additional
> system-specific hardware info. It's much more reliable to get the DRAM
> address from the system with the error rather than try to post-process
> it later.
> 
Adding to what Yazen mentioned, the algorithm employed for translating
physical or normalized address into DRAM Address is somewhat complex.
As such, user space tools might not incorporate the support required
for translation.
Having DRAM Address as part of kernel messages and tracepoints ensures
that any memory error related information is not skipped.

Does this alleviate your concerns?
If yes, will add this information to commit messages and resend.

> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


