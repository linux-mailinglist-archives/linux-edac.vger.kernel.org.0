Return-Path: <linux-edac+bounces-4786-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D891CB51C59
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12915A002A7
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992C327A32;
	Wed, 10 Sep 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QlInzHdT"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E132ED2A;
	Wed, 10 Sep 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519310; cv=fail; b=Kw0EElNzWn0kYomd8yovhPpwTnoA4+UQv2A/ANSTHyShOy7Kiz2Fb6yT6gbvQlMxXZAZY4pczQ7HEeReyax4p0RsZD1XsUi9y0BHna903+hdrZfnQSpRPeofz274n3jY+gXnERnVw+mPD0XvBUTGL84cETxhDMY+gUq4AAbByVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519310; c=relaxed/simple;
	bh=l/QUvU1OaMRQCIa17IOF0Ht3yPcRF9X/i/JJX/CD1wg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RmZqX/1ArFxKR8z1zV387mw0Cclcb1YS2qBxcm1B1JgZyoxWwyfvGyrGRybPu3ZO23YfJLFd5573MEPeFVuasifO/JfmpFY6frarA1/3U7ydUr1u4FkzFW9skOPIwRqXU4ZKR9IZ6ygBLJWMze9nD2/LMaTTovi9LoJ1RvbA/Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QlInzHdT; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEYQSJv/bOt55RMEYRFqRvEW3t1AAx14TlhkICH2d/XEeB3wbPMvG+Cm5QO1hpoSXOf0rWoHCE/GoUpZUAgFkUnK7Ivn2Drdj4Gr/RBvoZe8DKPIefTNOCXsbvWwv8jj+FI4Pd0Fr596MM2Pa2qyGrOLzYHK89S/eDXk9rWSkhGxCq6k3F7/fw291960r0clMkSy0pDVdx8VA6pKzTdxirtkXK9qcwMIudBs4M05v+GZ6kzEylaWIl1X7+1T2H7urDv2nHnbE4JovTtTfR+HZbAu/Q68R9VJDE1sxPIH+U0mogCyIprmKjGFcFSawSwziPeNa5znKl1yL/wo1TDH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDP1vGTLRmBHUlC1Y/ieKfY5ubBoJNwZv0sotz4leZY=;
 b=P25b2ljwjY5TlFw48kRFa6KhsicAhX6fcBJJDw/aXeCTJp0ZGTCAgy6NCkaaSjLKN8nbzAN3+9uOMBsW4aZ7KbADvI+JmIgJIjO+hsMeC9FD/+qo84JsF9S5Z/evfOFlfkcwt2dOQqAEoMxYBUPdH6tEVrdjoE8ic/C9nt10G0bxMa2QDbqNtX6k26BnxWeg50/bkvEU1TWemFE/4VR5p2XTGJNrDLVGcyUMeSMEnfmfAbFrdkQH27xwDnFPhH1QvcXFaUs6KRlx6RH3Se0+AWE0vuu5wyntWhiSSpkDdfAogtaxVviyyQG7xD4l1p8OGHeIcj9R7gLE7VfKi6H3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDP1vGTLRmBHUlC1Y/ieKfY5ubBoJNwZv0sotz4leZY=;
 b=QlInzHdT1pyVm7auRXNbdoB1xQzv5S9j4/yRRp/dXE1xTz9TlG5okYQbYZ7X6OgIZdSaH7/BRHF8nmR7UFLzHb8KpVgfXxc6Tzttf5znOrw+8HM/LhEbx1r4rE1hM1QEZC7JI7Qy0ySJdGaUmiYtfcoUg+8hslIPHrRwb7PmW7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:48:24 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:48:24 +0000
Message-ID: <98e347a3-459e-41e4-8ad3-5dac086b6e74@amd.com>
Date: Wed, 10 Sep 2025 10:48:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] EDAC/amd64: Remove NUM_CONTROLLERS macro
To: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-3-avadhut.naik@amd.com>
 <20250910150525.GE11602@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250910150525.GE11602@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: bae6c62e-cc8c-43a5-e919-08ddf08179db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vi9qOUJVV1pjRXlDY0dVNGpaZDJDV29qYk1QcC92VFIyMndVa0drdUlmelBs?=
 =?utf-8?B?aXpzZVIzc3RmaWJaV29zYjE3S3pqblZBUjA2bTJDZE0vNHgzSFNtTFNyWW83?=
 =?utf-8?B?S1lzTW5SR3lCRVlKbjV4anhvdzZVb0trOHJCT0krV1M1aU9sbXN0MnlucnlC?=
 =?utf-8?B?VUIrL29qTjh6TXh6MEpEczRmYWJVTHRrMGJvZzgvRENVUkZKMFZyNTNYbVlW?=
 =?utf-8?B?WFNRRmZtOVhZMEtrVXJOamdmc2hVYWtYUTIxRFNxMmtoMkg4YUtrT0NmSnRC?=
 =?utf-8?B?akpkdVVZR1hWT1E2dWdwaGczQWpzd1RBMW9sVkFHLzdsYzdEdlFGUzBnbTg0?=
 =?utf-8?B?TFQvelo1dkZ6T1dNZityM3YvOGpoNDZ6Vnp5cGVjS1lKbVJ5djhTeTl2OThQ?=
 =?utf-8?B?dDRHOWtOZjVFRXA3R0tOempqK1YzVjJ2bzFBbjZxcXdtZlhRdmhFN2p4b3NJ?=
 =?utf-8?B?WDFPUjRtSUU5SGt4cmVwY0MzRWdOUFN1VDNlR29uZDhlL3NJYUJRZnVSWWw1?=
 =?utf-8?B?RS8ySVU1WW9yT0hFaFRZcEZleEZVTnowYkFwaEtxVno3Rmx5UTY1Qy9QMHo5?=
 =?utf-8?B?RTIyblozZlBFemVhVlJBVmduODRteDhqbzEvR3B4enVHZU42WThtVEY2QTQx?=
 =?utf-8?B?aWJSYS80SjhiSGt0RUFlOXczajR3dXN3R05yZmNOc3hhOWFXVnlvMWgxc1Bo?=
 =?utf-8?B?b05tMnNLb1B5T3VQT2ZkM3ZlRVZHejVaTGd6T09KSTFML0VMbHBHWGF2Q3Az?=
 =?utf-8?B?NzdlbEhQcFlSUzVibUtsaTFUR1JudE4yUzBtSUNJZE9xd0pNRDBLWUdPYnFv?=
 =?utf-8?B?SGg1Z3lhQzgwZ2pobGsrYTJ0cVZZYWRzTVhnMG1yTjZFdmIwWkJUNzl0R3V3?=
 =?utf-8?B?dGlIV1pEYmJTVkp1OC9sUHQ5N08zb2NFMThYZjRjZXNwWG9WNVpLWkF5WmpK?=
 =?utf-8?B?Y2daZXQxVFBOTHRBQm1iY2FTbkxrWUJ3VVZDcHlsOFVpQTk3OTNRNzBlVkJS?=
 =?utf-8?B?SGgyeExkUWh0S3lxblRpL09QeGtIRjhtSjJLNThKS3hFRGRQZXBIclBhYm4x?=
 =?utf-8?B?ektiQ3lKUEpzN0lYMzdTN1ZTdXFUQnpKMENaNCtXVkUrWWVRWTduVHYwV1FB?=
 =?utf-8?B?OWovQUpRS2pNeVlMK3pzQ2xvcXZGS3F2Sm41UFVGRUdJM2lJVDdwTUtqN0Mx?=
 =?utf-8?B?Vlg4aDBBRjlQZlJ0NVlwUDEvZStSQzFkY3FGZXBvNytFWS8rWVhHd21YU29J?=
 =?utf-8?B?NUpsY2NzbzdicW9YSlFTNi9LSEVSZlBCWnhGelY0cXhxSkVYS2VwREFxRTNB?=
 =?utf-8?B?YndPRytMaEYyeVcxZmVvTnlmbWIxOVRDQnZqMmJuWEpwSUZneEM1S3NKOFcr?=
 =?utf-8?B?M3VBV3RXdXRLNjJCZWJBY2RMMUw1ckd0dVBRWEQ4Qm1UNWdHRHJxN2NKbFBW?=
 =?utf-8?B?bk9GQTFhTXgzd21jWU51Y1lDeTdhVXpSQUU3aDg0WnUzeDJVK2wwYnZ1a29T?=
 =?utf-8?B?Yi9SN2JjQ0RjQ24xWEluditBN00zcXpidHh1aytwUVUxamQ4bFkvbnhyd1Ux?=
 =?utf-8?B?QXMrRXY5cUN1ZG5zK3dVQncwbEVqZWlPMG8zN3QrWTNDYlUxUk1sWDE1NlQ5?=
 =?utf-8?B?QnMxcitjMG9ObGIxZDk4VGlJOVg1ZnNJcjZVVmthd3pCMFRDSTIvVXVMT3VZ?=
 =?utf-8?B?aW9FQk9zaER5NUx0SzN5SDNyMVBjVklMcXlLRUYwMG9QTVp0WEo2eG1tbVlt?=
 =?utf-8?B?UEtXV09ORDcyQ1JmQjNqMkovWHk2Yi9vWGx5SmQ0OWlnZDg4cjAxeFBlVzdj?=
 =?utf-8?B?ajhZTGpMMlFVODdxZ05PUlR1YTFHRzc0U3NJVzJPQlZiMHZNcXdlMjNJMjh0?=
 =?utf-8?B?VTVueUIvdGhZOC9JTVo0YitZVDdGYi9ZT0M2N2ZDelBMZlBFU0lHVUptbEVp?=
 =?utf-8?Q?L0j/ZBM026U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tmszb3NONE5LcFpETXdrYlllS2o4b3ZtOVFmdnFUaFgybGhwbkhULytQNjcy?=
 =?utf-8?B?ZGJzU0FpeWZ0K1NLOUxiU2pvcTUwZk0vaGwwaDBWK1hiOHhiTEhuOTdZM3Vs?=
 =?utf-8?B?Unp3amlzeDdqckFLZFFMZnJXcy9EUFpqRmZGb3NQWkVicnRScUhQclRGdXRR?=
 =?utf-8?B?YTEwL1czbmxtZDVkbXpFdDNINHBmTkhRdllJT3ZVTGplQktzT0E1b3VheUFI?=
 =?utf-8?B?YWc1emNhMEEwUTVuS3I0VU4vb2xIelM5MHBTVnF0ZWtxdytGdnhRcXlvMHAv?=
 =?utf-8?B?b0ovbk02ZzJsdGxZSkE1UDdVOVIxc3pDeVI0UGp5dlRvVW1YaU9qYjIxbDQ1?=
 =?utf-8?B?QVRBY3d4SEpRM0p4YVQyUHp6K2ltMk5UV0xONURTYitSemRFK1htbTRqbWJB?=
 =?utf-8?B?MEhOOFgzSHVGRXNUZ3F2TmIxQ1laM1drbjVaSms2NGdRcEtwU0ZVUmE2Mnlv?=
 =?utf-8?B?RWJxTzBCelhzMm1zNnFTTmcvVUZYU1FBYzdJSjFoQ3pMVmszc2xpNFZIaDhl?=
 =?utf-8?B?VVVlZFJ0NXo0S3dmUXNaa3BDZ0hmckFWV0dieElsclVNSjZQK0ZuWU8rV2xE?=
 =?utf-8?B?UTMxNWdsVWtLdHltSEllY2FFaU54aDk4WUMrZ1Z1dUxrRXE0SEQydEtSS2tm?=
 =?utf-8?B?T1I4Vk8xY2pxZHNPL0hHd0p1SzRqQ2pqY2FTbHlScnEyNDVLY2xIRGtKVUgv?=
 =?utf-8?B?dGQ4MzkzRDU4S1BmVi85Njk3TFdPVFVtelV6RnRDM253RUNZN2JuaGRiZ3J4?=
 =?utf-8?B?dC9XUlZHemxVZW92N1NTcVIvaDhQV1NzTzluOGdBS1Jpdk5aQks0Wng1RXdK?=
 =?utf-8?B?RFdHbWpOL0ViVTdJSS93K3Bnd0FZR0hkQ3krREtMZExHT2NRREs5cnZYaWtJ?=
 =?utf-8?B?d1NlTHhHZzM0OUxsL2Z0OFM3a0VDbFNwZ09LcXk3NUd0QkNwWmw5ZHJ2MHhm?=
 =?utf-8?B?dnR2Wk9ueDQyNGVEOXFxVG1pSUI5TVBhNGsxK3pyeHNNNWdFdmM1dVNxVXIw?=
 =?utf-8?B?azlxY3Z3REN5Ky8wRlVpbSsrTWRNcjM0d0N4ZWRoekkxTmRmOVpIYndNNXUz?=
 =?utf-8?B?RFNXV3Boa2ZUUkIzQTRnWmdRdzgrVkZSYUZBUDl3SFBQVlhqRDVaYTdhc1E5?=
 =?utf-8?B?dHU2TnMwaHRvS2prWUw0bEtsYmpna2dNYU1jbEVnV3BzeHQyY1piWVlSWGNN?=
 =?utf-8?B?NW1jdDlDMmIyR2FpWmF6bElNaEV1SnV3bEw0UFRJbE44VEl0eDFESHdjdW5o?=
 =?utf-8?B?cWp6bHFybkljcExnTTVJSVcrZDRGYjF2eWl4UDN6dnF0L0daVWpmTEwzdlE1?=
 =?utf-8?B?OGVwR0xVc1FVV2RVVklWZ2VLalhGSVE4UW5yOWxzRUVZcTU0R3h1N3VqUWxT?=
 =?utf-8?B?Q3FZalBEQjh5dEswSWZZUG9obXg1bHV6MDRWcEc2VlUwbXgzK2dPUzRBdURY?=
 =?utf-8?B?ZGpXS05ub3FBVEJYRGdkZ3l1SUdVMTNaV01lY2Z2bGJ6N2MvS243UnhhM3hv?=
 =?utf-8?B?d2sweTlxRWh5d1JWeUtvZ2xuUXpSSUdrSUJQSlN5ZjRQR0Yvbk9oaFg0dG5K?=
 =?utf-8?B?YnZ6WE50ZUJpdytaSWFWZ0RJMkVLTUlKS3Ixd0ZsRTEvQi9HUk5IbTc0S0R1?=
 =?utf-8?B?WWliZ003Y2dydVBUNFFrZHlHQUVRK1A2SmZINldLZDNEeXQ4Zk1UaENKeURY?=
 =?utf-8?B?RFlXdjg5QWJNQllmazM1MEg1V2N0dWdLOFltN1lMbjFxaFFLeFRjR09qcEo1?=
 =?utf-8?B?eEJNeENJR1IzRnpHeU1uK3RJWWVOK3gxQ2dLQzl4MktHK2dLb0pPWFo1L29F?=
 =?utf-8?B?SktBVFhMaUlmclhENkFTcFNxZUdjTzY0WXBpRDZENkFKcmVJWEpTSS9qTnZy?=
 =?utf-8?B?eFFwY082bFVDbndyVFVudmJidklNdUZlTWhpaXJkRWwzUzV1cWFvaWVsbDA4?=
 =?utf-8?B?ZGk4WDFCdUhkVzNJc0o5VHY3ZHlHS0RGT0dSeUs1YVczNFRhclJKYjFnamhN?=
 =?utf-8?B?ZFphOVJyWHJXWkNsVXl5MnBrdXlpSkZnSFNrOHB2aDJFOTBWQUcwNUZZeWRs?=
 =?utf-8?B?UHcyQURvTCtXNjhzaEpmVGR4UHVGajg4N2ZUVk56R3ZYS2dJdWxaVHgvWjdp?=
 =?utf-8?Q?+m63VoRak1AjwpdowGQHDK72f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae6c62e-cc8c-43a5-e919-08ddf08179db
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:48:24.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwelZrHBHHAuuS7RAx8mARgXUeIQu3BmCO5aqh9cyGwiws7r5XIU1A+OxppzFVX6RuhPheoSxx5dMzEWdTxovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241



On 9/10/2025 10:05, Yazen Ghannam wrote:
> On Tue, Sep 09, 2025 at 06:53:11PM +0000, Avadhut Naik wrote:
>> Currently, the NUM_CONTROLLERS macro is only used to statically allocate
>> the csels array of struct chip_select in struct amd64_pvt.
>>
>> The size of this array, however, will never exceed the number of UMCs on
>> the SOC. Since, max_mcs variable in struct amd64_pvt already stores the
>> number of UMCs on the SOC, the macro can be removed and the static array
>> can be dynamically allocated instead.
> 
> You should note that max_mcs and the csels array are also used in legacy
> systems with 'DCTs'.
> 
> Those had a max of 2 controllers which we already set in
> per_family_init() as the global default. So the legacy systems are
> covered by this change too.
> 
> Without noting this, it seems like that case may be overlooked.
> 
Will mention this in the commit message!

>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>> Changes in v3:
>> Patch introduced.
>> ---
>>  drivers/edac/amd64_edac.c | 19 +++++++++++++------
>>  drivers/edac/amd64_edac.h |  5 ++---
>>  2 files changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 3989794e4f29..0fade110c3fb 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -4000,30 +4000,34 @@ static int probe_one_instance(unsigned int nid)
>>  	if (ret < 0)
>>  		goto err_enable;
>>  
>> +	pvt->csels = kcalloc(pvt->max_mcs, sizeof(*pvt->csels), GFP_KERNEL);
>> +	if (!pvt->csels)
>> +		goto err_enable;
>> +
> 
> You can move this allocation to the end of per_family_init(). That's
> where we determine 'max_mcs'.
> 
> If you do so, then the 'goto' changes below are not needed.
> 
> Another option is to put it in hw_info_get() like we do for UMCs. But
> that means adding the allocation to three different helper functions
> rather than just the one with per_family_init().
> 

Had considered moving allocation to per_family_init() while sending
this set. But then didn't since I had stated that I would be adding
this allocation in probe_one_instance().
In any case, will move it to per_family_init().

>>  	ret = pvt->ops->hw_info_get(pvt);
>>  	if (ret < 0)
>> -		goto err_enable;
>> +		goto err_csels;
>>  
>>  	ret = 0;
>>  	if (!instance_has_memory(pvt)) {
>>  		amd64_info("Node %d: No DIMMs detected.\n", nid);
>> -		goto err_enable;
>> +		goto err_csels;
>>  	}
>>  
>>  	if (!pvt->ops->ecc_enabled(pvt)) {
>>  		ret = -ENODEV;
>>  
>>  		if (!ecc_enable_override)
>> -			goto err_enable;
>> +			goto err_csels;
>>  
>>  		if (boot_cpu_data.x86 >= 0x17) {
>>  			amd64_warn("Forcing ECC on is not recommended on newer systems. Please enable ECC in BIOS.");
>> -			goto err_enable;
>> +			goto err_csels;
>>  		} else
>>  			amd64_warn("Forcing ECC on!\n");
>>  
>>  		if (!enable_ecc_error_reporting(s, nid, F3))
>> -			goto err_enable;
>> +			goto err_csels;
>>  	}
>>  
>>  	ret = init_one_instance(pvt);
>> @@ -4033,7 +4037,7 @@ static int probe_one_instance(unsigned int nid)
>>  		if (boot_cpu_data.x86 < 0x17)
>>  			restore_ecc_error_reporting(s, nid, F3);
>>  
>> -		goto err_enable;
>> +		goto err_csels;
>>  	}
>>  
>>  	amd64_info("%s detected (node %d).\n", pvt->ctl_name, pvt->mc_node_id);
>> @@ -4043,6 +4047,8 @@ static int probe_one_instance(unsigned int nid)
>>  
>>  	return ret;
>>  
>> +err_csels:
>> +	kfree(pvt->csels);
> 
> This can go in hw_info_put(). We have kfree(pvt->umc) there already.
> 
Okay. Will move it to hw_info_put().

-- 
Thanks,
Avadhut Naik


