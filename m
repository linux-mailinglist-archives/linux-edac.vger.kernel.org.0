Return-Path: <linux-edac+bounces-4785-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F9FB51BA8
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66D67B1DA3
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741928C2D2;
	Wed, 10 Sep 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KmQydqzJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453545464E;
	Wed, 10 Sep 2025 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518197; cv=fail; b=FZFY9VHjWKQt7sqs5JB4MTaD/8mTgZaEjI0LrOiZjMeVgou6lYEbL0MAJNuq1HUxoJVfB8hRzMUJpiWc7ltGQfs1IOBza2RNkKbKCbgpxNvlMsb+qeZy9CrGq4nITHkZgIvusVDfAm/SI2f+j8695/8O/mhWJDJfaEMPdSEduR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518197; c=relaxed/simple;
	bh=BLFC9AfI7q58Z9bPkN68+09QGGPf7wcWVbA5yFHTldc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LDYjWX7CYEsn53tyVWkNxRDsq0eE5uNSN61L9mgDCm6zPBdowJTUGat8ppgYw0WPQhJwlY65n9/IvDGfkBochr4tzQCEackPym/0hfAljRxTyJgOOjCwXyOFR3pmGBwS+uXKdRuN+hyr42fTKEKEfVGqoujong7y6FYgaz2JEL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KmQydqzJ; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syDFuGJcj94gOKNugv+aUHXpvVuegswPdI/8+iEKZI5SOV3Z0xqqNj/oCUVPhGezXDjR1pemOYClGDGLjak17wEAxBaak5eTkUQhA5wqdBK7LK/XFvz8les2juc+qS3fisy3vGsm1dOtHiSSd+zxIZ/cHF0FHOy5hU2cbzxwJgmpiTvpQCnJwX7KA5vEl6OBSFsvgXLmz2GVE0hCKLkkRQ0S0e+RubWrB9HPPlRdROFeyIYEWzZMagjcQWwqvRgMjDsgRTHLY+0QocboC8TAlBx5SBAr3IuPa1kdZCwp9Pw0S048ksy/NX4TDMjfoQKqCXk0H+KrCA59/d362GAm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buurZa1+vi1bnUrqFF5xC51391ABRVJwdNEMMShX3RE=;
 b=r6lxGd2d8lWqAZAqLNgD/Lc4pqmn1rNOyHYfdJJ7Yo+qd7cQEfrz/ZRwZKwFjxTt7CXn/46gsdTtCmyZdgzyISuOkvml/noFh0TQv+CmbmQWCzQN0TA3v6uKmzdq32/ciK3U6RF8AMCfvpk16gqQ4orPK1s7UaILqPfSEGhzKT0kUZy1NI6LeL4B9GjgkAW44ijDsifpaTbZgzNeujlkph5XXsPFw9ZzOFGeH46kto9bkAhtNlGoirDKo6IQCJLQuqUhL2F2gRC7khPfFO+NT4Qf8PkxZHM+kLQFzvIfY0n6AlE2LrW1Zo/u9BMPXBoSxaPsM02hWnFWTYclrF4gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buurZa1+vi1bnUrqFF5xC51391ABRVJwdNEMMShX3RE=;
 b=KmQydqzJxIUuFLmXFPIhD5dM5/6xXKjzIMqoZW131CaesAYv/7nMHeGJnhdcigfB/jiO9TKRZqzOMDRns1yiMnBH5DvXPQR6dn3ekB/QJQOzjThbcJ2Y3oCLT6HwRnt7gmebS4NISJnQTUB7PoWQckm+2MSxvYmtMI304ej8CLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:29:53 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:29:53 +0000
Message-ID: <e1702c62-57ea-47cb-8555-fe1614572b03@amd.com>
Date: Wed, 10 Sep 2025 10:29:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] EDAC/mc_sysfs: Increase legacy channel support to
 16
To: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
 <20250909185748.1621098-5-avadhut.naik@amd.com>
 <20250910151713.GG11602@yaz-khff2.amd.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20250910151713.GG11602@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:806:21::35) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2abf3e-9ef6-4c7d-0510-08ddf07ee3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amh6eHRlRFRENUpmWjBKM0g4NHNJeTFQeVZ3ZmFZdndGVFNxNFJ3YndmRmRz?=
 =?utf-8?B?VkV1b1QzMFBBVTFpbjJGaFN6eWg3NjZBdHF1QUU3WmdLUkE0YmxndzdndmtE?=
 =?utf-8?B?eWMyRVZ1WHpsWGtheW9udWcySjFsUW1oUkI0ejNVVWtSS3ZpNzhxcDFwdkVU?=
 =?utf-8?B?WVFMdkM3ckZHUW5KUDM3UytWc09lV29URlpXMVR1dHFjRmQ4VGtuSUZpQWp1?=
 =?utf-8?B?ZjVxOXlNSnN6NWtkQVBLRUtGTUVvby9qZDVVUEdrbmNNS1ZJcGoxdmFTRTVK?=
 =?utf-8?B?Y1kvNFlqa1UwQVJCV2RuaXZXaEE4T3NDcmcxUUo5WHdnc2dnUUsxTGJrQlZ3?=
 =?utf-8?B?RmpFMjhUdG9wbHFHREdYK2dMeUZDbU5jc2w1OHN2a2hiMmtERWIzSG9pcTBx?=
 =?utf-8?B?TzVvR2xMM1FhNEdJbnFlU05TMnRoNEFvMFpWSlAwMmVucE9VRG9uSWpPUERz?=
 =?utf-8?B?cTYrQVQvRHRiaHJvcTB3MG45UUZwZS9BUWl0RzliVDZIbjZUWlMwZm0wWFZO?=
 =?utf-8?B?R2M4V0pMMzNJTHFJYmt2THBad0tvTXFKRDNrNmFCSy9WTGgxalhsK2JSOTBl?=
 =?utf-8?B?b0Zud3A5MjgyWHhKemtkZXB5cHV3dC9oVmRGU1NzSlFZSDNxVXV6dy9qSWdm?=
 =?utf-8?B?U0dXT0UvVkkwcFlkcE9zRlJITUZvNWwvMmc5UWhCek4xaGNLZVdySGwwaGhJ?=
 =?utf-8?B?Q3JacSt4aEx6Qk9kV3Ryd3NYbkpQSDJXTDBzZlF2ckhMcVN4MGZGYy8wOHNz?=
 =?utf-8?B?N0kxTTNSc21uTXMxdGV4RHRTVzNnVkZSb05sQjF4a000WjhleUJsZytiTTZ2?=
 =?utf-8?B?RldCUGpZQzl4RldMS1pwc1ZzanFxYjN0d2NQVXdCVmJseC9adEpQRTJKaWNG?=
 =?utf-8?B?RU8zNHhRbWl3c3dacXFJYnQwb0t0V2lUbzJTUHBLUGFlQXRvVWRJTGhoRXhT?=
 =?utf-8?B?U2RZUFllbUh0YWVUSEFFZWQwRTlzb0NTUzY5UC83ZUoxRjBMVTNQQ0s3ckpv?=
 =?utf-8?B?Um9sUnY0dE1KMlJaRTZMODN2UGxwZ1I5R1ZTZVYxeWU0RmZMRlhYY2cvQjI1?=
 =?utf-8?B?TjFTQm5EMVhESFZsVk91dytEMGpBeFdpcDNvQ3BrY3pVb2RSMUd4T3BDRlND?=
 =?utf-8?B?ZXhTbHRXeEF5VUtMR2t2UTZMRVB0cUdqalZ6NXFuM3RJb2drUEhqWXcrd0o4?=
 =?utf-8?B?Q3ZQVy9vZkxwaUxwaTI3RWRvWFlxN1ZFSGZjL0Y3VEFvckFKTytQak9wL0tK?=
 =?utf-8?B?bFlmcWFZZmx4cWUwejBCeTF1MVZ4Q2gybHNqbngrZmVHMUhrWElBZzRDZEU0?=
 =?utf-8?B?YzRkL1RXa05JOExsbUpDejZrRzM2RGJldXBVa1RXK00wOU1UMDBncEgyTHlS?=
 =?utf-8?B?STE0emtIVkg2STRWSmVvdGNtVUlyWExTaHdyOW55WUhwYXdydzRINjkzMldx?=
 =?utf-8?B?dURTWm9YTU1BeDNQWVhTTEI0QkNNUkhQb2hZNHU0UEFNRE0yUDlVNFFkdm1V?=
 =?utf-8?B?MEZHeldGb29mOW12bDBLNXlwY05idjNIRmhZWDFNN0pjRDlaTnJmekF1MmF6?=
 =?utf-8?B?ZE9TZTdkK2UxRHNsOEdsbVhDTjNHYk1oQVFsN0ZXc21SdC9md2c0OUhtMzRO?=
 =?utf-8?B?Mm5RMWMyR0RFYk9HSjJKZFNkOFlFNXpnT0prdVNGcm5TcGpLOGh5TXp3L0FE?=
 =?utf-8?B?RGVkUDdsRk82cFVZZzROOWpLUlNrRm9Ub3FOajZxdUhVajJYQTg1cWlzRXRx?=
 =?utf-8?B?L09LMjB3YS80ZkJ3UG11YlFOMzkvSjc3c3F5dUlPeHB2ZUt0YjVhV0VXTy9k?=
 =?utf-8?B?WEZ4RkdYUlloVFFTZXlCc3FIQnloMDU0WUFSSzdvWFNNR3FtaW5rMHNuamZG?=
 =?utf-8?B?STBQUThiQUNqVlErNitucDRESC9zM21yUUNEdGh6N0dud0ljMjhMZk81UHlJ?=
 =?utf-8?Q?QhqiifIxEw0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGVnM3BxNmVFTzRjRGdZYUlOWFZkUFdqNXlwelNNVzZVczZCNUZHSit1VjdX?=
 =?utf-8?B?Ylh0VWpYd0xFZG9mUGpCalZFc1BCK0RyVUh6akYvS3lOS1J1aWoyOXFrVXoz?=
 =?utf-8?B?bXZITXJHU2t6bllib0JSYVhWNTJKT3p6cGVvb0Jycll2SFZCampzb3h5Rkhu?=
 =?utf-8?B?dmZYT3BrWEpnWDRaTDdzNmR5MmhYeWZmbVluOERIZjRqMkowWnlveEJFN0Yr?=
 =?utf-8?B?YTlJYWVxdHEvOGlqRXhoeWFRYlNVRjl6UWl2M0h6YzRweG1ia3ZmUGU1YUxa?=
 =?utf-8?B?M2loZk5HbkViKzI5ei9NUVhzOTE3UkU5dEswczQ1N2VibDZ2Y3pKYnZpZlBt?=
 =?utf-8?B?ZDJVUkF5MzB1bU4wYW5lTG5MaHB2dlBvME1tOFZndlcwUmFsVG45TmRvZnhm?=
 =?utf-8?B?aHV6ME96azZuQnRrMWJtS0w4VkxwbkpmTDA0SkY2d2xLTVc3NmtZQStxbkFV?=
 =?utf-8?B?U24zb3AxaUhST0NuaGQ0SjN1eG5sYXA2REx2R1FnSXR4N1VGQ2ozUjNqZmU4?=
 =?utf-8?B?UktmMkJySm5TMUlHU25JNkZBREJPWXdpNXhuQnVHY2dXNGluU1Q5Nm1UaktT?=
 =?utf-8?B?aHljZjlsenBmMVArWmVrMXlqMlloZTk5VDFlWkNVQnhCNnplbUNvUzlDSURT?=
 =?utf-8?B?WEpUNEVVUER5N0VGUHBRK0diWFk2RjJPMTY1eEFBZWljNkVKbXRZNVh3MVUy?=
 =?utf-8?B?WlpZMlZqRTRQZUVpMitNckV2YU5uVFdoMFR0WHcxdlRqenVkeTdVVmxYTTlQ?=
 =?utf-8?B?eU1kdkJ1aVFYaHZEZTV3RDBONlJKemhXUnIvK0RhQnoyNUFjd2V0eGkwWHl0?=
 =?utf-8?B?MGdTS2JLSFJyZCtUWGZlbnJ0REF2TTJqZXZHYUlSb2t5STF2TXNJdndKWERD?=
 =?utf-8?B?L3YvSStzQVNhY1g3YWlWTmNiV1h6RmNad3h2QmIxakxBem5ZSlFxU0RKMnU1?=
 =?utf-8?B?ZUxIeG9wSFZ2VEo4amJVQUxteVpzdTh4YUdUOXNIRS9nOStVUjFOa3NhRDE2?=
 =?utf-8?B?VVZERkI1M1dsTDcvZEI2UjJtRHgvc0krRExLUjloVjJ6SEt6S1huVE9hM0RX?=
 =?utf-8?B?bEVJTXJEMHhKSi9IYjZ0N29NSWxXaUUzNzJTTmhPZ0c0emhnUDIwSVZlUk9R?=
 =?utf-8?B?NGdMNDJRZWVmM2NPOWRETTVsSUlseis2aGJWRFpoRXArd3ErQWEwUDBjS0sr?=
 =?utf-8?B?Q1JteXoxTUJhYjVnbFVlNUsrKy9jZ3FhS1BWVS9BVW5VN0dQaXk4NXpyYkFV?=
 =?utf-8?B?MjduWTgva1RndnVOOXM4M3B3cXFYbEFnNVZkVHoyVjV0T3FQdTFuTFRmUnVo?=
 =?utf-8?B?U29ETWpXWkFzZCtqWFZ0ME05WmF5RG9BT1d1L1VxNWd5c3lrZkpuTGNnc3Ar?=
 =?utf-8?B?YWZuRExSOEY1K2xESnJ2dHhNYi9uU3FlSEIrTUFQZThRcHFTRTRrRWhRV3FM?=
 =?utf-8?B?NnhyYXVyK1gyTUF0SlpjZGdIUkFvYmRxTVJnUlVueTRmcWRDaytxNWpRNnRj?=
 =?utf-8?B?b3lOYkVBZjUzN2s2NG5NQjJHWDREaUs2eEo5M3Z3K3JOVzRNNGlKc3JwK1Bj?=
 =?utf-8?B?UVh3ZGk0V0pma0tyajZZSVBmSUk0VVFWYmRYSEZLWDRzcmNkcTBlWThDcVNX?=
 =?utf-8?B?bWs2dGtXZDlSWHhOSkMyZVBaSm95SmQvbXoyZ2tzdEx2MTZqZWZGRjFwWDlB?=
 =?utf-8?B?VU9NSVBMcDgwWDVQVFdkaHE0dmZDeE5oRDFSWDQ1VHg2RkFqaHdPOFRmWHo2?=
 =?utf-8?B?bXlTOW81TUxkMnI2WE1ScHYyS3JvMm5VbGJYbUVML25XM252RVZKT2VUOXVP?=
 =?utf-8?B?NFJLeGduS3hHdGNVZXJzMHgyZDlIaWkvUXkrV21zbzYyK2hKcWg1ZDFDeDgw?=
 =?utf-8?B?YnkvQVpxVkFXL2puU0JLL1FHaHlYQnNYZ0pmbmtrREVGME84bmFqZ2dTR2xl?=
 =?utf-8?B?ZGs5SFFMTlk5aG1xZ3RienpPUHhMQ25vOU9ycldoR2FrcUQ2QWJCT05NRGFF?=
 =?utf-8?B?cnRGUVpwWFZIQTB5bm16WkZYTzgzaUFUTlhxRW1QSTRiM01nYzRDVjAwaUdK?=
 =?utf-8?B?QnZ3aHZZeWsxbm91bThYQjRnVDNNbFBHM0toQnlSTDFTVGovTE9wY2ZqOU9T?=
 =?utf-8?Q?5dtXNJGcQ9SKDCho/umdD4QHp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2abf3e-9ef6-4c7d-0510-08ddf07ee3b7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:29:53.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdZMzA03NrxPkopz1IWWOAg753PlUcow/vneS18jb7jEwhlpaDEM+C+7TvISTDe+898o0qgyhAhWMvpRuC0Lfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197



On 9/10/2025 10:17, Yazen Ghannam wrote:
> On Tue, Sep 09, 2025 at 06:53:13PM +0000, Avadhut Naik wrote:
>> Newer AMD systems can support up to 16 channels per EDAC "mc" device.
>> These are detected by the EDAC module running on the device, and the
>> current EDAC interface is appropriately enumerated.
>>
>> The legacy EDAC sysfs interface however, provides device attributes for
>> channels 0 through 11 only. Consequently, the last four channels, 12
>> through 15, will not be enumerated and will not be visible through the
>> legacy sysfs interface.
>>
>> Add additional device attributes to ensure that all 16 channels, if
>> present, are enumerated by and visible through the legacy EDAC sysfs
>> interface.
>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>> Changes in v2:
>> Patch introduced.
>>
>> Changes in v3:
>> No changes.
>> ---
>>  drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
>> index 0f338adf7d93..8689631f1905 100644
>> --- a/drivers/edac/edac_mc_sysfs.c
>> +++ b/drivers/edac/edac_mc_sysfs.c
>> @@ -305,6 +305,14 @@ DEVICE_CHANNEL(ch10_dimm_label, S_IRUGO | S_IWUSR,
>>  	channel_dimm_label_show, channel_dimm_label_store, 10);
>>  DEVICE_CHANNEL(ch11_dimm_label, S_IRUGO | S_IWUSR,
>>  	channel_dimm_label_show, channel_dimm_label_store, 11);
>> +DEVICE_CHANNEL(ch12_dimm_label, S_IRUGO | S_IWUSR,
>> +	channel_dimm_label_show, channel_dimm_label_store, 12);
>> +DEVICE_CHANNEL(ch13_dimm_label, S_IRUGO | S_IWUSR,
>> +	channel_dimm_label_show, channel_dimm_label_store, 13);
>> +DEVICE_CHANNEL(ch14_dimm_label, S_IRUGO | S_IWUSR,
>> +	channel_dimm_label_show, channel_dimm_label_store, 14);
>> +DEVICE_CHANNEL(ch15_dimm_label, S_IRUGO | S_IWUSR,
>> +	channel_dimm_label_show, channel_dimm_label_store, 15);
>>  
>>  /* Total possible dynamic DIMM Label attribute file table */
>>  static struct attribute *dynamic_csrow_dimm_attr[] = {
>> @@ -320,6 +328,10 @@ static struct attribute *dynamic_csrow_dimm_attr[] = {
>>  	&dev_attr_legacy_ch9_dimm_label.attr.attr,
>>  	&dev_attr_legacy_ch10_dimm_label.attr.attr,
>>  	&dev_attr_legacy_ch11_dimm_label.attr.attr,
>> +	&dev_attr_legacy_ch12_dimm_label.attr.attr,
>> +	&dev_attr_legacy_ch13_dimm_label.attr.attr,
>> +	&dev_attr_legacy_ch14_dimm_label.attr.attr,
>> +	&dev_attr_legacy_ch15_dimm_label.attr.attr,
>>  	NULL
>>  };
>>  
>> @@ -348,6 +360,14 @@ DEVICE_CHANNEL(ch10_ce_count, S_IRUGO,
>>  		   channel_ce_count_show, NULL, 10);
>>  DEVICE_CHANNEL(ch11_ce_count, S_IRUGO,
>>  		   channel_ce_count_show, NULL, 11);
>> +DEVICE_CHANNEL(ch12_ce_count, S_IRUGO,
>> +		   channel_ce_count_show, NULL, 12);
>> +DEVICE_CHANNEL(ch13_ce_count, S_IRUGO,
>> +		   channel_ce_count_show, NULL, 13);
>> +DEVICE_CHANNEL(ch14_ce_count, S_IRUGO,
>> +		   channel_ce_count_show, NULL, 14);
>> +DEVICE_CHANNEL(ch15_ce_count, S_IRUGO,
>> +		   channel_ce_count_show, NULL, 15);
>>  
>>  /* Total possible dynamic ce_count attribute file table */
>>  static struct attribute *dynamic_csrow_ce_count_attr[] = {
>> @@ -363,6 +383,10 @@ static struct attribute *dynamic_csrow_ce_count_attr[] = {
>>  	&dev_attr_legacy_ch9_ce_count.attr.attr,
>>  	&dev_attr_legacy_ch10_ce_count.attr.attr,
>>  	&dev_attr_legacy_ch11_ce_count.attr.attr,
>> +	&dev_attr_legacy_ch12_ce_count.attr.attr,
>> +	&dev_attr_legacy_ch13_ce_count.attr.attr,
>> +	&dev_attr_legacy_ch14_ce_count.attr.attr,
>> +	&dev_attr_legacy_ch15_ce_count.attr.attr,
>>  	NULL
>>  };
>>  
>> -- 
> 
> There are many checkpatch warnings here.
> 
> Maybe it'd be prudent to note this in the commit message?
> 
> Something like "checkpatch warnings ignored to maintain coding style"
> and maybe "affected lines are deprecated and will be removed", etc.?
> 
> Otherwise, I expect there will be some "checkpatch warning" fixes coming
> our way.
> 

Initially, was going to fix the checkpatch warnings. But then noticed that
previous commits to this area had ignored warnings too. So let them be as
is.

In any case, will add about this to the commit message.
> Thanks,
> Yazen

-- 
Thanks,
Avadhut Naik


